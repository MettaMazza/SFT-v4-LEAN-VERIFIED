import SFT.Physics.AlphaBlocks
namespace SFT.Physics.AlphaPromotion
open AlphaBlocks AlphaCovers GeneratorOperations
set_option maxRecDepth 20000

-- Host counts record the promoted and remaining interchangeable directions.
def stagesFrom (promoted : Nat) : Nat → List (Nat × Nat)
 | 0 => [(promoted,0)]
 | remaining+1 => (promoted,remaining+1) :: stagesFrom (promoted+1) remaining

def nextStage : Nat × Nat → Option (Nat × Nat)
 | (promoted,0) => none
 | (promoted,remaining+1) => some (promoted+1,remaining)

theorem stageCount (promoted remaining : Nat) : (stagesFrom promoted remaining).length = remaining+1 := by
 induction remaining generalizing promoted with
 | zero => rfl
 | succ remaining ih => exact congrArg Nat.succ (ih (promoted+1))

theorem successorConservesDirections (promoted remaining : Nat) :
 (promoted+1)+remaining = promoted+(remaining+1) := Nat.succ_add promoted remaining

theorem successorDecreasesRemaining (remaining : Nat) : remaining < remaining+1 := Nat.lt_succ_self _

theorem terminalHasNoSuccessor (promoted : Nat) : nextStage (promoted,0) = none := rfl

theorem positiveRemainingHasSuccessor (promoted remaining : Nat) :
 nextStage (promoted,remaining+1) = some (promoted+1,remaining) := rfl

theorem stageConservation (promoted remaining : Nat) (p r : Nat)
 (held : (p,r) ∈ stagesFrom promoted remaining) : p+r = promoted+remaining := by
 induction remaining generalizing promoted with
 | zero => cases held with | head => rfl | tail _ h => cases h
 | succ remaining ih => cases held with
   | head => rfl
   | tail _ h => exact (ih (promoted+1) h).trans (successorConservesDirections promoted remaining)

theorem terminalIncluded (promoted remaining : Nat) : (promoted+remaining,0) ∈ stagesFrom promoted remaining := by
 induction remaining generalizing promoted with
 | zero => exact List.Mem.head _
 | succ remaining ih =>
   have h := ih (promoted+1)
   rw [successorConservesDirections] at h
   exact List.Mem.tail _ h

theorem allRemainingStages (promoted remaining : Nat) (r : Nat) (bound : r ≤ remaining) :
 ∃ p, (p,r) ∈ stagesFrom promoted remaining := by
 induction remaining generalizing promoted with
 | zero => have h := Nat.eq_zero_of_le_zero bound; cases h; exact ⟨promoted,List.Mem.head _⟩
 | succ remaining ih =>
   cases Nat.lt_or_eq_of_le bound with
   | inl less => obtain ⟨p,h⟩ := ih (promoted+1) (Nat.le_of_lt_succ less); exact ⟨p,List.Mem.tail _ h⟩
   | inr same => cases same; exact ⟨promoted,List.Mem.head _⟩

def rung (blocks : Blocks) (promoted : Nat) : Except String Nat := do
 let downPart ← if promoted == blocks.generator then .ok 1 else
   positivePower (.integer (.ofNat blocks.down)) (.integer (.ofNat (blocks.generator-promoted)))
 let upPart ← if promoted == 0 then .ok 1 else
   positivePower (.integer (.ofNat blocks.up)) (.integer (.ofNat promoted))
 .ok (downPart*upPart)

def rungsFrom (blocks : Blocks) (promoted : Nat) : Nat → Except String (List Nat)
 | 0 => do let value ← rung blocks promoted; .ok [value]
 | remaining+1 => do
   let value ← rung blocks promoted
   let tail ← rungsFrom blocks (promoted+1) remaining
   .ok (value :: tail)

def promotionRungs : Except String (List Nat) := do
 let blocks ← fineStructureBlocks
 rungsFrom blocks 0 blocks.generator

theorem forcedRungs : promotionRungs = .ok [125,175,245,343] := by
 unfold promotionRungs
 rw [forcedBlocks]
 rfl

theorem completeStages : stagesFrom 0 3 = [(0,3),(1,2),(2,1),(3,0)] := rfl

theorem allDirectionsOnce :
 nextStage (0,3) = some (1,2) ∧ nextStage (1,2) = some (2,1) ∧
 nextStage (2,1) = some (3,0) ∧ nextStage (3,0) = none := ⟨rfl,rfl,rfl,rfl⟩

def runStages (blocks : Blocks) : List (Nat × Nat) → Except String (List Nat)
 | [] => .ok []
 | (p,_) :: rest => do
   let value ← rung blocks p
   let tail ← runStages blocks rest
   .ok (value :: tail)

theorem nativeStages (blocks : Blocks) (promoted remaining : Nat) :
 rungsFrom blocks promoted remaining = runStages blocks (stagesFrom promoted remaining) := by
 induction remaining generalizing promoted with
 | zero => rfl
 | succ remaining ih =>
   change (do let value ← rung blocks promoted; let tail ← rungsFrom blocks (promoted+1) remaining; pure (value::tail)) = _
   rw [ih]
   rfl

theorem completeNativeLadder : promotionRungs = .ok [125,175,245,343] ∧
 stagesFrom 0 3 = [(0,3),(1,2),(2,1),(3,0)] ∧ nextStage (3,0) = none :=
 ⟨forcedRungs,completeStages,rfl⟩
end SFT.Physics.AlphaPromotion
