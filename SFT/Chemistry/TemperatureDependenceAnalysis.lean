import SFT.Chemistry.TemperatureDependence
import SFT.Chemistry.MolecularDiffusionAnalysis
namespace SFT.Chemistry.TemperatureDependenceAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open TemperatureDependence
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev ratioRat := SolvationDissolutionAnalysis.ratioRat
abbrev sourceInteger := TemperatureCorrespondenceSource.integer
structure RowAnalysis where
 lawRow : TemperatureRateRow
 temperature : Rat
 density : Rat
 rate : Rat
 uncertaintyCount : Nat
 reactionKey : String
def analyzeRow (row : InternalEnergyCompositionSource.Target) (targetOrdinal : Nat) : Except String RowAnalysis := do
 let t := get row.row "target_payload"
 let method := match get t "measurement_method" with | .text s=>s | .null | .boolean _ | .integer _ | .array _ | .object _=>""
 let disclosure := match get t "source_error_disclosure" with | .text s=>s | .null | .boolean _ | .integer _ | .array _ | .object _=>""
 if !(sameValue (get t "reaction_identity") (.text "OH + ethanol") || sameValue (get t "reaction_identity") (.text "OH + propan-2-ol")) || !Text.contains method "Laval" ||
  !sameValue (get t "fitted_arrhenius_prefactor_or_activation_value_used_in_fold_law") (.boolean false) || !Text.contains disclosure "95 percent confidence" then
  throw "KIN-003 source reaction, method or error disclosure changed"
 let decode := fun (value : Value)=>externalPositiveMagnitude (match value with | .text s=>.text s | .null | .boolean _ | .integer _ | .array _ | .object _=>.other)
 let temperatureValue ← field t "temperature_K_external_inscription"
 let temperature ← decode temperatureValue
 let density ← field t "total_density_1e16_molecule_cm_minus3_external_inscription" >>= decode
 let rate ← field t "rate_coefficient_molecule_minus1_cm3_s_minus1_external_inscription" >>= decode
 let uncertainties ← ["temperature_uncertainty_K_external_inscription","total_density_uncertainty_1e16_molecule_cm_minus3_external_inscription","rate_uncertainty_molecule_minus1_cm3_s_minus1_external_inscription"].mapM fun key=>field t key >>= decode
 let reactionKey ← field t "reaction_key" >>= identityString
 let reaction ← CapabilityValues.heldLabel "registered-reaction" reactionKey
 let bathGas ← field t "bath_gas" >>= identityString
 let densityText ← field t "total_density_1e16_molecule_cm_minus3_external_inscription" >>= identityString
 let conditionOrdinalValue ← field t "source_condition_row_ordinal"
 let conditionOrdinalText ← identityString conditionOrdinalValue
 let condition ← CapabilityValues.heldLabel "complete-condition" (Text.intercalate "" [bathGas,"-density-",densityText,"-source-row-",conditionOrdinalText])
 let ordinal ← sourceInteger conditionOrdinalValue
 let n ← match ordinal with
  | .ofNat n=>CapabilityValues.count n
  | .negSucc _=>Except.error "an SFT count must be a positive counted value"
 let targetN ← CapabilityValues.count targetOrdinal
 let lawRow ← makeRow (.held reaction) (.held condition)
  (.ratio temperature) (.ratio rate) (.count n) (.count targetN) (uncertainties.map DihedralTorsion.Height.ratio)
 pure ⟨lawRow,ratioRat temperature,ratioRat density,ratioRat rate,uncertainties.length,reactionKey⟩
structure Analysis where
 count : Nat
 conditionCount : Nat
 uncertaintyCount : Nat
 reactionCounts : List (String×Nat)
 absenceCount : Nat
 temperatureBounds : Rat×Rat
 densityBounds : Rat×Rat
 rateBounds : Rat×Rat
 checks : List (String×Bool)
def exactTemperatureDependenceAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.zipIdx.mapM fun (row,i)=>analyzeRow row (i+1)
 let relation ← forcedTemperatureDependence (analyzed.map fun row=>RowInput.row row.lawRow)
 let sourceOrder := relation.orderedRows.map fun (_,_,_,_,_,n)=>n.value
 let expected := (List.range 19).map (fun n=>n+1)
 let orderCheck := sourceOrder.length==expected.length && (sourceOrder.zip expected).all (fun (x,y)=>x==y)
 let uncertainties := analyzed.foldl (fun n row=>n+row.uncertaintyCount) 0
 let reactions : List (String×Nat) := analyzed.foldl (fun acc row=>
  if acc.any (fun (k,_)=>Text.equal k row.reactionKey) then
   acc.map (fun (k,n)=>(k,if Text.equal k row.reactionKey then n+1 else n))
  else acc++[(row.reactionKey,1)]) []
 let matrix ← RunningConvergenceMeasurement.array (if hasKey primary "complete_source_ordered_table_matrix" then get primary "complete_source_ordered_table_matrix" else .array [])
 let absences ← matrix.mapM fun row=>do
  let cells ← ["ethanol_rate_1e_minus11_molecule_minus1_cm3_s_minus1_external_inscription","propan-2-ol_rate_1e_minus11_molecule_minus1_cm3_s_minus1_external_inscription"].mapM fun key=>field row key
  pure ((cells.filter (fun v=>sameValue v (.text "EmptyOne"))).length)
 let absenceCount := absences.foldl Nat.add 0
 let temperatures ← RealGasAnalysis.bounds (analyzed.map RowAnalysis.temperature)
 let densities ← RealGasAnalysis.bounds (analyzed.map RowAnalysis.density)
 let rates ← RealGasAnalysis.bounds (analyzed.map RowAnalysis.rate)
 pure ⟨rows.length,matrix.length,uncertainties,reactions,absenceCount,temperatures,densities,rates,[
  ("all_nineteen_targets_retained_in_source_order",orderCheck),
  ("both_registered_reactions_retained",reactions.length==2 && reactions.any (fun (k,n)=>Text.equal k "ethanol" && n==13) && reactions.any (fun (k,n)=>Text.equal k "propan-2-ol" && n==6)),
  ("all_fifty_seven_uncertainty_coordinates_retained",uncertainties==57),
  ("all_fourteen_condition_rows_and_nine_absences_retained",matrix.length==14 && absenceCount==9),
  ("complete_pdf_and_measured_table_preserved",sameValue (get primary "complete_pdf_page_count") (.integer 27) && sameValue (get primary "all_table_1_rows_columns_uncertainties_absences_and_note_preserved") (.boolean true)),
  ("fitted_table_excluded_without_value_selection",sameValue (get primary "fitted_table_2_excluded_by_prefetch_measured_table_rule") (.boolean true)),
  ("no_imported_or_fitted_form_or_selection",sameValue (get primary "arrhenius_exponential_logarithmic_prefactor_activation_value_continuum_derivative_selection_fit_or_target_correction_used_in_law") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.TemperatureDependenceAnalysis
