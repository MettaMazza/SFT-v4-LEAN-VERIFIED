import SFT.Mathematics.OrbitLoopCompletion
namespace SFT.Physics.VacuumOddRecurrence
open SFT.Mathematics.OrbitOrderIdentity
open SFT.Mathematics.OrbitOrderExistence
open SFT.Mathematics.OrbitCyclotomic
open SFT.Mathematics.OrbitCycleSupport

/-- The positive held rank of the original unit part at any finite Fold depth. -/
theorem unitLive (q k : Nat) (aboveOne : 1 < q) :
  0 < rankIterate 1 q k ∧ rankIterate 1 q k ≤ q :=
  iterateBounds 1 q k (by decide) (Nat.le_of_lt aboveOne)

/-- Odd support preserves the reduced unit residue at every supplied depth. -/
theorem unitReduced (q k : Nat) (aboveOne : 1 < q) (odd : q % 2 = 1) :
  Nat.gcd (rankIterate 1 q k) q = 1 :=
  iterateReduced 1 q k (Nat.lt_trans (by decide) aboveOne) odd (SFT.Mathematics.OrbitBinaryDepth.gcdOneLeft q)

/-- V3's complete finite residue argument supplies a first, not merely sampled, return. -/
theorem unitFirstReturn (q : Nat) (aboveOne : 1 < q) (odd : q % 2 = 1) :
  ∃ period, 0 < period ∧ period ≤ q ∧ rankIterate 1 q period = 1 ∧
    ∀ j, 0 < j → j < period → rankIterate 1 q j ≠ 1 := by
  obtain ⟨period,_,first,bound⟩ := firstOrderExists q (Nat.lt_trans (by decide) aboveOne) odd
  have eqv := exactExecutedReturnIffOrder 1 q period (by decide) (Nat.le_of_lt aboveOne) (SFT.Mathematics.OrbitBinaryDepth.gcdOneLeft q)
  refine ⟨period,first.1,bound,eqv.mpr first.2.1,?_⟩
  intro j positive before returned
  exact first.2.2 j positive before
    ((exactExecutedReturnIffOrder 1 q j (by decide) (Nat.le_of_lt aboveOne) (SFT.Mathematics.OrbitBinaryDepth.gcdOneLeft q)).mp returned)

/-- Every later executed position stays on the same first-return cycle. -/
theorem unitPerpetualCycle (q : Nat) (aboveOne : 1 < q) (odd : q % 2 = 1) :
  ∃ period, 0 < period ∧ period ≤ q ∧ rankIterate 1 q period = 1 ∧
    (∀ j, 0 < j → j < period → rankIterate 1 q j ≠ 1) ∧
    ∀ k, rankIterate 1 q k = rankIterate 1 q (k % period) := by
  obtain ⟨period,pos,bound,returned,first⟩ := unitFirstReturn q aboveOne odd
  exact ⟨period,pos,bound,returned,first,iterateModuloPeriod 1 q period pos returned⟩

/-- This holds for each supplied positive odd successor, without a finite denominator cutoff. -/
theorem everyOddSuccessor (n : Nat) :
  ∃ period, 0 < period ∧ period ≤ 2*n+3 ∧ rankIterate 1 (2*n+3) period = 1 ∧
    ∀ j, 0 < j → j < period → rankIterate 1 (2*n+3) j ≠ 1 := by
  apply unitFirstReturn
  · exact Nat.lt_of_lt_of_le (by decide : 1 < 3) (Nat.le_add_left 3 (2*n))
  · rw [Nat.add_comm (2*n) 3]
    exact (moduloAddMultiple 3 2 n (by decide)).trans (by rfl)
end SFT.Physics.VacuumOddRecurrence
#print axioms SFT.Physics.VacuumOddRecurrence.unitLive
#print axioms SFT.Physics.VacuumOddRecurrence.unitReduced
#print axioms SFT.Physics.VacuumOddRecurrence.unitFirstReturn
#print axioms SFT.Physics.VacuumOddRecurrence.unitPerpetualCycle
#print axioms SFT.Physics.VacuumOddRecurrence.everyOddSuccessor
