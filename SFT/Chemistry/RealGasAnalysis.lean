import SFT.Chemistry.ComponentExchangeAnalysis
namespace SFT.Chemistry.RealGasAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
abbrev sourceFraction := ComponentExchangeAnalysis.sourceFraction
abbrev truthy := ComponentExchangeAnalysis.truthy
abbrev fractionText := InternalEnergyCompositionSource.fractionText
structure RowAnalysis where
 dataset : String
 components : String×String
 pressure : Rat
 temperature : Rat
 gas : Option Rat
 liquidCoordinates : Nat
def analyzeCoordinate (coordinate : Value) : Except String (Option Rat × Nat) := do
 let value ← field coordinate "external_inscription" >>= identityString >>= sourceFraction
 let name ← field coordinate "coordinate_name" >>= identityString
 if Text.equal name "temperature_K" then
  if @decide (value.num≤0) (Int.decLe _ _) || !sameValue (get coordinate "sft_interface_state") (.text "exact-positive-coordinate") then
   throw "THERMO-010 temperature is not exact positive"
  pure (some value,0)
 else if (Text.chars "liquid_mole_fraction_component_").isPrefixOf (Text.chars name) then
  if @decide (value.num=0) (Int.decEq _ _) then
   if !sameValue (get coordinate "sft_interface_state") (.text "EmptyOne") then throw "THERMO-010 external absence glyph became a number"
  else if @decide (0<value.num) (Int.decLt _ _) && @decide (value.num≤Int.ofNat value.den) (Int.decLe _ _) then
   if !sameValue (get coordinate "sft_interface_state") (.text "exact-positive-coordinate") then throw "THERMO-010 positive liquid composition was relabelled"
  else throw "THERMO-010 liquid composition is outside the One"
  pure (none,1)
 else throw "THERMO-010 unregistered state coordinate"
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let target := get row.row "target_payload"
 if !sameValue (get target "external_phase_classification") (.text "binary-real-gas-vapor-liquid-equilibrium") then
  throw "THERMO-010 external equilibrium classification changed"
 let components ← match get target "ordered_component_orgnums" with
  | .array [a,b] => pure (a,b)
  | .array [] | .array [_] | .array (_::_::_::_) | .null | .boolean _ | .integer _ | .text _ | .object _ => throw "THERMO-010 component support is incomplete"
 let complete := match get target "complete_component_records" with | .array xs => xs.length | .null | .boolean _ | .integer _ | .text _ | .object _ => 0
 if complete != 2 then throw "THERMO-010 component support is incomplete"
 let pair := (← identityString components.1,← identityString components.2)
 let pressure ← field target "pressure_kPa_external_inscription" >>= identityString >>= sourceFraction
 if @decide (pressure.num≤0) (Int.decLe _ _) then throw "THERMO-010 pressure is not an exact positive external inscription"
 if !truthy (get target "pressure_uncertainty") then throw "THERMO-010 pressure uncertainty is absent"
 let coordinates ← match get target "condition_and_liquid_composition_coordinates" with
  | .array xs => pure xs
  | .null | .boolean _ | .integer _ | .text _ | .object _ => throw "THERMO-010 did not retain temperature and liquid composition"
 if coordinates.length != 2 then throw "THERMO-010 did not retain temperature and liquid composition"
 let parsed ← coordinates.mapM analyzeCoordinate
 let temperature := parsed.foldl (fun current item => match item.1 with | some t => some t | none => current) none
 let liquidCount := parsed.foldl (fun n item => n+item.2) 0
 let temperature ← match temperature with
  | some t => if liquidCount==1 then pure t else throw "THERMO-010 state coordinates are incomplete"
  | none => throw "THERMO-010 state coordinates are incomplete"
 let gas ← match get target "gas_component_mole_fraction_external_inscription" with
  | .null => do
   if !sameValue (get target "composition_dataset_ordinal") .null ||
    !sameValue (get target "gas_composition_interface_state") (.text "unreported") ||
    !sameValue (get row.row "composition_companion_class") (.text "EmptyOne") then
    throw "THERMO-010 pressure-only state was altered"
   pure none
  | .boolean _ | .integer _ | .text _ | .array _ | .object _ => do
   let inscription := get target "gas_component_mole_fraction_external_inscription"
   let gas ← identityString inscription >>= sourceFraction
   if @decide (gas.num≤0) (Int.decLe _ _) || @decide (Int.ofNat gas.den<gas.num) (Int.decLt _ _) then
    throw "THERMO-010 gas composition is not an exact positive part of the One"
   if !sameValue (get target "gas_composition_interface_state") (.text "exact-phase-part") ||
    !truthy (get target "gas_composition_uncertainty") ||
    !sameValue (get row.row "composition_companion_class") (.text "present") then
    throw "THERMO-010 paired gas composition record is incomplete"
   pure (some gas)
 let dataset ← field target "pressure_dataset_ordinal" >>= identityString
 pure ⟨dataset,pair,pressure,temperature,gas,liquidCount⟩
def bounds (values : List Rat) : Except String (Rat×Rat) := do
 let first ← match values.head? with | some v => pure v | none => throw "min() arg is an empty sequence"
 let low := values.foldl (fun a b => if @decide ((subtract b a).num<0) (Int.decLt _ _) then b else a) first
 let high := values.foldl (fun a b => if @decide ((subtract a b).num<0) (Int.decLt _ _) then b else a) first
 pure (low,high)
def distinctCount (values : List Rat) : Nat :=
 ((values.map fractionText).foldl (fun seen s => if seen.any (Text.equal s) then seen else seen++[s]) ([] : List String)).length
structure Analysis where
 count : Nat
 datasets : List (String×Nat)
 pairs : List (String×String)
 pressureBounds : Rat×Rat
 temperatureBounds : Rat×Rat
 distinctTemperatures : Nat
 gasBounds : Rat×Rat
 checks : List (String×Bool)
def exactRealGasAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let datasets := analyzed.foldl (fun counts row =>
  if counts.any (fun item => Text.equal item.1 row.dataset) then
   counts.map (fun (key,n) => (key,if Text.equal key row.dataset then n+1 else n))
  else counts++[(row.dataset,1)]) ([] : List (String×Nat))
 let pairs := analyzed.foldl (fun pairs row => if pairs.any (fun p => Text.equal p.1 row.components.1 && Text.equal p.2 row.components.2) then pairs else pairs++[row.components]) ([] : List (String×String))
 -- Two stable exact string passes implement the original sorted tuple pairs.
 let ordered := sortFields ((sortFields (pairs.map fun (a,b)=>(b,a))).map fun (b,a)=>(a,b))
 let pressures := analyzed.map RowAnalysis.pressure
 let temperatures := analyzed.map RowAnalysis.temperature
 let gases := analyzed.filterMap RowAnalysis.gas
 let pb ← bounds pressures
 let tb ← bounds temperatures
 let gb ← bounds gases
 let expected := [("12",8),("14",5),("15",24),("17",9),("18",9),("19",27),("21",12)]
 let correctCounts := datasets.length==7 && expected.all (fun (key,n) => datasets.any (fun (k,m) => Text.equal key k && m==n))
 let expectedPairs := [("1","3"),("2","4"),("2","5")]
 let correctPairs := pairs.length==3 && expectedPairs.all (fun (a,b) => pairs.any (fun (x,y) => Text.equal a x && Text.equal b y))
 let liquidCount := analyzed.foldl (fun total row => total+row.liquidCoordinates) 0
 pure ⟨rows.length,datasets,ordered,pb,tb,distinctCount temperatures,gb,[
  ("all_94_equilibrium_states_retained",rows.length==94),
  ("all_seven_pressure_datasets_retained",correctCounts),
  ("all_three_binary_component_pairs_retained",correctPairs),
  ("all_pressures_exact_positive",pressures.length==94),
  ("all_temperatures_exact_positive",temperatures.length==94),
  ("all_liquid_composition_coordinates_retained",liquidCount==94),
  ("all_59_paired_gas_compositions_retained",gases.length==59),
  ("all_35_pressure_only_states_retained",(analyzed.filter fun row => row.gas.isNone).length==35),
  ("measured_pressure_vector_is_nonconstant",distinctCount pressures>1),
  ("measured_gas_composition_vector_is_nonconstant",distinctCount gases>1),
  ("complete_raw_source_surface_preserved",sameValue (get primary "complete_compound_count") (.integer 5) &&
   sameValue (get primary "complete_source_dataset_count") (.integer 21) && sameValue (get primary "complete_source_point_count") (.integer 176) &&
   sameValue (get primary "complete_equilibrium_state_count") (.integer 94) && sameValue (get primary "all_direct_equilibrium_states_and_complete_raw_source_preserved") (.boolean true)),
  ("no_correlated_fitted_or_imported_model_value_used",sameValue (get primary "correlated_regressed_or_model_calculated_values_used_as_measurements") (.boolean false) &&
   sameValue (get primary "equation_of_state_fugacity_or_compressibility_fit_imported") (.boolean false) &&
   sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.RealGasAnalysis
