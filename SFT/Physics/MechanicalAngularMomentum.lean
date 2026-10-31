import SFT.Physics.MechanicalAngularMotion
namespace SFT.Physics.MechanicalAngularMomentum
open MechanicalEvents MechanicalDuration SFT.Mathematics.FoldScalar

structure AngularMomentum (Part Support State ClockState : Type) where
  separation : MechanicalLocation.Displacement Support
  momentum : MechanicalMomentum.Momentum Part Support State ClockState
  cycle : MechanicalAngularMotion.Cycle State
  leading : Path cycle.recurrence.first momentum.velocity.first
  trailing : Path momentum.velocity.last cycle.recurrence.last
  complete : MechanicalAngularMotion.join
    (MechanicalAngularMotion.join leading momentum.velocity.path) trailing = cycle.recurrence.path

def value {Part Support State ClockState : Type}
    (a : AngularMomentum Part Support State ClockState) : Scalar :=
  multiply (MechanicalWorkEnergy.displacementScalar a.separation)
    (MechanicalForce.momentumScalar a.momentum)

theorem momentumPathRetained {Part Support State ClockState : Type}
    (a : AngularMomentum Part Support State ClockState) :
    (changes a.leading ++ changes a.momentum.velocity.path) ++ changes a.trailing =
      changes a.cycle.recurrence.path := by
  rw [← MechanicalAngularMotion.joinChanges,← MechanicalAngularMotion.joinChanges]
  exact congrArg changes a.complete

def cyclicOrientation {Part Support State ClockState : Type}
    (a : AngularMomentum Part Support State ClockState) := a.cycle.held

theorem exactComposition {Part Support State ClockState : Type}
    (a : AngularMomentum Part Support State ClockState) :
    value a = .positive
      (productOrientation (MechanicalAcceleration.scalarOrientation a.separation.held)
        (MechanicalAcceleration.scalarOrientation (MechanicalMomentum.orientation a.momentum)))
      (SFT.Mathematics.ExactRatioRelations.compose a.separation.separation
        (MechanicalMomentum.magnitude a.momentum)) := rfl

theorem fullCompositionRetained {Part Support State ClockState : Type}
    (a : AngularMomentum Part Support State ClockState) :
    (AngularMomentum.mk a.separation a.momentum a.cycle a.leading a.trailing a.complete : AngularMomentum Part Support State ClockState) = a := rfl

theorem changedSeparationDistinguished {Part Support State ClockState : Type}
    (a b : AngularMomentum Part Support State ClockState) (h : a.separation ≠ b.separation) : a ≠ b :=
  fun eq => h (congrArg AngularMomentum.separation eq)

theorem changedMomentumDistinguished {Part Support State ClockState : Type}
    (a b : AngularMomentum Part Support State ClockState) (h : a.momentum ≠ b.momentum) : a ≠ b :=
  fun eq => h (congrArg AngularMomentum.momentum eq)

theorem changedCycleDistinguished {Part Support State ClockState : Type}
    (a b : AngularMomentum Part Support State ClockState) (h : a.cycle ≠ b.cycle) : a ≠ b :=
  fun eq => h (congrArg AngularMomentum.cycle eq)

def angularScalar {Part Support State ClockState : Type}
    (a : AngularMomentum Part Support State ClockState) := value a

structure Torque (Part Support State ClockState Clock : Type) where
  first : Event (AngularMomentum Part Support State ClockState)
  last : Event (AngularMomentum Part Support State ClockState)
  interval : Path first last
  clock : Recurrence Clock
  present : 0 < count interval

def before {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) := a.first.carrier

def after {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) := a.last.carrier

def provenance {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) := sourceRecords a.interval

def duration {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) :=
  positiveRatio a.interval a.clock a.present

def difference {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) :=
  subtract (angularScalar (after a)) (angularScalar (before a))

def torque {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) :=
  dividePositive (difference a) (duration a)

theorem exactChangeRate {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) :
    torque a = dividePositive (subtract (angularScalar (after a)) (angularScalar (before a)))
      (positiveRatio a.interval a.clock a.present) := rfl

theorem durationExact {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) :
    count a.interval * (duration a).denominator = (duration a).numerator * count a.clock.path :=
  exactRecurrenceRatio a.interval a.clock a.present

theorem unchangedIsEmptyOne {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) (same : (after a) = (before a)) :
    torque a = .emptyOne := by
  unfold torque difference
  rw [same,subtractSelf]
  rfl

theorem positiveChangeRateExact {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) (o : Orientation)
    (m : SFT.Foundation.ExactOperations.PositiveFraction) (change : difference a = .positive o m) :
    torque a = .positive o (quotientMagnitude m (duration a)) ∧
      (m.numerator * (duration a).denominator) * (quotientMagnitude m (duration a)).denominator =
      (quotientMagnitude m (duration a)).numerator * (m.denominator * (duration a).numerator) := by
  constructor
  · unfold torque
    rw [change]
    rfl
  · exact quotientExact _ _

theorem changedBeforeDistinguished {Part Support State ClockState Clock : Type}
    (a b : Torque Part Support State ClockState Clock) (h : (before a) ≠ (before b)) : a ≠ b :=
  fun equal => h (congrArg before equal)

theorem changedAfterDistinguished {Part Support State ClockState Clock : Type}
    (a b : Torque Part Support State ClockState Clock) (h : (after a) ≠ (after b)) : a ≠ b :=
  fun equal => h (congrArg after equal)

theorem changedProvenanceDistinguished {Part Support State ClockState Clock : Type}
    (a b : Torque Part Support State ClockState Clock) (h : provenance a ≠ provenance b) : a ≠ b :=
  fun equal => h (congrArg provenance equal)

theorem retainedBeforeObservation {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) : before a = a.first.carrier := rfl

theorem retainedAfterObservation {Part Support State ClockState Clock : Type}
    (a : Torque Part Support State ClockState Clock) : after a = a.last.carrier := rfl

end SFT.Physics.MechanicalAngularMomentum
