import SFT.Physics.BoundaryGrowth
namespace SFT.Physics.LeptonTake
open SFT.Foundation.ExactOperations BoundaryGrowth

def heldRemainder (whole part : PositiveFraction)
 (smaller : part.numerator*whole.denominator < whole.numerator*part.denominator) : PositiveFraction :=
 normalizePositive (whole.numerator*part.denominator-part.numerator*whole.denominator)
   (whole.denominator*part.denominator) (SFT.Foundation.ExactCast.subtractPositive _ _ smaller)
   (Nat.mul_pos (Nat.pos_of_ne_zero whole.denominatorNonzero) (Nat.pos_of_ne_zero part.denominatorNonzero))

def positiveTake (whole part : Rat) : Except String PositiveFraction :=
 match admitPositive whole with
 | none => .error "ValueError: positive take requires a smaller positive part"
 | some w => match admitPositive part with
   | none => .error "ValueError: positive take requires a smaller positive part"
   | some p => if smaller : p.numerator*w.denominator < w.numerator*p.denominator then
       .ok (heldRemainder w p smaller)
     else .error "ValueError: positive take requires a smaller positive part"

theorem admitted (whole part : PositiveFraction)
 (smaller : part.numerator*whole.denominator < whole.numerator*part.denominator) :
 positiveTake (asFraction whole) (asFraction part) = .ok (heldRemainder whole part smaller) := by
 unfold positiveTake
 rw [positiveRoundTrip,positiveRoundTrip]
 dsimp only
 rw [dite_eq_left smaller]

theorem rejected (whole part : PositiveFraction)
 (notSmaller : ¬ part.numerator*whole.denominator < whole.numerator*part.denominator) :
 positiveTake (asFraction whole) (asFraction part) =
 .error "ValueError: positive take requires a smaller positive part" := by
 unfold positiveTake
 rw [positiveRoundTrip,positiveRoundTrip]
 dsimp only
 rw [dite_eq_right notSmaller]

theorem remainderValue (whole part : PositiveFraction)
 (smaller : part.numerator*whole.denominator < whole.numerator*part.denominator) :
 (whole.numerator*part.denominator-part.numerator*whole.denominator) *
   (heldRemainder whole part smaller).denominator =
 (heldRemainder whole part smaller).numerator * (whole.denominator*part.denominator) :=
 normalizedValuePreserved _ _ (SFT.Foundation.ExactCast.subtractPositive _ _ smaller)
   (Nat.mul_pos (Nat.pos_of_ne_zero whole.denominatorNonzero) (Nat.pos_of_ne_zero part.denominatorNonzero))

theorem heldPartReassembles (whole part : PositiveFraction)
 (smaller : part.numerator*whole.denominator < whole.numerator*part.denominator) :
 (whole.numerator*part.denominator-part.numerator*whole.denominator) +
 part.numerator*whole.denominator = whole.numerator*part.denominator :=
 SFT.Foundation.FractionReduction.subtractAdd _ _ (Nat.le_of_lt smaller)

end SFT.Physics.LeptonTake
