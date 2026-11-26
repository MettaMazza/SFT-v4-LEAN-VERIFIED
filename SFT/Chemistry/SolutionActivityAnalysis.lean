import SFT.Chemistry.ComponentExchangeAnalysis
namespace SFT.Chemistry.SolutionActivityAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
structure RowAnalysis where
 dataset : String
 activity : Rat
 temperature : Rat
 absentCoordinates : Nat
 entries : Nat
def analyzeRow (target : Value) : Except String RowAnalysis := do
 let activity ← field target "relative_water_activity_external_inscription" >>= identityString >>= ComponentExchangeAnalysis.sourceFraction
 let temperature ← field target "temperature_K_external_inscription" >>= identityString >>= ComponentExchangeAnalysis.sourceFraction
 if @decide (activity.num≤0) (Int.decLe _ _) || @decide (Int.ofNat activity.den<activity.num) (Int.decLt _ _) then
  throw "THERMO-009 activity is not an exact positive part of the One"
 if !sameValue (get target "external_measurement_method") (.text "ISOPIE") ||
  !sameValue (get target "external_standard_state") (.text "Pure compound") then
  throw "THERMO-009 source method or standard state changed"
 if !ComponentExchangeAnalysis.truthy (get target "activity_uncertainty") then throw "THERMO-009 source uncertainty is absent"
 let entries ← match get target "composition_interface_entries" with
  | .array xs => pure xs
  | .null => pure []
  | .boolean _ | .integer _ | .text _ | .object _ => throw "THERMO-009 composition is not complete binary or ternary support"
 if !(entries.length==1 || entries.length==2) then throw "THERMO-009 composition is not complete binary or ternary support"
 let absent ← entries.mapM fun entry => do
  let inscription ← field entry "external_molality_inscription" >>= identityString >>= ComponentExchangeAnalysis.sourceFraction
  if @decide (inscription.num=0) (Int.decEq _ _) then
   if !sameValue (get entry "sft_interface_state") (.text "EmptyOne") then
    throw "THERMO-009 external absence glyph was consumed as a number"
   pure true
  else if @decide (0<inscription.num) (Int.decLt _ _) then
   if !sameValue (get entry "sft_interface_state") (.text "exact-positive-composition-coordinate") then
    throw "THERMO-009 positive composition coordinate was relabelled"
   pure false
  else throw "THERMO-009 composition contains a negative external inscription"
 let dataset ← field target "dataset_ordinal" >>= identityString
 pure ⟨dataset,activity,temperature,(absent.filter id).length,entries.length⟩
structure Analysis where
 count : Nat
 datasets : List (String×Nat)
 activities : List Rat
 minimum : Rat
 maximum : Rat
 distinct : Nat
 checks : List (String×Bool)
def exactSolutionActivityAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM fun row => analyzeRow (get row.row "target_payload")
 let datasets := analyzed.foldl (fun counts row =>
  if counts.any (fun item => Text.equal item.1 row.dataset) then
   counts.map (fun (key,n) => (key,if Text.equal key row.dataset then n+1 else n))
  else counts++[(row.dataset,1)]) ([] : List (String×Nat))
 let activities := analyzed.map RowAnalysis.activity
 let first ← match activities.head? with | some a => pure a | none => throw "min() arg is an empty sequence"
 let minimum := activities.foldl (fun a b => if @decide ((subtract b a).num<0) (Int.decLt _ _) then b else a) first
 let maximum := activities.foldl (fun a b => if @decide ((subtract a b).num<0) (Int.decLt _ _) then b else a) first
 let distinct := (activities.map InternalEnergyCompositionSource.fractionText).foldl (fun values s => if values.any (Text.equal s) then values else values++[s]) ([] : List String)
 let expected := [("1",36),("2",32),("3",36),("4",32),("5",34),("6",9),("7",8),("8",9),("9",8)]
 let correctCounts := datasets.length==9 && expected.all (fun (key,n) => datasets.any (fun (k,m) => Text.equal key k && m==n))
 let absentRows := (analyzed.filter fun row => row.absentCoordinates>0).length
 let absentCoordinates := analyzed.foldl (fun total row => total+row.absentCoordinates) 0
 pure ⟨rows.length,datasets,activities,minimum,maximum,distinct.length,[
  ("all_204_rows_retained",rows.length==204),
  ("all_nine_datasets_retained",correctCounts),
  ("all_rows_share_fixed_298_15_K_environment",!analyzed.isEmpty && analyzed.all fun row => Text.equal (InternalEnergyCompositionSource.fractionText row.temperature) "5963/20"),
  ("all_activities_exact_positive_parts_of_One",activities.length==204),
  ("all_68_absence_rows_and_coordinates_translated_to_EmptyOne",absentRows==68 && absentCoordinates==68),
  ("complete_binary_and_ternary_rows_retained",(analyzed.filter fun row => row.entries==1).length==68 && (analyzed.filter fun row => row.entries==2).length==136),
  ("activity_vector_contains_nonconstant_measured_response",distinct.length>1),
  ("complete_raw_source_surface_preserved",sameValue (get primary "complete_compound_count") (.integer 6) &&
   sameValue (get primary "complete_dataset_count") (.integer 9) && sameValue (get primary "complete_activity_row_count") (.integer 204) &&
   sameValue (get primary "all_direct_activity_rows_and_absent_component_boundaries_preserved") (.boolean true)),
  ("no_correlated_or_fitted_model_value_used",sameValue (get primary "correlated_regressed_or_model_calculated_values_used_as_measurements") (.boolean false) &&
   sameValue (get primary "activity_coefficient_fitted_or_imported") (.boolean false))]⟩
end SFT.Chemistry.SolutionActivityAnalysis
