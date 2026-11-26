import SFT.Chemistry.SolvationDissolution
import SFT.Chemistry.RealGasAnalysis
import SFT.Chemistry.TemperatureCorrespondenceSource
namespace SFT.Chemistry.SolvationDissolutionAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open SolvationDissolution
abbrev truthy := ComponentExchangeAnalysis.truthy
abbrev fractionText := InternalEnergyCompositionSource.fractionText
def ratioRat (r : DihedralTorsion.Ratio) : Rat := normalize (.ofNat r.numerator.value) r.denominator.value r.denominator.positive
def positiveFraction (value : Value) (name : String) : Except String Rat := do
 let failure := Text.intercalate "" ["THERMO-015 ",name," is not an exact finite inscription"]
 let fraction ← match identityString value >>= fractionInscription with | .ok r => pure r | .error _ => throw failure
 if @decide (fraction.num≤0) (Int.decLe _ _) then throw (Text.intercalate "" ["THERMO-015 ",name," is not exact positive support"])
 pure fraction
def conditionSupport (value : Value) : Except String DihedralTorsion.Height := do
 let fraction ← match identityString value >>= fractionInscription with
  | .ok r => pure r
  | .error _ => throw "THERMO-015 condition is not an exact finite inscription"
 if @decide (fraction.num<0) (Int.decLt _ _) then throw "THERMO-015 condition left the exact nonnegative external boundary"
 if @decide (fraction.num=0) (Int.decEq _ _) then pure .emptyOne
 else do return .ratio (← positiveRatio fraction)
def addCount (counts : List (String×Nat)) (key : String) : List (String×Nat) :=
 if counts.any (fun item=>Text.equal item.1 key) then counts.map (fun (k,n)=>(k,if Text.equal k key then n+1 else n))
 else counts++[(key,1)]
def distinctInts (xs : List Int) : Bool :=
 (xs.foldl (fun out x=>if out.any (fun y=> @decide (x=y) (Int.decEq _ _)) then out else x::out) []).length==xs.length
structure RowAnalysis where
 sourceClass : String
 dataset : Option String
 orientation : Option String
 magnitude : Option Rat
 uncertainty : Rat
 capacity : Option Rat
 temperature : Option Rat
 mixed : Bool
 emptyConditions : Nat
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let t := get row.row "target_payload"
 let sourceClass ← identityString (get t "source_class")
 if Text.equal sourceClass "solvation" then
  let companions := match get t "calculated_companion_fields_excluded_from_measurement" with | .object fs => fs.map Prod.fst | .null | .boolean _ | .integer _ | .text _ | .array _ => []
  let expected := ["calculated_hydration_free_energy_kcal_per_mol","calculated_uncertainty_kcal_per_mol","calculated_reference"]
  if !truthy (get t "solute_compound_id") || !truthy (get t "solute_smiles") || !truthy (get t "solute_name") ||
   !sameValue (get t "solvent_identity") (.text "water") || !sameValue (get t "source_state") (.text "isolated-gas-reference") ||
   !sameValue (get t "destination_state") (.text "aqueous-hydrated-reference") || !truthy (get t "experimental_reference") ||
   !truthy (get t "complete_source_row") || companions.length != 3 || !(expected.all fun k=>companions.any (Text.equal k)) then
   throw "THERMO-015 complete FreeSolv carrier or provenance changed"
  let relation ← externalOrderAsFoldRelation (match get t "experimental_hydration_free_energy_kcal_per_mol_external_inscription" with
   | .text s => .text s | .null | .boolean _ | .integer _ | .object _ | .array _ => .other)
  let uncertainty ← positiveFraction (get t "experimental_uncertainty_kcal_per_mol_external_inscription") "solvation uncertainty"
  let solute ← field t "solute_compound_id" >>= text >>= CapabilityValues.heldLabel "chemical-component"
  let source ← field t "source_state" >>= text >>= CapabilityValues.heldLabel "chemical-state"
  let destination ← field t "destination_state" >>= text >>= CapabilityValues.heldLabel "chemical-state"
  let a ← makeAccount (.held solute) [.held ⟨"chemical-component","water",rfl,rfl⟩] (.held source) (.held destination) .emptyOne
  let carrier ← forcedTransferCarrier (.account a)
  if !Text.equal carrier.label "distinct-solute-single-solvent-reference-condition-state-transfer" then throw "THERMO-015 solvation carrier changed"
  pure ⟨sourceClass,none,some relation.orientation.label,(match relation.magnitude with | .ratio r => some (ratioRat r) | .emptyOne | .otherEmptyOne _ | .invalid => none),uncertainty,none,none,false,0⟩
 else if Text.equal sourceClass "dissolution" then
  let components ← (← RunningConvergenceMeasurement.array (get t "component_orgnums")).mapM TemperatureCorrespondenceSource.integer
  let solute ← TemperatureCorrespondenceSource.integer (get t "solute_orgnum")
  let solvents ← (← RunningConvergenceMeasurement.array (get t "solvent_orgnums")).mapM TemperatureCorrespondenceSource.integer
  let contains := fun (xs : List Int) (x : Int)=>xs.any (fun y=> @decide (x=y) (Int.decEq _ _))
  let required := components.filter fun x=> !(@decide (x=solute) (Int.decEq _ _))
  let records := match get t "complete_component_records" with | .array xs=>xs.length | .null | .boolean _ | .integer _ | .object _ | .text _ => 0
  if (components.length != 2 && components.length != 3) || !distinctInts components || !contains components solute ||
   solvents.isEmpty || !(solvents.all (contains required)) || !(required.all (contains solvents)) || records != components.length ||
   !sameValue (get t "source_state") (.text "separated-solute-and-solvent") ||
   !sameValue (get t "destination_state") (.text "condition-bound-saturated-liquid-solution") ||
   !truthy (get t "complete_point_record") || !truthy (get t "complete_property_metadata") || !truthy (get t "complete_variable_metadata") ||
   !truthy (get t "complete_constraint_metadata") || !truthy (get t "complete_phase_metadata") then
   throw "THERMO-015 complete NIST dissolution carrier or provenance changed"
  let capacityText ← field t "solubility_mole_fraction_external_inscription" >>= identityString
  let capacity ← exactSolubilityCapacity (.text capacityText)
  let uncertainty ← positiveFraction (get t "solubility_uncertainty_external_inscription") "solubility uncertainty"
  let variableFields ← match get t "variable_external_inscriptions" with | .object fs=>pure fs | .null | .boolean _ | .integer _ | .array _ | .text _ => throw "condition variables are not a mapping"
  let entries ← variableFields.mapM fun (key,value)=>do
   let index ← TemperatureCorrespondenceSource.integer (.text key)
   let value ← conditionSupport value
   pure (index,value)
  let variables := entries.foldl (fun out (key,value)=>
   if out.any (fun (k,_)=> @decide (k=key) (Int.decEq _ _)) then out.map (fun (k,v)=>(k,if @decide (k=key) (Int.decEq _ _) then value else v))
   else out++[(key,value)]) ([] : List (Int×DihedralTorsion.Height))
  let pressure ← positiveFraction (get t "pressure_constraint_external_inscription") "dissolution pressure"
  let absent := (variables.filter fun (_,v)=>match v with | .emptyOne | .otherEmptyOne _=>true | .ratio _ | .invalid => false).length
  let first ← match variables with | []=>throw "max() arg is an empty sequence" | x::_=>pure x
  let last := variables.foldl (fun old x=>if @decide (old.1<x.1) (Int.decLt _ _) then x else old) first
  let temperature ← match last.2 with | .ratio r=>pure r | .emptyOne | .otherEmptyOne _ | .invalid => throw "THERMO-015 temperature became absent"
  let solute ← identityString (.integer solute) >>= CapabilityValues.heldLabel "chemical-component"
  let solvents ← solvents.mapM fun value=>identityString (.integer value) >>= CapabilityValues.heldLabel "chemical-component"
  let source ← field t "source_state" >>= text >>= CapabilityValues.heldLabel "chemical-state"
  let destination ← field t "destination_state" >>= text >>= CapabilityValues.heldLabel "chemical-state"
  let a ← makeAccount (.held solute) (solvents.map MolecularFormationEnergy.LabelInput.held) (.held source) (.held destination) (.ratio temperature)
  let carrier ← forcedTransferCarrier (.account a)
  let mixed := solvents.length>1
  let expected := if mixed then "distinct-solute-mixed-solvent-condition-bound-state-transfer" else "distinct-solute-single-solvent-condition-bound-state-transfer"
  if !Text.equal carrier.label expected then throw "THERMO-015 dissolution carrier changed"
  let dataset ← TemperatureCorrespondenceSource.integer (get t "dataset_ordinal")
  let dataset ← identityString (.integer dataset)
  if @decide (pressure.num≤0) (Int.decLe _ _) then throw "THERMO-015 pressure support changed"
  pure ⟨sourceClass,some dataset,none,none,uncertainty,some (ratioRat capacity),some (ratioRat temperature),mixed,absent⟩
 else throw "THERMO-015 source class changed"
structure Range where
 name : String
 bounds : Rat×Rat
structure Analysis where
 count : Nat
 classes : List (String×Nat)
 datasets : List (String×Nat)
 orientations : List (String×Nat)
 mixedCount : Nat
 emptyCount : Nat
 ranges : List Range
 checks : List (String×Bool)
def exactSolvationDissolutionAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let classes := analyzed.foldl (fun cs row=>addCount cs row.sourceClass) []
 let datasets := analyzed.foldl (fun cs row=>match row.dataset with | some k=>addCount cs k | none=>cs) []
 let orientations := analyzed.foldl (fun cs row=>match row.orientation with | some k=>addCount cs k | none=>cs) []
 let mixed := (analyzed.filter RowAnalysis.mixed).length
 let absent := analyzed.foldl (fun n row=>n+row.emptyConditions) 0
 let rangeInputs := [("solvation_magnitude_kcal_per_mol",analyzed.filterMap RowAnalysis.magnitude),
  ("solvation_uncertainty_kcal_per_mol",(analyzed.filter fun row=>Text.equal row.sourceClass "solvation").map RowAnalysis.uncertainty),
  ("solubility_mole_fraction",analyzed.filterMap RowAnalysis.capacity),
  ("solubility_uncertainty",(analyzed.filter fun row=>Text.equal row.sourceClass "dissolution").map RowAnalysis.uncertainty),
  ("dissolution_temperature_K",analyzed.filterMap RowAnalysis.temperature)]
 let ranges ← rangeInputs.mapM fun (name,values)=>do return (⟨name,← RealGasAnalysis.bounds values⟩ : Range)
 let equalCounts := fun (a b : List (String×Nat))=> a.length==b.length && b.all (fun (k,n)=>a.any fun (key,count)=>Text.equal k key && n==count)
 pure ⟨rows.length,classes,datasets,orientations,mixed,absent,ranges,[
  ("all_799_records_retained",rows.length==799),
  ("all_642_solvation_and_157_dissolution_records_retained",equalCounts classes [("solvation",642),("dissolution",157)]),
  ("all_favorable_opposed_and_EmptyOne_solvation_rows_retained",equalCounts orientations [("destination-solution-retained",556),("source-separated-state-retained",84),("coincident-state-support",2)]),
  ("all_seven_dissolution_datasets_complete",equalCounts datasets [("1",13),("2",11),("3",11),("4",7),("5",10),("6",12),("7",93)]),
  ("all_93_mixed_solvent_records_retained",mixed==93),
  ("all_10_absent_solvent_condition_coordinates_are_EmptyOne",absent==10),
  ("complete_two_sources_preserved",sameValue (get primary "complete_source_count") (.integer 2) && sameValue (get primary "complete_target_count") (.integer 799) && sameValue (get primary "all_642_FreeSolv_and_157_direct_NIST_rows_preserved") (.boolean true)),
  ("calculated_or_correlated_companions_excluded_from_measurements",sameValue (get primary "calculated_or_correlated_companion_fields_used_as_measurements") (.boolean false)),
  ("no_imported_model_equation_logarithm_correlation_fit_or_selection",sameValue (get primary "force_field_continuum_solvent_partition_activity_solubility_product_logarithm_correlation_regression_fit_selection_or_target_correction_used") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.SolvationDissolutionAnalysis
