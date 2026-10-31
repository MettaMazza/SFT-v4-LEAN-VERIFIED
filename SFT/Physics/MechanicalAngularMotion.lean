import SFT.Physics.MechanicalPower
namespace SFT.Physics.MechanicalAngularMotion
open MechanicalEvents MechanicalDuration SFT.Mathematics.FoldScalar

-- mechanics_laws.py ANGULAR_MOTION: an ordered recurrence and its held traversal.
def join {State : Type} {a b c : Event State} (p : Path a b) : Path b c → Path a c
  | .one _ => p
  | .append prior step => .append (join p prior) step

theorem appendNil {A : Type} (xs : List A) : xs ++ [] = xs := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons x) ih

theorem appendAssociative {A : Type} (xs ys zs : List A) : (xs ++ ys) ++ zs = xs ++ (ys ++ zs) := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons x) ih

theorem appendLength {A : Type} (xs ys : List A) : (xs ++ ys).length = xs.length + ys.length := by
  induction xs with
  | nil => exact (Nat.zero_add _).symm
  | cons x xs ih =>
    change (xs ++ ys).length + 1 = (xs.length + 1) + ys.length
    rw [ih,Nat.add_right_comm]

theorem joinChanges {State : Type} {a b c : Event State} (p : Path a b) (q : Path b c) :
    changes (join p q) = changes p ++ changes q := by
  induction q with
  | one => exact (appendNil _).symm
  | append prior step ih =>
    change changes (join p prior) ++ [row step] = changes p ++ (changes prior ++ [row step])
    rw [ih,appendAssociative]

theorem joinCount {State : Type} {a b c : Event State} (p : Path a b) (q : Path b c) :
    count (join p q) = count p + count q := by
  unfold count
  rw [joinChanges,appendLength]

structure Cycle (State : Type) where
  recurrence : Recurrence State
  held : MechanicalLocation.Held

structure Position {State : Type} (cycle : Cycle State) where
  event : Event State
  initialPath : Path cycle.recurrence.first event
  remainingPath : Path event cycle.recurrence.last
  complete : join initialPath remainingPath = cycle.recurrence.path

def start {State : Type} (c : Cycle State) : Position c :=
  ⟨c.recurrence.first,.one _,c.recurrence.path,by
    have identity {a b : Event State} (p : Path a b) : join (.one a) p = p := by
      induction p with
      | one => rfl
      | append prior step ih => exact congrArg (fun p => Path.append p step) ih
    exact identity _⟩

def terminal {State : Type} (c : Cycle State) : Position c :=
  ⟨c.recurrence.last,c.recurrence.path,.one _,rfl⟩

def phase {State : Type} {c : Cycle State} (p : Position c) : Scalar :=
  if h : count p.initialPath = 0 then .emptyOne
  else .positive (MechanicalAcceleration.scalarOrientation c.held)
    (positiveRatio p.initialPath c.recurrence (Nat.pos_of_ne_zero h))

theorem wholeTrace {State : Type} {c : Cycle State} (p : Position c) :
    changes p.initialPath ++ changes p.remainingPath = changes c.recurrence.path :=
  (joinChanges p.initialPath p.remainingPath).symm.trans (congrArg changes p.complete)

theorem completeCount {State : Type} {c : Cycle State} (p : Position c) :
    count p.initialPath + count p.remainingPath = count c.recurrence.path :=
  (joinCount p.initialPath p.remainingPath).symm.trans (congrArg count p.complete)

theorem positionWithinRecurrence {State : Type} {c : Cycle State} (p : Position c) :
    count p.initialPath ≤ count c.recurrence.path := by
  rw [← completeCount p]
  exact Nat.le_add_right _ _

theorem initialPhaseIsEmpty {State : Type} (c : Cycle State) : phase (start c) = .emptyOne := by
  unfold phase
  exact dite_eq_left (show count (start c).initialPath = 0 from rfl)

theorem positivePhase {State : Type} {c : Cycle State} (p : Position c)
    (h : 0 < count p.initialPath) :
    phase p = .positive (MechanicalAcceleration.scalarOrientation c.held)
      (positiveRatio p.initialPath c.recurrence h) := by
  unfold phase
  rw [dite_eq_right (Nat.ne_of_gt h)]

theorem exactPhaseRatio {State : Type} {c : Cycle State} (p : Position c)
    (h : 0 < count p.initialPath) :
    count p.initialPath * (positiveRatio p.initialPath c.recurrence h).denominator =
      (positiveRatio p.initialPath c.recurrence h).numerator * count c.recurrence.path :=
  exactRecurrenceRatio _ _ _

theorem phaseIsPart {State : Type} {c : Cycle State} (p : Position c)
    (h : 0 < count p.initialPath) :
    (positiveRatio p.initialPath c.recurrence h).numerator ≤
      (positiveRatio p.initialPath c.recurrence h).denominator :=
  SFT.Foundation.ExactOperations.normalizedThroughOne _ _ h c.recurrence.hasTransition
    (positionWithinRecurrence p)

theorem terminalIsWholeRecurrence {State : Type} (c : Cycle State) :
    (positiveRatio (terminal c).initialPath c.recurrence c.recurrence.hasTransition).numerator = 1 ∧
    (positiveRatio (terminal c).initialPath c.recurrence c.recurrence.hasTransition).denominator = 1 :=
  referenceRecurrenceIsOne c.recurrence

theorem closedCarrierIdentity {State : Type} (c : Cycle State) :
    (terminal c).event.carrier = (start c).event.carrier := c.recurrence.returnsToCarrier

-- Both positions and the connecting interval are parts of this same ordered trace.
structure Motion (State Clock : Type) where
  cycle : Cycle State
  before : Position cycle
  after : Position cycle
  interval : Path before.event after.event
  intervalMatches : join before.initialPath interval = after.initialPath
  clock : Recurrence Clock
  present : 0 < count interval

def duration {State Clock : Type} (m : Motion State Clock) := positiveRatio m.interval m.clock m.present

def phaseChange {State Clock : Type} (m : Motion State Clock) := subtract (phase m.after) (phase m.before)

def velocity {State Clock : Type} (m : Motion State Clock) := dividePositive (phaseChange m) (duration m)

theorem intervalRetainsOrderedTrace {State Clock : Type} (m : Motion State Clock) :
    changes m.before.initialPath ++ changes m.interval = changes m.after.initialPath :=
  (joinChanges _ _).symm.trans (congrArg changes m.intervalMatches)

theorem intervalPositionCount {State Clock : Type} (m : Motion State Clock) :
    count m.before.initialPath + count m.interval = count m.after.initialPath :=
  (joinCount _ _).symm.trans (congrArg count m.intervalMatches)

theorem exactAngularVelocity {State Clock : Type} (m : Motion State Clock) :
    velocity m = dividePositive (subtract (phase m.after) (phase m.before))
      (positiveRatio m.interval m.clock m.present) := rfl

theorem durationExact {State Clock : Type} (m : Motion State Clock) :
    count m.interval * (duration m).denominator = (duration m).numerator * count m.clock.path :=
  exactRecurrenceRatio _ _ _

theorem positiveVelocityExact {State Clock : Type} (m : Motion State Clock)
    (o : Orientation) (q : SFT.Foundation.ExactOperations.PositiveFraction)
    (h : phaseChange m = .positive o q) :
    velocity m = .positive o (quotientMagnitude q (duration m)) ∧
    (q.numerator * (duration m).denominator) * (quotientMagnitude q (duration m)).denominator =
      (quotientMagnitude q (duration m)).numerator * (q.denominator * (duration m).numerator) := by
  constructor
  · unfold velocity
    rw [h]
    rfl
  · exact quotientExact _ _

theorem changedPhaseCarrierDistinguished {State : Type} {c : Cycle State} (p q : Position c)
    (h : p.event ≠ q.event) : p ≠ q := fun equal => h (congrArg Position.event equal)

end SFT.Physics.MechanicalAngularMotion
