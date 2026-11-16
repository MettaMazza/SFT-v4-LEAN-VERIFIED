import SFT.Physics.QuantumSupportJoint
namespace SFT.Physics.QuantumSupportJointThreeFiveProof
open QuantumSupportJoint
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalThreeByFive : jointSubsetCensus (.integer 3) (.integer 5)=
 .ok ⟨3,5,15,32767,217,32550,217,true,true,true,true⟩ := rfl
#print axioms originalThreeByFive
end SFT.Physics.QuantumSupportJointThreeFiveProof
