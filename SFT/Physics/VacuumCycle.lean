import SFT.Physics.VacuumBeat
namespace SFT.Physics.VacuumCycle
open VacuumBeat LeptonIntervals
structure Cycle where
 outward : Transfer
 restorationCost : Rat
 restoredVacuum : Rat
 residualWork : List Rat

def completeReturnedCycle : Except String Cycle := do
 let outward ← asymmetricBeat
 let restoration := outward.localWork
 let restored := add outward.vacuumAfter restoration
 if !restored.blt outward.vacuumBefore && !outward.vacuumBefore.blt restored then
  .ok ⟨outward,restoration,restored,[]⟩
 else .error "the vacuum reservoir was not restored exactly"

theorem sourceAssembly : completeReturnedCycle=.ok
 ⟨⟨⟨1,2,by decide,by decide⟩,⟨1,3,by decide,by decide⟩,⟨1,6,by decide,by decide⟩⟩,
  ⟨1,6,by decide,by decide⟩,⟨1,2,by decide,by decide⟩,[]⟩ := by
 unfold completeReturnedCycle
 rw [VacuumBeat.sourceAssembly]
 rfl

theorem everyReturnedCycle (c : Cycle) (returned : completeReturnedCycle=.ok c) :
 c.restorationCost=c.outward.localWork ∧ c.restoredVacuum=c.outward.vacuumBefore ∧
 c.residualWork=[] ∧ c.restorationCost=(⟨1,6,by decide,by decide⟩ : Rat) ∧
 add c.outward.vacuumAfter c.restorationCost=c.restoredVacuum := by
 rw [sourceAssembly] at returned
 cases returned
 exact ⟨rfl,rfl,rfl,rfl,VacuumBeat.sourceRecomposition⟩
end SFT.Physics.VacuumCycle
