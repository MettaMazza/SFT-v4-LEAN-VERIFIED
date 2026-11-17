import SFT.Chemistry.CoordinationNumberAnalysis
import SFT.Chemistry.MulticentreControls
namespace SFT.Chemistry.CoordinationNumberComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["positive-cardinality-of-complete-distinct-direct-central-incidences",
 "general-inorganic-sigma-pi-exclusion-and-crystal-senses-remain-distinct",
 "all-23-definition-structure-count-boundary-and-limitation-records-retained"]
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
 let values ← ["source_record_ordinal","authority","source_document_identity","source_record_role"].mapM (CoordinationNumberPrediction.identityText row)
 let identities ← (values.zipIdx 1).mapM fun (value,index) => do
  let cell ← cellAt cells index
  return match cell with
   | .label h => Text.equal h.label value
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
 let lawLabels ← (cells.drop 5).mapM fun cell => match cell with
  | .label h => pure h.label
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "law consequence requires a label"
 let lawMatch := lawLabels.length==expectedLaws.length && (lawLabels.zip expectedLaws).all (fun (a,b) => Text.equal a b)
 let actual ← match released.find? (fun p => Text.equal p.1 targetId) with
  | some p => pure p.2
  | none => throw (Text.intercalate "" ["'",targetId,"'"])
 let wanted := canonical (.label (← heldLabel "external-complete-source-record-hash" (← field row "target_payload_hash" >>= text)))
 let targetMatch := CoordinationNumberPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (targetHash : String) : Except String (List (String × Bool)) := do
 let central ← heldLabel "coordination-central-occurrence" "central"
 let other ← heldLabel "coordination-central-occurrence" "other"
 let row ← attachment (← count 1) other (← heldLabel "coordination-ligand-occurrence" "L")
  (← heldLabel "coordination-ligand-group" "L") (← heldLabel "positive-coordination-incidence" "edge")
 let entityLabel ← heldLabel "coordination-entity" "control"
 let element ← heldLabel "coordination-central-element" "M"
 let visible ← field analysis "all_boundaries_absences_and_disclaimers_retained"
 return [("tampered_omitted_source_record_rejected",StateSymmetryControls.rejected (CoordinationNumberAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("tampered_central_occurrence_mismatch_rejected",StateSymmetryControls.rejected (construct entityLabel element central [row])),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("complete_23_record_vector_retained",released.length==23),
  ("boundary_absence_and_disclaimer_surface_visible",CoordinationAnalysis.truthy visible),
  ("prediction_contains_no_withheld_target_hash",!Text.contains (Canonical.render document) targetHash)]

def analysisPassed (analysis : J) : Bool := match analysis with
 | .object fs => fs.all fun (key,value) =>
  Text.equal key "complete_registered_target_count" || Text.equal key "source_class_census" || CoordinationAnalysis.truthy value
 | .null | .text _ | .integer _ | .boolean _ | .array _ => false
end SFT.Chemistry.CoordinationNumberComparison
