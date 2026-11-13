import SFT.Materials.MaterialInterface
namespace SFT.Materials.BiomaterialInterface
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects SFT.Physics.MechanicalConservation
open SFT.Host.Canonical

-- FUNC-BIOMATERIAL: the original joint interface, its two directed ledgers,
-- and declared exposure/function records. Outcomes enter after the relation.
structure Record (Content Response : Type) where
 carrier : MaterialInterface.Carrier
 data : Edge → MaterialInterface.Payload Content Response
 transferBound : ∀ e, e ∈ MaterialInterface.boundary carrier → ∀ t, t ∈ (data e).content → MaterialInterface.onBoundary e t
 responseBound : ∀ e, e ∈ MaterialInterface.boundary carrier → ∀ t, t ∈ (data e).traction → MaterialInterface.onBoundary e t
 exposure : Value
 functionBoundary : Value
 biologicalOutcome : Value

variable {Content Response : Type}

def relation (r : Record Content Response) := MaterialInterface.assemble r.carrier r.data

theorem exactInterface (r : Record Content Response) :
 (relation r).map MaterialInterface.Row.edge = MaterialInterface.boundary r.carrier :=
 MaterialInterface.completeBoundaryProjection _ _

theorem identitiesRetained (r : Record Content Response) (row : MaterialInterface.Row Content Response)
 (h : row ∈ relation r) : row.firstMaterial ≠ row.secondMaterial :=
 MaterialInterface.distinctCarriersRetained _ _ _ h

theorem completeCompatibility (r : Record Content Response) (row : MaterialInterface.Row Content Response)
 (h : row ∈ relation r) : MaterialInterface.compatible r.carrier row :=
 MaterialInterface.assembledCompatibility _ _ r.transferBound r.responseBound _ h

theorem everyInterfaceRetained (r : Record Content Response) (e : Edge)
 (h : e ∈ MaterialInterface.boundary r.carrier) : MaterialInterface.row r.carrier r.data e ∈ relation r :=
 MaterialInterface.everyBoundaryRecorded _ _ _ h

theorem transferEitherDirection (r : Record Content Response) (e : Edge)
 (h : e ∈ MaterialInterface.boundary r.carrier) (t : Transfer String Content)
 (held : t ∈ (r.data e).content) :
 (t.source=e.1 ∧ t.destination=e.2) ∨ (t.source=e.2 ∧ t.destination=e.1) :=
 r.transferBound e h t held

theorem responseEitherDirection (r : Record Content Response) (e : Edge)
 (h : e ∈ MaterialInterface.boundary r.carrier) (t : Transfer String Response)
 (held : t ∈ (r.data e).traction) :
 (t.source=e.1 ∧ t.destination=e.2) ∨ (t.source=e.2 ∧ t.destination=e.1) :=
 r.responseBound e h t held

theorem transferSupportHeld (r : Record Content Response) (e : Edge)
 (h : e ∈ MaterialInterface.boundary r.carrier) (t : Transfer String Content)
 (held : t ∈ (r.data e).content) :
 t.source ∈ r.carrier.lattice.cells.graph.nodes ∧ t.destination ∈ r.carrier.lattice.cells.graph.nodes :=
 MaterialInterface.transferEndpointsHeld _ _ h t (r.transferBound e h t held)

theorem completeTransferBalance (r : Record Content Response) :
 outgoingSupport (MaterialInterface.allContent (relation r)) = incomingSupport (MaterialInterface.allContent (relation r)) :=
 MaterialInterface.completeContentBalance _ _

theorem completeResponseBalance (r : Record Content Response) :
 outgoingSupport (MaterialInterface.allTraction (relation r)) = incomingSupport (MaterialInterface.allTraction (relation r)) :=
 MaterialInterface.completeTractionBalance _ _

def observeOutcome (r : Record Content Response) (outcome : Value) : Record Content Response :=
 {r with biologicalOutcome := outcome}

theorem outcomeCannotSelectRelation (r : Record Content Response) (a b : Value) :
 relation (observeOutcome r a) = relation (observeOutcome r b) := rfl

def record (r : Record Content Response) := (r,relation r,r.exposure,r.functionBoundary,r.biologicalOutcome)

theorem fullInputRetained (r : Record Content Response) : (record r).1 = r := rfl

theorem exposureFunctionRetained (r : Record Content Response) :
 (record r).2.2.1 = r.exposure ∧ (record r).2.2.2.1 = r.functionBoundary := ⟨rfl,rfl⟩

theorem outcomeRecorded (r : Record Content Response) : (record r).2.2.2.2 = r.biologicalOutcome := rfl

def records (rs : List (Record Content Response)) := rs.map record

theorem base (r : Record Content Response) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Content Response)) (r : Record Content Response) :
 records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.BiomaterialInterface
