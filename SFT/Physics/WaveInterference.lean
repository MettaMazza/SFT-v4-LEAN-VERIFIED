import SFT.Physics.WaveSuperposition
namespace SFT.Physics.WaveInterference
open SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations

structure Predecessor (Cell Trace : Type) where
  cell : Cell
  fullTrace : Trace
  held : Orientation
  support : PositiveFraction

structure Merge (Cell Trace : Type) where
  left : Predecessor Cell Trace
  right : Predecessor Cell Trace
  sameCell : left.cell = right.cell

variable {Cell Trace : Type}

def mergedSupport (m : Merge Cell Trace) :=
  add (.positive m.left.held m.left.support) (.positive m.right.held m.right.support)

def observation (m : Merge Cell Trace) := (m.left.cell,mergedSupport m,m.left,m.right)

theorem matchingLabelsRetainSupport (h : Orientation) (x y : PositiveFraction) :
    add (.positive h x) (.positive h y) = .positive h (sumMagnitude x y) := by cases h <;> rfl

theorem matchingSupportExact (x y : PositiveFraction) :
    (leftCross x y + rightCross x y) * (sumMagnitude x y).denominator =
      (sumMagnitude x y).numerator * denominator x y := normalizedValuePreserved _ _ _ _

theorem opposedLabelsUseHeldRemainder (h : Orientation) (x y : PositiveFraction) :
    add (.positive h x) (.positive (opposite h) y) = opposed h (opposite h) x y := by cases h <;> rfl

theorem equalOpposedSupportCloses (h : Orientation) (x y : PositiveFraction)
    (same : leftCross x y = rightCross x y) :
    add (.positive h x) (.positive (opposite h) y) = .emptyOne := by
  rw [opposedLabelsUseHeldRemainder]
  exact opposedEqual _ _ _ _ same

theorem closureExactlyEqualSupport (h : Orientation) (x y : PositiveFraction) :
    add (.positive h x) (.positive (opposite h) y) = .emptyOne ↔ leftCross x y = rightCross x y := by
  rw [opposedLabelsUseHeldRemainder]
  exact opposedEmptyIff _ _ _ _

theorem unequalLeftSupportRetained (h : Orientation) (x y : PositiveFraction)
    (greater : rightCross x y < leftCross x y) :
    add (.positive h x) (.positive (opposite h) y) = .positive h (leftRemainder x y greater) := by
  rw [opposedLabelsUseHeldRemainder]
  exact opposedLeft _ _ _ _ greater

theorem unequalRightSupportRetained (h : Orientation) (x y : PositiveFraction)
    (greater : leftCross x y < rightCross x y) :
    add (.positive h x) (.positive (opposite h) y) = .positive (opposite h) (rightRemainder x y greater) := by
  rw [opposedLabelsUseHeldRemainder]
  exact opposedRight _ _ _ _ greater

theorem bothPredecessorsRetained (m : Merge Cell Trace) :
    (observation m).2.2.1 = m.left ∧ (observation m).2.2.2 = m.right := ⟨rfl,rfl⟩

theorem commonObservationCell (m : Merge Cell Trace) :
    (observation m).1 = m.right.cell := m.sameCell

theorem changedSourceTraceDistinguished (a b : Merge Cell Trace)
    (h : a.left.fullTrace ≠ b.left.fullTrace ∨ a.right.fullTrace ≠ b.right.fullTrace) : a ≠ b := by
  intro eq
  cases h with
  | inl h => exact h (congrArg (fun m => m.left.fullTrace) eq)
  | inr h => exact h (congrArg (fun m => m.right.fullTrace) eq)
end SFT.Physics.WaveInterference
