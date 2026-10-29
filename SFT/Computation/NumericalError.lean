import SFT.Computation.StreamingTrace
import SFT.Foundation.ExactCast
namespace SFT.Computation.NumericalError
open SFT.Foundation.ExactOperations

inductive Number where
 | positive : PositiveFraction → Number
 | zero : Number
 | negative : PositiveFraction → Number

abbrev Row := String × PositiveFraction × String

def one : PositiveFraction := normalizePositive 1 1 (Nat.zero_lt_succ _) (Nat.zero_lt_succ _)

def errorValue (exact approximate : PositiveFraction) : PositiveFraction × String :=
  let a := approximate.numerator * exact.denominator
  let e := exact.numerator * approximate.denominator
  let d := exact.denominator * approximate.denominator
  have hd : 0 < d := Nat.mul_pos (Nat.pos_of_ne_zero exact.denominatorNonzero) (Nat.pos_of_ne_zero approximate.denominatorNonzero)
  if same : a = e then (one,"equal")
  else if below : a < e then
    (normalizePositive (e-a) d (SFT.Foundation.ExactCast.subtractPositive _ _ below) hd,"held-below")
  else
    have above : e < a := Nat.lt_of_le_of_ne (Nat.le_of_not_gt below) (fun h => same h.symm)
    (normalizePositive (a-e) d (SFT.Foundation.ExactCast.subtractPositive _ _ above) hd,"held-above")

def rowsFrom (index : Nat) : List Number → List Number → Except String (List Row)
 | [], [] => .ok []
 | [], _ :: _ => .error "comparison requires equal nonempty generated supports"
 | _ :: _, [] => .error "comparison requires equal nonempty generated supports"
 | x :: xs, y :: ys => match x with
   | .zero => .error "scientific proof values must be exact positive parts"
   | .negative _ => .error "scientific proof values must be exact positive parts"
   | .positive exact => match y with
     | .zero => .error "scientific proof values must be exact positive parts"
     | .negative _ => .error "scientific proof values must be exact positive parts"
     | .positive approximate => match rowsFrom (index+1) xs ys with
       | .error reason => .error reason
       | .ok rest => .ok ((SFT.Host.Text.append "cell-" (toString index),errorValue exact approximate) :: rest)

def exactErrorLedger (reference approximation : List Number) : Except String (List Row) :=
  if reference.length ≠ approximation.length ∨ reference = [] then
    .error "comparison requires equal nonempty generated supports"
  else rowsFrom 1 reference approximation

theorem equalMarker (exact approximate : PositiveFraction)
    (same : approximate.numerator * exact.denominator = exact.numerator * approximate.denominator) :
    errorValue exact approximate = (one,"equal") := by
  unfold errorValue; rw [dite_eq_left same]

theorem belowValue (exact approximate : PositiveFraction)
    (below : approximate.numerator * exact.denominator < exact.numerator * approximate.denominator) :
    (errorValue exact approximate).2 = "held-below" ∧
      (exact.numerator * approximate.denominator - approximate.numerator * exact.denominator) * (errorValue exact approximate).1.denominator =
        (errorValue exact approximate).1.numerator * (exact.denominator * approximate.denominator) := by
  have different := Nat.ne_of_lt below
  unfold errorValue; rw [dite_eq_right different,dite_eq_left below]
  exact ⟨rfl,normalizedValuePreserved _ _ (SFT.Foundation.ExactCast.subtractPositive _ _ below) (Nat.mul_pos (Nat.pos_of_ne_zero exact.denominatorNonzero) (Nat.pos_of_ne_zero approximate.denominatorNonzero))⟩

theorem aboveValue (exact approximate : PositiveFraction)
    (above : exact.numerator * approximate.denominator < approximate.numerator * exact.denominator) :
    (errorValue exact approximate).2 = "held-above" ∧
      (approximate.numerator * exact.denominator - exact.numerator * approximate.denominator) * (errorValue exact approximate).1.denominator =
        (errorValue exact approximate).1.numerator * (exact.denominator * approximate.denominator) := by
  have different := Ne.symm (Nat.ne_of_lt above)
  have notBelow := Nat.not_lt_of_ge (Nat.le_of_lt above)
  unfold errorValue; rw [dite_eq_right different,dite_eq_right notBelow]
  exact ⟨rfl,normalizedValuePreserved _ _ (SFT.Foundation.ExactCast.subtractPositive _ _ above) (Nat.mul_pos (Nat.pos_of_ne_zero exact.denominatorNonzero) (Nat.pos_of_ne_zero approximate.denominatorNonzero))⟩

theorem positiveError (exact approximate : PositiveFraction) : 0 < (errorValue exact approximate).1.numerator :=
  (errorValue exact approximate).1.positive

theorem rejectSupport (reference approximation : List Number)
    (bad : reference.length ≠ approximation.length ∨ reference = []) :
    exactErrorLedger reference approximation = .error "comparison requires equal nonempty generated supports" := by
  unfold exactErrorLedger; rw [ite_eq_left bad]

theorem admittedSupport (reference approximation : List Number)
    (length : reference.length = approximation.length) (nonempty : reference ≠ []) :
    exactErrorLedger reference approximation = rowsFrom 1 reference approximation := by
  unfold exactErrorLedger
  rw [ite_eq_right (fun h => h.elim (fun bad => bad length) nonempty)]

theorem rowsCount (index : Nat) (reference approximation : List Number) (rows : List Row)
    (accepted : rowsFrom index reference approximation = .ok rows) : rows.length = reference.length := by
  induction reference generalizing index approximation rows with
  | nil => cases approximation <;> cases accepted; rfl
  | cons exact rest ih =>
    cases approximation with
    | nil => cases accepted
    | cons approximate tail =>
      cases exact with
      | zero => cases accepted
      | negative _ => cases accepted
      | positive x =>
        cases approximate with
        | zero => cases accepted
        | negative _ => cases accepted
        | positive y =>
          unfold rowsFrom at accepted
          cases suffix : rowsFrom (index+1) rest tail with
          | error reason => rw [suffix] at accepted; cases accepted
          | ok more => rw [suffix] at accepted; cases accepted; exact congrArg Nat.succ (ih _ _ _ suffix)

theorem zeroReferenceRejected (index : Nat) (rest tail : List Number) (approximate : Number) :
    rowsFrom index (.zero :: rest) (approximate :: tail) = .error "scientific proof values must be exact positive parts" := rfl

theorem negativeReferenceRejected (index : Nat) (rest tail : List Number) (exact : PositiveFraction) (approximate : Number) :
    rowsFrom index (.negative exact :: rest) (approximate :: tail) = .error "scientific proof values must be exact positive parts" := rfl
end SFT.Computation.NumericalError
