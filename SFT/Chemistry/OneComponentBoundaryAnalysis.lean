import SFT.Chemistry.RealGasAnalysis
import SFT.Chemistry.TemperatureCorrespondenceSource
namespace SFT.Chemistry.OneComponentBoundaryAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
abbrev sourceFraction := ComponentExchangeAnalysis.sourceFraction
abbrev truthy := ComponentExchangeAnalysis.truthy
abbrev fractionText := InternalEnergyCompositionSource.fractionText
structure RowAnalysis where
 dataset : String
 component : String
 ordinal : Int
 temperature : Rat
 pressure : Rat
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let target := get row.row "target_payload"
 if !sameValue (get target "phase_boundary_class") (.text "one-component-liquid-vapor-coexistence") then
  throw "THERMO-012 phase-boundary class changed"
 let temperature ← field target "temperature_K_external_inscription" >>= identityString >>= sourceFraction
 let pressure ← field target "pressure_kPa_external_inscription" >>= identityString >>= sourceFraction
 if @decide (temperature.num≤0) (Int.decLe _ _) || @decide (pressure.num≤0) (Int.decLe _ _) then
  throw "THERMO-012 external coexistence coordinate is not exact positive"
 if !truthy (get target "pressure_uncertainty") || !truthy (get target "complete_component_record") then
  throw "THERMO-012 uncertainty or component record is absent"
 let property ← match get target "complete_property_metadata" with
  | .array [p] => pure p
  | .array [] | .array (_::_::_) | .null | .boolean _ | .integer _ | .text _ | .object _ => throw "THERMO-012 complete property or variable metadata is absent"
 let sourceVariable ← match get target "complete_variable_metadata" with
  | .array [v] => pure v
  | .array [] | .array (_::_::_) | .null | .boolean _ | .integer _ | .text _ | .object _ => throw "THERMO-012 complete property or variable metadata is absent"
 let group := get (get (get property "Property-MethodID") "PropertyGroup") "VaporPBoilingTAzeotropTandP"
 if !sameValue (get group "ePropName") (.text "Vapor or sublimation pressure, kPa") ||
  !sameValue (get group "sMethodName") (.text "Closed cell (Static) method") ||
  !sameValue (get (get sourceVariable "VariableID") "VariableType" |> fun v => get v "eTemperature") (.text "Temperature, K") then
  throw "THERMO-012 direct measurement method or coordinate changed"
 let dataset ← field target "dataset_ordinal" >>= identityString
 let ordinal ← field target "source_point_ordinal" >>= TemperatureCorrespondenceSource.integer
 let component ← field target "component_orgnum" >>= identityString
 pure ⟨dataset,component,ordinal,temperature,pressure⟩
def before (a b : RowAnalysis) : Bool :=
 if @decide (a.ordinal<b.ordinal) (Int.decLt _ _) then true
 else if @decide (b.ordinal<a.ordinal) (Int.decLt _ _) then false
 else if @decide ((subtract a.temperature b.temperature).num<0) (Int.decLt _ _) then true
 else if @decide ((subtract b.temperature a.temperature).num<0) (Int.decLt _ _) then false
 else @decide ((subtract a.pressure b.pressure).num≤0) (Int.decLe _ _)
def insertPoint (point : RowAnalysis) : List RowAnalysis → List RowAnalysis
 | [] => [point]
 | head::tail => if before point head then point::head::tail else head::insertPoint point tail
def datasetEdges (dataset : String) (points : List RowAnalysis) : Except String Nat := do
 let ordered := points.foldr insertPoint []
 if ordered.length != 5 || !(ordered.zipIdx.all fun (p,i) => @decide (p.ordinal=Int.ofNat (i+1)) (Int.decEq _ _)) then
  throw (Text.intercalate "" ["THERMO-012 dataset ",dataset," lost source succession"])
 let pairs := ordered.zip (ordered.drop 1)
 let checks ← pairs.mapM fun (prior,successor) => do
  if @decide ((subtract successor.temperature prior.temperature).num≤0) (Int.decLe _ _) ||
   @decide ((subtract successor.pressure prior.pressure).num≤0) (Int.decLe _ _) then
   throw "THERMO-012 coexistence succession lost temperature-pressure co-order"
  pure 1
 pure (checks.foldl (·+·) 0)
structure Analysis where
 count : Nat
 datasets : List (String×Nat)
 components : List (String×Nat)
 edges : Nat
 temperatureBounds : Rat×Rat
 pressureBounds : Rat×Rat
 checks : List (String×Bool)
def exactPhaseBoundaryAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let datasets := analyzed.foldl (fun counts row =>
  if counts.any (fun item => Text.equal item.1 row.dataset) then counts.map (fun (key,n)=>(key,if Text.equal key row.dataset then n+1 else n))
  else counts++[(row.dataset,1)]) ([] : List (String×Nat))
 let components := analyzed.foldl (fun counts row =>
  if counts.any (fun item => Text.equal item.1 row.component) then counts.map (fun (key,n)=>(key,if Text.equal key row.component then n+1 else n))
  else counts++[(row.component,1)]) ([] : List (String×Nat))
 let groups := analyzed.foldl (fun groups row =>
  if groups.any (fun item => Text.equal item.1 row.dataset) then groups.map (fun (key,points)=>(key,if Text.equal key row.dataset then points++[row] else points))
  else groups++[(row.dataset,[row])]) ([] : List (String×List RowAnalysis))
 let edges ← groups.mapM fun (key,points) => datasetEdges key points
 let edgeCount := edges.foldl (·+·) 0
 let temperatures := analyzed.map RowAnalysis.temperature
 let pressures := analyzed.map RowAnalysis.pressure
 let tb ← RealGasAnalysis.bounds temperatures
 let pb ← RealGasAnalysis.bounds pressures
 let datasetsMatch := datasets.length==3 && [("5",5),("8",5),("11",5)].all (fun (k,n)=>datasets.any fun (key,count)=>Text.equal key k && count==n)
 let componentsMatch := components.length==2 && [("4",10),("5",5)].all (fun (k,n)=>components.any fun (key,count)=>Text.equal key k && count==n)
 pure ⟨rows.length,datasets,components,edgeCount,tb,pb,[
  ("all_15_points_retained",rows.length==15),
  ("all_three_complete_datasets_retained",datasetsMatch),
  ("both_compounds_and_parallel_component_four_datasets_retained",componentsMatch),
  ("all_12_adjacent_successions_exactly_coordered",edgeCount==12),
  ("all_coordinates_exact_positive",temperatures.length==15 && pressures.length==15),
  ("complete_parent_source_preserved",sameValue (get primary "complete_parent_compound_count") (.integer 5) && sameValue (get primary "complete_parent_dataset_count") (.integer 21) && sameValue (get primary "complete_parent_point_count") (.integer 176) && sameValue (get primary "all_direct_one_component_points_and_complete_parent_source_preserved") (.boolean true)),
  ("no_imported_curve_equation_interpolation_or_fit",sameValue (get primary "clausius_clapeyron_eos_interpolation_regression_or_model_value_used") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.OneComponentBoundaryAnalysis
