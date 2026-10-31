import SFT.Physics.CosmoCompleteBudget
namespace SFT.Physics.CosmoCompleteBudgetWitnesses
open CosmoCompleteBudget
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match cosmicBudgetStructure with | .ok b => b.support == 32 && b.pinned == 10 && b.free == 22 | .error _ => false
def check1 : Bool := globalClosure
def check2 : Bool := matterClosure
def check3 : Bool := match cosmicBudgetStructure with | .ok b => b.vacuum == LeptonIntervals.normalize 11 16 (by decide) && b.matter == LeptonIntervals.normalize 5 16 (by decide) && b.baryon == LeptonIntervals.normalize 25 512 (by decide) && b.coldDark == LeptonIntervals.normalize 135 512 (by decide) | .error _ => false
def witnesses : List Witness := [⟨"forced-support","Depth five has 32 complete states, ten pinned and twenty-two free.",check0⟩,⟨"global-closure","Matter and vacuum close exactly to the One.",check1⟩,⟨"matter-closure","Baryon and cold-dark shares close exactly to total matter.",check2⟩,⟨"exact-components","All four refined component values are exact.",check3⟩]
theorem check0Passed : check0=true := rfl
theorem check1Passed : check1=true := rfl
theorem check2Passed : check2=true := rfl
theorem check3Passed : check3=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (check0 && check1 && check2 && check3 && true)=true
 rw [check0Passed,check1Passed,check2Passed,check3Passed]
 rfl
end SFT.Physics.CosmoCompleteBudgetWitnesses
