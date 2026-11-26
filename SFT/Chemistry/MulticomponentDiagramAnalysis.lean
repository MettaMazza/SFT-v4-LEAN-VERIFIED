import SFT.Chemistry.MulticomponentPhaseDiagram
import SFT.Chemistry.RealGasAnalysis
import SFT.Chemistry.TemperatureCorrespondenceSource
namespace SFT.Chemistry.MulticomponentDiagramAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open MulticomponentPhaseDiagram
abbrev sourceFraction := ComponentExchangeAnalysis.sourceFraction
abbrev truthy := ComponentExchangeAnalysis.truthy
abbrev fractionText := InternalEnergyCompositionSource.fractionText
def positiveRatio (value : Rat) : Except String DihedralTorsion.Ratio := do
 let n ← CapabilityValues.count value.num.natAbs
 let d ← CapabilityValues.count value.den
 pure ⟨n,d⟩
def coordinate (component : Int) (value : Rat) : Except String PhaseCompositionCoordinate := do
 if @decide (value.num<0) (Int.decLt _ _) || @decide (Int.ofNat value.den<value.num) (Int.decLt _ _) then
  throw "THERMO-013 external composition is outside the exact One boundary"
 let name ← identityString (.integer component)
 let label ← CapabilityValues.heldLabel "chemical-component" name
 if @decide (value.num=0) (Int.decEq _ _) then makeCoordinate (.held label) .emptyOne
 else do
  let ratio ← positiveRatio value
  makeCoordinate (.held label) (.ratio ratio)
def phaseWord (phase : String) (components : List Int) (values : List Rat) : Except String ExactPhaseCompositionWord := do
 if components.length != values.length then throw "THERMO-013 component-coordinate support is incomplete"
 let phase ← CapabilityValues.heldLabel "chemical-phase" phase
 let rows ← (components.zip values).mapM fun (c,v)=>coordinate c v
 makeWord (.held phase) (rows.map CoordinateInput.coordinate)
structure RowAnalysis where
 className : String
 pair : String
 temperature : Rat
 pressure : Rat
 coordinates : List Rat
 emptyCount : Nat
 equalBinary : Bool
 rank : Nat
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let target := get row.row "target_payload"
 let className ← identityString (get target "dataset_class")
 let rawComponents ← match get target "component_orgnums" with | .array xs => pure xs | .null => pure [] | .boolean _ | .integer _ | .text _ | .object _ => throw "THERMO-013 component class changed"
 let components ← rawComponents.mapM TemperatureCorrespondenceSource.integer
 let binary := Text.equal className "binary"
 if !(binary || Text.equal className "ternary") || components.length != (if binary then 2 else 3) then
  throw "THERMO-013 component class changed"
 let records := match get target "complete_component_records" with | .array xs => xs.length | .null | .boolean _ | .integer _ | .text _ | .object _ => 0
 let phases ← match get target "phase_ids" with | .array xs => pure xs | .null | .boolean _ | .integer _ | .text _ | .object _ => pure []
 if records != components.length || phases.length != 2 then throw "THERMO-013 component or phase provenance is incomplete"
 if !(phases.any fun p=>sameValue (get p "ePhase") (.text "Liquid")) ||
  !(phases.any fun p=>sameValue (get p "ePhase") (.text "Gas")) then throw "THERMO-013 liquid-gas phase pair changed"
 let temperature ← field target "temperature_K_external_inscription" >>= identityString >>= sourceFraction
 let pressure ← field target "pressure_kPa_external_inscription" >>= identityString >>= sourceFraction
 if @decide (temperature.num≤0) (Int.decLe _ _) || @decide (pressure.num≤0) (Int.decLe _ _) then
  throw "THERMO-013 external environment is not exact positive"
 let one : Rat := ⟨1,1,by decide,by decide⟩
 let (liquidValues,gasValues,equalBinary) ← if binary then do
  let x ← field target "liquid_reported_mole_fraction_external_inscription" >>= identityString >>= sourceFraction
  let y ← field target "gas_reported_mole_fraction_external_inscription" >>= identityString >>= sourceFraction
  pure ([x,subtract one x],[y,subtract one y],@decide ((subtract x y).num=0) (Int.decEq _ _))
 else do
  let x ← field target "liquid_component_1_mole_fraction_external_inscription" >>= identityString >>= sourceFraction
  let z ← field target "liquid_component_2_mole_fraction_external_inscription" >>= identityString >>= sourceFraction
  let y ← field target "gas_component_1_mole_fraction_external_inscription" >>= identityString >>= sourceFraction
  let w ← field target "gas_component_2_mole_fraction_external_inscription" >>= identityString >>= sourceFraction
  pure ([x,z,subtract (subtract one x) z],[y,w,subtract (subtract one y) w],false)
 let liquid ← phaseWord "liquid" components liquidValues
 let gas ← phaseWord "gas" components gasValues
 let exchange := liquid.coordinates.zipIdx.map fun (c,i) => (⟨c.componentIdentity,⟨i+1,Nat.zero_lt_succ i⟩,⟨i+1,Nat.zero_lt_succ i⟩⟩ : ComponentExchangeSupport)
 let temperatureRatio ← positiveRatio temperature
 let pressureRatio ← positiveRatio pressure
 let point ← makePoint (.word liquid) (.word gas) (.ratio temperatureRatio) (.ratio pressureRatio) exchange
 let rank ← multicomponentTwoPhaseDegreeSupport point
 if rank.value != 2 && rank.value != 3 then throw "THERMO-013 two-phase degree rank changed"
 let coordinates := liquidValues++gasValues
 if coordinates.any (fun v=> @decide (v.num<0) (Int.decLt _ _) || @decide (Int.ofNat v.den<v.num) (Int.decLt _ _)) then
  throw "THERMO-013 exact complement left the One boundary"
 let emptyCount := ((liquid.coordinates++gas.coordinates).filter fun c=>match c.coordinate with
  | .emptyOne | .otherEmptyOne _ => true
  | .ratio _ | .invalid => false).length
 let pairs ← field target "dataset_ordinals" >>= RunningConvergenceMeasurement.array
 let pair := Text.intercalate "," (← pairs.mapM identityString)
 if !truthy (get target "complete_pressure_record") || !truthy (get target "complete_component_records") then
  throw "THERMO-013 complete measurement provenance is absent"
 pure ⟨className,pair,temperature,pressure,coordinates,emptyCount,equalBinary,rank.value⟩
structure Analysis where
 count : Nat
 classes : List (String×Nat)
 pairs : List (String×Nat)
 coordinateCount : Nat
 emptyCount : Nat
 equalBinaryCount : Nat
 binaryRanks : Nat
 ternaryRanks : Nat
 temperatureBounds : Rat×Rat
 pressureBounds : Rat×Rat
 coordinateBounds : Rat×Rat
 checks : List (String×Bool)
def exactMulticomponentAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let classes := analyzed.foldl (fun counts row=>
  if counts.any (fun item=>Text.equal item.1 row.className) then counts.map (fun (k,n)=>(k,if Text.equal k row.className then n+1 else n))
  else counts++[(row.className,1)]) ([] : List (String×Nat))
 let pairs := analyzed.foldl (fun counts row=>
  if counts.any (fun item=>Text.equal item.1 row.pair) then counts.map (fun (k,n)=>(k,if Text.equal k row.pair then n+1 else n))
  else counts++[(row.pair,1)]) ([] : List (String×Nat))
 let temperatures := analyzed.map RowAnalysis.temperature
 let pressures := analyzed.map RowAnalysis.pressure
 let coordinates := analyzed.flatMap RowAnalysis.coordinates
 let emptyCount := analyzed.foldl (fun n row=>n+row.emptyCount) 0
 let equalBinary := (analyzed.filter RowAnalysis.equalBinary).length
 let binaryRanks := (analyzed.filter fun row=>row.rank==2).length
 let ternaryRanks := (analyzed.filter fun row=>row.rank==3).length
 let tb ← RealGasAnalysis.bounds temperatures
 let pb ← RealGasAnalysis.bounds pressures
 let cb ← RealGasAnalysis.bounds coordinates
 let classesMatch := classes.length==2 && [("binary",65),("ternary",51)].all (fun (k,n)=>classes.any fun (key,count)=>Text.equal k key && n==count)
 let pairsMatch := pairs.length==6 && [("7,8",1),("9,10",21),("11,12",1),("13,14",21),("15,16",21),("17",51)].all (fun (k,n)=>pairs.any fun (key,count)=>Text.equal k key && n==count)
 pure ⟨rows.length,classes,pairs,coordinates.length,emptyCount,equalBinary,binaryRanks,ternaryRanks,tb,pb,cb,[
  ("all_116_records_retained",rows.length==116),
  ("all_65_binary_and_51_ternary_records_retained",classesMatch),
  ("all_five_binary_pairs_and_complete_ternary_surface_retained",pairsMatch),
  ("all_566_exact_phase_coordinates_close_to_One",coordinates.length==566),
  ("all_12_absent_coordinates_are_EmptyOne",emptyCount==12),
  ("all_binary_and_ternary_phase_rule_ranks_retained",binaryRanks==65 && ternaryRanks==51),
  ("all_8_equal_binary_phase_coordinates_retained",equalBinary==8),
  ("complete_parent_source_preserved",sameValue (get primary "complete_source_compound_count") (.integer 3) && sameValue (get primary "complete_source_dataset_count") (.integer 17) && sameValue (get primary "complete_source_point_count") (.integer 187) && sameValue (get primary "complete_companion_pure_dataset_count") (.integer 6) && sameValue (get primary "all_direct_binary_and_ternary_points_and_complete_source_preserved") (.boolean true)),
  ("no_imported_phase_geometry_eos_interpolation_or_fit",sameValue (get primary "lever_rule_tie_line_equation_gibbs_triangle_convex_hull_eos_continuum_interpolation_regression_or_fit_used") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.MulticomponentDiagramAnalysis
