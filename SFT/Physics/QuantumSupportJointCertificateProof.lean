import SFT.Physics.QuantumSupportJoint
namespace SFT.Physics.QuantumSupportJointCertificateProof
open QuantumSupportJoint
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalTwoByThree : jointSubsetCensus (.integer 2) (.integer 3)=
 .ok ⟨2,3,6,63,21,42,21,true,true,true,true⟩ := rfl
end SFT.Physics.QuantumSupportJointCertificateProof
