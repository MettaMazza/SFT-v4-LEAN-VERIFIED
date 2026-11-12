import SFT.Materials.JunctionCoupling
namespace SFT.Materials.JunctionObservation
open SFT.Physics SFT.Mathematics.GeometryTopology
open SFT.Mathematics.DiscreteObjects
variable {Part Support State ClockState Clock : Type}

-- Complete endpoint observations of the actual interface coupling list.
def endpointObservations (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (cells : CollectiveCoarseGrain.NetworkObservation) :=
 (JunctionCoupling.interfaceCouplings inside p).map fun c =>
 (c.transfer, image cells.observation c.transfer.source,
  image cells.observation c.transfer.destination)

def closed (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (cells : CollectiveCoarseGrain.NetworkObservation) : Prop :=
 ∀ c, c ∈ JunctionCoupling.interfaceCouplings inside p →
 CollectiveCoarseGrain.sameMacroClass cells c.transfer.source c.transfer.destination

theorem closureExactly (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (cells : CollectiveCoarseGrain.NetworkObservation)
 (endpoints : ∀ c, c ∈ JunctionCoupling.interfaceCouplings inside p →
  c.transfer.source ∈ cells.graph.nodes ∧ c.transfer.destination ∈ cells.graph.nodes) :
 closed inside p cells ↔
 ∀ c, c ∈ JunctionCoupling.interfaceCouplings inside p →
 image cells.observation c.transfer.source = image cells.observation c.transfer.destination := by
 constructor
 · intro h c hc
   exact (CollectivePlasmaOscillation.screeningExactlyClosedObservation
    ⟨cells,c.transfer.source,c.transfer.destination,(endpoints c hc).1,(endpoints c hc).2⟩).mp (h c hc)
 · intro h c hc
   exact (CollectivePlasmaOscillation.screeningExactlyClosedObservation
    ⟨cells,c.transfer.source,c.transfer.destination,(endpoints c hc).1,(endpoints c hc).2⟩).mpr (h c hc)

theorem everyDepletionEndpointClosed (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (cells : CollectiveCoarseGrain.NetworkObservation) (h : closed inside p cells)
 (t : MechanicalConservation.Transfer String FieldElectricDistinction.Charge)
 (held : t ∈ FieldSourceContinuity.outward inside p.flow.transfers) :
 CollectiveCoarseGrain.sameMacroClass cells t.source t.destination := by
 obtain ⟨c,hc,same,_⟩ := JunctionCoupling.everyDepletionTransferHasSourceField inside p t held
 have result := h c hc
 rw [same] at result
 exact result

theorem distinctEndpointPreventsClosure (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (cells : CollectiveCoarseGrain.NetworkObservation)
 (c : CollectivePlasma.Coupling Part Support State ClockState Clock)
 (held : c ∈ JunctionCoupling.interfaceCouplings inside p)
 (different : image cells.observation c.transfer.source ≠ image cells.observation c.transfer.destination) :
 ¬ closed inside p cells := by
 intro h
 obtain ⟨label,_,_,left,right⟩ :=
  (CollectiveCoarseGrain.sameClassExactly _ _ _).mp (h c held)
 exact different (left.trans right.symm)

theorem closedTransferRetainsDepletion (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (cells : CollectiveCoarseGrain.NetworkObservation) (h : closed inside p cells)
 (t : MechanicalConservation.Transfer String FieldElectricDistinction.Charge)
 (held : t ∈ FieldSourceContinuity.outward inside p.flow.transfers) :
 ∃ c, c ∈ JunctionCoupling.interfaceCouplings inside p ∧ c.transfer = t ∧
 (JunctionTransfer.spaceCharge t).2.1.2 = c.field.electric.charge ∧
 CollectiveCoarseGrain.sameMacroClass cells t.source t.destination := by
 obtain ⟨c,hc,same,charge⟩ := JunctionCoupling.everyDepletionTransferHasSourceField inside p t held
 exact ⟨c,hc,same,charge.symm,everyDepletionEndpointClosed inside p cells h t held⟩

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
