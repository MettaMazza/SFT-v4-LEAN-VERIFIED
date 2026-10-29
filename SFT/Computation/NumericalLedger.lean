import SFT.Computation.NumericalError
namespace SFT.Computation.NumericalLedger
open NumericalError SFT.Foundation.ExactOperations

inductive Rows : Nat → List Number → List Number → List Row → Prop where
 | base (index) : Rows index [] [] []
 | next (index : Nat) (exact approximate : PositiveFraction) (reference approximation : List Number) (rest : List Row)
     (tail : Rows (index+1) reference approximation rest) :
     Rows index (.positive exact :: reference) (.positive approximate :: approximation)
       ((SFT.Host.Text.append "cell-" (toString index),errorValue exact approximate) :: rest)

theorem replay (index : Nat) (reference approximation : List Number) (rows : List Row)
    (certificate : Rows index reference approximation rows) : rowsFrom index reference approximation = .ok rows := by
  induction certificate with
  | base => rfl
  | next index exact approximate reference approximation rest tail ih =>
    unfold rowsFrom; rw [ih]

theorem reconstruct (index : Nat) (reference approximation : List Number) (rows : List Row)
    (accepted : rowsFrom index reference approximation = .ok rows) : Rows index reference approximation rows := by
  induction reference generalizing index approximation rows with
  | nil => cases approximation <;> cases accepted; exact .base _
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
          | ok more => rw [suffix] at accepted; cases accepted; exact .next _ _ _ _ _ _ (ih _ _ _ suffix)

theorem rowMeaning (index : Nat) (reference approximation : List Number) (rows : List Row) :
    rowsFrom index reference approximation = .ok rows ↔ Rows index reference approximation rows :=
  ⟨reconstruct _ _ _ _,replay _ _ _ _⟩

theorem supportLengths (index : Nat) (reference approximation : List Number) (rows : List Row)
    (certificate : Rows index reference approximation rows) : reference.length = approximation.length := by
  induction certificate with
  | base => rfl
  | next index exact approximate reference approximation rest tail ih => exact congrArg Nat.succ ih

theorem exactAdmission (reference approximation : List Number) (rows : List Row) :
    exactErrorLedger reference approximation = .ok rows ↔ reference ≠ [] ∧ Rows 1 reference approximation rows := by
  constructor
  · intro accepted
    unfold exactErrorLedger at accepted
    split at accepted
    · cases accepted
    · rename_i good
      exact ⟨fun h => good (Or.inr h),reconstruct _ _ _ _ accepted⟩
  · intro h
    rw [admittedSupport _ _ (supportLengths _ _ _ _ h.2) h.1]
    exact replay _ _ _ _ h.2

theorem referencePositive (index : Nat) (reference approximation : List Number) (rows : List Row)
    (certificate : Rows index reference approximation rows) :
    ∀ value, value ∈ reference → ∃ part : PositiveFraction, value = .positive part := by
  induction certificate with
  | base => intro value impossible; cases impossible
  | next index exact approximate reference approximation rest tail ih =>
    intro value member
    cases member with
    | head => exact ⟨exact,rfl⟩
    | tail _ member => exact ih value member

theorem approximationPositive (index : Nat) (reference approximation : List Number) (rows : List Row)
    (certificate : Rows index reference approximation rows) :
    ∀ value, value ∈ approximation → ∃ part : PositiveFraction, value = .positive part := by
  induction certificate with
  | base => intro value impossible; cases impossible
  | next index exact approximate reference approximation rest tail ih =>
    intro value member
    cases member with
    | head => exact ⟨approximate,rfl⟩
    | tail _ member => exact ih value member

theorem rowProvenance (index : Nat) (reference approximation : List Number) (rows : List Row)
    (certificate : Rows index reference approximation rows) :
    ∀ row, row ∈ rows → ∃ (position : Nat) (exact approximate : PositiveFraction),
      .positive exact ∈ reference ∧ .positive approximate ∈ approximation ∧
      row = (SFT.Host.Text.append "cell-" (toString position),errorValue exact approximate) := by
  induction certificate with
  | base => intro row impossible; cases impossible
  | next index exact approximate reference approximation rest tail ih =>
    intro row member
    cases member with
    | head => exact ⟨index,exact,approximate,.head _,.head _,rfl⟩
    | tail _ member =>
      obtain ⟨position,x,y,hx,hy,same⟩ := ih row member
      exact ⟨position,x,y,.tail _ hx,.tail _ hy,same⟩

theorem composition (index : Nat) (a b c d : List Number) (left right : List Row)
    (first : Rows index a b left) (second : Rows (index+a.length) c d right) :
    Rows index (a++c) (b++d) (left++right) := by
  induction first with
  | base => exact second
  | next index exact approximate reference approximation rest tail ih =>
    apply Rows.next
    apply ih
    have same : index + (reference.length+1) = (index+1)+reference.length := by
      rw [Nat.add_succ, Nat.succ_add]
    exact same ▸ second

theorem successor (index : Nat) (a b : List Number) (rows : List Row)
    (certificate : Rows index a b rows) (exact approximate : PositiveFraction) :
    Rows index (a++[.positive exact]) (b++[.positive approximate])
      (rows++[(SFT.Host.Text.append "cell-" (toString (index+a.length)),errorValue exact approximate)]) :=
  composition _ _ _ _ _ _ _ certificate (.next _ _ _ _ _ _ (.base _))


def positiveRows (index : Nat) : List PositiveFraction → List PositiveFraction → List Row
 | [], _ => []
 | _ :: _, [] => []
 | exact :: reference, approximate :: approximation =>
   (SFT.Host.Text.append "cell-" (toString index),errorValue exact approximate) ::
     positiveRows (index+1) reference approximation

theorem allPositiveAccepted (index : Nat) (reference approximation : List PositiveFraction)
    (sameLength : reference.length = approximation.length) :
    Rows index (reference.map Number.positive) (approximation.map Number.positive)
      (positiveRows index reference approximation) := by
  induction reference generalizing index approximation with
  | nil => cases approximation with
           | nil => exact .base _
           | cons _ _ => cases sameLength
  | cons exact rest ih =>
    cases approximation with
    | nil => cases sameLength
    | cons approximate tail =>
      exact .next _ _ _ _ _ _ (ih _ _ (Nat.succ.inj sameLength))

theorem positiveLedger (reference approximation : List PositiveFraction)
    (sameLength : reference.length = approximation.length) (nonempty : reference ≠ []) :
    exactErrorLedger (reference.map Number.positive) (approximation.map Number.positive) =
      .ok (positiveRows 1 reference approximation) := by
  apply (exactAdmission _ _ _).mpr
  constructor
  · cases reference with
    | nil => exact False.elim (nonempty rfl)
    | cons _ _ => intro bad; cases bad
  · exact allPositiveAccepted _ _ _ sameLength

theorem everyRowPositive (index : Nat) (reference approximation : List Number) (rows : List Row)
    (certificate : Rows index reference approximation rows) :
    ∀ row, row ∈ rows → 0 < row.2.1.numerator := by
  intro row held
  obtain ⟨position,exact,approximate,_,_,same⟩ := rowProvenance _ _ _ _ certificate row held
  cases same
  exact positiveError _ _

theorem noOmittedRows (index : Nat) (reference approximation : List Number) (rows : List Row)
    (certificate : Rows index reference approximation rows) :
    rows.length = reference.length ∧ rows.length = approximation.length := by
  have count := rowsCount _ _ _ _ (replay _ _ _ _ certificate)
  exact ⟨count,count.trans (supportLengths _ _ _ _ certificate)⟩

end SFT.Computation.NumericalLedger
