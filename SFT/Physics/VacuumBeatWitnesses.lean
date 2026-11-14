import SFT.Physics.VacuumBeat
namespace SFT.Physics.VacuumBeatWitnesses
open VacuumBeat LeptonIntervals
structure Witness where
 name : String
 statement : String
 passed : Bool
def workCheck : Bool := match asymmetricBeat with
 | .error _ => false
 | .ok t => !t.localWork.blt (⟨1,6,by decide,by decide⟩ : Rat) && !(⟨1,6,by decide,by decide⟩ : Rat).blt t.localWork
def retainedCheck : Bool := match asymmetricBeat with
 | .error _ => false
 | .ok t => !t.vacuumAfter.blt (⟨1,3,by decide,by decide⟩ : Rat) && !(⟨1,3,by decide,by decide⟩ : Rat).blt t.vacuumAfter
def conservationCheck : Bool := match asymmetricBeat with
 | .error _ => false
 | .ok t => !(add t.vacuumAfter t.localWork).blt t.vacuumBefore && !t.vacuumBefore.blt (add t.vacuumAfter t.localWork)
def witnesses : List Witness := [⟨"positive-work","The asymmetric beat produces a strict positive work carrier.",workCheck⟩,⟨"retained-vacuum","The outward transfer retains the generator-three unit in the reservoir.",retainedCheck⟩,⟨"outward-conservation","Reservoir and work reconstruct the initial vacuum carrier.",conservationCheck⟩]
theorem workCheckPassed : workCheck=true := by unfold workCheck;rw [sourceAssembly];rfl
theorem retainedCheckPassed : retainedCheck=true := by unfold retainedCheck;rw [sourceAssembly];rfl
theorem conservationCheckPassed : conservationCheck=true := by unfold conservationCheck;rw [sourceAssembly];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (workCheck && retainedCheck && conservationCheck && true)=true
 rw [workCheckPassed,retainedCheckPassed,conservationCheckPassed]
 rfl
end SFT.Physics.VacuumBeatWitnesses
