import SFT.Materials.MaterialInterface
import SFT.Chemistry.ReactionIdentity
namespace SFT.Materials.Corrosion
open SFT.Chemistry SFT.Foundation.Count.TraceDerivation
open SFT.Physics.MatterConservedLabels SFT.Physics.MechanicalConservation
abbrev Edge := SFT.Mathematics.GraphOperations.Edge

-- MATERIALS_OBLIGATIONS[73]: complete material/environment interface rows.
structure Record where
 carrier : MaterialInterface.Carrier
 reaction : Edge → ReactionIdentity.Reaction
 electrons : Edge → List RedoxTransfer.Transfer
 transport : Edge → Network String ReactionIdentity.HeldLabel
 electronBoundary : ∀ edge ∈ MaterialInterface.boundary carrier,
  ∀ t ∈ electrons edge,
  (t.raw.donor=edge.1 ∧ t.raw.acceptor=edge.2) ∨
  (t.raw.donor=edge.2 ∧ t.raw.acceptor=edge.1)
 transportBoundary : ∀ edge ∈ MaterialInterface.boundary carrier,
  ∀ t ∈ transport edge, MaterialInterface.onBoundary edge t
 environmentTime : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

def row (r : Record) (e : Edge) :=
 (e,r.carrier.material e.1,r.carrier.material e.2,r.reaction e,
 r.electrons e,r.transport e)

def rows (r : Record) := (MaterialInterface.boundary r.carrier).map (row r)

theorem completeInterface (r : Record) : (rows r).map Prod.fst = MaterialInterface.boundary r.carrier := by
 unfold rows
 generalize MaterialInterface.boundary r.carrier = es
 induction es with
 | nil => rfl
 | cons e es ih => exact congrArg (List.cons e) ih

theorem everyInterfaceRow (r : Record) (e : Edge)
 (held : e ∈ MaterialInterface.boundary r.carrier) : row r e ∈ rows r := memMap _ _ _ held

theorem noInventedInterfaceRow (r : Record) (value) (held : value ∈ rows r) :
 ∃ e ∈ MaterialInterface.boundary r.carrier, row r e = value := memMapPreimage _ _ _ held

theorem jointCarriersDistinct (r : Record) (e : Edge)
 (held : e ∈ MaterialInterface.boundary r.carrier) : r.carrier.material e.1 ≠ r.carrier.material e.2 :=
 ((MaterialInterface.boundaryExactly _ _).mp held).2

def placements (r : Record) :=
 (MaterialInterface.boundary r.carrier).flatMap (fun e => (r.reaction e).placements)

def electronRows (r : Record) :=
 (MaterialInterface.boundary r.carrier).flatMap (fun e => (r.electrons e).map (fun t => t.raw))

def allTransport (r : Record) := (MaterialInterface.boundary r.carrier).flatMap r.transport

theorem constituentCountsConserved (r : Record) (test : ReactionIdentity.HeldLabel → Bool) :
 inputCount test (ReactionIdentity.flows (placements r)) = outputCount test (ReactionIdentity.flows (placements r)) :=
 ReactionIdentity.noCarrierLoss _ _

theorem completeProductsRetainCarriers (r : Record) (e : Edge) :
 (destinations (ReactionIdentity.flows (r.reaction e).placements)).map Prod.fst =
 (r.reaction e).trace.raw.conservedCarriers := ReactionIdentity.everyCarrierReachesOutput _

theorem actualReactionChange (r : Record) (e : Edge) :
 ∃ c, c ∈ (r.reaction e).firstChange::(r.reaction e).furtherChanges ∧ c.before ≠ c.after :=
 ReactionIdentity.someRelationActuallyChanges _

theorem electronSequenceRetained (r : Record) :
 (inputs (RedoxTransfer.flows (electronRows r))).map Prod.fst =
 (destinations (RedoxTransfer.flows (electronRows r))).map Prod.fst := RedoxTransfer.fullElectronSequence _

theorem chargeLossGainPaired (r : Record) (test : RedoxTransfer.HeldLabel → Bool) :
 inputCount test (RedoxTransfer.flows (electronRows r)) = outputCount test (RedoxTransfer.flows (electronRows r)) :=
 RedoxTransfer.pairedLossGain _ _

theorem transportContentConserved (r : Record) :
 outgoingSupport (allTransport r) = incomingSupport (allTransport r) := completeConservation _

theorem transportEndpointsHeld (r : Record) (e : Edge)
 (held : e ∈ MaterialInterface.boundary r.carrier) (t : Transfer String ReactionIdentity.HeldLabel)
 (member : t ∈ r.transport e) :
 t.source ∈ r.carrier.lattice.cells.graph.nodes ∧ t.destination ∈ r.carrier.lattice.cells.graph.nodes :=
 MaterialInterface.transferEndpointsHeld _ _ held t (r.transportBoundary e held t member)

theorem electronEndpointsHeld (r : Record) (e : Edge)
 (held : e ∈ MaterialInterface.boundary r.carrier) (t : RedoxTransfer.Transfer)
 (member : t ∈ r.electrons e) :
 t.raw.donor ∈ r.carrier.lattice.cells.graph.nodes ∧ t.raw.acceptor ∈ r.carrier.lattice.cells.graph.nodes := by
 have h := MaterialInterface.boundaryEndpointsHeld _ _ held
 cases r.electronBoundary e held t member with
 | inl same => exact ⟨same.1.symm ▸ h.1,same.2.symm ▸ h.2⟩
 | inr same => exact ⟨same.1.symm ▸ h.2,same.2.symm ▸ h.1⟩

def record (r : Record) :=
 (r,rows r,ReactionIdentity.flows (placements r),RedoxTransfer.history (electronRows r),allTransport r)

theorem wholeInputRetained (r : Record) : (record r).1 = r := rfl

theorem completeElectronHistory (r : Record) :
 (RedoxTransfer.history (electronRows r)).map Prod.fst = electronRows r :=
 RedoxTransfer.completeSourceHistory _

theorem environmentAndProvenanceHeld (r : Record) :
 (record r).1.environmentTime = r.environmentTime ∧ (record r).1.provenance = r.provenance := ⟨rfl,rfl⟩

def records (rs : List Record) := rs.map record

theorem base (r : Record) : records [r] = [record r] := rfl

theorem successor (rs : List Record) (r : Record) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.Corrosion
