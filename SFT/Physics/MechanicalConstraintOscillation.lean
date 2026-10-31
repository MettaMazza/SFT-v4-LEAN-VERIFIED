import SFT.Physics.MechanicalConservation
namespace SFT.Physics.MechanicalConstraintOscillation
open MechanicalEvents MechanicalDuration

-- A source-bound reversal carries its complete observed displacement record.
structure RestoringStep (Support : Type) where
  before : Event (MechanicalLocation.Displacement Support)
  after : Event (MechanicalLocation.Displacement Support)
  transfer : Change before after
  restores : after.carrier = MechanicalLocation.reverse before.carrier

theorem reversalRetainsMagnitude {Support : Type} (s : RestoringStep Support) :
    s.after.carrier.separation = s.before.carrier.separation := by
  rw [s.restores]
  exact MechanicalLocation.reversePreservesMagnitude _

theorem reversalHoldsOpposite {Support : Type} (s : RestoringStep Support) :
    s.after.carrier.held = MechanicalLocation.opposite s.before.carrier.held := by rw [s.restores]; rfl

structure Oscillation (Support : Type) where
  first : Event (MechanicalLocation.Displacement Support)
  middle : Event (MechanicalLocation.Displacement Support)
  last : Event (MechanicalLocation.Displacement Support)
  outward : Change first middle
  returning : Change middle last
  firstReversal : middle.carrier = MechanicalLocation.reverse first.carrier
  secondReversal : last.carrier = MechanicalLocation.reverse middle.carrier

def path {Support : Type} (o : Oscillation Support) : Path o.first o.last :=
  .append (.append (.one _) o.outward) o.returning

theorem oneReversalCannotReturn {Support : Type} (d : MechanicalLocation.Displacement Support) :
    MechanicalLocation.reverse d ≠ d := by
  intro same
  have orientation := congrArg MechanicalLocation.Displacement.held same
  change MechanicalLocation.opposite d.held = d.held at orientation
  cases h : d.held <;> rw [h] at orientation <;> cases orientation

theorem intermediateCarrierDistinct {Support : Type} (o : Oscillation Support) :
    o.middle.carrier ≠ o.first.carrier := by
  rw [o.firstReversal]
  exact oneReversalCannotReturn _

theorem forcedCarrierReturn {Support : Type} (o : Oscillation Support) : o.last.carrier = o.first.carrier := by
  rw [o.secondReversal,o.firstReversal,MechanicalLocation.reverseTwice]

theorem exactTransitionCount {Support : Type} (o : Oscillation Support) : count (path o) = 2 := rfl

def recurrence {Support : Type} (o : Oscillation Support) : Recurrence (MechanicalLocation.Displacement Support) :=
  ⟨o.first,o.last,path o,forcedCarrierReturn o,by rw [exactTransitionCount]; exact Nat.zero_lt_succ 1⟩

def cycle {Support : Type} (o : Oscillation Support) : MechanicalAngularMotion.Cycle (MechanicalLocation.Displacement Support) :=
  ⟨recurrence o,o.first.carrier.held⟩

def period {Support Clock : Type} (o : Oscillation Support) (clock : Recurrence Clock) :=
  positiveRatio (path o) clock (recurrence o).hasTransition

theorem periodExact {Support Clock : Type} (o : Oscillation Support) (clock : Recurrence Clock) :
    2 * (period o clock).denominator = (period o clock).numerator * count clock.path :=
  exactRecurrenceRatio (path o) clock (recurrence o).hasTransition

theorem fullObservationTrace {Support : Type} (o : Oscillation Support) :
    events (path o) = [o.first,o.middle,o.last] := rfl

theorem fullTransferTrace {Support : Type} (o : Oscillation Support) :
    sourceRecords (path o) = [(o.outward.sourceIdentity,o.outward.actionRecord),
      (o.returning.sourceIdentity,o.returning.actionRecord)] := rfl

theorem retainedSeparation {Support : Type} (o : Oscillation Support) :
    o.last.carrier.separation = o.first.carrier.separation := congrArg MechanicalLocation.Displacement.separation (forcedCarrierReturn o)

theorem retainedReferences {Support : Type} (o : Oscillation Support) :
    o.last.carrier.first = o.first.carrier.first ∧ o.last.carrier.second = o.first.carrier.second :=
  ⟨congrArg MechanicalLocation.Displacement.first (forcedCarrierReturn o),
   congrArg MechanicalLocation.Displacement.second (forcedCarrierReturn o)⟩

theorem noUnobservedCarrierReturn {Support : Type} (o : Oscillation Support)
    (claimed : MechanicalLocation.Displacement Support) (h : claimed = o.last.carrier) :
    claimed = o.first.carrier := h.trans (forcedCarrierReturn o)

theorem phaseUsesRetainedRecurrence {Support : Type} (o : Oscillation Support)
    (p : MechanicalAngularMotion.Position (cycle o)) (h : 0 < count p.initialPath) :
    count p.initialPath * (positiveRatio p.initialPath (recurrence o) h).denominator =
      (positiveRatio p.initialPath (recurrence o) h).numerator * 2 :=
  MechanicalAngularMotion.exactPhaseRatio p h

-- Arbitrarily long finite restoring paths retain each source-bound step.
inductive RestoringPath {Support : Type} : Event (MechanicalLocation.Displacement Support) →
    Event (MechanicalLocation.Displacement Support) → Type where
  | one (a : Event (MechanicalLocation.Displacement Support)) : RestoringPath a a
  | append {a b c : Event (MechanicalLocation.Displacement Support)} : RestoringPath a b → Change b c →
      c.carrier = MechanicalLocation.reverse b.carrier → RestoringPath a c

def trace {Support : Type} {a b : Event (MechanicalLocation.Displacement Support)} :
    RestoringPath a b → Path a b
  | .one _ => .one _
  | .append prior step _ => .append (trace prior) step

def repeatedReversal {Support : Type} : Nat → MechanicalLocation.Displacement Support → MechanicalLocation.Displacement Support
  | 0, d => d
  | n+1, d => MechanicalLocation.reverse (repeatedReversal n d)

theorem fullCarrierEvolution {Support : Type} {a b : Event (MechanicalLocation.Displacement Support)}
    (p : RestoringPath a b) : b.carrier = repeatedReversal (count (trace p)) a.carrier := by
  induction p with
  | one => rfl
  | append prior step reversal ih =>
    change _ = repeatedReversal (count (.append (trace prior) step)) _
    rw [successorAddsOne]
    exact reversal.trans (congrArg MechanicalLocation.reverse ih)

theorem everyEvenReversalReturns {Support : Type} (n : Nat) (d : MechanicalLocation.Displacement Support) :
    repeatedReversal (2*n) d = d := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [Nat.mul_succ]
    change MechanicalLocation.reverse (MechanicalLocation.reverse (repeatedReversal (2*n) d)) = d
    rw [MechanicalLocation.reverseTwice,ih]

theorem finiteClosedRestoration {Support : Type} {a b : Event (MechanicalLocation.Displacement Support)}
    (p : RestoringPath a b) (n : Nat) (even : count (trace p) = 2*n) : b.carrier = a.carrier := by
  rw [fullCarrierEvolution p,even,everyEvenReversalReturns]

def generatedRecurrence {Support : Type} {a b : Event (MechanicalLocation.Displacement Support)}
    (p : RestoringPath a b) (n : Nat) (even : count (trace p) = 2*n)
    (present : 0 < count (trace p)) : Recurrence (MechanicalLocation.Displacement Support) :=
  ⟨a,b,trace p,finiteClosedRestoration p n even,present⟩

theorem arbitraryPeriodExact {Support Clock : Type} {a b : Event (MechanicalLocation.Displacement Support)}
    (p : RestoringPath a b) (clock : Recurrence Clock) (present : 0 < count (trace p)) :
    count (trace p) * (positiveRatio (trace p) clock present).denominator =
      (positiveRatio (trace p) clock present).numerator * count clock.path :=
  exactRecurrenceRatio _ _ _

end SFT.Physics.MechanicalConstraintOscillation
