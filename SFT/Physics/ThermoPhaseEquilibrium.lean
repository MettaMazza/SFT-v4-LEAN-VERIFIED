import SFT.Physics.ThermoStateRelation
namespace SFT.Physics.ThermoPhaseEquilibrium
open ThermoTemperature ThermoEquilibrium ThermoEquilibriumExchange
variable {Part Support State ClockState Clock Node Carrier : Type}
variable {reference : Transition Part Support State ClockState Clock}

def distinctPhases (state : CoupledState reference) : Prop :=
 classView state.left.after ≠ classView state.right.after

def coexists (e : Exchange reference Node Carrier) : Prop :=
 distinctPhases e.before ∧ equilibrated e

theorem coexistenceCriterion (e : Exchange reference Node Carrier) : coexists e ↔
 distinctPhases e.before ∧
 classView e.before.left.after = classView e.after.left.after ∧
 classView e.before.right.after = classView e.after.right.after ∧
 e.before.commonReading = e.after.commonReading := by
 constructor
 · intro ⟨different,balanced⟩
   exact ⟨different,(sourceCriterion e).mp balanced⟩
 · intro ⟨different,balanced⟩
   exact ⟨different,(sourceCriterion e).mpr balanced⟩

theorem distinctFibresPersist (e : Exchange reference Node Carrier) (h : coexists e) : distinctPhases e.after := by
 have preserved := (sourceCriterion e).mp h.2
 intro same
 exact h.1 (preserved.1.trans (same.trans preserved.2.1.symm))

theorem commonOrderBefore (e : Exchange reference Node Carrier) :
 ThermoTemperatureOrder.thermalOrder e.before.left e.before.right reference = .ok .eq :=
 commonTemperatureEstablished e.before

theorem commonOrderAfter (e : Exchange reference Node Carrier) :
 ThermoTemperatureOrder.thermalOrder e.after.left e.after.right reference = .ok .eq :=
 commonTemperatureEstablished e.after

theorem completeBoundaryBalance (e : Exchange reference Node Carrier) :
 MechanicalConservation.outgoingSupport (records e) = MechanicalConservation.incomingSupport (records e) :=
 fullReciprocalAccounting e

theorem coexistenceReversible (e : Exchange reference Node Carrier) (h : coexists e) : coexists (reverse e) :=
 ⟨distinctFibresPersist e h,reversalPreservesEquilibrium e h.2⟩

def phaseTransition (e : Exchange reference Node Carrier) : Prop :=
 classView e.before.left.after ≠ classView e.after.left.after ∨
 classView e.before.right.after ≠ classView e.after.right.after

theorem changedSelectedFibreExcludesUnchangedPhase (e : Exchange reference Node Carrier)
 (changed : phaseTransition e) : ¬ equilibrated e := by
 intro unchanged
 have preserved := (sourceCriterion e).mp unchanged
 cases changed with
 | inl left => exact left preserved.1
 | inr right => exact right preserved.2.1

theorem transitionRetainsAllCarriers (e : Exchange reference Node Carrier) :
 (records e).map MechanicalConservation.Transfer.carrier = [e.transfer.carrier,e.transfer.carrier] := rfl

theorem transitionRetainsSourceIdentity (e : Exchange reference Node Carrier) :
 (records e).map MechanicalConservation.Transfer.sourceIdentity =
 [e.transfer.sourceIdentity,e.transfer.sourceIdentity] := transferIdentityRetained e

abbrev phaseFibreIsComputed := ThermoEntropy.exactHeldFibre
abbrev eachMemberRetainedOnce := ThermoMicroMacro.everyPredecessorRetainedOnce
abbrev oneStateBase := SFT.InformationScience.EntropyExtension.singletonBase
abbrev successorPreservesFibre := SFT.InformationScience.EntropyExtension.fibreSuccessor
end SFT.Physics.ThermoPhaseEquilibrium
