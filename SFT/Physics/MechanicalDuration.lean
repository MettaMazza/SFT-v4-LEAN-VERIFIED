import SFT.Physics.MechanicalEvents
import SFT.Mathematics.ExactRatioRelations
namespace SFT.Physics.MechanicalDuration
open SFT.Physics.MechanicalEvents SFT.Mathematics.ExactRatioRelations
open SFT.Foundation.ExactOperations

structure Recurrence (State : Type) where
  first : Event State
  last : Event State
  path : Path first last
  returnsToCarrier : last.carrier = first.carrier
  hasTransition : 0 < count path

inductive Duration where
  | emptyOne
  | positive : PositiveFraction → Duration

def positiveRatio {State ClockState : Type} {a b : Event State}
    (p : Path a b) (clock : Recurrence ClockState) (h : 0 < count p) : PositiveFraction :=
  ratio (count p) (count clock.path) h clock.hasTransition

def elapsed {State ClockState : Type} {a b : Event State}
    (p : Path a b) (clock : Recurrence ClockState) : Duration :=
  if h : count p = 0 then .emptyOne
  else .positive (positiveRatio p clock (Nat.pos_of_ne_zero h))

theorem absenceIsEmptyOne {State ClockState : Type} {a b : Event State}
    (p : Path a b) (clock : Recurrence ClockState) (absent : count p = 0) :
    elapsed p clock = .emptyOne := by
  unfold elapsed
  rw [dite_eq_left absent]

theorem oneEventIsEmptyOne {State ClockState : Type} (a : Event State)
    (clock : Recurrence ClockState) : elapsed (.one a) clock = .emptyOne :=
  absenceIsEmptyOne _ _ rfl

theorem presentIsPositive {State ClockState : Type} {a b : Event State}
    (p : Path a b) (clock : Recurrence ClockState) (present : 0 < count p) :
    elapsed p clock = .positive (positiveRatio p clock present) := by
  unfold elapsed
  rw [dite_eq_right (Nat.ne_of_gt present)]

theorem absenceExactly {State ClockState : Type} {a b : Event State}
    (p : Path a b) (clock : Recurrence ClockState) :
    elapsed p clock = .emptyOne ↔ count p = 0 := by
  constructor
  · intro h
    cases n : count p with
    | zero => rfl
    | succ k =>
      have present : 0 < count p := by rw [n]; exact Nat.zero_lt_succ k
      rw [presentIsPositive p clock present] at h
      cases h
  · exact absenceIsEmptyOne p clock

theorem noNumericalZero {State ClockState : Type} {a b : Event State}
    (p : Path a b) (clock : Recurrence ClockState) (present : 0 < count p) :
    0 < (positiveRatio p clock present).numerator := (positiveRatio p clock present).positive

theorem exactRecurrenceRatio {State ClockState : Type} {a b : Event State}
    (p : Path a b) (clock : Recurrence ClockState) (present : 0 < count p) :
    count p * (positiveRatio p clock present).denominator =
      (positiveRatio p clock present).numerator * count clock.path :=
  ratioValue _ _ present clock.hasTransition

theorem clockRecurs {ClockState : Type} (clock : Recurrence ClockState) :
    clock.last.carrier = clock.first.carrier := clock.returnsToCarrier

theorem referenceRecurrenceIsOne {ClockState : Type} (clock : Recurrence ClockState) :
    (positiveRatio clock.path clock clock.hasTransition).numerator = 1 ∧
    (positiveRatio clock.path clock clock.hasTransition).denominator = 1 :=
  (normalizationOneIff _ _ clock.hasTransition clock.hasTransition).mpr rfl

theorem successorDurationPresent {State ClockState : Type} {a b c : Event State}
    (p : Path a b) (step : Change b c) (clock : Recurrence ClockState) :
    elapsed (.append p step) clock ≠ .emptyOne := by
  intro absent
  have zero := (absenceExactly _ _).mp absent
  rw [successorAddsOne] at zero
  exact Nat.noConfusion zero

theorem transitionCountRetainsOrder {State : Type} {a b : Event State}
    (p : Path a b) : (events p).length = count p + 1 := completeEventCount p

theorem referenceChangeTelescopes {State Old New : Type} {a b : Event State}
    (p : Path a b) (old : Recurrence Old) (next : Recurrence New) (h : 0 < count p) :
    (compose (positiveRatio p old h)
      (ratio (count old.path) (count next.path) old.hasTransition next.hasTransition)).numerator * count next.path =
    count p * (compose (positiveRatio p old h)
      (ratio (count old.path) (count next.path) old.hasTransition next.hasTransition)).denominator :=
  telescopeNormalized _ _ _ h old.hasTransition next.hasTransition
end SFT.Physics.MechanicalDuration
