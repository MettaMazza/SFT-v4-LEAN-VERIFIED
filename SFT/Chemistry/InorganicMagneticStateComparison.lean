import SFT.Chemistry.InorganicMagneticStateAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.InorganicMagneticStateComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["complete-unpaired-support-or-EmptyOne","exact-moment-count-and-successor-width","held-drawn-paramagnetic-or-repelled-diamagnetic-class","all-177-definition-value-orientation-and-absence-surfaces-retained"]
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
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (InorganicMagneticStatePrediction.identityText row)
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
 let targetMatch := InorganicMagneticStatePrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := InorganicMagneticStatePrediction.get analysis
 let eq := InorganicMagneticStatePrediction.equal
 return [("omitted_source_row_rejected",StateSymmetryControls.rejected (InorganicMagneticStateAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("all_177_target_hashes_bound_postseal",released.length==177),
  ("all_136_magnitudes_preserved",eq (get "positive_magnitude_count") (.integer 136)),
  ("all_38_absences_preserved",eq (get "structural_absence_count") (.integer 38)),
  ("shared_sources_not_recaptured",eq (get "source_recapture_count") (.integer 0)),
  ("prediction_contains_no_target_value_or_orientation",!Text.contains (Canonical.render document) "source_value_inscription" && !Text.contains (Canonical.render document) "native_value")]
def analysisPassed (analysis : J) : Bool :=
 let get := InorganicMagneticStatePrediction.get analysis
 let eq := InorganicMagneticStatePrediction.equal
 eq (get "balanced_moment") (.text "EmptyOne") &&
 eq (get "balanced_width") (.integer 1) &&
 eq (get "balanced_relation") (.text "repelled-from-field") &&
 eq (get "balanced_class") (.text "diamagnetic") &&
 eq (get "high_moment") (.integer 4) &&
 eq (get "high_width") (.integer 5) &&
 eq (get "high_relation") (.text "drawn-into-field") &&
 eq (get "high_class") (.text "paramagnetic") &&
 eq (get "successor_moment") (.integer 5) &&
 eq (get "successor_width") (.integer 6) &&
 CoordinationAnalysis.truthy (get "susceptibility_definition_present") &&
 CoordinationAnalysis.truthy (get "paramagnetic_definition_present") &&
 CoordinationAnalysis.truthy (get "diamagnetic_definition_present") &&
 eq (get "complete_magnetic_count") (.integer 174) &&
 eq (get "positive_magnitude_count") (.integer 136) &&
 eq (get "structural_absence_count") (.integer 38) &&
 eq (get "orientation_class_counts") (.object [("source-aligned",.integer 6),("source-opposed",.integer 62),("source-orientation-unspecified",.integer 68),("structural-absence",.integer 38)]) &&
 CoordinationAnalysis.truthy (get "all_rows_preserved") &&
 eq (get "forbidden_formula_or_fit_used") (.boolean false)
end SFT.Chemistry.InorganicMagneticStateComparison
