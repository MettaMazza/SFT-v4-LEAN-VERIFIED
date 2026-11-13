import SFT.Physics.SuperconductivityJointHistory
import SFT.Physics.FieldInduction
namespace SFT.Materials.MeissnerBoundary
open SFT.Physics SFT.QuantumComputation.ReversibleModel

-- Original SC-MEISSNER retains the actual charged boundary response and
-- its declared penetration region, on the complete phase-locked carrier.
structure Boundary where
 carrier : SuperconductivityJointHistory.SuperconductingCarrier
 first : SuperconductivityJointHistory.Row
 last : SuperconductivityJointHistory.Row
 history : SuperconductivityJointHistory.History carrier.transport first last
 result : State
 executed : SuperconductivityRecurrenceProofs.runRecurrences
   carrier.transport.boundary.preparation.state
   (SuperconductivityJointHistory.paths history) = .ok result
 penetration : List String
 magneticReading : String → State → SFT.Host.Canonical.Value
 current : String → FieldInduction.BoundaryWork String String String String String
 responseBound : ∀ cell, cell ∈ carrier.transport.boundary.lattice.cells.graph.nodes →
   (current cell).linked.after.observation = magneticReading cell result


def bulk (b : Boundary) :=
 b.carrier.transport.boundary.lattice.cells.graph.nodes.filter
  (fun cell => !SFT.Mathematics.DiscreteObjects.has b.penetration cell)

theorem bulkExactly (b : Boundary) (cell : String) :
 cell ∈ bulk b ↔ cell ∈ b.carrier.transport.boundary.lattice.cells.graph.nodes ∧
 cell ∉ b.penetration := by
 constructor
 · intro held
   have h := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp held
   refine ⟨h.1,?_⟩
   intro inside
   have yes := (SFT.Mathematics.DiscreteObjects.hasIff _ _).mpr inside
   rw [yes] at h
   cases h.2
 · intro ⟨held,outside⟩
   apply (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr
   refine ⟨held,?_⟩
   cases test : SFT.Mathematics.DiscreteObjects.has b.penetration cell with
   | false => rfl
   | true => exact False.elim (outside ((SFT.Mathematics.DiscreteObjects.hasIff _ _).mp test))

theorem completeBulkRecurrence (b : Boundary) :
 b.result = b.carrier.transport.boundary.preparation.state :=
 Except.ok.inj (b.executed.symm.trans
  (SuperconductivityJointHistory.sameHistoryReturnsPhase b.history))

theorem bulkMagneticReadingRetained (b : Boundary) (cell : String)
 (held : cell ∈ bulk b) :
 (b.current cell).linked.after.observation =
 b.magneticReading cell b.carrier.transport.boundary.preparation.state :=
 (b.responseBound cell ((bulkExactly b cell).mp held).1).trans
  (congrArg (b.magneticReading cell) (completeBulkRecurrence b))

theorem incompatibleAppliedDistinctionClosed (b : Boundary) (cell : String)
 (held : cell ∈ bulk b)
 (incompatible : (b.current cell).linked.before.observation ≠
   b.magneticReading cell b.carrier.transport.boundary.preparation.state) :
 (b.current cell).linked.after.observation ≠ (b.current cell).linked.before.observation := by
 intro same
 exact incompatible (same.symm.trans (bulkMagneticReadingRetained b cell held))

theorem penetrationExcludedFromBulk (b : Boundary) (cell : String)
 (inside : cell ∈ b.penetration) : cell ∉ bulk b :=
 fun held => ((bulkExactly b cell).mp held).2 inside

theorem completeBoundaryResponse (b : Boundary) (cell : String) :
 FieldInduction.boundaryTrace (b.current cell) =
 MechanicalEvents.changes (b.current cell).boundary.recurrence.path :=
 FieldInduction.completeBoundary _

theorem boundarySourceRetained (b : Boundary) (cell : String) :
 (FieldInduction.cyclicTransfers (b.current cell)).map (fun row => row.1) =
 (MechanicalEvents.changes (b.current cell).boundary.recurrence.path).map
  (fun _ => (b.current cell).linked) := FieldInduction.sourceChangeRetained _

def records (history : List Boundary) := history.map (fun b => (b,bulk b))

theorem base (b : Boundary) : records [b] = [(b,bulk b)] := rfl

theorem successor (history : List Boundary) (next : Boundary) :
 records (history ++ [next]) = records history ++ [(next,bulk next)] := by
 induction history with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (head,bulk head)) ih

end SFT.Materials.MeissnerBoundary
