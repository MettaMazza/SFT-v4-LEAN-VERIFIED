import SFT.Chemistry.HeatWorkTransferAnalysis
import SFT.Physics.LeptonRatios
namespace SFT.Chemistry.ComponentExchangeAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
-- Source: component_exchange_validation_v1.py:exact_component_exchange_analysis.
def sourceFraction (inscription : String) : Except String Rat :=
 match LeptonDecimal.split '/' (Text.chars inscription) with
 | [] => .error "Invalid literal for Fraction"
 | a::rest => match rest with
  | [] => HeatWorkTransferAnalysis.sourceDecimal inscription
  | b::tail => match tail with
   | [] => do
    let numerator ← HeatWorkTransferAnalysis.sourceDecimal (String.ofList a)
    let denominator ← HeatWorkTransferAnalysis.sourceDecimal (String.ofList b)
    LeptonRatios.divide numerator denominator
   | _::_ => .error "Invalid literal for Fraction"

def truthy : Value → Bool
 | .null => false
 | .boolean b => b
 | .integer n => !(@decide (n=0) (Int.decEq _ _))
 | .text s => !s.isEmpty
 | .array xs => !xs.isEmpty
 | .object xs => !xs.isEmpty
structure RowAnalysis where
 system : String
 pressure : Rat
 temperature : Rat
 liquid : Rat
 gas : Rat
 relation : String
def analyzeRow (target : Value) : Except String RowAnalysis := do
 let liquid ← field target "liquid_variable_component_part_external_inscription" >>= identityString >>= sourceFraction
 let liquidComplement ← field target "liquid_complement_component_part_external_inscription" >>= identityString >>= sourceFraction
 let gas ← field target "gas_variable_component_part_external_inscription" >>= identityString >>= sourceFraction
 let gasComplement ← field target "gas_complement_component_part_external_inscription" >>= identityString >>= sourceFraction
 let pressure ← field target "pressure_kPa_external_inscription" >>= identityString >>= sourceFraction
 let temperature ← field target "temperature_K_external_inscription" >>= identityString >>= sourceFraction
 let sums := [add liquid liquidComplement,add gas gasComplement]
 if !(sums.all fun v => Text.equal (InternalEnergyCompositionSource.fractionText v) "1") then
  throw "THERMO-008 phase composition does not exhaust the One"
 if !([liquid,liquidComplement,gas,gasComplement].all fun v =>
  @decide (0<v.num) (Int.decLt _ _) && @decide (v.num<Int.ofNat v.den) (Int.decLt _ _)) then
  throw "THERMO-008 multicomponent phase has an absent or overfull component"
 if !sameValue (get target "external_phase_classification") (.text "binary-vapor-liquid-equilibrium") then
  throw "THERMO-008 target lost its equilibrium classification"
 let components := match get target "complete_component_records" with
  | .array xs => xs.length
  | .null => 0
  | .boolean _ => 0
  | .integer _ => 0
  | .text _ => 0
  | .object _ => 0
 if components != 2 then throw "THERMO-008 target lost a component record"
 if !truthy (get target "temperature_uncertainty") || !truthy (get target "gas_composition_uncertainty") then
  throw "THERMO-008 target lost a reported uncertainty"
 let system ← field target "system_ordinal" >>= identityString
 let difference := subtract gas liquid
 let relation := if @decide (0<difference.num) (Int.decLt _ _) then "gas-greater"
  else if @decide (difference.num<0) (Int.decLt _ _) then "liquid-greater" else "equal"
 pure ⟨system,pressure,temperature,liquid,gas,relation⟩
structure Analysis where
 count : Nat
 systems : List (String×Nat)
 pressures : List Rat
 temperatures : List Rat
 liquids : List Rat
 gases : List Rat
 relations : List String
 checks : List (String×Bool)
def exactComponentExchangeAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM fun row => analyzeRow (get row.row "target_payload")
 let systems := analyzed.foldl (fun counts row =>
  if counts.any (fun item => Text.equal item.1 row.system) then
   counts.map (fun (key,n) => (key,if Text.equal key row.system then n+1 else n))
  else counts++[(row.system,1)]) ([] : List (String×Nat))
 let relations := analyzed.map RowAnalysis.relation
 let first := relations.take 20
 let crossings := (first.zip (first.drop 1)).zipIdx.filterMap fun ((a,b),i) => if Text.equal a b then none else some (i+1)
 let expected := [("1",20),("2",18),("3",18),("4",18)]
 let correctCounts := systems.length==4 && expected.all (fun (key,n) => systems.any (fun (k,m) => Text.equal key k && m==n))
 let endpointCount := match get primary "unmatched_temperature_endpoints" with
  | .array xs => xs.length
  | .null => 0
  | .boolean _ => 0
  | .integer _ => 0
  | .text _ => 0
  | .object _ => 0
 pure ⟨rows.length,systems,analyzed.map RowAnalysis.pressure,analyzed.map RowAnalysis.temperature,
  analyzed.map RowAnalysis.liquid,analyzed.map RowAnalysis.gas,relations,[
  ("all_74_rows_retained",rows.length==74),
  ("all_four_systems_retained",correctCounts),
  ("all_rows_share_fixed_101_3_kPa_environment",!analyzed.isEmpty && analyzed.all fun row => Text.equal (InternalEnergyCompositionSource.fractionText row.pressure) "1013/10"),
  ("all_phase_compositions_are_exact_positive_parts_of_One",analyzed.length==74),
  ("equal_component_account_does_not_require_equal_bulk_composition",analyzed.all fun row => !(@decide ((subtract row.liquid row.gas).num=0) (Int.decEq _ _))),
  ("both_external_enrichment_orientations_retained",(relations.filter (Text.equal "gas-greater")).length==66 && (relations.filter (Text.equal "liquid-greater")).length==8),
  ("system_one_composition_crossing_retained",crossings==[8]),
  ("all_eight_unmatched_source_endpoints_preserved",sameValue (get primary "complete_unmatched_temperature_endpoint_count") (.integer 8) && endpointCount==8),
  ("complete_raw_source_surface_preserved",sameValue (get primary "complete_source_compound_count") (.integer 5) &&
   sameValue (get primary "complete_source_dataset_count") (.integer 13) &&
   sameValue (get primary "all_direct_equilibrium_rows_and_unpaired_source_endpoints_preserved") (.boolean true))]⟩
end SFT.Chemistry.ComponentExchangeAnalysis
