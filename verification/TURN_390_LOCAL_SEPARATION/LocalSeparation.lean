import SFT.Mathematics.ExactRatioRelations
import SFT.Foundation.FoldCastLaws
namespace SFT.Mathematics.LocalSeparation
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
open SFT.Foundation.ExactCast SFT.Foundation.FoldCastLaws

/-- An ordered held pair after a common finite refinement. -/
structure HeldPair where
 lower : Nat
 upper : Nat
 denominator : Nat
 lowerPositive : 0 < lower
 separated : lower < upper
 withinWhole : upper ≤ denominator

def gap (p : HeldPair) : PositiveFraction :=
 normalizePositive (p.upper-p.lower) p.denominator
  (subtractPositive _ _ p.separated)
  (Nat.lt_of_lt_of_le (Nat.lt_trans p.lowerPositive p.separated) p.withinWhole)

theorem gapValue (p : HeldPair) :
 (p.upper-p.lower)*(gap p).denominator=(gap p).numerator*p.denominator :=
 normalizedValuePreserved _ _ _ _

theorem doubleDifference (upper lower : Nat) :
 (upper+upper)-(lower+lower)=(upper-lower)+(upper-lower) := by
 rw [← twoTimes upper,← twoTimes lower,mulSubtract,twoTimes]

def uncastTransport (p : HeldPair) : PositiveFraction :=
 normalizePositive ((p.upper+p.upper)-(p.lower+p.lower)) p.denominator
  (by rw [doubleDifference]; exact Nat.add_pos_left (subtractPositive _ _ p.separated) _)
  (Nat.lt_of_lt_of_le (Nat.lt_trans p.lowerPositive p.separated) p.withinWhole)

theorem localTransportExact (p : HeldPair) :
 uncastTransport p = normalizePositive ((p.upper-p.lower)+(p.upper-p.lower)) p.denominator
  (Nat.add_pos_left (subtractPositive _ _ p.separated) _)
  (Nat.lt_of_lt_of_le (Nat.lt_trans p.lowerPositive p.separated) p.withinWhole) := by
 exact positiveNormalizationCongr _ _ _ _ _ _ _ _ (doubleDifference p.upper p.lower) rfl

theorem transportValue (p : HeldPair) :
 ((p.upper-p.lower)+(p.upper-p.lower))*(uncastTransport p).denominator=
 (uncastTransport p).numerator*p.denominator := by
 rw [localTransportExact]
 exact normalizedValuePreserved _ _ _ _

#print axioms HeldPair
#print axioms gap
#print axioms gapValue
#print axioms doubleDifference
#print axioms uncastTransport
#print axioms localTransportExact
#print axioms transportValue
end SFT.Mathematics.LocalSeparation
