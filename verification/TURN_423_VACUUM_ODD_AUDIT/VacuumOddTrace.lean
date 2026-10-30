import SFT.Physics.VacuumOddOrbit
import SFT.Foundation.FoldCastLaws
namespace SFT.Physics.VacuumOddTrace
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.ExactCast SFT.Foundation.FoldCastLaws
open SFT.Foundation.ExactValueIdentity
open SFT.Mathematics.OrbitOrderIdentity

/-- Every subtraction in the actual positive cast preserves its remainder. -/
theorem removalRemainder {q n r : Nat} (hq : 0 < q) (trace : Removal q n r) :
 r % q = n % q := by
 induction trace with
 | retain n bound => rfl
 | step n r smaller tail ih =>
   exact ih.trans (moduloRemoves n q hq (Nat.le_of_lt smaller)).symm

theorem castMatchesRank (n q : Nat) (positive : 0 < n) (hq : 0 < q) :
 castNumerator (n+n) q = foldRank n q := by
 have pos := Nat.add_pos_left positive n
 have lhsBounds := castWithinOne (n+n) q hq
 have rhsBounds := foldRankBounds n q hq
 apply heldRemainderInjective _ _ q (castPositive _ _ pos hq) rhsBounds.1 lhsBounds rhsBounds.2
 have left := removalRemainder hq (castHasRemovalTrace (n+n) q hq)
 have right := foldRankResidue n q hq
 rw [Nat.mul_two] at right
 exact left.trans right.symm

theorem normalizationCongr (n a q : Nat) (hn : 0 < n) (ha : 0 < a)
 (nb : n ≤ q) (ab : a ≤ q) (same : n = a) :
 normalizePart n q hn nb = normalizePart a q ha ab := by
 cases same
 rfl

/-- The normalized Fraction transition and the held-rank transition agree exactly. -/
theorem normalizedFoldStep (n q : Nat) (positive : 0 < n) (bound : n ≤ q) :
 foldPart (normalizePart n q positive bound) =
 normalizePart (foldRank n q) q (foldRankBounds n q (Nat.lt_of_lt_of_le positive bound)).1
   (foldRankBounds n q (Nat.lt_of_lt_of_le positive bound)).2 := by
 rw [foldNormalized]
 exact normalizationCongr _ _ _ _ _ _ _ (castMatchesRank n q positive (Nat.lt_of_lt_of_le positive bound))

def state (q : Nat) (aboveOne : 1 < q) (k : Nat) : Part :=
 normalizePart (rankIterate 1 q k) q (VacuumOddRecurrence.unitLive q k aboveOne).1
   (VacuumOddRecurrence.unitLive q k aboveOne).2

theorem stateStep (q : Nat) (aboveOne : 1 < q) (k : Nat) :
 foldPart (state q aboveOne k) = state q aboveOne (k+1) :=
 normalizedFoldStep _ _ (VacuumOddRecurrence.unitLive q k aboveOne).1
   (VacuumOddRecurrence.unitLive q k aboveOne).2

theorem stateReturned (q period : Nat) (aboveOne : 1 < q)
 (returned : rankIterate 1 q period = 1) : state q aboveOne period = state q aboveOne 0 := by
 exact normalizationCongr _ _ _ _ _ _ _ returned

/-- The original Fraction Fold returns on the same finite period supplied by V3's rank derivation. -/
theorem fractionCycleExists (q : Nat) (aboveOne : 1 < q) (odd : q%2=1) :
 ∃ period, 0 < period ∧ period ≤ q ∧ state q aboveOne period = state q aboveOne 0 := by
 obtain ⟨period,pos,bound,returned,_⟩ := VacuumOddRecurrence.unitFirstReturn q aboveOne odd
 exact ⟨period,pos,bound,stateReturned q period aboveOne returned⟩
end SFT.Physics.VacuumOddTrace

#print axioms SFT.Physics.VacuumOddTrace.removalRemainder
#print axioms SFT.Physics.VacuumOddTrace.castMatchesRank
#print axioms SFT.Physics.VacuumOddTrace.normalizedFoldStep
#print axioms SFT.Physics.VacuumOddTrace.state
#print axioms SFT.Physics.VacuumOddTrace.stateStep
#print axioms SFT.Physics.VacuumOddTrace.stateReturned
#print axioms SFT.Physics.VacuumOddTrace.fractionCycleExists

#print axioms SFT.Physics.VacuumOddTrace.normalizationCongr
