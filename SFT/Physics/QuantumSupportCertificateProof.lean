import SFT.Physics.QuantumSupportCertificate
import SFT.Physics.QuantumSupportWalshFourProof
import SFT.Physics.QuantumSupportJointCertificateProof
import SFT.Physics.QuantumSupportJointThreeFiveProof
namespace SFT.Physics.QuantumSupportCertificateProof
open QuantumSupportCertificate
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalCertificate : theoremCertificate = .ok ⟨true,true,true,true,true,true,true⟩ := by
 unfold theoremCertificate
 rw [QuantumSupportWalshFourProof.originalCompleteCensus,
   QuantumSupportJointCertificateProof.originalTwoByThree,
   QuantumSupportJointThreeFiveProof.originalThreeByFive]
 rfl
#print axioms originalCertificate
end SFT.Physics.QuantumSupportCertificateProof
