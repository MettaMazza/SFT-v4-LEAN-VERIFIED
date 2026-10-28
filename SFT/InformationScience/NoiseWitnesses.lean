import SFT.InformationScience.NoiseExtension
namespace SFT.InformationScience.NoiseWitnesses
open NoiseRelation NoiseCorrection NoiseTrace
structure Witness where
  name : String
  statement : String
  passed : Bool

def a : Word := ["a","a","a"]
def b : Word := ["b","b","b"]
def relation : ErrorRelation := ⟨[a,b],[a,b,["b","a","a"],["a","b","b"],["a","a","b"]],
 [(a,a,"identity"),(b,b,"identity"),(a,["b","a","a"],"first-label-change"),
  (b,["a","b","b"],"first-label-change"),(a,["a","a","b"],"third-label-change")]⟩
def ambiguous : ErrorRelation := ⟨[a,b],[["b","a","b"]],
 [(a,["b","a","b"],"two-position-action"),(b,["b","a","b"],"one-position-action")]⟩
theorem relationAdmitted : makeRelation relation.sources relation.received relation.relation = .ok relation := rfl
theorem ambiguousAdmitted : makeRelation ambiguous.sources ambiguous.received ambiguous.relation = .ok ambiguous := rfl

def same {α : Type} [DecidableEq α] (a b : Except String α) : Bool := match a with
 | .error e => match b with | .error f => decide (e=f) | .ok _ => false
 | .ok x => match b with | .error _ => false | .ok y => decide (x=y)
def identityCheck : Bool := same (errorTrace a a) (.ok .emptyOne)
def positionCheck : Bool := same (errorTrace a ["b","a","a"]) (.ok (.changes [("position-1","a","b")]))
def detectionCheck : Bool := same (detectable [a,b] a ["b","a","a"]) (.ok true)
def uniqueCheck : Bool := same (uniquelyCorrectable relation ["b","a","a"]) (.ok true) &&
  same (correctionRecord relation ["b","a","a"]) (.ok (.uniqueSource a))
def ambiguousCheck : Bool := same (uniquelyCorrectable ambiguous ["b","a","b"]) (.ok false) &&
  (match correctionRecord ambiguous ["b","a","b"] with
   | .error _ => false
   | .ok record => match record with | .uniqueSource _ => false | .closedSourceClass _ => true)

def witnesses : List Witness := [
  ⟨"identity-error","Identity transport returns structural empty-One error.",identityCheck⟩,
  ⟨"position-trace","The first-label change retains its exact position and labels.",positionCheck⟩,
  ⟨"detection","A one-label image outside the repetition codebook is structurally detectable.",detectionCheck⟩,
  ⟨"unique-correction","The registered b/a/a image has exactly source a.",uniqueCheck⟩,
  ⟨"ambiguous-control","The shared b/a/b image retains both predecessors and refuses unique correction.",ambiguousCheck⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.InformationScience.NoiseWitnesses
