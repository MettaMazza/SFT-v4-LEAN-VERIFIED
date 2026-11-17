import SFT.Chemistry.LigandDenticitySource
import SFT.Chemistry.LigandDenticityAnalysis
import SFT.Chemistry.MulticentreControls
namespace SFT.Chemistry.LigandDenticityComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["positive-cardinality-of-complete-distinct-donor-sites-one-ligand-one-centre",
 "first-multiple-separate-site-successor-closes-carrier-centre-path",
 "separate-site-kappa-eta-and-scope-boundaries-retained-across-all-24-records"]
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
 let values ← ["source_record_ordinal","authority","source_document_identity","source_term_role","source_record_role"].mapM (LigandDenticityPrediction.identityText row)
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
 let targetMatch := LigandDenticityPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (targetHash : String) : Except String (List (String × Bool)) := do
 let entity ← LigandDenticityAnalysis.validationEntity 2
 let topology ← LigandDenticityAnalysis.validationTopology entity
 let wrong ← LigandDenticity.construct {topology with central := ← heldLabel "coordination-central-occurrence" "different-centre"}
 let one ← LigandDenticityAnalysis.validationEntity 1
 let carrierA := (← LigandDenticityAnalysis.validationTopology one).carrier
 let carrierB ← heldLabel "coordination-ligand-carrier-occurrence" "ligand-two"
 return [("tampered_omitted_source_record_rejected",StateSymmetryControls.rejected (LigandDenticityAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("tampered_central_occurrence_mismatch_rejected",StateSymmetryControls.rejected (LigandDenticity.forced entity wrong)),
  ("equal_group_labels_do_not_merge_carrier_occurrences",!MulticentreSupport.sameLabel carrierA carrierB),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("complete_24_record_vector_retained",released.length==24),
  ("prediction_contains_no_withheld_target_hash",!Text.contains (Canonical.render document) targetHash)]

def analysisPassed (analysis : J) : Bool := match analysis with
 | .object fs => fs.all fun (key,value) =>
  Text.equal key "complete_registered_target_count" || Text.equal key "source_class_census" || CoordinationAnalysis.truthy value
 | .null | .text _ | .integer _ | .boolean _ | .array _ => false
end SFT.Chemistry.LigandDenticityComparison
