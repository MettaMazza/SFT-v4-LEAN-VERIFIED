import SFT.Physics.ThermoEquilibrium
namespace SFT.Physics.ThermoEquilibriumExchange
open ThermoTemperature ThermoEquilibrium

structure Exchange {Part Support State ClockState Clock : Type}
    (reference : Transition Part Support State ClockState Clock) (Node Carrier : Type) where
  before : CoupledState reference
  after : CoupledState reference
  transfer : MechanicalConservation.Transfer Node Carrier

variable {Part Support State ClockState Clock Node Carrier : Type}
variable {reference : Transition Part Support State ClockState Clock}

def records (e : Exchange reference Node Carrier) := exchanges e.transfer

def equilibrated (e : Exchange reference Node Carrier) : Prop := sameEquilibrium e.before e.after

theorem sourceCriterion (e : Exchange reference Node Carrier) :
    equilibrated e ↔
      classView e.before.left.after = classView e.after.left.after ∧
      classView e.before.right.after = classView e.after.right.after ∧
      e.before.commonReading = e.after.commonReading := precisePreservation e.before e.after

def reverse (e : Exchange reference Node Carrier) : Exchange reference Node Carrier :=
  ⟨e.after,e.before,reciprocal e.transfer⟩

theorem reversalPreservesEquilibrium (e : Exchange reference Node Carrier) (h : equilibrated e) :
    equilibrated (reverse e) := symmetric e.before e.after h

theorem reversalReconstructs (e : Exchange reference Node Carrier) : reverse (reverse e) = e := rfl

theorem fullReciprocalAccounting (e : Exchange reference Node Carrier) :
    MechanicalConservation.outgoingSupport (records e) = MechanicalConservation.incomingSupport (records e) :=
  reciprocalAccountingClosed e.transfer

theorem transferIdentityRetained (e : Exchange reference Node Carrier) :
    (records e).map MechanicalConservation.Transfer.sourceIdentity =
      [e.transfer.sourceIdentity,e.transfer.sourceIdentity] := rfl
end SFT.Physics.ThermoEquilibriumExchange
