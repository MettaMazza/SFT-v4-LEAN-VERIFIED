import SFT.Physics.GravityAuthoritativeWitnesses
namespace SFT.Physics.GravityWaveValidationWitnesses
open GravityAuthoritativeWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"complete-wave-vector","Speed, polarization, quadrupole and scope rows remain jointly classified.",waveCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (waveCheck && true)=true
 rw [waveCheckPassed]
 rfl
end SFT.Physics.GravityWaveValidationWitnesses
