import SFT.Chemistry.ElementaryTransitionRate
import SFT.Chemistry.MolecularDiffusionAnalysis
namespace SFT.Chemistry.ElementaryTransitionRateAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open ElementaryTransitionRate
abbrev truthy := ComponentExchangeAnalysis.truthy
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev ratioRat := SolvationDissolutionAnalysis.ratioRat
abbrev addCount := SolvationDissolutionAnalysis.addCount
abbrev sourceInteger := TemperatureCorrespondenceSource.integer
abbrev Range := MolecularDiffusionAnalysis.Range
-- Error text of the original direct Fraction(str(...)) temperature conversion.
def temperatureFraction (text : String) : Except String Rat :=
 match SolvationDissolution.fractionInscription text with
 | .ok r=>.ok r
 | .error _=>.error (Text.intercalate "" ["Invalid literal for Fraction: '",text,"'"])
structure RowAnalysis where
 order : String
 source : String
 rate : Rat
 temperature : Rat
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let t := get row.row "target_payload"
 let metadata := get t "complete_source_metadata"
 let dataType := match get metadata "Data type" with | .text s=>s | .null | .boolean _ | .integer _ | .array _ | .object _=>""
 if !sameValue (get metadata "Category") (.text "Experiment") || !Text.contains (Text.lowerAscii dataType) "measured" ||
  !truthy (get metadata "Reaction") || !truthy (get metadata "Rate expression") ||
  !sameValue (get t "source_reported_rate_is_arrhenius_tabulation_of_direct_experimental_record") (.boolean true) ||
  !sameValue (get t "raw_event_count_claimed") (.boolean false) then
  throw "KIN-001 complete external experimental provenance changed"
 let orderValue := get metadata "Reaction order"
 if !(["1","2","3"].any fun v=>sameValue orderValue (.text v)) then throw "KIN-001 source-declared external order class changed"
 let rateText ← identityString (if hasKey t "rate_external_inscription" then get t "rate_external_inscription" else .text "")
 let rate ← externalRateMagnitude (.text rateText)
 let temperatureText ← identityString (if hasKey t "temperature_K_external_inscription" then get t "temperature_K_external_inscription" else .text "")
 let temperature ← temperatureFraction temperatureText
 if (@decide (temperature.num≤0) (Int.decLe _ _)) || !truthy (get t "rate_unit_external_inscription") then throw "KIN-001 external condition or unit changed"
 let reactionText ← field row.row "record_id" >>= text
 let reaction ← CapabilityValues.heldLabel "registered-elementary-reaction" reactionText
 let ordinal ← field row.row "source_row_ordinal" >>= sourceInteger
 let events ← match ordinal with
  | .ofNat n=>CapabilityValues.count n
  | .negSucc _=>Except.error "an SFT count must be a positive counted value"
 let temperatureSupport ← SolvationDissolution.positiveRatio temperature
 let account ← makeAccount (.held reaction) (.held ⟨"molecular-state","source-bound-reactant-state",rfl,rfl⟩)
  (.held ⟨"molecular-state","source-bound-product-state",rfl,rfl⟩) (.count events) (.count ⟨1,by decide⟩) (.count ⟨1,by decide⟩)
  [.ratio temperatureSupport,.emptyOne]
 let relation ← forcedElementaryTransitionRate (.account account)
 if !Text.equal relation.carrier.label reactionText then throw "KIN-001 registered elementary carrier changed"
 let order ← text orderValue
 let source ← field row.row "source_id" >>= text
 pure ⟨order,source,ratioRat rate,temperature⟩
structure Analysis where
 count : Nat
 orders : List (String×Nat)
 sources : List (String×Nat)
 rateRanges : List Range
 temperatureRanges : List Range
 checks : List (String×Bool)
def exactElementaryRateAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let orders := analyzed.foldl (fun cs row=>addCount cs row.order) []
 let sources := analyzed.foldl (fun cs row=>addCount cs row.source) []
 let rates ← MolecularDiffusionAnalysis.exactRanges (analyzed.map fun row=>(row.order,row.rate))
 let temperatures ← MolecularDiffusionAnalysis.exactRanges (analyzed.map fun row=>(row.order,row.temperature))
 let expected := [("1",4),("2",24),("3",18)]
 let orderCheck := orders.length==expected.length && expected.all (fun (k,n)=>orders.any fun (key,count)=>Text.equal k key && n==count)
 pure ⟨rows.length,orders,sources,rates,temperatures,[
  ("all_46_rows_retained",rows.length==46),
  ("all_declared_order_classes_retained",orderCheck),
  ("all_four_complete_sources_retained",sources.length==4 && (sources.foldl (fun n x=>n+x.2) 0)==46),
  ("all_sources_direct_experiment_records",true),
  ("arrhenius_tabulations_disclosed_not_raw_event_counts",rows.all fun row=>sameValue (get (get row.row "target_payload") "raw_event_count_claimed") (.boolean false)),
  ("no_imported_rate_law_fit_or_selection",sameValue (get primary "mass_action_rate_equation_reaction_order_arrhenius_logarithm_concentration_derivative_continuum_selection_fit_or_target_correction_used_in_law") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.ElementaryTransitionRateAnalysis
