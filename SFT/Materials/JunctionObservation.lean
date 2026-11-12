import SFT.Materials.JunctionCoupling
namespace SFT.Materials.JunctionObservation
open SFT.Physics SFT.Mathematics.GeometryTopology
open SFT.Mathematics.DiscreteObjects
variable {Part Support State ClockState Clock : Type}

-- Endpoint observations use the same generated network as the actual transfers.
-- V3 collective_matter_laws.py: complete shared cell and boundary records.
def endpointObservations (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 :=
 (JunctionCoupling.dopedInterfaceCouplings before after p).map fun c =>
 (c.transfer, image p.flow.cells.observation c.transfer.source,
  image p.flow.cells.observation c.transfer.destination)

def closed (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 : Prop :=
 ∀ c, c ∈ JunctionCoupling.dopedInterfaceCouplings before after p →
 CollectiveCoarseGrain.sameMacroClass p.flow.cells c.transfer.source c.transfer.destination

theorem closureExactly (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 :
 closed before after p ↔
 ∀ c, c ∈ JunctionCoupling.dopedInterfaceCouplings before after p →
 image p.flow.cells.observation c.transfer.source = image p.flow.cells.observation c.transfer.destination := by
 constructor
 · intro h c hc
   exact (CollectivePlasmaOscillation.screeningExactlyClosedObservation
    ⟨p.flow.cells,c.transfer.source,c.transfer.destination,
     (SFT.Mathematics.GraphOperations.acceptedGraphEndpoints p.flow.cells.nodes p.flow.cells.edges
       p.flow.cells.graph p.flow.cells.generated _
       (CollectivePlasma.couplingIsAdjacent p c ((filterMemberIff _ _ _).mp hc).1)).1,
     (SFT.Mathematics.GraphOperations.acceptedGraphEndpoints p.flow.cells.nodes p.flow.cells.edges
       p.flow.cells.graph p.flow.cells.generated _
       (CollectivePlasma.couplingIsAdjacent p c ((filterMemberIff _ _ _).mp hc).1)).2⟩).mp (h c hc)
 · intro h c hc
   exact (CollectivePlasmaOscillation.screeningExactlyClosedObservation
    ⟨p.flow.cells,c.transfer.source,c.transfer.destination,
     (SFT.Mathematics.GraphOperations.acceptedGraphEndpoints p.flow.cells.nodes p.flow.cells.edges
       p.flow.cells.graph p.flow.cells.generated _
       (CollectivePlasma.couplingIsAdjacent p c ((filterMemberIff _ _ _).mp hc).1)).1,
     (SFT.Mathematics.GraphOperations.acceptedGraphEndpoints p.flow.cells.nodes p.flow.cells.edges
       p.flow.cells.graph p.flow.cells.generated _
       (CollectivePlasma.couplingIsAdjacent p c ((filterMemberIff _ _ _).mp hc).1)).2⟩).mpr (h c hc)

theorem everyDepletionEndpointClosed (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (h : closed before after p)
 (t : MechanicalConservation.Transfer String FieldElectricDistinction.Charge)
 (held : t ∈ JunctionTransfer.dopedInterfaceTransfers before after p.flow.transfers) :
 CollectiveCoarseGrain.sameMacroClass p.flow.cells t.source t.destination := by
 obtain ⟨c,hc,same,_⟩ := JunctionCoupling.everyDopedInterfaceTransferHasSourceField before after p t held
 have result := h c hc
 rw [same] at result
 exact result

theorem distinctEndpointPreventsClosure (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)

 (c : CollectivePlasma.Coupling Part Support State ClockState Clock)
 (held : c ∈ JunctionCoupling.dopedInterfaceCouplings before after p)
 (different : image p.flow.cells.observation c.transfer.source ≠ image p.flow.cells.observation c.transfer.destination) :
 ¬ closed before after p := by
 intro h
 obtain ⟨label,_,_,left,right⟩ :=
  (CollectiveCoarseGrain.sameClassExactly _ _ _).mp (h c held)
 exact different (left.trans right.symm)

theorem closedTransferRetainsDepletion (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (h : closed before after p)
 (t : MechanicalConservation.Transfer String FieldElectricDistinction.Charge)
 (held : t ∈ JunctionTransfer.dopedInterfaceTransfers before after p.flow.transfers) :
 ∃ c, c ∈ JunctionCoupling.dopedInterfaceCouplings before after p ∧ c.transfer = t ∧
 (JunctionTransfer.spaceCharge t).2.1.2 = c.field.electric.charge ∧
 CollectiveCoarseGrain.sameMacroClass p.flow.cells t.source t.destination := by
 obtain ⟨c,hc,same,charge⟩ := JunctionCoupling.everyDopedInterfaceTransferHasSourceField before after p t held
 exact ⟨c,hc,same,charge,everyDepletionEndpointClosed before after p h t held⟩

-- Reuse the existing restoring record; never fabricate a motion or an equilibrium.
theorem actualRestoringPathRetainsJunctionCharge
 (r : CollectivePlasmaOscillation.RestoringResponse Part Support State ClockState Clock)
 (step : MechanicalEvents.Row State) :
 r.motion.last.carrier = r.coupling.field.electric.work.displacement ∧
 (FieldInduction.electricResponse r.coupling.field.induction step).charge =
 (JunctionTransfer.spaceCharge r.coupling.transfer).2.1.2 :=
 ⟨CollectivePlasmaOscillation.returnedDisplacement r,
  CollectivePlasmaOscillation.recurrenceRetainsCharge r step⟩
end SFT.Materials.JunctionObservation
