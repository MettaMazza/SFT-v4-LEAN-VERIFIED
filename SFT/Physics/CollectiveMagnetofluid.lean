import SFT.Physics.CollectivePlasmaOscillation
namespace SFT.Physics.CollectiveMagnetofluid
open MechanicalConservation

structure JointCarrier (Material Momentum Energy : Type) where
 fluid : CollectiveFlow.Content Material Momentum Energy
 charge : FieldElectricDistinction.Charge

def chargeTransfer {Material Momentum Energy : Type}
 (t : Transfer String (JointCarrier Material Momentum Energy)) : Transfer String FieldElectricDistinction.Charge :=
 ⟨t.source,t.destination,t.carrier.charge,t.sourceIdentity,t.actionRecord⟩

structure Magnetofluid (Material Momentum Energy Part Support State ClockState Clock : Type) where
 flow : CollectiveFlow.Flow (JointCarrier Material Momentum Energy)
 plasma : CollectivePlasma.Plasma Part Support State ClockState Clock
 sameCells : flow.cells = plasma.flow.cells
 sameTransfers : flow.transfers.map chargeTransfer = plasma.flow.transfers

variable {Material Momentum Energy Part Support State ClockState Clock : Type}

theorem commonGeneratedNetwork (m : Magnetofluid Material Momentum Energy Part Support State ClockState Clock) :
 m.flow.cells.graph = m.plasma.flow.cells.graph := congrArg CollectiveCoarseGrain.NetworkObservation.graph m.sameCells

theorem eachFluidTransferHasField (m : Magnetofluid Material Momentum Energy Part Support State ClockState Clock)
 (t : Transfer String (JointCarrier Material Momentum Energy)) (held : t ∈ m.flow.transfers) :
 ∃ c, c ∈ m.plasma.couplings ∧ c.transfer = chargeTransfer t := by
 apply CollectivePlasma.everyMobileCarrierCoupled m.plasma
 rw [← m.sameTransfers]
 exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem eachFieldTransferHasFluid (m : Magnetofluid Material Momentum Energy Part Support State ClockState Clock)
 (c : CollectivePlasma.Coupling Part Support State ClockState Clock) (held : c ∈ m.plasma.couplings) :
 ∃ t, t ∈ m.flow.transfers ∧ chargeTransfer t = c.transfer := by
 have h := CollectivePlasma.noUnrecordedCoupling m.plasma c held
 rw [← m.sameTransfers] at h
 exact SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ h

theorem exactJointCarrierConservation (m : Magnetofluid Material Momentum Energy Part Support State ClockState Clock) :
 outgoingSupport m.flow.transfers = incomingSupport m.flow.transfers := completeConservation _

theorem fluidProjectionConserved (m : Magnetofluid Material Momentum Energy Part Support State ClockState Clock) :
 (outgoingSupport m.flow.transfers).map JointCarrier.fluid =
 (incomingSupport m.flow.transfers).map JointCarrier.fluid :=
 congrArg (List.map JointCarrier.fluid) (exactJointCarrierConservation m)

theorem chargeProjectionConserved (m : Magnetofluid Material Momentum Energy Part Support State ClockState Clock) :
 (outgoingSupport m.flow.transfers).map JointCarrier.charge =
 (incomingSupport m.flow.transfers).map JointCarrier.charge :=
 congrArg (List.map JointCarrier.charge) (exactJointCarrierConservation m)

theorem sharedTransferIdentity (t : Transfer String (JointCarrier Material Momentum Energy)) :
 (chargeTransfer t).source = t.source ∧ (chargeTransfer t).destination = t.destination ∧
 (chargeTransfer t).sourceIdentity = t.sourceIdentity ∧ (chargeTransfer t).actionRecord = t.actionRecord :=
 ⟨rfl,rfl,rfl,rfl⟩

theorem sharedMagneticCharge (t : Transfer String (JointCarrier Material Momentum Energy))
 (c : CollectivePlasma.Coupling Part Support State ClockState Clock)
 (same : c.transfer = chargeTransfer t) : c.field.magnetic.transport.charge = t.carrier.charge := by
 rw [CollectivePlasma.magneticChargeIsTransportedCharge c,same]
 rfl

theorem jointBoundaryBalance (m : Magnetofluid Material Momentum Energy Part Support State ClockState Clock)
 (region : List String) :
 FieldSourceContinuity.departuresInside (CollectiveFlow.inside region) m.flow.transfers +
 (FieldSourceContinuity.inward (CollectiveFlow.inside region) m.flow.transfers).length =
 FieldSourceContinuity.arrivalsInside (CollectiveFlow.inside region) m.flow.transfers +
 (FieldSourceContinuity.outward (CollectiveFlow.inside region) m.flow.transfers).length :=
 CollectiveFlow.completeRegionBalance m.flow region

theorem unequalTransferCensusRejected (m : Magnetofluid Material Momentum Energy Part Support State ClockState Clock)
 (other : Network String FieldElectricDistinction.Charge)
 (different : other ≠ m.flow.transfers.map chargeTransfer) : other ≠ m.plasma.flow.transfers := by
 rw [← m.sameTransfers]
 exact different
end SFT.Physics.CollectiveMagnetofluid
