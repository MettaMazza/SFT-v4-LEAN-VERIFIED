import SFT.Chemistry.ComplexSpinStateAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.ComplexSpinStateComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["ten-complete-six-electron-signatures","unique-low-and-high-spin-extrema","exact-high-coincident-low-order-vector","all-three-frozen-definition-value-and-transport-surfaces-retained"]
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
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (ComplexSpinStatePrediction.identityText row)
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
 let targetMatch := ComplexSpinStatePrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := ComplexSpinStatePrediction.get analysis
 let eq := ComplexSpinStatePrediction.equal
 return [("omitted_source_row_rejected",StateSymmetryControls.rejected (ComplexSpinStateAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("transport_mismatch_preserved",CoordinationAnalysis.truthy (get "transport_mismatch_preserved")),
  ("all_three_target_hashes_bound_postseal",released.length==3),
  ("prediction_contains_no_target_payload_or_dimensional_value",!Text.contains (Canonical.render document) "target_payload_hash" && !Text.contains (Canonical.render document) "203.2" && !Text.contains (Canonical.render document) "227"),
  ("tampered_order_vector_rejected",!eq (get "order_vector") (.array [.text "low-precedes-high",.text "crossover-coincidence",.text "high-precedes-low"]))]
def analysisPassed (analysis : J) : Bool :=
 let get := ComplexSpinStatePrediction.get analysis
 let eq := ComplexSpinStatePrediction.equal
 eq (get "signature_count") (.integer 10) &&
 eq (get "low_signature") (.array [.integer 3,.text "EmptyOne",.text "EmptyOne",.text "EmptyOne"]) &&
 eq (get "low_spin_width") (.integer 1) &&
 eq (get "low_crossings") (.text "EmptyOne") &&
 eq (get "high_signature") (.array [.integer 1,.integer 2,.text "EmptyOne",.integer 2]) &&
 eq (get "high_spin_width") (.integer 5) &&
 eq (get "high_crossings") (.integer 2) &&
 eq (get "order_vector") (.array [.text "high-precedes-low",.text "crossover-coincidence",.text "low-precedes-high"]) &&
 eq (get "cost_vector") (.array [.array [.integer 1,.integer 3],.array [.integer 3,.integer 3],.array [.integer 5,.integer 3]]) &&
 CoordinationAnalysis.truthy (get "combined_high_low_definition_surface_present") &&
 CoordinationAnalysis.truthy (get "low_order_definition_surface_present") &&
 eq (get "external_distance_vector_pm") (.array [.text "1016/5",.text "2199/10"]) &&
 eq (get "external_temperature_vector_k") (.array [.text "115",.text "227"]) &&
 eq (get "external_term_vector") (.array [.text "1A1",.text "5T2"]) &&
 eq (get "external_state_vector") (.array [.text "low-spin",.text "high-spin"]) &&
 CoordinationAnalysis.truthy (get "external_dilution_direction_match") &&
 CoordinationAnalysis.truthy (get "complete_rows_preserved") &&
 eq (get "dimensional_values_fitted_or_derived") (.boolean false)
end SFT.Chemistry.ComplexSpinStateComparison
