import SFT.Chemistry.ViscousTransport
import SFT.Chemistry.MolecularDiffusionAnalysis
namespace SFT.Chemistry.ViscousTransportAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open ViscousTransport
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
   .error "THERMO-017 condition is not exact finite support"
  else .error "THERMO-017 condition became negative"
def variableKind (metadata : Value) : Except String String :=
 match MolecularDiffusionAnalysis.variableKind metadata with
 | .ok k=>.ok k
 | .error _=>.error "THERMO-017 variable kind changed"
structure RowAnalysis where
 mixture : String
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
 let phases := match get t "complete_phase_metadata" with | .array xs=>xs.map (fun p=>get p "ePhase") | .null | .boolean _ | .integer _ | .text _ | .object _ => []
 let liquid := match phases with | [p]=>sameValue p (.text "Liquid") | [] | _::_::_ => false
 if components.isEmpty || !SolvationDissolutionAnalysis.distinctInts components || records != components.length ||
  !sameValue (get t "mixture_class") (.text mixture) || !sameValue (get t "property_name") (.text "Viscosity, Pa*s") ||
  !truthy (get t "measurement_method") || !truthy (get t "viscosity_uncertainty_external_record") || !truthy (get t "complete_point_record") ||
  !truthy (get t "complete_property_metadata") || !truthy (get t "complete_variable_metadata") || !truthy (get t "complete_phase_metadata") || !liquid then
  throw "THERMO-017 complete composition/phase/provenance carrier changed"
 let metadataRows ← (← RunningConvergenceMeasurement.array (get t "complete_variable_metadata")).mapM fun m=>do
  let key ← sourceInteger (get m "nVarNumber")
  pure (key,m)
 let metadata := metadataRows.foldl (fun out (k,v)=>putVariable out k v) []
 let externalFields ← match get t "variable_external_inscriptions" with | .object fs=>pure fs | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "THERMO-017 condition carrier changed"
 let externalRows ← externalFields.mapM fun (key,value)=>do return (← sourceInteger (.text key),value)
 let external := externalRows.foldl (fun out (k,v)=>putVariable out k v) []
 if metadata.length != external.length || !(metadata.all fun (k,_)=>external.any fun (j,_)=> @decide (k=j) (Int.decEq _ _)) then
  throw "THERMO-017 condition carrier changed"
 let supportRows ← external.mapM fun (number,value)=>do
  let s ← support value
  match s with
  | .emptyOne | .otherEmptyOne _=>pure (s,none)
  | .ratio r=>
   let variableMetadata := ((metadata.find? fun (key,_)=> @decide (key=number) (Int.decEq _ _)).map Prod.snd).getD .null
   let kind ← variableKind variableMetadata
   pure (s,some (kind,ratioRat r))
  | .invalid=>throw "THERMO-017 condition is not exact finite support"
 let labels ← components.mapM fun x=>identityString (.integer x) >>= CapabilityValues.heldLabel "chemical-component"
 let point ← sourceInteger (get t "source_point_ordinal")
 let dataset ← sourceInteger (get t "dataset_ordinal")
 let positive := fun (n : Int)=>match n with
  | .ofNat n=>CapabilityValues.count n
  | .negSucc _=>Except.error "an SFT count must be a positive counted value"
 let exchanges ← positive point
 let ticks ← positive dataset
 let a ← makeAccount (labels.map MolecularFormationEnergy.LabelInput.held) (.held ⟨"chemical-phase","Liquid",rfl,rfl⟩)
  (.count ⟨3,by decide⟩) (.count ⟨4,by decide⟩) (.count ⟨5,by decide⟩) (.count exchanges) (.count ticks) (supportRows.map Prod.fst)
 let relation ← forcedViscousTransport (.account a)
 if !Text.equal relation.carrier.label (Text.append mixture "-composition-retained-momentum-exchange") then throw "THERMO-017 composition carrier changed"
 let magnitudeText ← field t "viscosity_Pa_s_external_inscription" >>= identityString
 let magnitude ← externalViscosityMagnitude (.text magnitudeText)
 let sourceId ← field t "source_id" >>= identityString
 let datasetText ← field t "dataset_ordinal" >>= identityString
 let method ← field t "measurement_method" >>= identityString
 let absent := (supportRows.filter fun (s,_)=>match s with | .emptyOne | .otherEmptyOne _=>true | .ratio _ | .invalid => false).length
 pure ⟨mixture,Text.intercalate ":" [sourceId,datasetText,mixture],method,ratioRat magnitude,supportRows.filterMap Prod.snd,absent⟩
structure Analysis where
 count : Nat
 mixtures : List (String×Nat)
 datasets : List (String×Nat)
 methods : List (String×Nat)
 emptyCount : Nat
 viscosityBounds : Rat×Rat
 conditionRanges : List Range
 checks : List (String×Bool)
def exactViscousTransportAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let mixtures := analyzed.foldl (fun cs row=>addCount cs row.mixture) []
 let datasets := analyzed.foldl (fun cs row=>addCount cs row.dataset) []
 let methods := analyzed.foldl (fun cs row=>addCount cs row.method) []
 let absent := analyzed.foldl (fun n row=>n+row.emptyCount) 0
 let bounds ← RealGasAnalysis.bounds (analyzed.map RowAnalysis.magnitude)
 let conditions ← MolecularDiffusionAnalysis.exactRanges (analyzed.flatMap RowAnalysis.conditions)
 let expected := [("NIST-TRC-THERMOML-FPE-2018-474-6-13:2:ternary",50),
  ("NIST-TRC-THERMOML-JCED-2005-50-1038-1042:1:pure",5),("NIST-TRC-THERMOML-JCED-2005-50-1038-1042:3:pure",6),
  ("NIST-TRC-THERMOML-JCED-2005-50-1038-1042:5:binary",70),("NIST-TRC-THERMOML-JCED-2005-50-1038-1042:7:binary",78),
  ("NIST-TRC-THERMOML-FPE-2017-453-13-23:2:binary",72),("NIST-TRC-THERMOML-FPE-2017-453-13-23:4:binary",72),("NIST-TRC-THERMOML-FPE-2017-453-13-23:6:binary",72)]
 let expectedMethods := [("CAPTUB:UFactor:3",75),("CAPTUB:UFactor:4",84),("Capillary tube (Ostwald; Ubbelohde) method",144),("Pressure drop in straight capillary",72),("Liquid flow through an orifice",50)]
 let equalCounts := fun (a b : List (String×Nat))=>a.length==b.length && b.all (fun (k,n)=>a.any fun (key,count)=>Text.equal k key && n==count)
 pure ⟨rows.length,mixtures,datasets,methods,absent,bounds,conditions,[
  ("all_425_records_retained",rows.length==425),
  ("all_11_pure_364_binary_50_ternary_records_retained",equalCounts mixtures [("pure",11),("binary",364),("ternary",50)]),
  ("all_eight_viscosity_datasets_complete",equalCounts datasets expected),
  ("all_five_measurement_methods_retained",equalCounts methods expectedMethods),
  ("all_38_absent_condition_coordinates_are_EmptyOne",absent==38),
  ("complete_three_sources_and_companions_preserved",sameValue (get primary "complete_source_count") (.integer 3) && sameValue (get primary "complete_dataset_count_across_sources") (.integer 17) && sameValue (get primary "complete_all_property_point_count_across_sources") (.integer 900) && sameValue (get primary "all_direct_viscosity_rows_and_complete_sources_preserved") (.boolean true)),
  ("non_viscosity_companions_excluded_from_measurements",sameValue (get primary "non_viscosity_companion_datasets_used_as_viscosity_measurements") (.boolean false)),
  ("no_imported_constitutive_continuum_fitted_law_or_selection",sameValue (get primary "Newtonian_constitutive_velocity_gradient_Arrhenius_WLF_VFT_logarithm_continuum_interpolation_regression_selection_or_target_correction_used") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.ViscousTransportAnalysis
