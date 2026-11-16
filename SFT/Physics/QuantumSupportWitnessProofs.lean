import SFT.Physics.QuantumSupportCertificateProof
import SFT.Physics.QuantumSupportWitnesses
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
namespace SFT.Physics.QuantumSupportWitnessProofs
open QuantumSupportWitnesses QuantumSupportCertificateProof QuantumSupportCertificate
theorem witness0Passed : witness0=true :=
 congrArg (QuantumSupportWitnesses.readFlag Certificate.walsh) originalCertificate
#print axioms witness0Passed
theorem witness1Passed : witness1=true :=
 congrArg (QuantumSupportWitnesses.readFlag Certificate.depth) originalCertificate
#print axioms witness1Passed
theorem witness2Passed : witness2=true :=
 congrArg (QuantumSupportWitnesses.readFlag Certificate.spacing) originalCertificate
#print axioms witness2Passed
theorem witness3Passed : witness3=true :=
 congrArg (QuantumSupportWitnesses.readFlag Certificate.depthTwoFloor) originalCertificate
#print axioms witness3Passed
theorem witness4Passed : witness4=true :=
 congrArg (QuantumSupportWitnesses.readFlag Certificate.joints) originalCertificate
#print axioms witness4Passed
theorem witness5Passed : witness5=true :=
 congrArg (QuantumSupportWitnesses.readFlag Certificate.coprime) originalCertificate
#print axioms witness5Passed
theorem witness6Passed : witness6=true :=
 congrArg (QuantumSupportWitnesses.readFlag Certificate.bell) originalCertificate
#print axioms witness6Passed
end SFT.Physics.QuantumSupportWitnessProofs
