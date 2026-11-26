import SFT.Chemistry.ThermalConductivity
import SFT.Chemistry.MolecularDiffusionAnalysis
namespace SFT.Chemistry.ThermalConductivityAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open ThermalConductivity
abbrev truthy := ComponentExchangeAnalysis.truthy
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev ratioRat := SolvationDissolutionAnalysis.ratioRat
abbrev addCount := SolvationDissolutionAnalysis.addCount
abbrev sourceInteger := TemperatureCorrespondenceSource.integer
abbrev putVariable {α : Type} := MolecularDiffusionAnalysis.putVariable (α := α)
abbrev Range := MolecularDiffusionAnalysis.Range
def support (value : Value) : Except String DihedralTorsion.Height :=
 match SolvationDissolutionAnalysis.conditionSupport value with
 | .ok v=>.ok v
 | .error e=>if Text.equal e "THERMO-015 condition is not an exact finite inscription" then
   .error "THERMO-018 condition is not exact finite support"
  else .error "THERMO-018 condition became negative"
def variableKind (metadata : Value) : Except String String :=
 match MolecularDiffusionAnalysis.variableKind metadata with
 | .ok k=>.ok k
 | .error _=>.error "THERMO-018 variable kind changed"
def constraintKind (metadata : Value) : Except String String := do
 let kinds := match get (get metadata "ConstraintID") "ConstraintType" with
  | .object fs=>fs.map Prod.fst | .null | .boolean _ | .integer _ | .text _ | .array _ => []
 match kinds.filter (fun k=> !Text.equal k "tml_elements") with
 | [k]=>pure k
 | [] | _::_::_ => throw "THERMO-018 constraint kind changed"
structure RowAnalysis where
 mixture : String
 phase : String
 dataset : String
 method : String
 magnitude : Rat
 conditions : List (String×Rat)
 emptyCount : Nat
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let t := get row.row "target_payload"
 let components ← (← RunningConvergenceMeasurement.array (get t "component_orgnums")).mapM sourceInteger
 let mixture := match components.length with | 1=>"pure" | 2=>"binary" | 3=>"ternary" | 0 | _+4 => "higher-component"
 let records := match get t "complete_component_records" with | .array xs=>xs.length | .null | .boolean _ | .integer _ | .text _ | .object _ => 0
 let phase := get t "property_phase"
 let phaseValid := ["Gas","Liquid","Crystal 2"].any (fun p=>sameValue phase (.text p))
 if components.isEmpty || !SolvationDissolutionAnalysis.distinctInts components || records != components.length ||
  !sameValue (get t "mixture_class") (.text mixture) || !sameValue (get t "property_name") (.text "Thermal conductivity, W/m/K") ||
  !truthy (get t "measurement_method") || !truthy (get t "thermal_conductivity_uncertainty_external_record") || !truthy (get t "complete_point_record") ||
  !truthy (get t "complete_property_metadata") || !truthy (get t "complete_variable_metadata") || !truthy (get t "complete_phase_metadata") || !phaseValid then
  throw "THERMO-018 complete composition/phase/provenance carrier changed"
 let metadataRows ← (← RunningConvergenceMeasurement.array (get t "complete_variable_metadata")).mapM fun m=>do
  let key ← sourceInteger (get m "nVarNumber")
  pure (key,m)
 let metadata := metadataRows.foldl (fun out (k,v)=>putVariable out k v) []
 let externalFields ← match get t "variable_external_inscriptions" with | .object fs=>pure fs | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "THERMO-018 condition carrier changed"
 let externalRows ← externalFields.mapM fun (key,value)=>do return (← sourceInteger (.text key),value)
 let external := externalRows.foldl (fun out (k,v)=>putVariable out k v) []
 if metadata.length != external.length || !(metadata.all fun (k,_)=>external.any fun (j,_)=> @decide (k=j) (Int.decEq _ _)) then
  throw "THERMO-018 condition carrier changed"
 let supportRows ← external.mapM fun (number,value)=>do
  let s ← support value
  match s with
  | .emptyOne | .otherEmptyOne _=>pure (s,none)
  | .ratio r=>
   let variableMetadata := ((metadata.find? fun (key,_)=> @decide (key=number) (Int.decEq _ _)).map Prod.snd).getD .null
   let kind ← variableKind variableMetadata
   pure (s,some (kind,ratioRat r))
  | .invalid=>throw "THERMO-018 condition is not exact finite support"
 let constraintValues ← match get t "complete_constraint_metadata" with
  | .null=>pure [] | .array xs=>pure xs | .boolean _ | .integer _ | .text _ | .object _ => throw "THERMO-018 constraint kind changed"
 let constraintRows ← constraintValues.mapM fun constraint=>do
  let s ← support (← field constraint "nConstraintValue")
  match s with
  | .emptyOne | .otherEmptyOne _=>pure (s,none)
  | .ratio r=>do let kind ← constraintKind constraint; pure (s,some (kind,ratioRat r))
  | .invalid=>throw "THERMO-018 condition is not exact finite support"
 let supportRows := supportRows ++ constraintRows
 let labels ← components.mapM fun x=>identityString (.integer x) >>= CapabilityValues.heldLabel "chemical-component"
 let point ← sourceInteger (get t "source_point_ordinal")
 let positive := fun (n : Int)=>match n with
  | .ofNat n=>CapabilityValues.count n
  | .negSucc _=>Except.error "an SFT count must be a positive counted value"
 let transfers ← positive point
 let dataset ← sourceInteger (get t "dataset_ordinal")
 let ticks ← positive dataset
 let boundary ← sourceInteger (get t "property_number") >>= positive
 let phaseText ← identityString phase
 let phaseLabel ← CapabilityValues.heldLabel "chemical-phase" phaseText
 let a ← makeAccount (labels.map MolecularFormationEnergy.LabelInput.held) (.held phaseLabel)
  (.count ⟨3,by decide⟩) (.count ⟨4,by decide⟩) (.count ⟨7,by decide⟩) (.count ⟨3,by decide⟩) (.count ⟨5,by decide⟩) (.count transfers) (.count ticks) (.count boundary) (supportRows.map Prod.fst)
 let relation ← forcedThermalConductivity (.account a)
 if !Text.equal relation.carrier.label (Text.append mixture "-composition-phase-energy-packet-transfer") then throw "THERMO-018 composition carrier changed"
 let magnitudeText ← field t "thermal_conductivity_W_m_K_external_inscription" >>= identityString
 let magnitude ← externalThermalConductivityMagnitude (.text magnitudeText)
 let sourceId ← field t "source_id" >>= identityString
 let datasetText ← field t "dataset_ordinal" >>= identityString
 let propertyText ← field t "property_number" >>= identityString
 let method ← field t "measurement_method" >>= identityString
 let absent := (supportRows.filter fun (s,_)=>match s with | .emptyOne | .otherEmptyOne _=>true | .ratio _ | .invalid => false).length
 pure ⟨mixture,phaseText,Text.intercalate ":" [sourceId,datasetText,propertyText,mixture,phaseText],method,ratioRat magnitude,supportRows.filterMap Prod.snd,absent⟩
structure Analysis where
 count : Nat
 mixtures : List (String×Nat)
 phases : List (String×Nat)
 datasets : List (String×Nat)
 methods : List (String×Nat)
 emptyCount : Nat
 conductivityBounds : Rat×Rat
 conditionRanges : List Range
 checks : List (String×Bool)
def exactThermalConductivityAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let mixtures := analyzed.foldl (fun cs row=>addCount cs row.mixture) []
 let phases := analyzed.foldl (fun cs row=>addCount cs row.phase) []
 let datasets := analyzed.foldl (fun cs row=>addCount cs row.dataset) []
 let methods := analyzed.foldl (fun cs row=>addCount cs row.method) []
 let absent := analyzed.foldl (fun n row=>n+row.emptyCount) 0
 let bounds ← RealGasAnalysis.bounds (analyzed.map RowAnalysis.magnitude)
 let conditions ← MolecularDiffusionAnalysis.exactRanges (analyzed.flatMap RowAnalysis.conditions)
 let expectedMethods := [("Hot wire method",472),("Modified transient plane source method",71),("THOTW",112)]
 let equalCounts := fun (a b : List (String×Nat))=>a.length==b.length && b.all (fun (k,n)=>a.any fun (key,count)=>Text.equal k key && n==count)
 pure ⟨rows.length,mixtures,phases,datasets,methods,absent,bounds,conditions,[
  ("all_655_records_retained",rows.length==655),
  ("all_123_pure_273_binary_259_ternary_records_retained",equalCounts mixtures [("pure",123),("binary",273),("ternary",259)]),
  ("all_51_gas_571_liquid_33_crystal_records_retained",equalCounts phases [("Gas",51),("Liquid",571),("Crystal 2",33)]),
  ("all_37_conductivity_datasets_complete",datasets.length==37 && (datasets.foldl (fun n x=>n+x.2) 0)==655),
  ("all_three_measurement_methods_retained",equalCounts methods expectedMethods),
  ("complete_three_sources_and_companions_preserved",sameValue (get primary "complete_source_count") (.integer 3) && sameValue (get primary "complete_dataset_count_across_sources") (.integer 61) && sameValue (get primary "complete_all_property_point_count_across_sources") (.integer 679) && sameValue (get primary "complete_thermal_conductivity_dataset_count") (.integer 37) && sameValue (get primary "all_direct_thermal_conductivity_rows_and_complete_sources_preserved") (.boolean true)),
  ("non_conductivity_companions_excluded_from_measurements",sameValue (get primary "non_thermal_conductivity_companions_used_as_thermal_conductivity_measurements") (.boolean false)),
  ("no_imported_constitutive_continuum_fitted_law_or_selection",sameValue (get primary "Fourier_constitutive_temperature_gradient_kinetic_theory_mixing_temperature_law_logarithm_continuum_interpolation_regression_selection_or_target_correction_used") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.ThermalConductivityAnalysis
