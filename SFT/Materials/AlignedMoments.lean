import SFT.Physics.CollectivePhaseOrder
namespace SFT.Materials.AlignedMoments
open SFT.Physics SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations

structure Record where
 region : CollectivePhaseOrder.OrderedRegion
 held : Orientation
 classHeld : region.macrostate.label = orientationName held
 magnitude : String → PositiveFraction
 recurrence : MechanicalDuration.Recurrence (List (String × Orientation))
 recurrenceStarts : recurrence.first.carrier = region.macrostate.members.map (fun cell => (cell,held))
 sourceRecords : SFT.Host.Canonical.Value
 orderingConditions : SFT.Host.Canonical.Value

def moments (r : Record) := r.region.macrostate.members.map fun cell =>
 (cell,Scalar.positive r.held (r.magnitude cell))

def accumulate (initial : Scalar) : List Scalar → Scalar
 | [] => initial
 | x::xs => accumulate (add initial x) xs

def magnitudeSum (initial : PositiveFraction) : List PositiveFraction → PositiveFraction
 | [] => initial
 | x::xs => magnitudeSum (sumMagnitude initial x) xs

theorem alignedSum (o : Orientation) (initial : PositiveFraction) (xs : List PositiveFraction) :
 accumulate (.positive o initial) (xs.map (Scalar.positive o)) = .positive o (magnitudeSum initial xs) := by
 induction xs generalizing initial with
 | nil => rfl
 | cons x xs ih =>
   change accumulate (add (.positive o initial) (.positive o x)) _ = _
   rw [equalOrientationsAdd]
   exact ih (sumMagnitude initial x)

def net (r : Record) := accumulate .emptyOne ((moments r).map Prod.snd)

theorem completeMomentRows (r : Record) : (moments r).map Prod.fst = r.region.macrostate.members := by
 unfold moments
 generalize r.region.macrostate.members = cells
 induction cells with
 | nil => rfl
 | cons c cs ih => exact congrArg (List.cons c) ih

theorem positiveNet (r : Record) (first : String) (rest : List String)
 (cells : r.region.macrostate.members = first::rest) :
 net r = .positive r.held (magnitudeSum (r.magnitude first) (rest.map r.magnitude)) := by
 unfold net moments
 rw [cells]
 change accumulate (.positive r.held (r.magnitude first))
   ((rest.map (fun cell => (cell,Scalar.positive r.held (r.magnitude cell)))).map Prod.snd) = _
 have mapped : ((rest.map (fun cell => (cell,Scalar.positive r.held (r.magnitude cell)))).map Prod.snd) =
   (rest.map r.magnitude).map (Scalar.positive r.held) := by
   clear cells
   induction rest with
   | nil => rfl
   | cons c cs ih => exact congrArg (List.cons (Scalar.positive r.held (r.magnitude c))) ih
 rw [mapped]
 exact alignedSum _ _ _

theorem netNotEmpty (r : Record) (first : String) (rest : List String)
 (cells : r.region.macrostate.members = first::rest) : net r ≠ .emptyOne := by
 rw [positiveNet r first rest cells]
 intro h; cases h

theorem netHasHeldOrientation (r : Record) : ∃ x : PositiveFraction, net r = .positive r.held x := by
 have present := SFT.InformationScience.EntropyLedger.membersPositive _ _ _ r.region.macrostate.computed _ r.region.macrostate.present
 cases cells : r.region.macrostate.members with
 | nil =>
   change 0 < r.region.macrostate.members.length at present
   rw [cells] at present
   exact False.elim (Nat.not_lt_zero _ present)
 | cons first rest => exact ⟨_,positiveNet r first rest cells⟩

theorem everyLocalOrientation (r : Record) (cell : String) (held : cell ∈ r.region.macrostate.members) :
 SFT.Mathematics.GeometryTopology.image r.region.cells.observation cell = some (orientationName r.held) := by
 have h := CollectivePhaseOrder.everyMemberSharesLabel r.region cell held
 rw [r.classHeld] at h
 exact h

theorem connectedRegion (r : Record) (a b : String)
 (ha : a ∈ r.region.macrostate.members) (hb : b ∈ r.region.macrostate.members) :
 SFT.Mathematics.GraphOperations.PathWitness (CollectivePhaseOrder.inducedGraph r.region.cells r.region.macrostate.members) a b :=
 CollectivePhaseOrder.exactConnectedSupport r.region a b ha hb

theorem recurrentOrientationClass (r : Record) :
 r.recurrence.last.carrier = r.region.macrostate.members.map (fun cell => (cell,r.held)) :=
 r.recurrence.returnsToCarrier.trans r.recurrenceStarts

def record (r : Record) := (r,moments r,net r)

theorem completeInputRetained (r : Record) : (record r).1 = r := rfl

def records (rs : List Record) := rs.map record

theorem base (r : Record) : records [r] = [record r] := rfl

theorem successor (rs : List Record) (r : Record) : records (rs ++ [r]) = records rs ++ [record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.AlignedMoments
