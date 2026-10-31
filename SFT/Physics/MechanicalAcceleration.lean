import SFT.Physics.MechanicalVelocity
import SFT.Mathematics.FoldScalar
namespace SFT.Physics.MechanicalAcceleration
open SFT.Physics.MechanicalEvents SFT.Physics.MechanicalDuration
open SFT.Mathematics.FoldScalar
-- The two held labels are renamed bijectively; complete displacement/reference
-- provenance remains in each velocity carrier and is not projected away.
def scalarOrientation : MechanicalLocation.Held → Orientation
  | .first => .forward
  | .second => .counter

def heldOrientation : Orientation → MechanicalLocation.Held
  | .forward => .first
  | .counter => .second

def velocityScalar {Support State ClockState : Type}
    (v : MechanicalVelocity.Velocity Support State ClockState) : Scalar :=
  .positive (scalarOrientation (MechanicalVelocity.orientation v)) (MechanicalVelocity.speed v)

structure Acceleration (Support State ClockState Clock : Type) where
  first : Event (MechanicalVelocity.Velocity Support State ClockState)
  last : Event (MechanicalVelocity.Velocity Support State ClockState)
  interval : Path first last
  clock : Recurrence Clock
  present : 0 < count interval

def before {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) := a.first.carrier

def after {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) := a.last.carrier

def provenance {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) := sourceRecords a.interval

def duration {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) :=
  positiveRatio a.interval a.clock a.present

def difference {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) :=
  subtract (velocityScalar (after a)) (velocityScalar (before a))

def value {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) :=
  dividePositive (difference a) (duration a)

theorem orientationRoundTrip (o : MechanicalLocation.Held) : heldOrientation (scalarOrientation o) = o := by
  cases o <;> rfl

theorem scalarRoundTrip (o : Orientation) : scalarOrientation (heldOrientation o) = o := by
  cases o <;> rfl

theorem reversalMatches {Support State ClockState : Type}
    (v : MechanicalVelocity.Velocity Support State ClockState) :
    velocityScalar (MechanicalVelocity.reverse v) = SFT.Mathematics.FoldScalar.reverse (velocityScalar v) := by
  cases v with
  | mk d first last path clock present =>
    cases d with
    | mk left right separation held => cases held <;> rfl

theorem exactChangeRate {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) :
    value a = dividePositive (subtract (velocityScalar (after a)) (velocityScalar (before a)))
      (positiveRatio a.interval a.clock a.present) := rfl

theorem durationExact {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) :
    count a.interval * (duration a).denominator = (duration a).numerator * count a.clock.path :=
  exactRecurrenceRatio a.interval a.clock a.present

theorem unchangedIsEmptyOne {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) (same : (after a) = (before a)) :
    value a = .emptyOne := by
  unfold value difference
  rw [same,subtractSelf]
  rfl

theorem positiveChangeRateExact {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) (o : Orientation)
    (m : SFT.Foundation.ExactOperations.PositiveFraction) (change : difference a = .positive o m) :
    value a = .positive o (quotientMagnitude m (duration a)) ∧
      (m.numerator * (duration a).denominator) * (quotientMagnitude m (duration a)).denominator =
      (quotientMagnitude m (duration a)).numerator * (m.denominator * (duration a).numerator) := by
  constructor
  · unfold value
    rw [change]
    rfl
  · exact quotientExact _ _

theorem changedBeforeDistinguished {Support State ClockState Clock : Type}
    (a b : Acceleration Support State ClockState Clock) (h : (before a) ≠ (before b)) : a ≠ b :=
  fun equal => h (congrArg before equal)

theorem changedAfterDistinguished {Support State ClockState Clock : Type}
    (a b : Acceleration Support State ClockState Clock) (h : (after a) ≠ (after b)) : a ≠ b :=
  fun equal => h (congrArg after equal)

theorem changedProvenanceDistinguished {Support State ClockState Clock : Type}
    (a b : Acceleration Support State ClockState Clock) (h : provenance a ≠ provenance b) : a ≠ b :=
  fun equal => h (congrArg provenance equal)

theorem retainedBeforeObservation {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) : before a = a.first.carrier := rfl

theorem retainedAfterObservation {Support State ClockState Clock : Type}
    (a : Acceleration Support State ClockState Clock) : after a = a.last.carrier := rfl

end SFT.Physics.MechanicalAcceleration
