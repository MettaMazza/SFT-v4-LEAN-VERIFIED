import SFT.Chemistry.ResonanceEquivalentPrediction
import SFT.Chemistry.ResonanceEquivalentAnalysis
import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.ResonanceEquivalentComparison
open SFT.Host SFT.Physics.CapabilityValues
abbrev Predictions := List (String × List Value)
def insertPrediction (rows : Predictions) (key : String) (word : List Value) : Predictions :=
 if rows.any (fun row => Text.equal row.1 key) then
  rows.map (fun row => if Text.equal row.1 key then (key,word) else row)
 else rows++[(key,word)]
def predictionMap (output : Value) : Except String Predictions := do
 let entries ← match output with
  | .table entries => .ok entries
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => .error "ORG-002 prediction incomplete"
 if entries.length != 4 then throw "ORG-002 prediction incomplete"
 let rows ← entries.foldlM (fun rows (key,value) => do
  let label ← match key with
   | .label label => .ok label
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "ORG-002 prediction row incomplete"
  if !Text.equal label.family "target-id" then throw "ORG-002 prediction row incomplete"
  let word ← match value with
   | .word word => .ok word
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => .error "ORG-002 prediction row incomplete"
  if word.length != 11 then throw "ORG-002 prediction row incomplete"
  pure (insertPrediction rows label.label word)) []
 if rows.length != 4 then throw "ORG-002 duplicate prediction target"
 return rows

def cellAt : List Value → Nat → Except String Value
 | [],_ => .error "tuple index out of range"
 | value::_,0 => .ok value
 | _::rest,n+1 => cellAt rest n
def labelMatches (value : Value) (expected : String) : Bool :=
 match value with
 | .label held => Text.equal held.label expected
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def heldCellLabel : Value → Except String String
 | .label held => .ok held.label
 | .emptyOne _ => .error "'EmptyOne' object has no attribute 'label'"
 | .count _ => .error "'PositiveCount' object has no attribute 'label'"
 | .ratio _ _ => .error "'PositiveRatio' object has no attribute 'label'"
 | .word _ => .error "'FoldWord' object has no attribute 'label'"
 | .pair _ _ => .error "'FoldPair' object has no attribute 'label'"
 | .table _ => .error "'FoldTable' object has no attribute 'label'"
def sameStrings : List String → List String → Bool
 | [],[] => true
 | [],_::_ => false
 | _::_,[] => false
 | a::as,b::bs => Text.equal a b && sameStrings as bs
structure Comparison where
 targetId : String
 identityMatch : Bool
 lawMatch : Bool
 postsealTargetHashMatch : Bool
 passed : Bool

def compare (identity : ResonanceEquivalentPrediction.Identity) (targetPayloadHash : String)
 (word : List Value) (released : Value) : Except String Comparison := do
 let fields := (ResonanceEquivalentPrediction.identityValues identity).zipIdx 1
 let identityChecks ← fields.mapM (fun (expected,index) => do
  let cell ← cellAt word index
  pure (labelMatches cell expected))
 let labels ← (word.drop 7).mapM heldCellLabel
 let lawMatch := sameStrings labels ResonanceEquivalentPrediction.expectedLaws
 let expected ← heldLabel "external-complete-source-record-hash" targetPayloadHash
 let targetMatch := equal released (.label expected)
 let identityMatch := identityChecks.all id
 return ⟨identity.targetId,identityMatch,lawMatch,targetMatch,identityMatch && lawMatch && targetMatch⟩
def comparisonValue (row : Comparison) : Canonical.Value := .object [
 ("target_id",.text row.targetId),("identity_match",.boolean row.identityMatch),
 ("law_match",.boolean row.lawMatch),("postseal_target_hash_match",.boolean row.postsealTargetHashMatch),
 ("passed",.boolean row.passed)]
#print axioms insertPrediction
#print axioms predictionMap
#print axioms cellAt
#print axioms labelMatches
#print axioms heldCellLabel
#print axioms sameStrings
#print axioms compare
#print axioms comparisonValue
end SFT.Chemistry.ResonanceEquivalentComparison
