import SFT.Physics.QuantumSupportWalsh
namespace SFT.Physics.QuantumSupportWalshThreeProof
open QuantumSupportWalsh
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalFirstThreeDepths : completeWalshCensus (.integer 3)=
 .ok ⟨3,273,65,true⟩ := rfl
end SFT.Physics.QuantumSupportWalshThreeProof
