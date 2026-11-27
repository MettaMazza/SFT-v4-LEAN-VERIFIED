import SFT.Chemistry.DefectAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.DefectComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["complete-reference-and-observed-local-support","vacancy-is-retained-site-with-EmptyOne","separate-positive-missing-and-added-supports","exact-formula-defect-and-origin-classification"]
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
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (DefectPrediction.identityText row)
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
 let targetMatch := DefectPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary v1Target analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := DefectPrediction.get analysis
 let eq := DefectPrediction.equal
 return [("omitted_source_row_rejected",StateSymmetryControls.rejected (DefectAnalysis.analysis (rows.take (rows.length-1)) primary v1Target)),
 ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
 ("all_fifteen_target_hashes_bound_postseal",released.length==15),
 ("v1_two_missing_note_surfaces_preserved",eq (get "v1_missing_registered_surface_count") (.integer 2)),
 ("v2_two_note_surfaces_complete",eq (get "definition_note_surface_count") (.integer 2)),
 ("two_scope_or_identity_distinctions_preserved",eq (get "scope_mismatch_or_distinction_count") (.integer 2)),
 ("sources_not_recaptured",eq (get "source_recapture_count") (.integer 0)),
 ("prediction_contains_no_definition_note_or_target_payload",!["complete_definition_text","complete_source_note_text","target_payload_hash","Surface vacancies"].any (fun token => Text.contains (Canonical.render document) token))]
def analysisPassed (analysis : J) : Bool :=
 let get := DefectPrediction.get analysis
 let eq := DefectPrediction.equal
 CoordinationAnalysis.truthy (get "pristine_defect_absence") &&
 eq (get "reference_formula_vector") (.array [.integer 1,.integer 1]) &&
 eq (get "vacancy_observed_formula_vector") (.array [.integer 1,.integer 2]) &&
 eq (get "vacancy_missing_a_count") (.integer 1) &&
 CoordinationAnalysis.truthy (get "vacancy_added_a_absence") &&
 eq (get "vacancy_class_vector") (.array [.text "vacancy"]) &&
 eq (get "vacancy_origin") (.text "intrinsic") &&
 eq (get "interstitial_observed_formula_vector") (.array [.integer 3,.integer 2]) &&
 eq (get "interstitial_added_a_count") (.integer 1) &&
 eq (get "interstitial_origin") (.text "intrinsic") &&
 eq (get "substitution_observed_formula_vector") (.array [.integer 1,.integer 1,.integer 2]) &&
 eq (get "substitution_missing_a_count") (.integer 1) &&
 eq (get "substitution_added_c_count") (.integer 1) &&
 eq (get "substitution_origin") (.text "extrinsic") &&
 eq (get "complete_target_count") (.integer 15) &&
 eq (get "complete_source_count") (.integer 5) &&
 eq (get "identity_only_unopened_target_count") (.integer 15) &&
 CoordinationAnalysis.truthy (get "all_registered_surfaces_present") &&
 CoordinationAnalysis.truthy (get "all_rows_preserved")
end SFT.Chemistry.DefectComparison
