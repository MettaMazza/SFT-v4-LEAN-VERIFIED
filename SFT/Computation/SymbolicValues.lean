import SFT.Computation.NumericalBoundary
namespace SFT.Computation.SymbolicValues
open NumericalError SFT.Foundation.ExactOperations

def positiveSum (left right : PositiveFraction) : PositiveFraction :=
  normalizePositive (left.numerator*right.denominator + right.numerator*left.denominator)
    (left.denominator*right.denominator)
    (Nat.add_pos_left (Nat.mul_pos left.positive (Nat.pos_of_ne_zero right.denominatorNonzero)) _)
    (Nat.mul_pos (Nat.pos_of_ne_zero left.denominatorNonzero) (Nat.pos_of_ne_zero right.denominatorNonzero))

-- Signs here preserve the raw Fraction environment domain; scientific literal
-- admission remains positive exactly as in evaluate_expression.
def difference (left right : PositiveFraction) : Number :=
  let l := left.numerator*right.denominator
  let r := right.numerator*left.denominator
  let d := left.denominator*right.denominator
  have hd : 0<d := Nat.mul_pos (Nat.pos_of_ne_zero left.denominatorNonzero) (Nat.pos_of_ne_zero right.denominatorNonzero)
  if same : l=r then .zero
  else if greater : r<l then
    .positive (normalizePositive (l-r) d (SFT.Foundation.ExactCast.subtractPositive _ _ greater) hd)
  else
    have less : l<r := Nat.lt_of_le_of_ne (Nat.le_of_not_gt greater) same
    .negative (normalizePositive (r-l) d (SFT.Foundation.ExactCast.subtractPositive _ _ less) hd)

def add : Number → Number → Number
 | .zero, right => right
 | .positive left, right => match right with
   | .zero => .positive left
   | .positive right => .positive (positiveSum left right)
   | .negative right => difference left right
 | .negative left, right => match right with
   | .zero => .negative left
   | .positive right => difference right left
   | .negative right => .negative (positiveSum left right)

theorem sumValue (left right : PositiveFraction) :
    (left.numerator*right.denominator + right.numerator*left.denominator) * (positiveSum left right).denominator =
      (positiveSum left right).numerator * (left.denominator*right.denominator) :=
  normalizedValuePreserved _ _ _ _

theorem cancellation (left right : PositiveFraction)
    (same : left.numerator*right.denominator = right.numerator*left.denominator) : difference left right = .zero := by
  unfold difference; rw [dite_eq_left same]

theorem leftIdentity (value : Number) : add .zero value = value := rfl

theorem rightIdentity (value : Number) : add value .zero = value := by cases value <;> rfl

theorem positiveAddition (left right : PositiveFraction) :
    add (.positive left) (.positive right) = .positive (positiveSum left right) := rfl


theorem differencePositive (left right : PositiveFraction)
    (greater : right.numerator*left.denominator < left.numerator*right.denominator) :
    ∃ value : PositiveFraction, difference left right = .positive value ∧
      (left.numerator*right.denominator-right.numerator*left.denominator)*value.denominator =
        value.numerator*(left.denominator*right.denominator) := by
  have different := Ne.symm (Nat.ne_of_lt greater)
  unfold difference
  rw [dite_eq_right different,dite_eq_left greater]
  exact ⟨_,rfl,normalizedValuePreserved _ _ _ _⟩

theorem differenceNegative (left right : PositiveFraction)
    (less : left.numerator*right.denominator < right.numerator*left.denominator) :
    ∃ value : PositiveFraction, difference left right = .negative value ∧
      (right.numerator*left.denominator-left.numerator*right.denominator)*value.denominator =
        value.numerator*(left.denominator*right.denominator) := by
  have different := Nat.ne_of_lt less
  have notGreater := Nat.not_lt_of_ge (Nat.le_of_lt less)
  unfold difference
  rw [dite_eq_right different,dite_eq_right notGreater]
  exact ⟨_,rfl,normalizedValuePreserved _ _ _ _⟩

end SFT.Computation.SymbolicValues
