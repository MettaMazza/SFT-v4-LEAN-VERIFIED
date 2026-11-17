import SFT.Chemistry.JointCorrelationTargets
import SFT.Chemistry.JointCorrelationSupport
namespace SFT.Chemistry.JointCorrelationComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (Resolved field text integer)
abbrev J := Canonical.Value
abbrev Predictions := List (String × Value)
def store (rows : Predictions) (key : String) (value : Value) : Predictions :=
 if rows.any (fun row => Text.equal row.1 key) then rows.map (fun row => if Text.equal row.1 key then (key,value) else row)
 else rows++[(key,value)]
def predictionMap (entries : List (Value × Value)) : Except String Predictions := do
 let rows ← entries.foldlM (fun rows (key,value) => do
  let key ← match key with
   | .label h => if Text.equal h.family "joint-support-law" then .ok h.label else .error "ELEC-007 prediction key is invalid"
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "ELEC-007 prediction key is invalid"
  return store rows key value) []
 if rows.length != 5 then throw "ELEC-007 prediction law is incomplete"
 return rows
def lookup (rows : Predictions) (key : String) : Except String Value :=
 match rows.find? (fun row => Text.equal row.1 key) with
 | none => .error (Text.intercalate "" ["'",key,"'"])
 | some row => .ok row.2
def expected : Except String Predictions := do
 return [("joint-word-count",.count (← count 2)),("independent-cartesian-count",.count (← count 4)),
 ("joint-relation",.label (← heldLabel "joint-support-result" "nonfactorizable-complementary-cross-centre-pair")),
 ("same-centre-support",.label (← heldLabel "joint-support-result" "excluded")),
 ("dissociation-record",.label (← heldLabel "joint-support-result" "exact-positive-post-seal-observation"))]
def validatePrediction (predicted : Predictions) : Except String Unit := do
 let wanted ← expected
 let same := wanted.map fun (key,v) => match predicted.find? (fun row => Text.equal row.1 key) with
  | none => false
  | some row => equal row.2 v
 if predicted.length != 5 || !same.all id then throw "ELEC-007 sealed joint-support law changed"
 return ()
def compare (predicted : Predictions) (row : Resolved) : Except String J := do
 let fields := Canonical.Value.object row.row.fields
 let species ← field fields "species" >>= text
 let support ← JointCorrelationSupport.completeSupport species "left-product" "right-product"
 let joint ← JointCorrelationSupport.positiveJointWordCount support
 let cartesian := JointCorrelationSupport.positiveIndependentCartesianCount
 let jointPredicted ← lookup predicted "joint-word-count"
 let cartesianPredicted ← lookup predicted "independent-cartesian-count"
 let n ← field fields "value_numerator" >>= integer
 let d ← field fields "value_denominator" >>= integer
 let energy ← JointCorrelationObservation.positiveRatio n d
 let un ← field fields "uncertainty_numerator"
 let ud ← field fields "uncertainty_denominator"
 let uncertaintyPassed ← match un with
  | .text s => do
   if Text.equal s "absence" then
    pure (equal row.observation.positiveUncertaintyOrAbsence (.emptyOne "empty-One"))
   else do
     let ni ← JointCorrelationObservation.uncertaintyInt (JointCorrelationTargets.uncertainty un)
     let di ← JointCorrelationObservation.uncertaintyInt (JointCorrelationTargets.uncertainty ud)
     pure (equal row.observation.positiveUncertaintyOrAbsence (← JointCorrelationObservation.positiveRatio ni di))
  | .integer _ | .null | .boolean _ | .array _ | .object _ => do
   let ni ← JointCorrelationObservation.uncertaintyInt (JointCorrelationTargets.uncertainty un)
   let di ← JointCorrelationObservation.uncertaintyInt (JointCorrelationTargets.uncertainty ud)
   pure (equal row.observation.positiveUncertaintyOrAbsence (← JointCorrelationObservation.positiveRatio ni di))
 let passed := equal (.count joint) jointPredicted && equal (.count cartesian) cartesianPredicted &&
  JointCorrelationSupport.retainsNonfactorizable support && equal row.observation.positiveEnergySeparation energy && uncertaintyPassed
 let copied ← ["target_id","source_id","species","state","record_kind","value_inscription","value_numerator","value_denominator","uncertainty_inscription","unit"].mapM fun key => do return (key,← field fields key)
 return .object (copied++[("joint_word_count",.integer (.ofNat joint.value)),
  ("independent_cartesian_count",.integer (.ofNat cartesian.value)),("passed",.boolean passed)])
end SFT.Chemistry.JointCorrelationComparison
