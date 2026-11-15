import SFT.Physics.AccumulatedSeparation
namespace SFT.Physics.AccumulatedSeparationGeneral
open AccumulatedSeparation LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
set_option maxHeartbeats 100000000
-- Original exceptional first step is kept separately from the later contraction.
theorem originalFirstStepNotHalf :
 (do let a ← adjacentSectorGap (.integer 1); let b ← adjacentSectorGap (.integer 2); pure ((add b b).blt a))=.ok false := rfl
-- Expand the exact source denominators at every support R=k+2.
theorem originalContractionDenominatorIdentity (k : Nat) :
 (2*(k+2)+2)*(2*(k+2)+3)=2*((k+4)*(k+5))+(2*k*k+8*k+2) := by
 have commute : k*(2*k)=2*(k*k) := by rw [←mulAssoc,Nat.mul_comm k 2,mulAssoc]
 simp only [Nat.mul_add,addMul,mulAssoc,commute,Nat.reduceMul]
 simp only [Nat.mul_comm k 3,Nat.mul_comm k 4,Nat.mul_comm k 5,←mulAssoc,Nat.reduceMul]
 calc
  _ = (4*k*k+8*k+4*k+8*k+6*k)+(16+8+12+6) := by
   conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
   all_goals conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
  _ = (2*k*k+8*k+10*k+2*k*k+8*k)+(40+2) := by
   have four : 4*k*k=2*k*k+2*k*k := by
    change ((2+2)*k)*k=_
    rw [addMul,addMul]
   have ten : 10*k=4*k+6*k := addMul 4 6 k
   change (4*k*k+8*k+4*k+8*k+6*k)+42=(2*k*k+8*k+10*k+2*k*k+8*k)+42
   rw [four,ten]
   conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
   all_goals conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
  _ = _ := by
   conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
   all_goals conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
theorem originalEveryContractionCross (k : Nat) :
 2*((k+4)*(k+5)) < (2*(k+2)+2)*(2*(k+2)+3) := by
 rw [originalContractionDenominatorIdentity]
 exact Nat.lt_add_of_pos_right (Nat.add_pos_right _ (by decide))
theorem originalSupportContractionCross (support : Nat) (h : 2≤support) :
 2*((support+2)*(support+3))<(2*support+2)*(2*support+3) := by
 cases support with
 | zero => exact False.elim (Nat.not_succ_le_zero 1 h)
 | succ n =>
  cases n with
  | zero => exact False.elim (Nat.not_succ_le_self 1 h)
  | succ k => exact originalEveryContractionCross k
theorem originalEveryHalfContraction (k : Nat) :
 successorIsBelowHalf (.integer (.ofNat (k+2)))=.ok true := by
 unfold successorIsBelowHalf
 dsimp only
 rw [originalEveryGap (k+1)]
 dsimp only [Except.bind,Bind.bind]
 rw [originalEveryGap (k+2)]
 dsimp only [Except.bind,Bind.bind]
 rw [addNormalized]
 apply congrArg Except.ok
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (by decide)
  (Nat.mul_pos (Nat.add_pos_right _ (by decide)) (Nat.add_pos_right _ (by decide))) (by decide)
  (Nat.mul_pos (Nat.add_pos_right _ (by decide)) (Nat.add_pos_right _ (by decide)))
 rw [Nat.one_mul]
 have bound : 2≤2^(k+1) := by
  change 2≤2^k*2
  exact Nat.mul_le_mul_right 2 (Nat.pow_pos (by decide))
 change 2*((2^(k+1)+2)*(2^(k+1)+3)) < (2^(k+1)*2+2)*(2^(k+1)*2+3)
 rw [Nat.mul_comm (2^(k+1)) 2]
 exact originalSupportContractionCross _ bound
end SFT.Physics.AccumulatedSeparationGeneral
