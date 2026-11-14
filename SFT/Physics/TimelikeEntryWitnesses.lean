import SFT.Physics.SpacetimeAdmissibility
namespace SFT.Physics.TimelikeEntryWitnesses
open SpacetimeAdmissibility
structure Witness where
 name : String
 statement : String
 passed : Bool
def cycleCheck : Bool := closedTimelikeAdmissible ["state","proof"] ["state","proof"] true
def paradoxCheck : Bool := !closedTimelikeAdmissible ["state","proof"] ["changed-state","proof"] true
def traceCheck : Bool := !closedTimelikeAdmissible ["state","proof"] ["state","proof"] false
def witnesses : List Witness := [⟨"cycle","An exact complete-state recurrence passes.",cycleCheck⟩,⟨"paradox","A changed self-ancestor record fails.",paradoxCheck⟩,⟨"missing-trace","An unrecorded cycle fails.",traceCheck⟩]
theorem cycleCheckPassed : cycleCheck=true := rfl
theorem paradoxCheckPassed : paradoxCheck=true := rfl
theorem traceCheckPassed : traceCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (cycleCheck && paradoxCheck && traceCheck && true)=true
 rw [cycleCheckPassed,paradoxCheckPassed,traceCheckPassed]
 rfl
end SFT.Physics.TimelikeEntryWitnesses
