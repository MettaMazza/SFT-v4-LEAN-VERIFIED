import SFT.Physics.FieldElectricPotential
namespace SFT.Physics.FieldMagneticOrientation
open SFT.Mathematics.FoldScalar

-- field_laws.py MAGNETIC: preserve both held reversals in the transported
-- source/motion relation. Geometric carrier correspondence is separate.
def responseOrientation (charge motion : Orientation) : Orientation := productOrientation charge motion

theorem oppositeInvolutive (h : Orientation) : opposite (opposite h) = h := oppositeTwice h

theorem reversingCharge (q v : Orientation) :
    responseOrientation (opposite q) v = opposite (responseOrientation q v) := by cases q <;> cases v <;> rfl

theorem reversingMotion (q v : Orientation) :
    responseOrientation q (opposite v) = opposite (responseOrientation q v) := by cases q <;> cases v <;> rfl

theorem reversingBoth (q v : Orientation) :
    responseOrientation (opposite q) (opposite v) = responseOrientation q v := by cases q <;> cases v <;> rfl

-- The unit orientation fixes the convention; both source reversal laws then
-- determine every orientation pair, without selecting a fitted coefficient.
theorem uniqueTwoReversalComposition (respond : Orientation → Orientation → Orientation)
    (unit : respond .forward .forward = .forward)
    (chargeRule : ∀ q v, respond (opposite q) v = opposite (respond q v))
    (motionRule : ∀ q v, respond q (opposite v) = opposite (respond q v))
    (q v : Orientation) : respond q v = responseOrientation q v := by
  cases q with
  | forward =>
    cases v with
    | forward => exact unit
    | counter =>
      have h := motionRule .forward .forward
      rw [unit] at h
      exact h
  | counter =>
    cases v with
    | forward =>
      have h := chargeRule .forward .forward
      rw [unit] at h
      exact h
    | counter =>
      have h := chargeRule .forward .counter
      have k := motionRule .forward .forward
      rw [unit] at k
      change respond .forward .counter = .counter at k
      change respond .counter .counter = opposite (respond .forward .counter) at h
      rw [k] at h
      exact h

end SFT.Physics.FieldMagneticOrientation
