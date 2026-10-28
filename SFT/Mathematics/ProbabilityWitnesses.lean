import SFT.Mathematics.ProbabilityObservations
namespace SFT.Mathematics.ProbabilityWitnesses
open ProbabilityEvents ProbabilityIndependence ProbabilityModes ProbabilityObservations
structure Witness where
  name : String
  statement : String
  passed : Bool

def support : List String := ["aa","ab","ba","bb"]
def joint : List (String × String) := [("a","a"),("a","b"),("b","a"),("b","b")]
def halfWeight (result : Except String Weight) : Bool :=
  match result with
  | .error _ => false
  | .ok weight => match weight with
    | .inl _ => false
    | .inr value => value.numerator == 1 && value.denominator == 2

def emptyWeight (result : Except String Weight) : Bool :=
  match result with
  | .error _ => false
  | .ok weight => match weight with
    | .inl labels => decide (labels = ["empty-One"])
    | .inr _ => false

def witnesses : List Witness := [
  ⟨"exact-weight","Two held states in four complete states have the exact one-over-two part.",(halfWeight (exactWeight support ["aa","ab"]))⟩,
  ⟨"empty-event","The empty event is structural empty One rather than numerical zero.",(emptyWeight (exactWeight support []))⟩,
  ⟨"conditional","Conditioning on the two a-prefix states retains one selected state as one-over-two.",(halfWeight (conditionalWeight support ["aa","ba"] ["aa","ab"]))⟩,
  ⟨"independence","The complete two-by-two pair support factorizes exactly.",(match independent joint ["a"] ["a"] with | .ok result => result | .error _ => false)⟩,
  ⟨"ties-retained","An exact modal summary preserves both equally supported alternatives.",(match exactMode ["a","b","a","b"] with | .ok labels => decide (labels = ["a","b"]) | .error _ => false)⟩,
  ⟨"observation-classes","A prefix observation retains two exact two-state classes.",(match observationClasses support [("aa","a"),("ab","a"),("ba","b"),("bb","b")] with | .ok rows => decide (rows = [("a",["aa","ab"]),("b",["ba","bb"])]) | .error _ => false)⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl

end SFT.Mathematics.ProbabilityWitnesses
