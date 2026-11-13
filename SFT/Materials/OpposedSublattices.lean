import SFT.Materials.AlignedMoments
namespace SFT.Materials.OpposedSublattices
open SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations
abbrev Moment := String × PositiveFraction

def total (first : Moment) (rest : List Moment) :=
 AlignedMoments.magnitudeSum first.2 (rest.map Prod.snd)

structure Record where
 graph : SFT.Mathematics.GraphOperations.GeneratedGraph
 generated : SFT.Mathematics.GraphOperations.makeGraph graph.nodes graph.edges = .ok graph
 firstLeft : Moment
 restLeft : List Moment
 firstRight : Moment
 restRight : List Moment
 held : Orientation
 fullSupport : graph.nodes = ((firstLeft::restLeft).map Prod.fst) ++ ((firstRight::restRight).map Prod.fst)
 disjoint : ∀ x, x ∈ (firstLeft::restLeft).map Prod.fst → x ∈ (firstRight::restRight).map Prod.fst → False
 crosses : ∀ e, e ∈ graph.edges →
   (e.1 ∈ (firstLeft::restLeft).map Prod.fst ∧ e.2 ∈ (firstRight::restRight).map Prod.fst) ∨
   (e.1 ∈ (firstRight::restRight).map Prod.fst ∧ e.2 ∈ (firstLeft::restLeft).map Prod.fst)
 recurrence : SFT.Physics.MechanicalDuration.Recurrence (List (String × Orientation))
 recurrenceStarts : recurrence.first.carrier =
   ((firstLeft::restLeft).map (fun m => (m.1,held))) ++
   ((firstRight::restRight).map (fun m => (m.1,opposite held)))
 recurrenceRecords : SFT.Host.Canonical.Value
 orderingConditions : SFT.Host.Canonical.Value

def leftValue (r : Record) := total r.firstLeft r.restLeft
def rightValue (r : Record) := total r.firstRight r.restRight

def net (r : Record) := add (.positive r.held (leftValue r)) (.positive (opposite r.held) (rightValue r))

-- Exact original 'local-order-global-closure' coordinate: compute its
-- necessary and sufficient test from the complete two-sublattice sums.
def closes (r : Record) := leftCross (leftValue r) (rightValue r) = rightCross (leftValue r) (rightValue r)

theorem closureExactly (r : Record) : net r = .emptyOne ↔ closes r := by
 unfold net closes
 cases h : r.held with
 | forward => exact opposedEmptyIff .forward .counter _ _
 | counter => exact opposedEmptyIff .counter .forward _ _

theorem completeLeftSum (r : Record) :
 AlignedMoments.accumulate (.positive r.held r.firstLeft.2)
 ((r.restLeft.map Prod.snd).map (Scalar.positive r.held)) = .positive r.held (leftValue r) :=
 AlignedMoments.alignedSum _ _ _

theorem completeRightSum (r : Record) :
 AlignedMoments.accumulate (.positive (opposite r.held) r.firstRight.2)
 ((r.restRight.map Prod.snd).map (Scalar.positive (opposite r.held))) =
 .positive (opposite r.held) (rightValue r) := AlignedMoments.alignedSum _ _ _

theorem localOrientationsDistinct (r : Record) : r.held ≠ opposite r.held := by
 cases r.held <;> intro h <;> cases h

theorem leftOrderPresent (r : Record) : (.positive r.held (leftValue r) : Scalar) ≠ .emptyOne := by
 intro h; cases h

theorem rightOrderPresent (r : Record) : (.positive (opposite r.held) (rightValue r) : Scalar) ≠ .emptyOne := by
 intro h; cases h

theorem recurrentOpposedOrder (r : Record) :
 r.recurrence.last.carrier = ((r.firstLeft::r.restLeft).map (fun m => (m.1,r.held))) ++
   ((r.firstRight::r.restRight).map (fun m => (m.1,opposite r.held))) :=
 r.recurrence.returnsToCarrier.trans r.recurrenceStarts

def record (r : Record) := (r,Scalar.positive r.held (leftValue r),Scalar.positive (opposite r.held) (rightValue r),net r)

theorem closureRetainsLocalOrders (r : Record) (admitted : closes r) :
 (record r).2.2.2 = .emptyOne ∧ (record r).2.1 ≠ .emptyOne ∧ (record r).2.2.1 ≠ .emptyOne :=
 ⟨(closureExactly r).mpr admitted,leftOrderPresent r,rightOrderPresent r⟩

theorem sublatticesDistinguishable (r : Record) (x : String)
 (left : x ∈ (r.firstLeft::r.restLeft).map Prod.fst) :
 x ∉ (r.firstRight::r.restRight).map Prod.fst := r.disjoint x left

theorem completeInputRetained (r : Record) : (record r).1 = r := rfl

def records (rs : List Record) := rs.map record

theorem base (r : Record) : records [r] = [record r] := rfl

theorem successor (rs : List Record) (r : Record) : records (rs ++ [r]) = records rs ++ [record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.OpposedSublattices
