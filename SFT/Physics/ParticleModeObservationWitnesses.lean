import SFT.Physics.ParticleModeWitnesses
namespace SFT.Physics.ParticleModeObservationWitnesses
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"fibres","Formal particle-mode witness fibres is closed.",ParticleModeWitnesses.witness0⟩,⟨"coordinates","Formal particle-mode witness coordinates is closed.",ParticleModeWitnesses.witness1⟩,⟨"cover","Formal particle-mode witness cover is closed.",ParticleModeWitnesses.witness2⟩,⟨"placement","Formal particle-mode witness placement is closed.",ParticleModeWitnesses.witness3⟩,⟨"mass","Formal particle-mode witness mass is closed.",ParticleModeWitnesses.witness4⟩,⟨"dual","Formal particle-mode witness dual is closed.",ParticleModeWitnesses.witness5⟩,⟨"reach","Formal particle-mode witness reach is closed.",ParticleModeWitnesses.witness6⟩,⟨"transition","Formal particle-mode witness transition is closed.",ParticleModeWitnesses.witness7⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 unfold witnesses
 change (ParticleModeWitnesses.witness0 && (ParticleModeWitnesses.witness1 && (ParticleModeWitnesses.witness2 && (ParticleModeWitnesses.witness3 && (ParticleModeWitnesses.witness4 && (ParticleModeWitnesses.witness5 && (ParticleModeWitnesses.witness6 && (ParticleModeWitnesses.witness7 && true)))))))) = true
 rw [ParticleModeWitnesses.witness0Passed,ParticleModeWitnesses.witness1Passed,ParticleModeWitnesses.witness2Passed,ParticleModeWitnesses.witness3Passed,ParticleModeWitnesses.witness4Passed,ParticleModeWitnesses.witness5Passed,ParticleModeWitnesses.witness6Passed,ParticleModeWitnesses.witness7Passed]
 rfl
end SFT.Physics.ParticleModeObservationWitnesses
