import SFT.Mathematics.ExactRatioRelations
namespace SFT.Mathematics.FoldScalar
open SFT.Foundation.ExactOperations
-- Pinned sft/mathematics/calculator/values.py: admitted scalar domain,
-- reverse, add_scalar, subtract_scalar and division by a positive forward scalar.
inductive Orientation where
  | forward | counter

def opposite : Orientation → Orientation
  | .forward => .counter
  | .counter => .forward

def orientationName : Orientation → String
  | .forward => "forward-held"
  | .counter => "counter-held"

inductive Scalar where
  | emptyOne
  | positive (orientation : Orientation) (magnitude : PositiveFraction)

def reverse : Scalar → Scalar
  | .emptyOne => .emptyOne
  | .positive o x => .positive (opposite o) x

def denominator (x y : PositiveFraction) := x.denominator * y.denominator

def leftCross (x y : PositiveFraction) := x.numerator * y.denominator

def rightCross (x y : PositiveFraction) := y.numerator * x.denominator

theorem denominatorPositive (x y : PositiveFraction) : 0 < denominator x y :=
  Nat.mul_pos (Nat.pos_of_ne_zero x.denominatorNonzero) (Nat.pos_of_ne_zero y.denominatorNonzero)

def sumMagnitude (x y : PositiveFraction) : PositiveFraction :=
  normalizePositive (leftCross x y + rightCross x y) (denominator x y)
    (Nat.add_pos_left (Nat.mul_pos x.positive (Nat.pos_of_ne_zero y.denominatorNonzero)) _)
    (denominatorPositive x y)

def leftRemainder (x y : PositiveFraction) (h : rightCross x y < leftCross x y) : PositiveFraction :=
  normalizePositive (leftCross x y - rightCross x y) (denominator x y)
    (SFT.Foundation.ExactCast.subtractPositive _ _ h) (denominatorPositive x y)

def rightRemainder (x y : PositiveFraction) (h : leftCross x y < rightCross x y) : PositiveFraction :=
  normalizePositive (rightCross x y - leftCross x y) (denominator x y)
    (SFT.Foundation.ExactCast.subtractPositive _ _ h) (denominatorPositive x y)

def opposed (left right : Orientation) (x y : PositiveFraction) : Scalar :=
  if h : rightCross x y < leftCross x y then .positive left (leftRemainder x y h)
  else if h : leftCross x y < rightCross x y then .positive right (rightRemainder x y h)
  else .emptyOne

def add : Scalar → Scalar → Scalar
  | .emptyOne, right => right
  | left, .emptyOne => left
  | .positive .forward x, .positive .forward y => .positive .forward (sumMagnitude x y)
  | .positive .counter x, .positive .counter y => .positive .counter (sumMagnitude x y)
  | .positive .forward x, .positive .counter y => opposed .forward .counter x y
  | .positive .counter x, .positive .forward y => opposed .counter .forward x y

def subtract (left right : Scalar) : Scalar := add left (reverse right)

def quotientMagnitude (x t : PositiveFraction) : PositiveFraction :=
  SFT.Mathematics.ExactRatioRelations.compose x
    (SFT.Mathematics.ExactRatioRelations.reciprocal t)

def dividePositive (value : Scalar) (duration : PositiveFraction) : Scalar :=
  match value with
  | .emptyOne => .emptyOne
  | .positive held magnitude => .positive held (quotientMagnitude magnitude duration)

theorem oppositeTwice (o : Orientation) : opposite (opposite o) = o := by cases o <;> rfl

theorem reverseTwice (s : Scalar) : reverse (reverse s) = s := by
  cases s with
  | emptyOne => rfl
  | positive o x => cases o <;> rfl

theorem reversalPreservesMagnitude (o : Orientation) (x : PositiveFraction) :
    reverse (.positive o x) = .positive (opposite o) x := rfl

theorem addEmptyLeft (s : Scalar) : add .emptyOne s = s := rfl

theorem addEmptyRight (s : Scalar) : add s .emptyOne = s := by cases s <;> rfl

theorem equalOrientationsAdd (o : Orientation) (x y : PositiveFraction) :
    add (.positive o x) (.positive o y) = .positive o (sumMagnitude x y) := by cases o <;> rfl

theorem sumExact (x y : PositiveFraction) :
    (leftCross x y + rightCross x y) * (sumMagnitude x y).denominator =
      (sumMagnitude x y).numerator * denominator x y := normalizedValuePreserved _ _ _ _

theorem leftRemainderExact (x y : PositiveFraction) (h : rightCross x y < leftCross x y) :
    (leftCross x y - rightCross x y) * (leftRemainder x y h).denominator =
      (leftRemainder x y h).numerator * denominator x y := normalizedValuePreserved _ _ _ _

theorem rightRemainderExact (x y : PositiveFraction) (h : leftCross x y < rightCross x y) :
    (rightCross x y - leftCross x y) * (rightRemainder x y h).denominator =
      (rightRemainder x y h).numerator * denominator x y := normalizedValuePreserved _ _ _ _

theorem opposedLeft (a b : Orientation) (x y : PositiveFraction)
    (h : rightCross x y < leftCross x y) :
    opposed a b x y = .positive a (leftRemainder x y h) := by
  unfold opposed
  rw [dite_eq_left h]

theorem opposedRight (a b : Orientation) (x y : PositiveFraction)
    (h : leftCross x y < rightCross x y) :
    opposed a b x y = .positive b (rightRemainder x y h) := by
  unfold opposed
  rw [dite_eq_right (Nat.not_lt_of_ge (Nat.le_of_lt h)), dite_eq_left h]

theorem opposedEqual (a b : Orientation) (x y : PositiveFraction)
    (h : leftCross x y = rightCross x y) : opposed a b x y = .emptyOne := by
  unfold opposed
  rw [dite_eq_right (Nat.not_lt_of_ge (Nat.le_of_eq h)),
      dite_eq_right (Nat.not_lt_of_ge (Nat.le_of_eq h.symm))]

theorem opposedEmptyIff (a b : Orientation) (x y : PositiveFraction) :
    opposed a b x y = .emptyOne ↔ leftCross x y = rightCross x y := by
  constructor
  · intro empty
    unfold opposed at empty
    split at empty
    · cases empty
    · rename_i notLeft
      split at empty
      · cases empty
      · rename_i notRight
        exact Nat.le_antisymm (Nat.le_of_not_gt notLeft) (Nat.le_of_not_gt notRight)
  · exact opposedEqual a b x y

theorem addMultiply (a b c : Nat) : (a+b)*c = a*c+b*c := by
  rw [Nat.mul_comm (a+b) c,Nat.mul_add,Nat.mul_comm c a,Nat.mul_comm c b]

theorem leftRemainderReconstructs (x y : PositiveFraction) (h : rightCross x y < leftCross x y) :
    rightCross x y * (leftRemainder x y h).denominator +
      (leftRemainder x y h).numerator * denominator x y =
      leftCross x y * (leftRemainder x y h).denominator := by
  rw [← leftRemainderExact x y h, ← addMultiply, Nat.add_comm,
      SFT.Foundation.FractionReduction.subtractAdd _ _ (Nat.le_of_lt h)]

theorem rightRemainderReconstructs (x y : PositiveFraction) (h : leftCross x y < rightCross x y) :
    leftCross x y * (rightRemainder x y h).denominator +
      (rightRemainder x y h).numerator * denominator x y =
      rightCross x y * (rightRemainder x y h).denominator := by
  rw [← rightRemainderExact x y h, ← addMultiply, Nat.add_comm,
      SFT.Foundation.FractionReduction.subtractAdd _ _ (Nat.le_of_lt h)]

theorem subtractSelf (s : Scalar) : subtract s s = .emptyOne := by
  cases s with
  | emptyOne => rfl
  | positive o x => cases o <;> exact opposedEqual _ _ x x rfl

theorem subtractEmpty (s : Scalar) : subtract s .emptyOne = s := addEmptyRight s

theorem subtractFromEmpty (s : Scalar) : subtract .emptyOne s = reverse s := rfl

theorem quotientExact (x t : PositiveFraction) :
    (x.numerator * t.denominator) * (quotientMagnitude x t).denominator =
      (quotientMagnitude x t).numerator * (x.denominator * t.numerator) :=
  SFT.Mathematics.ExactRatioRelations.composeRepresents x
    (SFT.Mathematics.ExactRatioRelations.reciprocal t)
    x.numerator x.denominator t.denominator t.numerator rfl
    (SFT.Mathematics.ExactRatioRelations.reciprocalValue t)

theorem divisionRetainsOrientation (o : Orientation) (x t : PositiveFraction) :
    dividePositive (.positive o x) t = .positive o (quotientMagnitude x t) := rfl

theorem divisionPreservesEmpty (t : PositiveFraction) : dividePositive .emptyOne t = .emptyOne := rfl

theorem quotientPositive (x t : PositiveFraction) : 0 < (quotientMagnitude x t).numerator :=
  (quotientMagnitude x t).positive

end SFT.Mathematics.FoldScalar
