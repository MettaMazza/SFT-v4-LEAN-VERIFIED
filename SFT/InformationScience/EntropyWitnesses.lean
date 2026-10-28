import SFT.InformationScience.EntropyExtension
namespace SFT.InformationScience.EntropyWitnesses
open EntropyPartition EntropyLedger EntropyRefinement
structure Witness where
  name : String
  statement : String
  passed : Bool

def support : List String := ["aa","ab","ba","bb"]
def fine := support.map (fun state => (state,state))
def prefixObservation : List (String × String) := [("aa","a"),("ab","a"),("ba","b"),("bb","b")]
def coarse := support.map (fun state => (state,"unresolved"))
def isEmptyOne : Uncertainty → Bool
  | .emptyOne => true
  | .pairs _ => false
def uncertaintyLength : Uncertainty → Nat
  | .emptyOne => 1
  | .pairs pairs => pairs.length

def fineCheck : Bool := match entropyLedger support fine with
  | .error _ => false
  | .ok records => records.all (fun record => isEmptyOne record.unresolvedDistinctions)
def prefixCheck : Bool := match entropyLedger support prefixObservation with
  | .error _ => false
  | .ok records => records.all (fun record => decide (record.exactSupportPart.numerator = 1) && decide (record.exactSupportPart.denominator = 2) && decide (uncertaintyLength record.unresolvedDistinctions = 1))
def coarseCheck : Bool := match closedPairs support coarse with
  | .error _ => false
  | .ok pairs => decide (pairs.length = 6)
def refinementCheck : Bool := refines support fine prefixObservation && refines support prefixObservation coarse
def monotonicityCheck : Bool := match closedPairs support fine with
  | .error _ => false
  | .ok a => match closedPairs support prefixObservation with
    | .error _ => false
    | .ok b => match closedPairs support coarse with
      | .error _ => false
      | .ok c => decide (a.length < b.length) && decide (b.length < c.length)

def witnesses : List Witness := [
  ⟨"fine-certainty","Fine observation gives every state a singleton class with empty-One uncertainty.",fineCheck⟩,
  ⟨"prefix-uncertainty","Prefix observation has two exact half-support classes and one unresolved pair each.",prefixCheck⟩,
  ⟨"coarse-uncertainty","Complete coarsening retains all six microstate pairs as unresolved.",coarseCheck⟩,
  ⟨"refinement-order","Fine refines prefix, and prefix refines the one-class observation.",refinementCheck⟩,
  ⟨"closed-pair-monotonicity","Refinement reduces closed distinctions exactly in the witness chain.",monotonicityCheck⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.InformationScience.EntropyWitnesses
