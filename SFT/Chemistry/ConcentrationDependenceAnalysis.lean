import SFT.Chemistry.ConcentrationDependence
import SFT.Chemistry.MolecularDiffusionAnalysis
namespace SFT.Chemistry.ConcentrationDependenceAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open ConcentrationDependence
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev ratioRat := SolvationDissolutionAnalysis.ratioRat
abbrev sourceInteger := TemperatureCorrespondenceSource.integer
structure RowAnalysis where
 lawRow : ConcentrationRateRow
 temperature : Rat
 density : Rat
 rate : Rat
 uncertaintyCount : Nat
 note : Value
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let t := get row.row "target_payload"
 let method := match get t "measurement_method" with | .text s=>s | .null | .boolean _ | .integer _ | .array _ | .object _=>""
 let disclosure := match get t "source_table_fit_disclosure" with | .text s=>s | .null | .boolean _ | .integer _ | .array _ | .object _=>""
 if !sameValue (get t "reaction_identity") (.text "OH + dimethyl ether") || !Text.contains method "Laval" ||
  !sameValue (get t "fitted_exponent_or_coefficient_used_in_fold_law") (.boolean false) || !Text.contains disclosure "pseudo-first-order" then
  throw "KIN-002 source reaction, method or fit disclosure changed"
 let decode := fun (value : Value)=>externalPositiveMagnitude (match value with | .text s=>.text s | .null | .boolean _ | .integer _ | .array _ | .object _=>.other)
 let temperatureValue ← field t "temperature_K_external_inscription"
 let temperature ← decode temperatureValue
 let density ← field t "flow_density_1e16_molecule_cm_minus3_external_inscription" >>= decode
 let rate ← field t "rate_coefficient_molecule_minus1_cm3_s_minus1_external_inscription" >>= decode
 let uncertainties ← ["temperature_uncertainty_K_external_inscription","flow_density_uncertainty_1e16_molecule_cm_minus3_external_inscription","rate_uncertainty_molecule_minus1_cm3_s_minus1_external_inscription"].mapM fun key=>field t key >>= decode
 let temperatureText ← identityString temperatureValue
 let condition ← CapabilityValues.heldLabel "complete-condition" (Text.intercalate "" ["temperature-",temperatureText,"-K"])
 let ordinal ← field row.row "source_row_ordinal" >>= sourceInteger
 let n ← match ordinal with
  | .ofNat n=>CapabilityValues.count n
  | .negSucc _=>Except.error "an SFT count must be a positive counted value"
 let lawRow ← makeRow (.held ⟨"registered-reactant","OH-plus-DME",rfl,rfl⟩) (.held condition)
  (.ratio density) (.ratio rate) (.count n) (uncertainties.map DihedralTorsion.Height.ratio ++ [.emptyOne])
 pure ⟨lawRow,ratioRat temperature,ratioRat density,ratioRat rate,uncertainties.length,
  if hasKey t "source_note_markers" then get t "source_note_markers" else .text ""⟩
structure Analysis where
 count : Nat
 uncertaintyCount : Nat
 notes : List Value
 temperatureBounds : Rat×Rat
 densityBounds : Rat×Rat
 rateBounds : Rat×Rat
 checks : List (String×Bool)
def exactConcentrationDependenceAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let relation ← forcedConcentrationDependence (analyzed.map fun row=>RowInput.row row.lawRow)
 let sourceOrder := relation.orderedRows.map fun (_,_,_,n)=>n.value
 let expected := (List.range 9).map (fun n=>n+1)
 let orderCheck := sourceOrder.length==expected.length && (sourceOrder.zip expected).all (fun (x,y)=>x==y)
 let uncertainties := analyzed.foldl (fun n row=>n+row.uncertaintyCount) 0
 let temperatures ← RealGasAnalysis.bounds (analyzed.map RowAnalysis.temperature)
 let densities ← RealGasAnalysis.bounds (analyzed.map RowAnalysis.density)
 let rates ← RealGasAnalysis.bounds (analyzed.map RowAnalysis.rate)
 pure ⟨rows.length,uncertainties,analyzed.map RowAnalysis.note,temperatures,densities,rates,[
  ("all_nine_rows_retained_in_source_order",orderCheck),
  ("all_27_uncertainty_coordinates_retained",uncertainties==27),
  ("all_notes_and_adverse_rows_retained",analyzed.length==9),
  ("complete_pdf_and_table_preserved",sameValue (get primary "complete_pdf_page_count") (.integer 13) && sameValue (get primary "all_table_2_rows_uncertainties_and_notes_preserved") (.boolean true)),
  ("no_imported_power_order_fit_or_selection",sameValue (get primary "mass_action_power_law_reaction_order_fitted_exponent_coefficient_logarithm_continuum_derivative_selection_or_target_correction_used_in_law") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.ConcentrationDependenceAnalysis
