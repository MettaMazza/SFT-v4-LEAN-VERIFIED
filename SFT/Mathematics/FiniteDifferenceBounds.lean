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

theorem errorHalves (n : Nat) :
 ((errorBound (n+1)).numerator+(errorBound (n+1)).numerator)*(errorBound n).denominator =
 (errorBound n).numerator*(errorBound (n+1)).denominator := by
 let a := errorBound (n+1)
 let b := errorBound n
 let q := 2^n
 have ha := errorValue (n+1)
 rw [dyadicDenominatorStep] at ha
 change 6*a.denominator=a.numerator*(q+q) at ha
 have hb := errorValue n
 change 6*b.denominator=b.numerator*q at hb
 apply cancelPositive q _ _ (Nat.pow_pos (by decide))
 calc
  q*((a.numerator+a.numerator)*b.denominator) = (a.numerator*(q+q))*b.denominator := by
   rw [← mulAssoc,Nat.mul_add, Nat.mul_comm q a.numerator,← Nat.mul_add]
  _ = (6*a.denominator)*b.denominator := congrArg (fun x => x*b.denominator) ha.symm
  _ = (6*b.denominator)*a.denominator := by rw [mulAssoc,Nat.mul_comm a.denominator b.denominator,← mulAssoc]
  _ = (b.numerator*q)*a.denominator := congrArg (fun x => x*a.denominator) hb
  _ = q*(b.numerator*a.denominator) := by rw [Nat.mul_comm b.numerator q,mulAssoc]

theorem errorStrictlyDecreases (n : Nat) :
 (errorBound (n+1)).numerator*(errorBound n).denominator <
 (errorBound n).numerator*(errorBound (n+1)).denominator := by
 have h := errorHalves n
 rw [addMul] at h
 rw [← h]
 exact Nat.lt_add_of_pos_right (Nat.mul_pos (errorPositive (n+1))
   (Nat.pos_of_ne_zero (errorBound n).denominatorNonzero))

theorem dyadicExceedsIndex (n : Nat) : n+1 ≤ 2^n := by
 induction n with
 | zero => exact Nat.le_refl 1
 | succ n ih =>
  rw [dyadicDenominatorStep]
  have h : (n+1)+1 ≤ (n+1)+(n+1) :=
   Nat.add_le_add_left (Nat.succ_le_succ (Nat.zero_le n)) (n+1)
  exact Nat.le_trans h (Nat.add_le_add ih ih)

theorem finiteErrorCertificate (a d : Nat) (ha : 0<a) (_hd : 0<d) :
 (errorBound (6*d)).numerator*d < a*(errorBound (6*d)).denominator := by
 let e := errorBound (6*d)
 let q := 2^(6*d)
 have qlarge : 6*d<q := Nat.lt_of_lt_of_le (Nat.lt_succ_self _) (dyadicExceedsIndex _)
 have ev := errorValue (6*d)
 change 6*e.denominator=e.numerator*q at ev
 have product : (e.numerator*d)*q<e.denominator*q := by
  calc
   (e.numerator*d)*q = (e.numerator*q)*d := by rw [mulAssoc,Nat.mul_comm d q,← mulAssoc]
   _ = (6*e.denominator)*d := congrArg (fun n => n*d) ev.symm
   _ = e.denominator*(6*d) := by rw [Nat.mul_comm 6 e.denominator,mulAssoc]
   _ < e.denominator*q := Nat.mul_lt_mul_of_pos_left qlarge (Nat.pos_of_ne_zero e.denominatorNonzero)
 have small : e.numerator*d<e.denominator := by
  apply Nat.lt_of_not_ge
  intro h
  exact Nat.not_lt_of_ge (Nat.mul_le_mul_right q h) product
 have bound : e.denominator≤a*e.denominator := by
  have h := Nat.mul_le_mul_right e.denominator ha
  rw [Nat.one_mul] at h
  exact h
 exact Nat.lt_of_lt_of_le small bound

#print axioms dyadicExceedsIndex
#print axioms finiteErrorCertificate
#print axioms errorHalves
#print axioms errorStrictlyDecreases
#print axioms addMul
#print axioms quadraticCentered
#print axioms cubicForward
#print axioms errorBound
#print axioms errorPositive
#print axioms errorValue
#print axioms dyadicDenominatorStep
end SFT.Mathematics.FiniteDifferenceBounds
