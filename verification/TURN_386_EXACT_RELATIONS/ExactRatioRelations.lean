import SFT.Foundation.ExactOperations
namespace SFT.Mathematics.ExactRatioRelations
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction

def ratio (a b : Nat) (ha : 0 < a) (hb : 0 < b) : PositiveFraction :=
 normalizePositive a b ha hb

def reciprocal (x : PositiveFraction) : PositiveFraction :=
 normalizePositive x.denominator x.numerator
  (Nat.pos_of_ne_zero x.denominatorNonzero) x.positive

def compose (x y : PositiveFraction) : PositiveFraction :=
 normalizePositive (x.numerator*y.numerator) (x.denominator*y.denominator)
  (Nat.mul_pos x.positive y.positive)
  (Nat.mul_pos (Nat.pos_of_ne_zero x.denominatorNonzero)
    (Nat.pos_of_ne_zero y.denominatorNonzero))

theorem ratioValue (a b : Nat) (ha : 0 < a) (hb : 0 < b) :
 a*(ratio a b ha hb).denominator = (ratio a b ha hb).numerator*b :=
 normalizedValuePreserved a b ha hb

theorem reciprocalValue (x : PositiveFraction) :
 x.denominator*(reciprocal x).denominator =
 (reciprocal x).numerator*x.numerator :=
 normalizedValuePreserved _ _ _ _

theorem composeValue (x y : PositiveFraction) :
 (x.numerator*y.numerator)*(compose x y).denominator =
 (compose x y).numerator*(x.denominator*y.denominator) :=
 normalizedValuePreserved _ _ _ _

theorem reciprocalReturnsOne (x : PositiveFraction) :
 (compose x (reciprocal x)).numerator = 1 ∧
 (compose x (reciprocal x)).denominator = 1 := by
 apply (normalizationOneIff _ _ _ _).mpr
 exact (Nat.mul_comm _ _).trans (reciprocalValue x).symm

theorem telescopeRaw (a b c : Nat) (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
 (normalizePositive (a*b) (b*c) (Nat.mul_pos ha hb) (Nat.mul_pos hb hc)).numerator*c =
 a*(normalizePositive (a*b) (b*c) (Nat.mul_pos ha hb) (Nat.mul_pos hb hc)).denominator := by
 let z := normalizePositive (a*b) (b*c) (Nat.mul_pos ha hb) (Nat.mul_pos hb hc)
 have h := normalizedValuePreserved (a*b) (b*c) (Nat.mul_pos ha hb) (Nat.mul_pos hb hc)
 change (a*b)*z.denominator = z.numerator*(b*c) at h
 have h' : b*(z.numerator*c) = b*(a*z.denominator) := by
  calc
   b*(z.numerator*c) = z.numerator*(b*c) := by rw [← mulAssoc, Nat.mul_comm b z.numerator, mulAssoc]
   _ = (a*b)*z.denominator := h.symm
   _ = b*(a*z.denominator) := by rw [Nat.mul_comm a b, mulAssoc]
 have hdiv := congrArg (fun n => n/b) h'
 rw [divisionMultiple b (z.numerator*c) hb, divisionMultiple b (a*z.denominator) hb] at hdiv
 exact hdiv

theorem equalPartsReconstruct (m : Nat) (hm : 0 < m) :
 (normalizePositive (m*1) (1*m) (Nat.mul_pos hm (by decide))
  (Nat.mul_pos (by decide) hm)).numerator = 1 ∧
 (normalizePositive (m*1) (1*m) (Nat.mul_pos hm (by decide))
  (Nat.mul_pos (by decide) hm)).denominator = 1 :=
 (normalizationOneIff _ _ _ _).mpr (Nat.mul_comm m 1)

#print axioms ratio
#print axioms reciprocal
#print axioms compose
#print axioms ratioValue
#print axioms reciprocalValue
#print axioms composeValue
#print axioms reciprocalReturnsOne
#print axioms telescopeRaw
#print axioms equalPartsReconstruct
end SFT.Mathematics.ExactRatioRelations
