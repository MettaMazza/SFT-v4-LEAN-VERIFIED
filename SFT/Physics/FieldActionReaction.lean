import SFT.Physics.FieldSourceContinuity
namespace SFT.Physics.FieldActionReaction
open MechanicalConservation

structure HeldTransfer (Node Carrier : Type) where
  location : Node
  carrier : Carrier
  held : MechanicalLocation.Held
  sourceIdentity : String
  actionRecord : SFT.Host.Canonical.Value

variable {Node Carrier : Type}

def sourceLoss (t : Transfer Node Carrier) : HeldTransfer Node Carrier :=
  ⟨t.source,t.carrier,.first,t.sourceIdentity,t.actionRecord⟩

def recipientGain (t : Transfer Node Carrier) : HeldTransfer Node Carrier :=
  ⟨t.destination,t.carrier,.second,t.sourceIdentity,t.actionRecord⟩

theorem exactSameCarrier (t : Transfer Node Carrier) :
    (sourceLoss t).carrier = (recipientGain t).carrier := rfl

theorem oppositeHeld (t : Transfer Node Carrier) :
    (recipientGain t).held = MechanicalLocation.opposite (sourceLoss t).held := rfl

theorem heldRolesDistinct (t : Transfer Node Carrier) : (sourceLoss t).held ≠ (recipientGain t).held := by
  intro h; cases h

theorem bothEndpointsRetained (t : Transfer Node Carrier) :
    (sourceLoss t).location = t.source ∧ (recipientGain t).location = t.destination := ⟨rfl,rfl⟩

theorem completeProvenanceRetained (t : Transfer Node Carrier) :
    (sourceLoss t).sourceIdentity = (recipientGain t).sourceIdentity ∧
    (sourceLoss t).actionRecord = (recipientGain t).actionRecord := ⟨rfl,rfl⟩

def paired (network : Network Node Carrier) := network.map (fun t => (sourceLoss t,recipientGain t))

theorem completePairCount (network : Network Node Carrier) : (paired network).length = network.length := by
  induction network with
  | nil => rfl
  | cons t ts ih => exact congrArg Nat.succ ih

theorem fullCarrierConservation (network : Network Node Carrier) :
    (paired network).map (fun p => p.1.carrier) = (paired network).map (fun p => p.2.carrier) := by
  induction network with
  | nil => rfl
  | cons t ts ih => exact congrArg (List.cons t.carrier) ih

theorem successorPreservesPairs (network : Network Node Carrier) (t : Transfer Node Carrier) :
    paired (network ++ [t]) = paired network ++ [(sourceLoss t,recipientGain t)] :=
  ReferenceRealization.mapAppendOne _ _ _

theorem positiveMomentumAtBothEnds {Part Support State ClockState : Type}
    (t : Transfer Node (MechanicalMomentum.Momentum Part Support State ClockState)) :
    0 < (MechanicalMomentum.magnitude (sourceLoss t).carrier).numerator ∧
    0 < (MechanicalMomentum.magnitude (recipientGain t).carrier).numerator :=
  ⟨(MechanicalMomentum.magnitude t.carrier).positive,(MechanicalMomentum.magnitude t.carrier).positive⟩

theorem momentumMagnitudeEqual {Part Support State ClockState : Type}
    (t : Transfer Node (MechanicalMomentum.Momentum Part Support State ClockState)) :
    MechanicalMomentum.magnitude (sourceLoss t).carrier = MechanicalMomentum.magnitude (recipientGain t).carrier := rfl
end SFT.Physics.FieldActionReaction
