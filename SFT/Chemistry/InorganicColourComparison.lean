import SFT.Chemistry.InorganicColourAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.InorganicColourComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["four-directed-ligand-metal-transition-classes","retained-endpoints-and-positive-order-gap","proper-absorbed-and-retained-colour-partition","all-eight-definition-spectrum-and-custody-surfaces-retained"]
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
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (InorganicColourPrediction.identityText row)
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
 let targetMatch := InorganicColourPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := InorganicColourPrediction.get analysis
 let eq := InorganicColourPrediction.equal
 return [("omitted_source_row_rejected",StateSymmetryControls.rejected (InorganicColourAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("all_eight_target_hashes_bound_postseal",released.length==8),
  ("shared_spectra_not_recaptured",eq (get "source_recapture_count") (.integer 0)),
  ("metal_to_metal_definition_absence_preserved",CoordinationAnalysis.truthy (get "metal_to_metal_definition_absent_preserved")),
  ("prediction_contains_no_target_payload_peak_or_wavelength",!Text.contains (Canonical.render document) "target_payload_hash" && !Text.contains (Canonical.render document) "48361/200")]
def analysisPassed (analysis : J) : Bool :=
 let get := InorganicColourPrediction.get analysis
 let eq := InorganicColourPrediction.equal
 eq (get "transition_classes") (.array [.text "ligand-to-ligand",.text "ligand-to-metal",.text "metal-to-ligand",.text "metal-to-metal"]) &&
 eq (get "exact_gap") (.integer 2) &&
 eq (get "absorbed_count") (.integer 1) &&
 eq (get "retained_colour_count") (.integer 2) &&
 CoordinationAnalysis.truthy (get "generic_definition_present") &&
 CoordinationAnalysis.truthy (get "ll_definition_present") &&
 CoordinationAnalysis.truthy (get "lm_definition_present") &&
 CoordinationAnalysis.truthy (get "ml_definition_present") &&
 eq (get "spectrum_count") (.integer 4) &&
 eq (get "point_count_vector") (.array [.integer 224,.integer 79,.integer 80,.integer 73]) &&
 eq (get "total_point_count") (.integer 456) &&
 eq (get "interior_maximum_count_vector") (.array [.integer 2,.integer 2,.integer 1,.integer 2]) &&
 CoordinationAnalysis.truthy (get "all_spectra_selective") &&
 eq (get "originally_blind_count") (.integer 1) &&
 CoordinationAnalysis.truthy (get "all_rows_preserved") &&
 eq (get "dimensional_value_or_colour_fitted") (.boolean false)
end SFT.Chemistry.InorganicColourComparison
