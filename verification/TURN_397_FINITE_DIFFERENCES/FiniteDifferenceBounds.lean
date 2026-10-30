import SFT.Mathematics.ExactRatioRelations
namespace SFT.Mathematics.FiniteDifferenceBounds
open SFT.Foundation.FractionReduction SFT.Foundation.ExactOperations
open ExactRatioRelations
set_option maxHeartbeats 2000000

theorem addMul (a b c : Nat) : (a+b)*c=a*c+b*c := by
 rw [Nat.mul_comm (a+b) c,Nat.mul_add,Nat.mul_comm c a,Nat.mul_comm c b]

/-- Denominator-cleared centered quadratic second difference at One,
with the positive denominator q=m+1. -/
theorem quadraticCentered (m : Nat) :
 ((m+1)+1)*((m+1)+1)+m*m=
 (m+1)*(m+1)+(m+1)*(m+1)+(1+1) := by
 conv => lhs; simp only [Nat.mul_add,addMul,Nat.mul_one,Nat.one_mul,Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
 conv => rhs; simp only [Nat.mul_add,addMul,Nat.mul_one,Nat.one_mul,Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]

/-- Denominator-cleared forward cubic second difference at One. -/
theorem cubicForward (q : Nat) :
 ((q+1)+1)*((q+1)+1)*((q+1)+1)+q*q*q=
 (q+1)*(q+1)*(q+1)+(q+1)*(q+1)*(q+1)+
 (q+q+q+q+q+q)+(1+1+1+1+1+1) := by
 conv => lhs; simp only [Nat.mul_add,addMul,Nat.mul_one,Nat.one_mul,Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
 conv => rhs; simp only [Nat.mul_add,addMul,Nat.mul_one,Nat.one_mul,Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]

def errorBound (n : Nat) : PositiveFraction :=
 ratio 6 (2^n) (by decide) (Nat.pow_pos (by decide))

theorem errorPositive (n : Nat) : 0<(errorBound n).numerator := (errorBound n).positive

theorem errorValue (n : Nat) :
 6*(errorBound n).denominator=(errorBound n).numerator*(2^n) :=
 ratioValue _ _ _ _

theorem dyadicDenominatorStep (n : Nat) : 2^(n+1)=2^n+2^n := by
 rw [Nat.pow_succ,Nat.mul_succ,Nat.mul_one]

#print axioms addMul
#print axioms quadraticCentered
#print axioms cubicForward
#print axioms errorBound
#print axioms errorPositive
#print axioms errorValue
#print axioms dyadicDenominatorStep
end SFT.Mathematics.FiniteDifferenceBounds
