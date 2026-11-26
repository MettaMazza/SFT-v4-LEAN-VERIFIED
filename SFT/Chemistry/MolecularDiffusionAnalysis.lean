import SFT.Chemistry.MolecularDiffusion
import SFT.Chemistry.SolvationDissolutionAnalysis
namespace SFT.Chemistry.MolecularDiffusionAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open MolecularDiffusion
abbrev truthy := ComponentExchangeAnalysis.truthy
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev ratioRat := SolvationDissolutionAnalysis.ratioRat
abbrev addCount := SolvationDissolutionAnalysis.addCount
abbrev sourceInteger := TemperatureCorrespondenceSource.integer
def conditionSupport (value : Value) : Except String DihedralTorsion.Height :=
 match SolvationDissolutionAnalysis.conditionSupport value with
 | .ok v=>.ok v
 | .error e=>if Text.equal e "THERMO-015 condition is not an exact finite inscription" then
   .error "THERMO-016 condition is not an exact finite inscription"
  else .error "THERMO-016 condition left the exact nonnegative external boundary"
def variableKind (metadata : Value) : Except String String :=
 let names := match get (get metadata "VariableID") "VariableType" with
  | .object fs=>fs.filterMap fun (key,_)=>if Text.equal key "tml_elements" then none else some key
  | .null | .boolean _ | .integer _ | .text _ | .array _ => []
 match names with | [name]=>.ok name | [] | _::_::_ => .error "THERMO-016 variable kind changed"
def putVariable {α : Type} (rows : List (Int×α)) (key : Int) (value : α) : List (Int×α) :=
 if rows.any (fun (k,_)=> @decide (k=key) (Int.decEq _ _)) then
  rows.map (fun (k,v)=>(k,if @decide (k=key) (Int.decEq _ _) then value else v))
 else rows++[(key,value)]
structure RowAnalysis where
 className : String
 dataset : String
 method : String
 phase : String
 magnitude : Rat
 conditions : List (String×Rat)
 emptyCount : Nat
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let t := get row.row "target_payload"
 let className ← identityString (get t "diffusion_class")
 if !(["binary","self","tracer"].any (Text.equal className)) then throw "THERMO-016 diffusion class changed"
 let components ← (← RunningConvergenceMeasurement.array (get t "component_orgnums")).mapM sourceInteger
 let records := match get t "complete_component_records" with | .array xs=>xs.length | .null | .boolean _ | .integer _ | .text _ | .object _ => 0
 let propertyName ← identityString (get t "property_name")
 let propertyPrefix := if Text.equal className "binary" then "Binary diffusion coefficient" else if Text.equal className "self" then "Self diffusion coefficient" else "Tracer diffusion coefficient"
 if components.isEmpty || !SolvationDissolutionAnalysis.distinctInts components || records != components.length ||
  !(Text.chars propertyPrefix).isPrefixOf (Text.chars propertyName) || !truthy (get t "measurement_method") ||
  !truthy (get t "diffusion_uncertainty_external_record") || !truthy (get t "complete_point_record") ||
  !truthy (get t "complete_property_metadata") || !truthy (get t "complete_variable_metadata") || !truthy (get t "complete_phase_metadata") then
  throw "THERMO-016 complete molecular carrier or provenance changed"
 let migrating ← match get t "property_component_orgnum" with
  | .null=>match components with | first::_=>pure first | []=>throw "THERMO-016 migrating identity left the constituent carrier"
  | .boolean _ | .integer _ | .text _ | .array _ | .object _ => sourceInteger (get t "property_component_orgnum")
 if !(components.any fun x=> @decide (x=migrating) (Int.decEq _ _)) then throw "THERMO-016 migrating identity left the constituent carrier"
 let phases ← (← RunningConvergenceMeasurement.array (get t "complete_phase_metadata")).mapM fun p=>identityString (get p "ePhase")
 let phase ← match phases with
  | [p]=>if Text.equal p "Liquid" || Text.equal p "Fluid (supercritical or subcritical phases)" then pure p else throw "THERMO-016 phase identity changed"
  | [] | _::_::_ => throw "THERMO-016 phase identity changed"
 let metadataRows ← (← RunningConvergenceMeasurement.array (get t "complete_variable_metadata")).mapM fun m=>do
  let key ← sourceInteger (get m "nVarNumber")
  pure (key,m)
 let metadata := metadataRows.foldl (fun out (k,v)=>putVariable out k v) []
 let externalFields ← match get t "variable_external_inscriptions" with | .object fs=>pure fs | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "THERMO-016 variable carrier changed"
 let externalRows ← externalFields.mapM fun (key,value)=>do return (← sourceInteger (.text key),value)
 let external := externalRows.foldl (fun out (k,v)=>putVariable out k v) []
 if metadata.length != external.length || !(metadata.all fun (k,_)=>external.any fun (j,_)=> @decide (k=j) (Int.decEq _ _)) then
  throw "THERMO-016 variable carrier changed"
 let supportRows ← external.mapM fun (number,value)=>do
  let support ← conditionSupport value
  match support with
  | .emptyOne | .otherEmptyOne _=>pure (support,none)
  | .ratio r=>
   let variableMetadata := ((metadata.find? fun (key,_)=> @decide (key=number) (Int.decEq _ _)).map Prod.snd).getD .null
   let kind ← variableKind variableMetadata
   pure (support,some (kind,ratioRat r))
  | .invalid=>throw "THERMO-016 condition is not an exact finite inscription"
 let migrant ← identityString (.integer migrating) >>= CapabilityValues.heldLabel "chemical-component"
 let constituentLabels ← components.mapM fun x=>identityString (.integer x) >>= CapabilityValues.heldLabel "chemical-component"
 let classLabel ← CapabilityValues.heldLabel "diffusion-class" className
 let phaseLabel ← CapabilityValues.heldLabel "chemical-phase" phase
 let sourcePoint ← sourceInteger (get t "source_point_ordinal")
 let dataset ← sourceInteger (get t "dataset_ordinal")
 let positive := fun (n : Int)=>match n with
  | .ofNat n=>CapabilityValues.count n
  | .negSucc _=>Except.error "an SFT count must be a positive counted value"
 let transitions ← positive sourcePoint
 let ticks ← positive dataset
 let a ← makeAccount (.held migrant) (constituentLabels.map MolecularFormationEnergy.LabelInput.held) (.held classLabel) (.held phaseLabel)
  (.count ⟨3,by decide⟩) (.count ⟨4,by decide⟩) (.count transitions) (.count ticks) (supportRows.map Prod.fst)
 let relation ← forcedCountedDiffusion (.account a)
 if !Text.equal relation.carrier.label (Text.append className "-identity-retained-adjacent-transition") then throw "THERMO-016 counted transition law changed"
 let conserved ← completeConstituentConservation (a.constituentIdentities.map MolecularFormationEnergy.LabelInput.held)
  (a.constituentIdentities.reverse.map MolecularFormationEnergy.LabelInput.held)
 if !conserved then throw "THERMO-016 constituent conservation changed"
 let magnitudeText ← field t "diffusion_coefficient_m2_per_s_external_inscription" >>= identityString
 let magnitude ← externalDiffusionMagnitude (.text magnitudeText)
 let sourceId ← field t "source_id" >>= identityString
 let datasetText ← field t "dataset_ordinal" >>= identityString
 let method ← field t "measurement_method" >>= identityString
 let absent := (supportRows.filter fun (support,_)=>match support with | .emptyOne | .otherEmptyOne _=>true | .ratio _ | .invalid => false).length
 pure ⟨className,Text.intercalate ":" [sourceId,datasetText,className],Text.intercalate ":" [className,method],phase,ratioRat magnitude,supportRows.filterMap Prod.snd,absent⟩
structure Range where
 name : String
 bounds : Rat×Rat
def exactRanges (values : List (String×Rat)) : Except String (List Range) := do
 let keys := values.foldl (fun keys (k,_)=>if keys.any (Text.equal k) then keys else keys++[k]) []
 let keys := (Canonical.sortFields (keys.map fun k=>(k,k))).map Prod.fst
 keys.mapM fun key=>do
  let bound ← RealGasAnalysis.bounds (values.filterMap fun (k,v)=>if Text.equal k key then some v else none)
  pure ⟨key,bound⟩
structure Analysis where
 count : Nat
 classes : List (String×Nat)
 datasets : List (String×Nat)
 methods : List (String×Nat)
 phases : List (String×Nat)
 emptyCount : Nat
 ranges : List Range
 conditionRanges : List Range
 checks : List (String×Bool)
def exactMolecularDiffusionAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let classes := analyzed.foldl (fun cs row=>addCount cs row.className) []
 let datasets := analyzed.foldl (fun cs row=>addCount cs row.dataset) []
 let methods := analyzed.foldl (fun cs row=>addCount cs row.method) []
 let phases := analyzed.foldl (fun cs row=>addCount cs row.phase) []
 let absent := analyzed.foldl (fun n row=>n+row.emptyCount) 0
 let ranges ← exactRanges (analyzed.map fun row=>(row.className,row.magnitude))
 let conditions ← exactRanges (analyzed.flatMap RowAnalysis.conditions)
 let expected := [("NIST-TRC-THERMOML-JCED-2011-56-4840-4848:1:binary",113),
  ("NIST-TRC-THERMOML-FPE-2017-437-34-42:1:self",1),("NIST-TRC-THERMOML-FPE-2017-437-34-42:3:self",3),
  ("NIST-TRC-THERMOML-FPE-2017-437-34-42:5:tracer",6),("NIST-TRC-THERMOML-FPE-2017-437-34-42:6:tracer",11),("NIST-TRC-THERMOML-FPE-2017-437-34-42:13:tracer",5),
  ("NIST-TRC-THERMOML-FPE-2008-271-43-52:6:binary",5),("NIST-TRC-THERMOML-FPE-2008-271-43-52:8:binary",5),("NIST-TRC-THERMOML-FPE-2008-271-43-52:10:binary",5),("NIST-TRC-THERMOML-FPE-2008-271-43-52:12:binary",5),("NIST-TRC-THERMOML-FPE-2008-271-43-52:14:binary",5)]
 let equalCounts := fun (a b : List (String×Nat))=>a.length==b.length && b.all (fun (k,n)=>a.any fun (key,count)=>Text.equal k key && n==count)
 pure ⟨rows.length,classes,datasets,methods,phases,absent,ranges,conditions,[
  ("all_164_records_retained",rows.length==164),
  ("all_138_binary_4_self_22_tracer_records_retained",equalCounts classes [("binary",138),("self",4),("tracer",22)]),
  ("all_11_diffusion_datasets_complete",equalCounts datasets expected),
  ("all_three_methods_and_classes_retained",equalCounts methods [("binary:TAYLOR:UFactor:4",25),("binary:Taylor dispersion method",113),("self:NMR",4),("tracer:NMR",22)]),
  ("all_liquid_and_subsupercritical_phase_rows_retained",equalCounts phases [("Liquid",139),("Fluid (supercritical or subcritical phases)",25)]),
  ("all_26_absent_condition_coordinates_are_EmptyOne",absent==26),
  ("complete_three_sources_and_companions_preserved",sameValue (get primary "complete_source_count") (.integer 3) && sameValue (get primary "complete_dataset_count_across_sources") (.integer 30) && sameValue (get primary "complete_all_property_point_count_across_sources") (.integer 373) && sameValue (get primary "all_direct_binary_self_and_tracer_diffusion_rows_and_complete_sources_preserved") (.boolean true)),
  ("non_diffusion_companions_excluded_from_measurements",sameValue (get primary "non_diffusion_companion_datasets_used_as_diffusion_measurements") (.boolean false)),
  ("no_imported_transport_model_random_premise_fit_or_selection",sameValue (get primary "Fick_Brownian_random_walk_Stokes_Einstein_activation_transport_fit_logarithm_continuum_interpolation_regression_selection_or_target_correction_used") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.MolecularDiffusionAnalysis
