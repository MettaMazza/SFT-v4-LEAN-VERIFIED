import SFT.Physics.VacuumCycle
namespace SFT.Physics.VacuumCycleWitnesses
open VacuumCycle
structure Witness where
 name : String
 statement : String
 passed : Bool
def costCheck : Bool := match completeReturnedCycle with
 | .error _ => false
 | .ok t => !t.restorationCost.blt (⟨1,6,by decide,by decide⟩ : Rat) && !(⟨1,6,by decide,by decide⟩ : Rat).blt t.restorationCost
def returnCheck : Bool := match completeReturnedCycle with
 | .error _ => false
 | .ok t => !t.restoredVacuum.blt (⟨1,2,by decide,by decide⟩ : Rat) && !(⟨1,2,by decide,by decide⟩ : Rat).blt t.restoredVacuum
def emptyCheck : Bool := match completeReturnedCycle with
 | .error _ => false
 | .ok t => t.residualWork.isEmpty
def witnesses : List Witness := [⟨"restoration-cost","The restoration cost equals the outward work carrier exactly.",costCheck⟩,⟨"vacuum-return","The vacuum carrier returns to its exact initial half-One state.",returnCheck⟩,⟨"empty-residual","No numerical zero is emitted; exhausted work is the empty structural record.",emptyCheck⟩]
theorem costCheckPassed : costCheck=true := by unfold costCheck;rw [sourceAssembly];rfl
theorem returnCheckPassed : returnCheck=true := by unfold returnCheck;rw [sourceAssembly];rfl
theorem emptyCheckPassed : emptyCheck=true := by unfold emptyCheck;rw [sourceAssembly];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (costCheck && returnCheck && emptyCheck && true)=true
 rw [costCheckPassed,returnCheckPassed,emptyCheckPassed]
 rfl
end SFT.Physics.VacuumCycleWitnesses
