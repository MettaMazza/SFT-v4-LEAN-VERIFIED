import SFT.Chemistry.NucleophilicAnalysis
import SFT.Chemistry.ConjugatedSupportControls
namespace SFT.Chemistry.AdditionHistory
open SFT.Host
open JointCorrelationTargets (field text)
open ConformerPrediction (get equal)
open ConformerAnalysis (array)
abbrev J := Canonical.Value
def history (v5 v6 v8 : J) (query : String) (priorIdentitiesPresent : List Bool) : Except String J := do
 let rows ← field v8 "results_in_original_source_order" >>= array
 let favorable ← rows.mapM fun row => do
  return equal (← field (← field row "comparison") "status") (.text "favorable") &&
   equal (← field row "external_confident_inscription") (.text "True")
 let adverse ← rows.mapM fun row => do
  return equal (← field (← field row "comparison") "status") (.text "adverse") &&
   equal (← field row "external_confident_inscription") (.text "False")
 let lines := HalfReactionOrientationAnalysis.splitLines (Text.chars query) []
 let queryCount := (lines.drop 1).filter (fun line => SFT.Physics.CapabilityValues.nonblank line) |>.length
 let summary : J := .object [
  ("v1_through_v4_identity_and_capture_records_preserved",.boolean (priorIdentitiesPresent.length == 4 && priorIdentitiesPresent.all id)),
  ("v5_complete_rows",← field v5 "complete_conventional_data_row_count"),("v5_qualifying",← field v5 "qualifying_source_count"),
  ("v5_unresolved",← field v5 "unresolved_candidate_count"),("v6_complete_selected",← field v6 "complete_selected_product_count"),
  ("v6_status_counts",← field v6 "status_counts"),("v7_query_data_rows",.integer (.ofNat queryCount)),
  ("v8_complete_selected",← field v8 "complete_selected_product_count"),("v8_status_counts",← field v8 "status_counts"),
  ("v8_independent_confidence_split",.object [("favorable_confident_true",.integer (.ofNat (favorable.filter id).length)),
   ("adverse_confident_false",.integer (.ofNat (adverse.filter id).length))])]
 let expected : J := .object [
  ("v1_through_v4_identity_and_capture_records_preserved",.boolean true),
  ("v5_complete_rows",.integer 1065119),("v5_qualifying",.integer 0),("v5_unresolved",.integer 0),
  ("v6_complete_selected",.integer 47),("v6_status_counts",.object [("adverse",.integer 31),("favorable",.integer 8),("malformed",.integer 0),("unresolved",.integer 8)]),
  ("v7_query_data_rows",.integer 0),("v8_complete_selected",.integer 93),
  ("v8_status_counts",.object [("adverse",.integer 2),("favorable",.integer 91),("malformed",.integer 0),("unresolved",.integer 0)]),
  ("v8_independent_confidence_split",.object [("favorable_confident_true",.integer 91),("adverse_confident_false",.integer 2)])]
 if !equal summary expected then throw "ORG-009 V1--V8 adverse development history changed"
 return summary
end SFT.Chemistry.AdditionHistory
