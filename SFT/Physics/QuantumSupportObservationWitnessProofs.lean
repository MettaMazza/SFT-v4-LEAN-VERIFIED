import SFT.Physics.QuantumSupportObservationWitnesses
import SFT.Physics.QuantumSupportCertificateProof
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
namespace SFT.Physics.QuantumSupportObservationWitnessProofs
open QuantumSupportObservationWitnesses QuantumSupportCertificateProof QuantumSupportCertificate
theorem formalWalshPassed : formalWalsh=true :=
 congrArg (QuantumSupportWitnesses.readFlag Certificate.walsh) originalCertificate
#print axioms formalWalshPassed
theorem formalJointsPassed : formalJoints=true :=
 congrArg (QuantumSupportWitnesses.readFlag Certificate.joints) originalCertificate
#print axioms formalJointsPassed
theorem formalBellPassed : formalBell=true :=
 congrArg (QuantumSupportWitnesses.readFlag Certificate.bell) originalCertificate
#print axioms formalBellPassed
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 dsimp only [witnesses, List.all_cons, List.all_nil]
 rw [formalWalshPassed, formalJointsPassed, formalBellPassed]
 rfl
#print axioms allWitnessesPass
end SFT.Physics.QuantumSupportObservationWitnessProofs
