import SFT.Chemistry.InsertionEliminationAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.InsertionEliminationComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["complete-before-after-removed-added-adjacency-trace","insertion-and-exact-extrusion-boundary","migration-plus-insertion-and-two-eliminand-laws","complete-ten-row-scope-absence-and-product-retention"]
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
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (InsertionEliminationPrediction.identityText row)
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
 let targetMatch := InsertionEliminationPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := InsertionEliminationPrediction.get analysis
 let eq := InsertionEliminationPrediction.equal
 return [("omitted_source_row_rejected",StateSymmetryControls.rejected (InsertionEliminationAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("all_ten_target_hashes_bound_postseal",released.length==10),
  ("absent_rendered_example_preserved",eq (get "rendered_structure_absence_count") (.integer 1)),
  ("sources_not_recaptured",eq (get "source_recapture_count") (.integer 0)),
  ("prediction_contains_no_definition_product_or_target",!["complete_definition_text","target_payload_hash","X-Z + Y -> X-Y-Z"].any (fun token => Text.contains (Canonical.render document) token))]
def analysisPassed (analysis : J) : Bool :=
 let get := InsertionEliminationPrediction.get analysis
 let eq := InsertionEliminationPrediction.equal
 eq (get "insertion_before_count") (.integer 1) &&
 eq (get "insertion_after_count") (.integer 2) &&
 eq (get "insertion_removed_count") (.integer 1) &&
 eq (get "insertion_added_count") (.integer 2) &&
 CoordinationAnalysis.truthy (get "extrusion_restores_source") &&
 eq (get "migratory_composition") (.array [.text "migration",.text "insertion"]) &&
 eq (get "migratory_common_edge_count") (.integer 1) &&
 eq (get "distinct_eliminand_removed_count") (.integer 2) &&
 eq (get "single_centre_carrier_count") (.integer 3) &&
 eq (get "complete_target_count") (.integer 10) &&
 eq (get "complete_source_count") (.integer 3) &&
 CoordinationAnalysis.truthy (get "all_registered_surfaces_present") &&
 eq (get "scope_distinction_count") (.integer 1) &&
 CoordinationAnalysis.truthy (get "all_rows_preserved")
end SFT.Chemistry.InsertionEliminationComparison
