import SFT.Chemistry.CoupledTransport
import SFT.Chemistry.MolecularDiffusionAnalysis
namespace SFT.Chemistry.CoupledTransportAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open CoupledTransport
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
   .error "THERMO-019 support is not exact finite"
  else .error "THERMO-019 support became negative"
def positiveExternal (value : Value) : Except String DihedralTorsion.Ratio := do
 match ← support value with
 | .ratio r=>pure r
 | .emptyOne | .otherEmptyOne _=>throw "THERMO-019 measured response became absent"
 | .invalid=>throw "THERMO-019 support is not exact finite"
def kind (metadata : Value) (outer inner : String) : Except String String := do
 let kinds := match get (get metadata outer) inner with
  | .object fs=>fs.map Prod.fst | .null | .boolean _ | .integer _ | .text _ | .array _=>[]
 match kinds.filter (fun k=> !Text.equal k "tml_elements") with
 | [k]=>pure k
 | [] | _::_::_=>throw "THERMO-019 condition kind changed"
structure RowAnalysis where
 mixture : String
 pair : String
 role : String
 property : String
 massHeatMethod : Bool
 dataset : String
 method : String
 magnitude : Rat
 conditions : List (String×Rat)
 emptyCount : Nat
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let t := get row.row "target_payload"
 let components ← (← RunningConvergenceMeasurement.array (get t "component_orgnums")).mapM sourceInteger
 let mixture := match components.length with | 1=>"pure" | 2=>"binary" | 3=>"ternary" | 0 | _+4=>"higher-component"
 let records := match get t "complete_component_records" with | .array xs=>xs.length | .null | .boolean _ | .integer _ | .text _ | .object _=>0
 let pairValue := get t "carrier_pair"
 let propertyValue := get t "property_name"
 let expectedRoles := [("mass-heat","Binary diffusion coefficient, m2/s","mass-response-under-thermal-forcing"),
  ("mass-charge","Electrical conductivity, S/m","charge-response"),
  ("mass-charge","Tracer diffusion coefficient, m2/s","mass-response-under-charge-probe"),
  ("heat-charge","Thermal conductivity, W/m/K","heat-response"),
  ("heat-charge","Electrical conductivity, S/m","charge-response")]
 let roleValue := ((expectedRoles.find? fun (pair,property,_)=>sameValue pairValue (.text pair) && sameValue propertyValue (.text property)).map fun (_,_,role)=>Value.text role).getD .null
 if components.isEmpty || !SolvationDissolutionAnalysis.distinctInts components || records != components.length ||
  !sameValue (get t "mixture_class") (.text mixture) || !sameValue roleValue (get t "response_role") ||
  !sameValue (get t "property_phase") (.text "Liquid") || !truthy (get t "measurement_method") ||
  !truthy (get t "coupled_response_uncertainty_external_record") || !truthy (get t "complete_point_record") ||
  !truthy (get t "complete_property_metadata") || !truthy (get t "complete_variable_metadata") || !truthy (get t "complete_phase_metadata") then
  throw "THERMO-019 complete pair/composition/phase/provenance carrier changed"
 let metadataRows ← (← RunningConvergenceMeasurement.array (get t "complete_variable_metadata")).mapM fun m=>do
  let key ← sourceInteger (get m "nVarNumber")
  pure (key,m)
 let metadata := metadataRows.foldl (fun out (k,v)=>putVariable out k v) []
 let externalFields ← match get t "variable_external_inscriptions" with | .object fs=>pure fs | .null | .boolean _ | .integer _ | .text _ | .array _=>throw "THERMO-019 condition carrier changed"
 let externalRows ← externalFields.mapM fun (key,value)=>do return (← sourceInteger (.text key),value)
 let external := externalRows.foldl (fun out (k,v)=>putVariable out k v) []
 if metadata.length != external.length || !(metadata.all fun (k,_)=>external.any fun (j,_)=> @decide (k=j) (Int.decEq _ _)) then
  throw "THERMO-019 condition carrier changed"
 let supportRows ← external.mapM fun (number,value)=>do
  let s ← support value
  match s with
  | .emptyOne | .otherEmptyOne _=>pure (s,none)
  | .ratio r=>
   let variableMetadata := ((metadata.find? fun (key,_)=> @decide (key=number) (Int.decEq _ _)).map Prod.snd).getD .null
   let kind ← kind variableMetadata "VariableID" "VariableType"
   pure (s,some (kind,ratioRat r))
  | .invalid=>throw "THERMO-019 support is not exact finite"
 let constraintValues ← match get t "complete_constraint_metadata" with
  | .null=>pure [] | .array xs=>pure xs | .boolean _ | .integer _ | .text _ | .object _=>throw "THERMO-019 condition kind changed"
 let constraintRows ← constraintValues.mapM fun constraint=>do
  let s ← support (← field constraint "nConstraintValue")
  match s with
  | .emptyOne | .otherEmptyOne _=>pure (s,none)
  | .ratio r=>do let kind ← kind constraint "ConstraintID" "ConstraintType"; pure (s,some (kind,ratioRat r))
  | .invalid=>throw "THERMO-019 support is not exact finite"
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
 let pair ← identityString pairValue
 let property ← identityString propertyValue
 let role ← field t "response_role" >>= identityString
 let a ← makeAccount (labels.map MolecularFormationEnergy.LabelInput.held) (.held ⟨"chemical-phase","Liquid",rfl,rfl⟩)
  [.held ⟨"transport-carrier","mass",rfl,rfl⟩,.held ⟨"transport-carrier","heat",rfl,rfl⟩,.held ⟨"transport-carrier","charge",rfl,rfl⟩]
  (.count ⟨3,by decide⟩) (.count ⟨4,by decide⟩) [.count ⟨2,by decide⟩,.count ⟨3,by decide⟩,.count ⟨5,by decide⟩]
  (.count transfers) (.count ticks) (.count boundary) (supportRows.map Prod.fst)
 let relation ← forcedCoupledTransport (.account a)
 if !Text.equal relation.carrierTopology.label (Text.append mixture "-composition-phase-shared-mass-heat-charge-event-ledger") ||
  !(relation.pairwiseProjections.any fun p=>Text.equal p.label pair) then throw "THERMO-019 triad projection changed"
 let magnitude ← positiveExternal (← field t "coupled_response_external_inscription")
 let sourceId ← field t "source_id" >>= identityString
 let datasetText ← field t "dataset_ordinal" >>= identityString
 let propertyText ← field t "property_number" >>= identityString
 let method ← field t "measurement_method" >>= identityString
 let absent := (supportRows.filter fun (s,_)=>match s with | .emptyOne | .otherEmptyOne _=>true | .ratio _ | .invalid=>false).length
 pure ⟨mixture,pair,role,property,(!sameValue (get row.row "carrier_pair") (.text "mass-heat") || Text.equal method "thermal-diffusion forced Rayleigh scattering"),Text.intercalate ":" [sourceId,datasetText,propertyText,pair,property],method,ratioRat magnitude,supportRows.filterMap Prod.snd,absent⟩
structure Analysis where
 count : Nat
 pairs : List (String×Nat)
 roles : List (String×Nat)
 properties : List (String×Nat)
 mixtures : List (String×Nat)
 methods : List (String×Nat)
 datasets : List (String×Nat)
 emptyCount : Nat
 responseRanges : List Range
 conditionRanges : List Range
 checks : List (String×Bool)
def exactCoupledTransportAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let pairs := analyzed.foldl (fun cs row=>addCount cs row.pair) []
 let roles := analyzed.foldl (fun cs row=>addCount cs row.role) []
 let properties := analyzed.foldl (fun cs row=>addCount cs row.property) []
 let mixtures := analyzed.foldl (fun cs row=>addCount cs row.mixture) []
 let methods := analyzed.foldl (fun cs row=>addCount cs row.method) []
 let datasets := analyzed.foldl (fun cs row=>addCount cs row.dataset) []
 let absent := analyzed.foldl (fun n row=>n+row.emptyCount) 0
 let responses ← MolecularDiffusionAnalysis.exactRanges (analyzed.map fun row=>(row.property,row.magnitude))
 let conditions ← MolecularDiffusionAnalysis.exactRanges (analyzed.flatMap RowAnalysis.conditions)
 let equalCounts := fun (a b : List (String×Nat))=>a.length==b.length && b.all (fun (k,n)=>a.any fun (key,count)=>Text.equal k key && n==count)
 pure ⟨rows.length,pairs,roles,properties,mixtures,methods,datasets,absent,responses,conditions,[
  ("all_232_records_retained",rows.length==232),
  ("all_three_pairwise_surfaces_retained",equalCounts pairs [("mass-heat",22),("mass-charge",146),("heat-charge",64)]),
  ("all_response_roles_retained",equalCounts roles [("mass-response-under-thermal-forcing",22),("charge-response",147),("mass-response-under-charge-probe",31),("heat-response",32)]),
  ("all_four_property_families_retained",equalCounts properties [("Binary diffusion coefficient, m2/s",22),("Electrical conductivity, S/m",147),("Thermal conductivity, W/m/K",32),("Tracer diffusion coefficient, m2/s",31)]),
  ("all_137_binary_95_ternary_records_retained",equalCounts mixtures [("binary",137),("ternary",95)]),
  ("all_five_methods_retained",equalCounts methods [("thermal-diffusion forced Rayleigh scattering",22),("Radiometer CDM 210 Meterlab conductimeter with a CDC 745-9 cell",115),("Electrochemistry (cyclic voltametry)",31),("Coaxial cylinder method",32),("contact method",32)]),
  ("all_15_coupled_datasets_complete",datasets.length==15 && (datasets.foldl (fun n x=>n+x.2) 0)==232),
  ("all_six_absent_conditions_are_EmptyOne",absent==6),
  ("mass_heat_surface_is_thermal_forcing_method",analyzed.all RowAnalysis.massHeatMethod),
  ("complete_three_sources_and_companions_preserved",sameValue (get primary "complete_source_count") (.integer 3) && sameValue (get primary "complete_dataset_count_across_sources") (.integer 23) && sameValue (get primary "complete_all_property_point_count_across_sources") (.integer 375) && sameValue (get primary "complete_coupled_dataset_count") (.integer 15) && sameValue (get primary "all_direct_coupled_rows_and_complete_sources_preserved") (.boolean true)),
  ("companions_excluded_from_measurements",sameValue (get primary "companion_properties_used_as_coupled_measurements") (.boolean false)),
  ("no_imported_matrix_continuum_fitted_law_or_selection",sameValue (get primary "Onsager_matrix_continuum_gradient_flux_equation_phenomenological_cross_coefficient_signed_magnitude_fit_logarithm_interpolation_regression_selection_or_target_correction_used") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.CoupledTransportAnalysis
