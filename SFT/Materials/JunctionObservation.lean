import SFT.Materials.JunctionCoupling
namespace SFT.Materials.JunctionObservation
open SFT.Physics SFT.Mathematics.GeometryTopology
open SFT.Mathematics.DiscreteObjects
variable {Part Support State ClockState Clock : Type}

-- Endpoint observations use the same generated network as the actual transfers.
-- V3 collective_matter_laws.py: complete shared cell and boundary records.
def endpointObservations (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 :=
 (JunctionCoupling.interfaceCouplings inside p).map fun c =>
 (c.transfer, image p.flow.cells.observation c.transfer.source,
  image p.flow.cells.observation c.transfer.destination)

def closed (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 : Prop :=
 ∀ c, c ∈ JunctionCoupling.interfaceCouplings inside p →
 CollectiveCoarseGrain.sameMacroClass p.flow.cells c.transfer.source c.transfer.destination

theorem closureExactly (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 :
 closed inside p ↔
 ∀ c, c ∈ JunctionCoupling.interfaceCouplings inside p →
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

theorem everyDepletionEndpointClosed (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (h : closed inside p)
 (t : MechanicalConservation.Transfer String FieldElectricDistinction.Charge)
 (held : t ∈ FieldSourceContinuity.outward inside p.flow.transfers) :
 CollectiveCoarseGrain.sameMacroClass p.flow.cells t.source t.destination := by
 obtain ⟨c,hc,same,_⟩ := JunctionCoupling.everyDepletionTransferHasSourceField inside p t held
 have result := h c hc
 rw [same] at result
 exact result

theorem distinctEndpointPreventsClosure (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)

 (c : CollectivePlasma.Coupling Part Support State ClockState Clock)
 (held : c ∈ JunctionCoupling.interfaceCouplings inside p)
 (different : image p.flow.cells.observation c.transfer.source ≠ image p.flow.cells.observation c.transfer.destination) :
 ¬ closed inside p := by
 intro h
 obtain ⟨label,_,_,left,right⟩ :=
  (CollectiveCoarseGrain.sameClassExactly _ _ _).mp (h c held)
 exact different (left.trans right.symm)

theorem closedTransferRetainsDepletion (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (h : closed inside p)
 (t : MechanicalConservation.Transfer String FieldElectricDistinction.Charge)
 (held : t ∈ FieldSourceContinuity.outward inside p.flow.transfers) :
 ∃ c, c ∈ JunctionCoupling.interfaceCouplings inside p ∧ c.transfer = t ∧
 (JunctionTransfer.spaceCharge t).2.1.2 = c.field.electric.charge ∧
 CollectiveCoarseGrain.sameMacroClass p.flow.cells t.source t.destination := by
 obtain ⟨c,hc,same,charge⟩ := JunctionCoupling.everyDepletionTransferHasSourceField inside p t held
 exact ⟨c,hc,same,charge.symm,everyDepletionEndpointClosed inside p h t held⟩

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
