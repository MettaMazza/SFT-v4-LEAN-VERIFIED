import SFT.Physics.SpinStatisticsOccupationCertificateProof
import SFT.Physics.SpinStatisticsWeightsCertificateProof
import SFT.Physics.SpinStatisticsColdCertificateProof
namespace SFT.Physics.SpinStatisticsCertificateProof
open SpinStatisticsCondensationCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalCertificate : certificate=.ok ⟨true,true,true,true⟩ := by
 unfold certificate
 rw [SpinStatisticsOccupationCertificateProof.originalOccupation,
     SpinStatisticsWeightsCertificateProof.originalWeights,
     SpinStatisticsColdCertificateProof.originalCold]
 rfl
end SFT.Physics.SpinStatisticsCertificateProof
