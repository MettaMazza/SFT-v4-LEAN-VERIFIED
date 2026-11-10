import SFT.Physics.CollectiveDensity
namespace SFT.Physics.CollectivePressure
open SFT.Mathematics.GraphOperations
open SFT.Mathematics.FoldScalar
open SFT.Foundation.ExactOperations

structure BoundaryRecurrence (State : Type) where
 network : CollectiveCoarseGrain.NetworkObservation
 heldRegion : List String
 boundary : List Edge
 computed : crossingCut network.graph heldRegion = .ok boundary
 boundaryPositive : 0 < boundary.length
 recurrence : MechanicalDuration.Recurrence State

def supportRecurrence {State : Type} (b : BoundaryRecurrence State) : PositiveFraction :=
 normalizePositive (b.boundary.length * MechanicalEvents.count b.recurrence.path) 1
 (Nat.mul_pos b.boundaryPositive b.recurrence.hasTransition) (Nat.zero_lt_succ 0)

-- The same oriented momentum carrier is normalized by its generated boundary
-- support and recurrence. The normal component is the source's declared
-- normal observation; closing its held orientation produces pressure.
def stress {State : Type} (b : BoundaryRecurrence State) (momentum : Scalar) : Scalar :=
 multiply momentum (.positive .forward (SFT.Mathematics.ExactRatioRelations.reciprocal (supportRecurrence b)))

inductive ClosedMagnitude where
 | emptyOne
 | positive (magnitude : PositiveFraction)

def closeOrientation : Scalar → ClosedMagnitude
 | .emptyOne => .emptyOne
 | .positive _ magnitude => .positive magnitude

def pressure {State : Type} (b : BoundaryRecurrence State) (normalMomentum : Scalar) :=
 closeOrientation (stress b normalMomentum)

theorem completeBoundary {State : Type} (b : BoundaryRecurrence State) :
 b.boundary = b.network.graph.edges.filter (fun edge =>
 SFT.Mathematics.DiscreteObjects.has b.heldRegion edge.1 != SFT.Mathematics.DiscreteObjects.has b.heldRegion edge.2) :=
 cutResult b.network.graph b.heldRegion b.boundary b.computed

theorem generatedDenominator {State : Type} (b : BoundaryRecurrence State) :
 (b.boundary.length * MechanicalEvents.count b.recurrence.path) * (supportRecurrence b).denominator =
 (supportRecurrence b).numerator * 1 := normalizedValuePreserved _ _ _ _

theorem positiveStress {State : Type} (b : BoundaryRecurrence State) (o : Orientation) (x : PositiveFraction) :
 stress b (.positive o x) = .positive o (quotientMagnitude x (supportRecurrence b)) := by
 cases o <;> rfl

theorem exactStressRatio {State : Type} (b : BoundaryRecurrence State) (x : PositiveFraction) :
 (x.numerator * (supportRecurrence b).denominator) * (quotientMagnitude x (supportRecurrence b)).denominator =
 (quotientMagnitude x (supportRecurrence b)).numerator * (x.denominator * (supportRecurrence b).numerator) :=
 quotientExact x (supportRecurrence b)

theorem absentTransfer {State : Type} (b : BoundaryRecurrence State) :
 stress b .emptyOne = .emptyOne ∧ pressure b .emptyOne = .emptyOne := ⟨rfl,rfl⟩

theorem stressRetainsOrientationReversal {State : Type} (b : BoundaryRecurrence State) (x : Scalar) :
 stress b (reverse x) = reverse (stress b x) := by
 cases x with
 | emptyOne => rfl
 | positive o m => cases o <;> rfl

theorem closureIgnoresOnlyHeldOrientation (x : Scalar) : closeOrientation (reverse x) = closeOrientation x := by
 cases x with
 | emptyOne => rfl
 | positive o m => cases o <;> rfl

theorem pressureOrientationClosed {State : Type} (b : BoundaryRecurrence State) (x : Scalar) :
 pressure b (reverse x) = pressure b x := by
 unfold pressure
 rw [stressRetainsOrientationReversal]
 exact closureIgnoresOnlyHeldOrientation _

theorem pressureRetainsExactMagnitude {State : Type} (b : BoundaryRecurrence State) (o : Orientation) (x : PositiveFraction) :
 pressure b (.positive o x) = .positive (quotientMagnitude x (supportRecurrence b)) := by
 unfold pressure
 rw [positiveStress]
 rfl

theorem closedObservationDetermined {Result : Type} (observe : Scalar → Result)
 (closed : ∀ x, observe (reverse x) = observe x) (o : Orientation) (m : PositiveFraction) :
 observe (.positive o m) = observe (.positive .forward m) := by
 cases o with
 | forward => rfl
 | counter => exact closed (.positive .forward m)

abbrev completeTransferLedger := @MechanicalConservation.completeConservation
abbrev successorRetainsBoundaryCarrierRecords := @MechanicalConservation.appendRetainsPrior
end SFT.Physics.CollectivePressure
