import SFT.Physics.StellarResponses
namespace SFT.Physics.StellarRadialDerivation
open SFT.Foundation.FractionReduction
-- For the original exact q=n/d>One, compare q^4 and q^5 by their
-- positive denominators. This is the source's perfect-power comparison.
theorem originalCompressedCrossOrder (n d : Nat) (positive : 0<d) (above : d<n) :
 n^4*d^5 < n^5*d^4 := by
 have np : 0<n := Nat.lt_trans positive above
 have common : 0<n^4*d^4 := Nat.mul_pos (Nat.pow_pos np) (Nat.pow_pos positive)
 have step := Nat.mul_lt_mul_of_pos_left above common
 have left : n^4*d^5=(n^4*d^4)*d := by rw [Nat.pow_succ d 4,mulAssoc]
 have right : n^5*d^4=(n^4*d^4)*n := by
  rw [Nat.pow_succ n 4,mulAssoc,mulAssoc,Nat.mul_comm n (d^4)]
 rw [left,right]
 exact step
-- 1/q^5 < 1/q^4 has the same positive cross-product order.
theorem originalExpandedCrossOrder (n d : Nat) (positive : 0<d) (above : d<n) :
 d^5*n^4 < d^4*n^5 := by
 rw [Nat.mul_comm (d^5),Nat.mul_comm (d^4)]
 exact originalCompressedCrossOrder n d positive above
#print axioms originalCompressedCrossOrder
#print axioms originalExpandedCrossOrder
end SFT.Physics.StellarRadialDerivation
