import SFT.Physics.ThermoTemperature
namespace SFT.Physics.ThermoTemperatureOrder
open SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations ThermoTemperature

-- Exact translation of values.py compare_scalar, using cross products of
-- the existing positive rational magnitudes. Ordering is the host comparison
-- result; it is not an additional admitted proof magnitude.
def magnitudeCompare (x y : PositiveFraction) : Ordering :=
  if x.numerator*y.denominator = y.numerator*x.denominator then .eq
  else if y.numerator*x.denominator < x.numerator*y.denominator then .gt else .lt

def reverseOrder : Ordering → Ordering
  | .lt => .gt | .eq => .eq | .gt => .lt

def compareScalar : Scalar → Scalar → Ordering
  | .emptyOne, .emptyOne => .eq
  | .emptyOne, .positive .forward _ => .lt
  | .emptyOne, .positive .counter _ => .gt
  | .positive .forward _, .emptyOne => .gt
  | .positive .counter _, .emptyOne => .lt
  | .positive .forward _, .positive .counter _ => .gt
  | .positive .counter _, .positive .forward _ => .lt
  | .positive .forward x, .positive .forward y => magnitudeCompare x y
  | .positive .counter x, .positive .counter y => reverseOrder (magnitudeCompare x y)

def thermalOrder {Part Support State ClockState Clock : Type}
    (left right reference : Transition Part Support State ClockState Clock) : Except String Ordering :=
  match relativeCarrier left reference with
  | .error e => .error e
  | .ok a => match relativeCarrier right reference with
    | .error e => .error e
    | .ok b => .ok (compareScalar a b)

theorem magnitudeEqualityExact (x y : PositiveFraction) :
    magnitudeCompare x y = .eq ↔ x.numerator*y.denominator = y.numerator*x.denominator := by
  unfold magnitudeCompare
  by_cases h : x.numerator*y.denominator = y.numerator*x.denominator
  · rw [ite_eq_left h]; exact ⟨fun _ => h,fun _ => rfl⟩
  · rw [ite_eq_right h]
    constructor
    · intro same
      split at same <;> cases same
    · intro same; exact False.elim (h same)

theorem magnitudeSelf (x : PositiveFraction) : magnitudeCompare x x = .eq :=
  (magnitudeEqualityExact x x).mpr rfl

theorem comparisonReflexive (x : Scalar) : compareScalar x x = .eq := by
  cases x with
  | emptyOne => rfl
  | positive held magnitude =>
    cases held with
    | forward => exact magnitudeSelf magnitude
    | counter => change reverseOrder (magnitudeCompare magnitude magnitude) = .eq
                 rw [magnitudeSelf]; rfl

theorem forwardComparison (x y : PositiveFraction) :
    compareScalar (.positive .forward x) (.positive .forward y) = magnitudeCompare x y := rfl

theorem counterComparison (x y : PositiveFraction) :
    compareScalar (.positive .counter x) (.positive .counter y) = reverseOrder (magnitudeCompare x y) := rfl

theorem exactHeldReferenceOrder {Part Support State ClockState Clock : Type}
    (left right reference : Transition Part Support State ClockState Clock) (a b : Scalar)
    (ha : relativeCarrier left reference = .ok a) (hb : relativeCarrier right reference = .ok b) :
    thermalOrder left right reference = .ok (compareScalar a b) := by
  unfold thermalOrder
  rw [ha,hb]

theorem sameReadingSameOrder {Part Support State ClockState Clock : Type}
    (left right reference : Transition Part Support State ClockState Clock) (a : Scalar)
    (ha : relativeCarrier left reference = .ok a) (hb : relativeCarrier right reference = .ok a) :
    thermalOrder left right reference = .ok .eq := by
  rw [exactHeldReferenceOrder left right reference a a ha hb,comparisonReflexive]
def magnitudeLE (x y : PositiveFraction) : Prop :=
  x.numerator*y.denominator ≤ y.numerator*x.denominator

theorem magnitudeOrderReflexive (x : PositiveFraction) : magnitudeLE x x := Nat.le_refl _

theorem magnitudeOrderTotal (x y : PositiveFraction) : magnitudeLE x y ∨ magnitudeLE y x :=
  Nat.le_total _ _

theorem magnitudeOrderAntisymmetric (x y : PositiveFraction)
    (xy : magnitudeLE x y) (yx : magnitudeLE y x) : magnitudeCompare x y = .eq :=
  (magnitudeEqualityExact x y).mpr (Nat.le_antisymm xy yx)

theorem magnitudeOrderTransitive (x y z : PositiveFraction)
    (xy : magnitudeLE x y) (yz : magnitudeLE y z) : magnitudeLE x z := by
  have first := Nat.mul_le_mul_right z.denominator xy
  have second := Nat.mul_le_mul_right x.denominator yz
  have a1 : (x.numerator*y.denominator)*z.denominator = y.denominator*(x.numerator*z.denominator) := by
    rw [Nat.mul_comm x.numerator y.denominator,SFT.Foundation.FractionReduction.mulAssoc]
  have a2 : (y.numerator*x.denominator)*z.denominator = x.denominator*(y.numerator*z.denominator) := by
    rw [Nat.mul_comm y.numerator x.denominator,SFT.Foundation.FractionReduction.mulAssoc]
  have b1 : (y.numerator*z.denominator)*x.denominator = x.denominator*(y.numerator*z.denominator) :=
    Nat.mul_comm _ _
  have b2 : (z.numerator*y.denominator)*x.denominator = y.denominator*(z.numerator*x.denominator) := by
    rw [Nat.mul_comm z.numerator y.denominator,SFT.Foundation.FractionReduction.mulAssoc]
  rw [a1,a2] at first
  rw [b1,b2] at second
  exact Nat.le_of_mul_le_mul_left (Nat.le_trans first second) (Nat.pos_of_ne_zero y.denominatorNonzero)

end SFT.Physics.ThermoTemperatureOrder
