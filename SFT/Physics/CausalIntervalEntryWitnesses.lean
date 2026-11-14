import SFT.Physics.CausalInterval
namespace SFT.Physics.CausalIntervalEntryWitnesses
open CausalInterval
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def massiveCheck : Bool := match intervalWitness with
 | .error _ => false
 | .ok x => (match x.intervalSquare with | none => false | some q => same q ⟨16,25,by decide,by decide⟩) && same x.properTime ⟨4,5,by decide,by decide⟩
def boundaryCheck : Bool := match exactInterval ⟨1,1,by decide,by decide⟩ ⟨1,1,by decide,by decide⟩ with
 | .error _ => false
 | .ok x => x.intervalSquare.isNone
def witnesses : List Witness := [⟨"massive","The generated causal triple closes.",massiveCheck⟩,⟨"boundary","Equal claims produce structural absence, not numerical zero.",boundaryCheck⟩]
theorem massiveCheckPassed : massiveCheck=true := by unfold massiveCheck;rw [originalMassiveRecord];rfl
theorem boundaryCheckPassed : boundaryCheck=true := by unfold boundaryCheck;rw [originalBoundary];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (massiveCheck && boundaryCheck && true)=true
 rw [massiveCheckPassed,boundaryCheckPassed]
 rfl
end SFT.Physics.CausalIntervalEntryWitnesses
