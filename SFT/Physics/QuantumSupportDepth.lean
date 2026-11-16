import SFT.Physics.QuantumSupportPreparation
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.QuantumSupportDepth
open QuantumSupportPreparation LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.CommonRefinement
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000

theorem originalWordCount (depth : Nat) : (words depth).length=2^depth := by
 induction depth with
 | zero => rfl
 | succ depth ih =>
   change (((words depth).map (List.cons held))++(((words depth).map (List.cons returned))++[])).length=_
   rw [appendLength,appendLength,mapLength,mapLength,ih]
   change 2^depth+(2^depth+0)=2^(depth+1)
   rw [Nat.add_zero,Nat.pow_succ,Nat.mul_succ,Nat.mul_one]
private theorem powerNext (n : Nat) : 2^n<2^(n+1) := by
 rw [Nat.pow_succ,Nat.mul_succ,Nat.mul_one]
 exact Nat.lt_add_of_pos_right (Nat.pow_pos (by decide))
private theorem powerStrict (a b : Nat) (less : a<b) : 2^a<2^b := by
 induction b with
 | zero => exact False.elim (Nat.not_lt_zero _ less)
 | succ b ih =>
   cases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ less) with
   | inl h => exact Nat.lt_trans (ih h) (powerNext b)
   | inr h => rw [h];exact powerNext b

theorem originalDyadicCover (d : Nat) : AlphaCovers.coverDepth (2^(d+1))=d+1 := by
 have cover := AlphaCovers.leastPositiveCover (2^(d+1))
 apply Nat.le_antisymm
 · apply Nat.le_of_not_gt
   intro smaller
   exact Nat.lt_irrefl _ (cover.2.2 (d+1) (Nat.zero_lt_succ _) smaller)
 · apply Nat.le_of_not_gt
   intro smaller
   exact Nat.not_lt_of_ge cover.2.1 (powerStrict _ _ smaller)

theorem originalPreparationDepthUnique (a b : Nat) (same : 2^(a+1)=2^(b+1)) : a=b := by
 apply Nat.le_antisymm
 · apply Nat.le_of_not_gt
   intro less
   have strict := powerStrict (b+1) (a+1) (Nat.succ_lt_succ less)
   rw [same] at strict
   exact Nat.lt_irrefl _ strict
 · apply Nat.le_of_not_gt
   intro less
   have strict := powerStrict (a+1) (b+1) (Nat.succ_lt_succ less)
   rw [same] at strict
   exact Nat.lt_irrefl _ strict
private theorem positiveOperation (n : Nat) (positive : 0<n) (name : String) :
 SpinStatisticsCondensation.positiveWhole (.integer (.ofNat n)) name=.ok n := by
 cases n with
 | zero => exact False.elim (Nat.not_lt_zero _ positive)
 | succ n => rfl
private theorem divideWhole (n p : Nat) (positive : 0<p) :
 LeptonRatios.divide (wholeRatio n) (wholeRatio p)=.ok (natRatio n p positive) := by
 cases p with
 | zero => exact False.elim (Nat.not_lt_zero _ positive)
 | succ p =>
   rw [←natRatioWhole n,←natRatioWhole (p+1),divideNormalized n 1 (p+1) 1 (by decide) (Nat.zero_lt_succ _) (by decide)]
   apply congrArg Except.ok
   apply natRatioCongruence
   rw [Nat.mul_one,Nat.one_mul]

theorem originalEveryDyadicPreparation (d : Nat) :
 preparationDepth (.integer (.ofNat (2^(d+1))))=
 .ok ⟨2^(d+1),d+1,(List.range (d+1)).map (fun i => 2^(i+1)),natRatio 1 (2^(d+1)) (Nat.pow_pos (by decide))⟩ := by
 unfold preparationDepth
 rw [positiveOperation _ (Nat.pow_pos (by decide))]
 dsimp only [Except.bind,Bind.bind]
 rw [originalDyadicCover]
 have size : 2≤2^(d+1) := by
   have one := powerStrict 0 (d+1) (Nat.zero_lt_succ _)
   exact one
 have guard : decide (2^(d+1)<2)=false := decide_eq_false (Nat.not_lt_of_ge size)
 have equal := naturalEqualityReflexive (2^(d+1))
 have unequal : (2^(d+1)!=2^(d+1))=false := by
  change (!(2^(d+1)==2^(d+1)))=false
  rw [equal]
  rfl
 rw [guard,unequal]
 rw [divideWhole]
 rfl
end SFT.Physics.QuantumSupportDepth
