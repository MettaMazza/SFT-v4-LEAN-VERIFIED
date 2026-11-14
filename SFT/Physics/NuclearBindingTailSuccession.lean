import SFT.Physics.NuclearBindingTail
namespace SFT.Physics.NuclearBindingTailSuccession
set_option maxHeartbeats 100000000
-- The exact positive-successor condition evaluated by tail_upper_bounds.
theorem everyTailSuccessor (n : Nat) :
 12*(4096+n)+14 < 2*(4096+n)*(4096+n) := by
 let m := 4096+n
 have base : 4096 ≤ m := Nat.le_add_right 4096 n
 have positive : 0 < m := Nat.lt_of_lt_of_le (by decide : 0<4096) base
 have twice : 26 < 2*m := Nat.lt_of_lt_of_le (by decide : 26<2*4096) (Nat.mul_le_mul_left 2 base)
 calc
  12*m+14 ≤ 12*m+14*m := Nat.add_le_add_left (Nat.le_mul_of_pos_right 14 positive) _
  _ = m*12+m*14 := (congrArg (fun x => x+14*m) (Nat.mul_comm 12 m)).trans (congrArg (fun x => m*12+x) (Nat.mul_comm 14 m))
  _ = m*(12+14) := (Nat.mul_add m 12 14).symm
  _ = 26*m := Nat.mul_comm m 26
  _ < 2*m*m := Nat.mul_lt_mul_of_pos_right twice positive
-- For A=5Z+R, the unmatched count is U=A-2Z=3Z+R.
-- This is precisely the cross-multiplied quarter-order 9/100 lower bound.
theorem lowChargeAsymmetry (charge remainder : Nat) :
 9*((5*charge+remainder)*(5*charge+remainder)) ≤
 25*((3*charge+remainder)*(3*charge+remainder)) := by
 have leading : 3*(5*charge)=5*(3*charge) := by
  rw [← SFT.Foundation.FractionReduction.mulAssoc,← SFT.Foundation.FractionReduction.mulAssoc]
 have linear : 3*(5*charge+remainder) ≤ 5*(3*charge+remainder) := by
  rw [Nat.mul_add,Nat.mul_add,leading]
  exact Nat.add_le_add_left (Nat.mul_le_mul_right remainder (by decide : 3≤5)) _
 have square := Nat.mul_le_mul linear linear
 rw [SFT.Foundation.PrimitiveMaps.mulInterchange 3 (5*charge+remainder) 3 (5*charge+remainder),SFT.Foundation.PrimitiveMaps.mulInterchange 5 (3*charge+remainder) 5 (3*charge+remainder)] at square
 exact square
end SFT.Physics.NuclearBindingTailSuccession
