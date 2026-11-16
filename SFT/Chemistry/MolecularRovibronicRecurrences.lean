import SFT.Chemistry.MolecularRovibronicState
namespace SFT.Chemistry.MolecularRovibronicState
open SFT.Physics.CapabilityValues SFT.Physics.MolecularLadders
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem rotationalValue (state : State) (n : Nat) (h : state.rotationalOrdinal.value = n+1) :
 (rotationalRecurrence state).map PositiveCount.value = .ok ((n+1)*(n+2)) := by
 unfold rotationalRecurrence
 rewrite [h,everyRotationalLevel]
 change (count ((n+1)*(n+2))).map PositiveCount.value = _
 unfold count
 have hp : 0 < (n+1)*(n+2) := Nat.mul_pos (Nat.zero_lt_succ n) (Nat.zero_lt_succ (n+1))
 rewrite [dif_pos hp]
 rfl
theorem vibrationalValue (state : State) (n : Nat) (h : state.vibrationalOrdinal.value = n+1) :
 (vibrationalRecurrence state).map PositiveCount.value = .ok (2*n+1) := by
 unfold vibrationalRecurrence
 rewrite [h,everyOddCarrier]
 change (count (2*n+1)).map PositiveCount.value = _
 unfold count
 rewrite [dif_pos (Nat.zero_lt_succ (2*n))]
 rfl
theorem completeKey (state : State) (v r : PositiveCount)
 (hv : vibrationalRecurrence state = .ok v) (hr : rotationalRecurrence state = .ok r) :
 exactStateKey state = .ok ⟨state.electronicState.molecularCarrierId,state.isotopeLabels.map HeldLabel.label,v.value,r.value,state.heldSpinState.label,state.observationRecord.label⟩ := by
 unfold exactStateKey
 rewrite [hv,hr]
 rfl
#print axioms rotationalValue
#print axioms vibrationalValue
#print axioms completeKey
end SFT.Chemistry.MolecularRovibronicState
