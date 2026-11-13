import SFT.Physics.CollectivePressure
namespace SFT.Materials.StressStrainRecord
open SFT.Physics SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations

structure Record (State : Type) where
 boundary : CollectivePressure.BoundaryRecurrence State
 transferredMomentum : Scalar
 reference : MechanicalLocation.Displacement String
 current : MechanicalLocation.Displacement String
 firstIdentity : current.first.referenceIdentity = reference.first.referenceIdentity
 secondIdentity : current.second.referenceIdentity = reference.second.referenceIdentity
 firstSupport : current.first.support = reference.first.support
 secondSupport : current.second.support = reference.second.support
 direction : current.held = reference.held
 conditions : SFT.Host.Canonical.Value

def stress {State : Type} (r : Record State) :=
 CollectivePressure.stress r.boundary r.transferredMomentum

def change {State : Type} (r : Record State) : Scalar :=
 subtract (.positive .forward r.current.separation) (.positive .forward r.reference.separation)

def strain {State : Type} (r : Record State) : Scalar :=
 dividePositive (change r) r.reference.separation

theorem completeBoundarySupport {State : Type} (r : Record State) :
 r.boundary.boundary = r.boundary.network.graph.edges.filter (fun edge =>
 SFT.Mathematics.DiscreteObjects.has r.boundary.heldRegion edge.1 !=
 SFT.Mathematics.DiscreteObjects.has r.boundary.heldRegion edge.2) :=
 CollectivePressure.completeBoundary r.boundary

theorem stressFromPositiveTransfer {State : Type} (r : Record State)
 (o : Orientation) (m : PositiveFraction) (actual : r.transferredMomentum = .positive o m) :
 stress r = .positive o (quotientMagnitude m (CollectivePressure.supportRecurrence r.boundary)) := by
 unfold stress
 rw [actual]
 exact CollectivePressure.positiveStress r.boundary o m

theorem strainExpansion {State : Type} (r : Record State)
 (grows : rightCross r.current.separation r.reference.separation <
 leftCross r.current.separation r.reference.separation) :
 strain r = .positive .forward
  (quotientMagnitude (leftRemainder r.current.separation r.reference.separation grows) r.reference.separation) := by
 unfold strain change
 change dividePositive (opposed .forward .counter r.current.separation r.reference.separation) _ = _
 rw [opposedLeft _ _ _ _ grows]
 rfl

theorem strainContraction {State : Type} (r : Record State)
 (shrinks : leftCross r.current.separation r.reference.separation <
 rightCross r.current.separation r.reference.separation) :
 strain r = .positive .counter
  (quotientMagnitude (rightRemainder r.current.separation r.reference.separation shrinks) r.reference.separation) := by
 unfold strain change
 change dividePositive (opposed .forward .counter r.current.separation r.reference.separation) _ = _
 rw [opposedRight _ _ _ _ shrinks]
 rfl

theorem unchangedSeparation {State : Type} (r : Record State)
 (same : leftCross r.current.separation r.reference.separation =
 rightCross r.current.separation r.reference.separation) :
 strain r = .emptyOne := by
 unfold strain change
 change dividePositive (opposed .forward .counter r.current.separation r.reference.separation) _ = _
 rw [opposedEqual _ _ _ _ same]
 rfl

theorem normalizedChangeExact {State : Type} (r : Record State) (x : PositiveFraction) :
 (x.numerator * r.reference.separation.denominator) *
 (quotientMagnitude x r.reference.separation).denominator =
 (quotientMagnitude x r.reference.separation).numerator *
 (x.denominator * r.reference.separation.numerator) :=
 quotientExact x r.reference.separation

theorem sameReferencePair {State : Type} (r : Record State) :
 r.current.first.referenceIdentity = r.reference.first.referenceIdentity ∧
 r.current.second.referenceIdentity = r.reference.second.referenceIdentity ∧
 r.current.first.support = r.reference.first.support ∧
 r.current.second.support = r.reference.second.support ∧
 r.current.held = r.reference.held :=
 ⟨r.firstIdentity,r.secondIdentity,r.firstSupport,r.secondSupport,r.direction⟩

def result {State : Type} (r : Record State) := (r,stress r,strain r)

theorem observationConditionsRetained {State : Type} (r : Record State) :
 (result r).1.conditions = r.conditions := rfl

def records {State : Type} (rows : List (Record State)) := rows.map result

theorem base {State : Type} (r : Record State) : records [r] = [result r] := rfl

theorem successor {State : Type} (rows : List (Record State)) (next : Record State) :
 records (rows ++ [next]) = records rows ++ [result next] := by
 induction rows with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (result head)) ih

end SFT.Materials.StressStrainRecord
