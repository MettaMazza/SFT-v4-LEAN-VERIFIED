import SFT.Physics.ThermoTemperatureOrder
namespace SFT.Physics.ThermoEquilibrium
open ThermoTemperature ThermoTemperatureOrder SFT.Mathematics.FoldScalar

-- thermodynamics_laws.EQUILIBRIUM: coupled supports at one held thermal
-- reference. Each reading is computed from its complete retained probe.
structure CoupledState {Part Support State ClockState Clock : Type}
    (reference : Transition Part Support State ClockState Clock) where
  left : Transition Part Support State ClockState Clock
  right : Transition Part Support State ClockState Clock
  commonReading : Scalar
  leftComputed : relativeCarrier left reference = .ok commonReading
  rightComputed : relativeCarrier right reference = .ok commonReading

variable {Part Support State ClockState Clock : Type}
variable {reference : Transition Part Support State ClockState Clock}

def classView (state : Macrostate) := (state.label,state.members)
def view (state : CoupledState reference) :=
  (classView state.left.after,classView state.right.after,state.commonReading)
def sameEquilibrium (before after : CoupledState reference) : Prop := view before = view after

theorem precisePreservation (before after : CoupledState reference) :
    sameEquilibrium before after ↔
      classView before.left.after = classView after.left.after ∧
      classView before.right.after = classView after.right.after ∧
      before.commonReading = after.commonReading := by
  constructor
  · intro h
    exact ⟨congrArg Prod.fst h,congrArg (fun x => x.2.1) h,congrArg (fun x => x.2.2) h⟩
  · intro ⟨hl,hr,ht⟩
    unfold sameEquilibrium view
    rw [hl,hr,ht]

theorem reflexive (state : CoupledState reference) : sameEquilibrium state state := rfl

theorem symmetric (before after : CoupledState reference)
    (h : sameEquilibrium before after) : sameEquilibrium after before := h.symm

theorem transitive (a b c : CoupledState reference)
    (ab : sameEquilibrium a b) (bc : sameEquilibrium b c) : sameEquilibrium a c := ab.trans bc

theorem commonTemperatureEstablished (state : CoupledState reference) :
    thermalOrder state.left state.right reference = .ok .eq :=
  sameReadingSameOrder state.left state.right reference state.commonReading state.leftComputed state.rightComputed

theorem changedLeftClassExcluded (before after : CoupledState reference)
    (different : classView before.left.after ≠ classView after.left.after) :
    ¬ sameEquilibrium before after := fun h => different ((precisePreservation before after).mp h).1

theorem changedRightClassExcluded (before after : CoupledState reference)
    (different : classView before.right.after ≠ classView after.right.after) :
    ¬ sameEquilibrium before after := fun h => different ((precisePreservation before after).mp h).2.1

theorem changedThermalOrderExcluded (before after : CoupledState reference)
    (different : before.commonReading ≠ after.commonReading) :
    ¬ sameEquilibrium before after := fun h => different ((precisePreservation before after).mp h).2.2

-- Reciprocal boundary exchanges reverse endpoints and retain the complete
-- carrier and original source/action provenance.
def reciprocal {Node Carrier : Type} (t : MechanicalConservation.Transfer Node Carrier) :
    MechanicalConservation.Transfer Node Carrier :=
  ⟨t.destination,t.source,t.carrier,t.sourceIdentity,t.actionRecord⟩

theorem reciprocalTwice {Node Carrier : Type} (t : MechanicalConservation.Transfer Node Carrier) :
    reciprocal (reciprocal t) = t := rfl

def exchanges {Node Carrier : Type} (t : MechanicalConservation.Transfer Node Carrier) := [t,reciprocal t]

theorem exactReciprocalEndpoints {Node Carrier : Type} (t : MechanicalConservation.Transfer Node Carrier) :
    (reciprocal t).source = t.destination ∧ (reciprocal t).destination = t.source := ⟨rfl,rfl⟩

theorem bothTransfersRetained {Node Carrier : Type} (t : MechanicalConservation.Transfer Node Carrier) :
    (exchanges t).map MechanicalConservation.Transfer.carrier = [t.carrier,t.carrier] := rfl

theorem reciprocalAccountingClosed {Node Carrier : Type} (t : MechanicalConservation.Transfer Node Carrier) :
    MechanicalConservation.outgoingSupport (exchanges t) = MechanicalConservation.incomingSupport (exchanges t) :=
  MechanicalConservation.completeConservation _
end SFT.Physics.ThermoEquilibrium
