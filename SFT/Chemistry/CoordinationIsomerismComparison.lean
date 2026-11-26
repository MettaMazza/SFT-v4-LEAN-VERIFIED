import SFT.Chemistry.CoordinationIsomerismAnalysis
import SFT.Chemistry.MulticentreControls
namespace SFT.Chemistry.CoordinationIsomerismComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["complete-occurrence-bijection-preserves-composition-attachment-adjacency-and-three-axis-two-fibre-words","same-complete-composition-required","first-attachment-or-graph-failure-forces-attachment-class","global-fibre-complement-precedes-remaining-orientation-adjacency-class","all-seventeen-surfaces-two-identity-redirects-and-literal-term-absence-retained"]
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
 let values ← ["source_record_ordinal","authority","source_id","registered_identity","source_record_role","source_locator"].mapM (CoordinationIsomerismPrediction.identityText row)
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
 let targetMatch := CoordinationIsomerismPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (targetHash : String) : Except String (List (String × Bool)) := do
 let different ← field analysis "different_composition_rejected"
 let redirectCount ← field analysis "registered_to_presented_identity_redirect_count"
 let redirects ← field analysis "registered_to_presented_identity_redirects_preserved"
 let absence ← field analysis "explicit_linkage_literal_absence_preserved"
 let third := CoordinationIsomerismAnalysis.makeForm ["L","L"] ["mode-one","mode-one"]
  [["fibre-one","EmptyOne","EmptyOne"],["fibre-three","EmptyOne","EmptyOne"]] [(1,2)]
 return [("tampered_omitted_source_record_rejected",StateSymmetryControls.rejected (CoordinationIsomerismAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("third_fibre_label_rejected",StateSymmetryControls.rejected third),
  ("different_composition_rejected",CoordinationAnalysis.truthy different),
  ("both_presented_identity_redirects_preserved",CoordinationIsomerismPrediction.equal redirectCount (.integer 2) && CoordinationAnalysis.truthy redirects),
  ("explicit_linkage_literal_absence_preserved",CoordinationAnalysis.truthy absence),
  ("complete_17_record_vector_retained",released.length==17),
  ("prediction_contains_no_withheld_target_hash_or_inscription",!Text.contains (Canonical.render document) targetHash && !Text.contains (Canonical.render document) "source_inscription")]

def analysisPassed (analysis : J) : Bool := match analysis with
 | .object fs =>
  let booleans := fs.all fun (key,value) =>
   if Text.equal key "imported_catalogue_or_observed_class_used_as_fold_parameter" then true
   else match value with
    | .boolean b => b
    | .null | .text _ | .integer _ | .array _ | .object _ => true
  let get := CoordinationIsomerismPrediction.get analysis
  booleans && CoordinationIsomerismPrediction.equal (get "registered_to_presented_identity_redirect_count") (.integer 2) &&
   CoordinationIsomerismPrediction.equal (get "imported_catalogue_or_observed_class_used_as_fold_parameter") (.boolean false)
 | .null | .text _ | .boolean _ | .integer _ | .array _ => false
end SFT.Chemistry.CoordinationIsomerismComparison
