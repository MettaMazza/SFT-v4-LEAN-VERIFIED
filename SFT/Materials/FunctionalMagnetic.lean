import SFT.Materials.MaterialInterface
import SFT.Materials.AlignedMoments
import SFT.Physics.FieldMagnetic
namespace SFT.Materials.FunctionalMagnetic
open SFT.Physics SFT.Mathematics.FoldScalar

-- Original FUNC-MAGNETIC retains every local moment and domain label; an
-- absent applied-field record is structural absence, not an invented scalar.
structure State (S T CS : Type) where
 domains : MaterialInterface.Carrier
 moment : String → Scalar
 appliedField : Option (FieldMagnetic.Response S T CS)

variable {S T CS : Type}

def momentRows (s : State S T CS) := s.domains.lattice.cells.graph.nodes.map (fun cell => (cell,s.moment cell))
def net (s : State S T CS) := AlignedMoments.accumulate .emptyOne ((momentRows s).map Prod.snd)
def walls (s : State S T CS) := MaterialInterface.boundary s.domains

theorem everyCellRetained (s : State S T CS) :
 (momentRows s).map Prod.fst = s.domains.lattice.cells.graph.nodes := by
 unfold momentRows
 generalize s.domains.lattice.cells.graph.nodes = nodes
 induction nodes with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons h) ih

theorem wallExactly (s : State S T CS) (edge : String × String) :
 edge ∈ walls s ↔ edge ∈ s.domains.lattice.cells.graph.edges ∧ s.domains.material edge.1 ≠ s.domains.material edge.2 :=
 MaterialInterface.boundaryExactly _ _

structure Record (S T CS : Type) where
 first : MechanicalEvents.Event (State S T CS)
 last : MechanicalEvents.Event (State S T CS)
 path : MechanicalEvents.Path first last
 losses : MechanicalConservation.Network String Scalar
 lossBound : ∀ loss, loss ∈ losses → ∃ step ∈ MechanicalEvents.changes path,
  loss.sourceIdentity = step.sourceIdentity ∧ loss.actionRecord = step.actionRecord
 frequencyTemperature : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

def stateRecord (s : State S T CS) := (s,s.appliedField,momentRows s,walls s,net s)
def history (r : Record S T CS) := (MechanicalEvents.events r.path).map (fun e => (e,stateRecord e.carrier))
def residual (r : Record S T CS) := (r.last.carrier.appliedField,net r.last.carrier)

theorem completeHistoryCount (r : Record S T CS) :
 (history r).length = MechanicalEvents.count r.path+1 :=
 (SFT.Foundation.CommonRefinement.mapLength _ _).trans (MechanicalEvents.completeEventCount _)

theorem completeHistoryEvents (r : Record S T CS) :
 (history r).map Prod.fst = MechanicalEvents.events r.path := by
 unfold history
 generalize MechanicalEvents.events r.path = events
 induction events with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons h) ih

theorem eachHistoryField (r : Record S T CS) (e : MechanicalEvents.Event (State S T CS))
 (held : e ∈ MechanicalEvents.events r.path) :
 (e,stateRecord e.carrier) ∈ history r := SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem allTransitionSources (r : Record S T CS) :
 (MechanicalEvents.changes r.path).map (fun step => (step.sourceIdentity,step.actionRecord)) = MechanicalEvents.sourceRecords r.path :=
 MechanicalEvents.allSourceRecordsRetained _

theorem lossConserved (r : Record S T CS) :
 MechanicalConservation.outgoingSupport r.losses = MechanicalConservation.incomingSupport r.losses :=
 MechanicalConservation.completeConservation _

theorem everyLossHasActualTransition (r : Record S T CS) (loss : MechanicalConservation.Transfer String Scalar)
 (held : loss ∈ r.losses) : ∃ step ∈ MechanicalEvents.changes r.path,
 loss.sourceIdentity = step.sourceIdentity ∧ loss.actionRecord = step.actionRecord := r.lossBound loss held

theorem fieldAbsentResidual (r : Record S T CS) (absent : r.last.carrier.appliedField = none) :
 residual r = (none,net r.last.carrier) := by unfold residual; rw [absent]

theorem retainedRemanentOrientation (r : Record S T CS) (o : Orientation)
 (x : SFT.Foundation.ExactOperations.PositiveFraction)
 (held : net r.last.carrier = .positive o x) : (residual r).2 = .positive o x := held

theorem actualAppliedFieldOrientation (field : FieldMagnetic.Response S T CS) :
 FieldMagnetic.held field = FieldMagnetic.orientation field.transport := rfl

def record (r : Record S T CS) := (r,history r,MechanicalEvents.changes r.path,r.losses,residual r)

theorem completeInputRetained (r : Record S T CS) : (record r).1 = r := rfl

def records (rs : List (Record S T CS)) := rs.map record

theorem base (r : Record S T CS) : records [r] = [record r] := rfl

theorem successor (rs : List (Record S T CS)) (r : Record S T CS) :
 records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.FunctionalMagnetic
