import SFT.Chemistry.ConformerPopulationWitnesses
import SFT.Chemistry.ConformerPopulationAnalysis
import SFT.Chemistry.CoordinationAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.FiniteMicrostateSupportSource
namespace SFT.Chemistry.ConformerPopulationComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)

abbrev J := Canonical.Value

def expectedLaws : List String := ["exact-conditioned-class-count-ratio","structural-EmptyOne-absence","positive-Take-energy-and-population-order","complete-blind-condition-bound-value-vector"]
def cellAt : List Value → Nat → Except String Value
 | [],_ => .error "tuple index out of range"
 | x::_,0 => .ok x
 | _::xs,n+1 => cellAt xs n

def compare (predicted : JointCorrelationComparison.Predictions) (released : List (String × J)) (row : J) : Except String J := do
 let targetId ← field row "target_id" >>= text
 let word ← JointCorrelationComparison.lookup predicted targetId
 let cells ← match word with
  | .word cells => pure cells
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => throw "prediction consequence requires a word"
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (ConformerPopulationPrediction.identityText row)
 let identities ← (values.zipIdx 1).mapM fun (value,index) => do
  let cell ← cellAt cells index
  return match cell with
   | .label h => Text.equal h.label value
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
 let lawLabels ← (cells.drop 7).mapM fun cell => match cell with
  | .label h => pure h.label
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "law consequence requires a label"
 let lawMatch := lawLabels.length==expectedLaws.length && (lawLabels.zip expectedLaws).all (fun (a,b) => Text.equal a b)
 let actual ← match released.find? (fun p => Text.equal p.1 targetId) with
  | some p => pure p.2
  | none => throw (Text.intercalate "" ["'",targetId,"'"])
 let wanted := canonical (.label (← heldLabel "external-complete-source-record-hash" (← field row "target_payload_hash" >>= text)))
 let targetMatch := ConformerPopulationPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (analysis document : J) (released : List (String × J)) : Except String (List (String × Bool)) := do
 let get := ConformerPopulationPrediction.get analysis
 let documentText := HalfReactionOrientationAnalysis.casefold (FiniteMicrostateSupportSource.spacedRender document)
 return [("omitted_source_rejected",StateSymmetryControls.rejected (ConformerPopulationAnalysis.analysis (rows.take (rows.length-1)) (.object []))),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("all_fourteen_target_hashes_bound_postseal",released.length==14),
  ("exact_witness_populations",ConformerPopulationWitnesses.populationWitness),
  ("exact_successor_populations",ConformerPopulationWitnesses.successorWitness),
  ("blind_ordered_population_sum_exact",ConformerPopulationPrediction.equal (get "ordered_population_fraction_sum") (.text "1")),
  ("blind_population_order_matches_reconstruction",ConformerPopulationPrediction.equal (get "ordered_population_strict_order_reconstructed") (get "ordered_population_order")),
  ("blind_positive_energy_gaps_complete",ConformerPopulationPrediction.equal (get "fold_positive_energy_gaps") (.array [.text "480",.text "178",.text "2605"])),
  ("condition_and_timescale_retained",CoordinationAnalysis.truthy (get "condition_and_observation_timescale_retained")),
  ("all_adverse_routes_preserved",["failed_nist_successor_preserved","failed_osti_fulltext_preserved","failed_v3_recorder_preserved","failed_core_legacy_route_preserved","isotropic_display_rounding_adverse_row_preserved"].all (fun k => CoordinationAnalysis.truthy (get k))),
  ("all_224_acs_measurement_rows_preserved",ConformerPopulationPrediction.equal (get "acs_supporting_measurement_row_count") (.integer 224)),
  ("prediction_contains_no_opened_value_or_payload",!(["0.33","0.51","441","3263","298.5","target_payload_hash"].any (Text.contains documentText)))]

def analysisPassed (analysis : J) : Bool :=
 let get := ConformerPopulationPrediction.get analysis
 CoordinationAnalysis.truthy (get "blind_quantitative_pdf_obtained") &&
 CoordinationAnalysis.truthy (get "blind_quantitative_supporting_file_obtained") &&
 ConformerPopulationPrediction.equal (get "complete_target_count") (.integer 14)
end SFT.Chemistry.ConformerPopulationComparison
