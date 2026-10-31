import SFT.Physics.MechanicalMomentum
import SFT.Physics.MechanicalAcceleration
import SFT.Mathematics.FoldScalar
namespace SFT.Physics.MechanicalForce
open SFT.Physics.MechanicalEvents SFT.Physics.MechanicalDuration
open SFT.Mathematics.FoldScalar
def momentumScalar {Part Support State ClockState : Type}
    (p : MechanicalMomentum.Momentum Part Support State ClockState) : Scalar :=
  .positive (MechanicalAcceleration.scalarOrientation (MechanicalMomentum.orientation p))
    (MechanicalMomentum.magnitude p)

structure Force (Part Support State ClockState Clock : Type) where
  first : Event (MechanicalMomentum.Momentum Part Support State ClockState)
  last : Event (MechanicalMomentum.Momentum Part Support State ClockState)
  interval : Path first last
  clock : Recurrence Clock
  present : 0 < count interval

def before {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) := a.first.carrier

def after {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) := a.last.carrier

def provenance {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) := sourceRecords a.interval

def duration {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) :=
  positiveRatio a.interval a.clock a.present

def difference {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) :=
  subtract (momentumScalar (after a)) (momentumScalar (before a))

def value {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) :=
  dividePositive (difference a) (duration a)

theorem exactChangeRate {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) :
    value a = dividePositive (subtract (momentumScalar (after a)) (momentumScalar (before a)))
      (positiveRatio a.interval a.clock a.present) := rfl

theorem durationExact {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) :
    count a.interval * (duration a).denominator = (duration a).numerator * count a.clock.path :=
  exactRecurrenceRatio a.interval a.clock a.present

theorem unchangedIsEmptyOne {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) (same : (after a) = (before a)) :
    value a = .emptyOne := by
  unfold value difference
  rw [same,subtractSelf]
  rfl

theorem positiveChangeRateExact {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) (o : Orientation)
    (m : SFT.Foundation.ExactOperations.PositiveFraction) (change : difference a = .positive o m) :
    value a = .positive o (quotientMagnitude m (duration a)) ∧
      (m.numerator * (duration a).denominator) * (quotientMagnitude m (duration a)).denominator =
      (quotientMagnitude m (duration a)).numerator * (m.denominator * (duration a).numerator) := by
  constructor
  · unfold value
    rw [change]
    rfl
  · exact quotientExact _ _

theorem changedBeforeDistinguished {Part Support State ClockState Clock : Type}
    (a b : Force Part Support State ClockState Clock) (h : (before a) ≠ (before b)) : a ≠ b :=
  fun equal => h (congrArg before equal)

theorem changedAfterDistinguished {Part Support State ClockState Clock : Type}
    (a b : Force Part Support State ClockState Clock) (h : (after a) ≠ (after b)) : a ≠ b :=
  fun equal => h (congrArg after equal)

theorem changedProvenanceDistinguished {Part Support State ClockState Clock : Type}
    (a b : Force Part Support State ClockState Clock) (h : provenance a ≠ provenance b) : a ≠ b :=
  fun equal => h (congrArg provenance equal)

theorem retainedBeforeObservation {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) : before a = a.first.carrier := rfl

theorem retainedAfterObservation {Part Support State ClockState Clock : Type}
    (a : Force Part Support State ClockState Clock) : after a = a.last.carrier := rfl

end SFT.Physics.MechanicalForce
