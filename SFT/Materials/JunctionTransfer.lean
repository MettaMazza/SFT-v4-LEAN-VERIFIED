import SFT.Materials.CarrierMajority
import SFT.Materials.MaterialInterface
import SFT.Physics.FieldSourceContinuity
import SFT.Physics.FieldElectricDistinction
import SFT.Mathematics.FoldScalar
namespace SFT.Materials.JunctionTransfer
open SFT.Physics SFT.Physics.MechanicalConservation
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar

-- Original SEMI-JUNCTION transfer: the source is depleted by the same
-- carrier occurrence that arrives across the retained material interface.
def spaceCharge (transfer : Transfer String FieldElectricDistinction.Charge) :=
 ((transfer.source,FieldElectricDistinction.reverse transfer.carrier),
  (transfer.destination,transfer.carrier),transfer.sourceIdentity,transfer.actionRecord)

theorem chargeMagnitudePaired (transfer : Transfer String FieldElectricDistinction.Charge) :
 (spaceCharge transfer).1.2.amount = (spaceCharge transfer).2.1.2.amount :=
 FieldElectricDistinction.reversalRetainsAmount transfer.carrier

theorem chargeOrientationsOpposed (transfer : Transfer String FieldElectricDistinction.Charge) :
 (spaceCharge transfer).1.2.held =
 MechanicalLocation.opposite (spaceCharge transfer).2.1.2.held := rfl

theorem transferAndChargeProvenanceRetained (transfer : Transfer String FieldElectricDistinction.Charge) :
 (spaceCharge transfer).1.1 = transfer.source ∧
 (spaceCharge transfer).2.1.1 = transfer.destination ∧
 (spaceCharge transfer).2.2.1 = transfer.sourceIdentity ∧
 (spaceCharge transfer).2.2.2 = transfer.actionRecord := ⟨rfl,rfl,rfl,rfl⟩

def depletion (inside : String → Bool) (network : Network String FieldElectricDistinction.Charge) :=
 (FieldSourceContinuity.outward inside network).map spaceCharge

theorem depletionExactly (inside : String → Bool) (network : Network String FieldElectricDistinction.Charge)
 (record) : record ∈ depletion inside network ↔
 ∃ transfer, transfer ∈ network ∧ inside transfer.source = true ∧
 inside transfer.destination = false ∧ spaceCharge transfer = record := by
 constructor
 · intro h
   obtain ⟨transfer,held,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage spaceCharge record _ h
   have p := (FieldSourceContinuity.outwardMember inside network transfer).mp held
   exact ⟨transfer,p.1,p.2.1,p.2.2,same⟩
 · intro ⟨transfer,held,source,destination,same⟩
   cases same
   exact SFT.Foundation.Count.TraceDerivation.memMap spaceCharge transfer _
    ((FieldSourceContinuity.outwardMember inside network transfer).mpr ⟨held,source,destination⟩)

theorem everyInterfaceTransferHasRetainedEndpoints (carrier : MaterialInterface.Carrier)
 (edge : SFT.Mathematics.GraphOperations.Edge) (held : edge ∈ MaterialInterface.boundary carrier)
 (transfer : Transfer String FieldElectricDistinction.Charge)
 (bound : MaterialInterface.onBoundary edge transfer) :
 (spaceCharge transfer).1.1 ∈ carrier.lattice.cells.graph.nodes ∧
 (spaceCharge transfer).2.1.1 ∈ carrier.lattice.cells.graph.nodes :=
 MaterialInterface.transferEndpointsHeld carrier edge held transfer bound

theorem exactDepletionTransportBalance (inside : String → Bool)
 (network : Network String FieldElectricDistinction.Charge) :
 FieldSourceContinuity.departuresInside inside network + (FieldSourceContinuity.inward inside network).length =
 FieldSourceContinuity.arrivalsInside inside network + (FieldSourceContinuity.outward inside network).length :=
 FieldSourceContinuity.exactInteriorBoundaryBalance inside network

-- SEMI-JUNCTION's opposed-doped-region carrier uses the already derived
-- SEMI-PN-TYPE orientations of actual prior/result supports at each endpoint.
-- Both transfer directions are retained; balanced support supplies neither class.
def opposedDopedEndpoints (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (transfer : Transfer String FieldElectricDistinction.Charge) : Bool :=
 match CarrierMajority.orientation (before transfer.source) (after transfer.source) with
 | none => false
 | some sourceOrientation =>
   match CarrierMajority.orientation (before transfer.destination) (after transfer.destination) with
   | none => false
   | some destinationOrientation =>
     match sourceOrientation with
     | .first => match destinationOrientation with | .first => false | .second => true
     | .second => match destinationOrientation with | .first => true | .second => false

theorem opposedDopedEndpointsExactly
 (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (transfer : Transfer String FieldElectricDistinction.Charge) :
 opposedDopedEndpoints before after transfer = true ↔
 (CarrierMajority.orientation (before transfer.source) (after transfer.source) = some .first ∧
  CarrierMajority.orientation (before transfer.destination) (after transfer.destination) = some .second) ∨
 (CarrierMajority.orientation (before transfer.source) (after transfer.source) = some .second ∧
  CarrierMajority.orientation (before transfer.destination) (after transfer.destination) = some .first) := by
 unfold opposedDopedEndpoints
 cases a : CarrierMajority.orientation (before transfer.source) (after transfer.source) with
 | none =>
   cases b : CarrierMajority.orientation (before transfer.destination) (after transfer.destination) with
   | none => exact ⟨(fun h => by cases h),(fun h => by cases h with | inl h => cases h.1 | inr h => cases h.1)⟩
   | some y => cases y <;> exact ⟨(fun h => by cases h),(fun h => by cases h with | inl h => cases h.1 | inr h => cases h.1)⟩
 | some x =>
   cases b : CarrierMajority.orientation (before transfer.destination) (after transfer.destination) with
   | none => cases x <;> exact ⟨(fun h => by cases h),(fun h => by cases h with | inl h => cases h.2 | inr h => cases h.2)⟩
   | some y =>
     cases x <;> cases y
     · exact ⟨(fun h => by cases h),(fun h => by cases h with | inl h => cases h.2 | inr h => cases h.1)⟩
     · exact ⟨fun _ => .inl ⟨rfl,rfl⟩,fun _ => rfl⟩
     · exact ⟨fun _ => .inr ⟨rfl,rfl⟩,fun _ => rfl⟩
     · exact ⟨(fun h => by cases h),(fun h => by cases h with | inl h => cases h.1 | inr h => cases h.2)⟩

def dopedInterfaceTransfers
 (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (network : Network String FieldElectricDistinction.Charge) :=
 network.filter (opposedDopedEndpoints before after)

def dopedSpaceCharge
 (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (network : Network String FieldElectricDistinction.Charge) :=
 (dopedInterfaceTransfers before after network).map spaceCharge

theorem dopedSpaceChargeExactly
 (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (network : Network String FieldElectricDistinction.Charge) (record) :
 record ∈ dopedSpaceCharge before after network ↔
 ∃ transfer, transfer ∈ network ∧ opposedDopedEndpoints before after transfer = true ∧
 spaceCharge transfer = record := by
 constructor
 · intro h
   obtain ⟨transfer,held,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage spaceCharge record _ h
   have parts := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp held
   exact ⟨transfer,parts.1,parts.2,same⟩
 · intro ⟨transfer,held,opposed,same⟩
   cases same
   exact SFT.Foundation.Count.TraceDerivation.memMap spaceCharge transfer _
    ((SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨held,opposed⟩)

end SFT.Materials.JunctionTransfer
