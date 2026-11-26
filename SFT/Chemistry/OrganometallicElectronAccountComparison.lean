import SFT.Chemistry.OrganometallicElectronAccountAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.OrganometallicElectronAccountComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["forced-two-plus-six-plus-ten-capacity-eighteen","complete-disjoint-nonbonded-and-bond-pair-support","exact-capacity-complete-or-incomplete-held-relation","pair-successor-until-capacity-halt-with-four-row-retention"]
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
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (OrganometallicElectronAccountPrediction.identityText row)
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
 let targetMatch := OrganometallicElectronAccountPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := OrganometallicElectronAccountPrediction.get analysis
 let eq := OrganometallicElectronAccountPrediction.equal
 return [("omitted_source_row_rejected",StateSymmetryControls.rejected (OrganometallicElectronAccountAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("all_four_target_hashes_bound_postseal",released.length==4),
  ("capacity_overflow_rejected",CoordinationAnalysis.truthy (get "overflow_rejected")),
  ("sources_not_recaptured",eq (get "source_recapture_count") (.integer 0)),
  ("prediction_contains_no_definition_observed_eighteen_or_target_payload",!["complete_definition_text","target_payload_hash","should be 18"].any (fun token => Text.contains (Canonical.render document) token))]
def analysisPassed (analysis : J) : Bool :=
 let get := OrganometallicElectronAccountPrediction.get analysis
 let eq := OrganometallicElectronAccountPrediction.equal
 eq (get "s_width") (.integer 2) &&
 eq (get "p_width") (.integer 6) &&
 eq (get "d_width") (.integer 10) &&
 eq (get "capacity") (.integer 18) &&
 eq (get "complete_count") (.integer 18) &&
 eq (get "complete_relation") (.text "capacity-complete") &&
 eq (get "partial_count") (.integer 2) &&
 eq (get "successor_count") (.integer 4) &&
 CoordinationAnalysis.truthy (get "all_registered_surfaces_present") &&
 CoordinationAnalysis.truthy (get "all_rows_preserved")
end SFT.Chemistry.OrganometallicElectronAccountComparison
