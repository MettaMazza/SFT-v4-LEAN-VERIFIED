import SFT.Chemistry.CoordinationGeometryAnalysis
import SFT.Chemistry.MulticentreControls
namespace SFT.Chemistry.CoordinationGeometryComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["complete-held-direct-position-and-boundary-adjacency-signature",
 "positive-count-retained-but-never-shape-selecting","generator-three-space-and-boundary-rank-two",
 "all-fifty-three-reported-adverse-absent-and-unresolved-surfaces-retained"]
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
 let values ← ["source_record_ordinal","authority","source_id","source_document_identity","source_record_role"].mapM (CoordinationGeometryPrediction.identityText row)
 let identities ← (values.zipIdx 1).mapM fun (value,index) => do
  let cell ← cellAt cells index
  return match cell with
   | .label h => Text.equal h.label value
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
 let lawLabels ← (cells.drop 6).mapM fun cell => match cell with
  | .label h => pure h.label
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "law consequence requires a label"
 let lawMatch := lawLabels.length==expectedLaws.length && (lawLabels.zip expectedLaws).all (fun (a,b) => Text.equal a b)
 let actual ← match released.find? (fun p => Text.equal p.1 targetId) with
  | some p => pure p.2
  | none => throw (Text.intercalate "" ["'",targetId,"'"])
 let wanted := canonical (.label (← heldLabel "external-complete-source-record-hash" (← field row "target_payload_hash" >>= text)))
 let targetMatch := CoordinationGeometryPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (targetHash : String) : Except String (List (String × Bool)) := do
 let different ← field analysis "equal_count_different_orientation_has_different_signature"
 let adverse ← field analysis "all_original_target_identity_mismatches_preserved"
 return [("tampered_omitted_source_record_rejected",StateSymmetryControls.rejected (CoordinationGeometryAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("equal_count_different_orientation_not_merged",CoordinationAnalysis.truthy different),
  ("all_four_original_adverse_identity_rows_retained",CoordinationAnalysis.truthy adverse),
  ("complete_53_record_vector_retained",released.length==53),
  ("prediction_contains_no_withheld_target_hash",!Text.contains (Canonical.render document) targetHash)]

def analysisPassed (analysis : J) : Bool := match analysis with
 | .object fs =>
  let booleans := fs.all fun (key,value) =>
   if Text.equal key "point_group_or_coordinate_used_as_fold_parameter" || Text.equal key "coordination_count_used_to_select_shape" then true
   else match value with | .boolean b => b | .null | .text _ | .integer _ | .array _ | .object _ => true
  let get := CoordinationGeometryPrediction.get analysis
  let absent := match get "coordinate_absence_rows_retained" with | .integer (.ofNat n) => n>=1 | .integer (.negSucc _) | .null | .text _ | .boolean _ | .array _ | .object _ => false
  booleans && CoordinationGeometryPrediction.equal (get "point_group_or_coordinate_used_as_fold_parameter") (.boolean false) &&
   CoordinationGeometryPrediction.equal (get "coordination_count_used_to_select_shape") (.boolean false) && absent
 | .null | .text _ | .boolean _ | .integer _ | .array _ => false
end SFT.Chemistry.CoordinationGeometryComparison
