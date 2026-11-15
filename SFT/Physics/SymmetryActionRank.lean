import SFT.Physics.SymmetryActionDescent
namespace SFT.Physics.SymmetryActionRank
open SymmetryAction SymmetryActionDyadic SymmetryActionDescent
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
open SFT.Mathematics.LimitComputations
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
theorem originalRankLoop (depth fuel rank : Nat) (enough : depth≤fuel) :
 rankLoop fuel (2^(depth+1)) rank=rank+depth := by
 induction depth generalizing fuel rank with
 | zero =>
  cases fuel <;> rw [Nat.add_zero] <;> rfl
 | succ depth ih =>
  cases fuel with
  | zero => exact False.elim (Nat.not_succ_le_zero _ enough)
  | succ fuel =>
   have bound : 2<2^(depth+1+1) := by
    have first : 2≤2^(depth+1) := Nat.mul_le_mul_right 2 (Nat.pow_pos (by decide : 0<2))
    exact Nat.lt_of_lt_of_le (by decide : 2<4) (Nat.mul_le_mul_right 2 first)
   unfold rankLoop
   rw [if_pos bound]
   have division : 2^(depth+1+1)/2=2^(depth+1) := by
    rw [Nat.pow_succ,Nat.mul_comm _ 2]
    exact divisionMultiple 2 _ (by decide)
   rw [division,ih fuel (rank+1) (Nat.le_of_succ_le_succ enough)]
   rw [Nat.add_right_comm rank 1 depth,Nat.add_assoc]
theorem originalPositiveDepthNotOneValue (p : Part) (depth : Nat) (shape : p.denominator=2^(depth+1)) :
 equalRat (asFraction p) oneRatio=false := by
 have den : (p.denominator==1)=false := by
  cases h : p.denominator==1 with
  | false => rfl
  | true =>
   have equal := Nat.eq_of_beq_eq_true h
   have bound : 2≤p.denominator := by
    rw [shape,Nat.pow_succ]
    exact Nat.mul_le_mul_right 2 (Nat.pow_pos (by decide : 0<2))
   rw [equal] at bound
   exact False.elim (Nat.not_succ_le_self 1 bound)
 unfold equalRat
 change (equalInt (.ofNat p.numerator) (.ofNat 1) && (p.denominator==1))=false
 rw [den]
 cases equalInt (.ofNat p.numerator) (.ofNat 1) <;> rfl
theorem originalEveryPositiveRank (p : Part) (depth : Nat) (shape : p.denominator=2^(depth+1)) :
 dyadicDenominatorRank (.fraction (asFraction p))=.ok (depth+1) := by
 unfold dyadicDenominatorRank
 dsimp only
 rw [originalPositiveDepthNotOneValue p depth shape]
 rw [(originalDyadicDomain p).mpr ⟨depth+1,shape⟩]
 dsimp only [Except.bind,Bind.bind]
 change Except.ok (rankLoop p.denominator p.denominator 1)=Except.ok (depth+1)
 have enough : depth≤p.denominator := by
  rw [shape]
  exact Nat.le_trans (Nat.le_succ _) (Nat.le_trans (Nat.le_succ _) (AccumulatedSeparationTolerance.sourcePowerCoversCount (depth+1)))
 rw [shape,originalRankLoop depth (2^(depth+1)) 1 (shape ▸ enough),Nat.add_comm 1 depth]
theorem originalOneValue (p : Part) (shape : p.denominator=1) : asFraction p=oneRatio := by
 cases p with
 | mk n d hd reduced pos bound =>
  change d=1 at shape
  cases shape
  have num : n=1 := Nat.le_antisymm bound pos
  cases num
  rfl
theorem originalSourceRankFalls (p : Part) (depth : Nat) (shape : p.denominator=2^(depth+2)) :
 dyadicDenominatorRank (.fraction (asFraction p))=.ok (depth+2) ∧
 dyadicDenominatorRank (.fraction (asFraction (SFT.Foundation.ExactOperations.foldPart p)))=.ok (depth+1) :=
 ⟨originalEveryPositiveRank p (depth+1) shape,
  originalEveryPositiveRank _ depth (originalDyadicNextDenominator p (depth+1) shape)⟩
end SFT.Physics.SymmetryActionRank
