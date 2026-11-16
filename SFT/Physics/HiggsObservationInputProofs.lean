import SFT.Physics.HiggsObservationValidation
import SFT.Physics.HiggsObservationAnalysisProofs
namespace SFT.Physics.HiggsObservationInputProofs
open HiggsObservationValidation HiggsObservationAnalysisProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem outsideMassBound : outsideMass originalTarget = .ok outsideMassTarget := rfl
theorem outsideCouplingBound : outsideCoupling originalTarget = .ok outsideCouplingTarget := rfl
theorem erasedOffsetBound : (do let a ← HiggsObservationAnalysis.exactAnalysis originalTarget; erasedOffset originalTarget a) = .ok erasedOffsetTarget := rfl
theorem originalFormalPass : formalPass = true := rfl
#print axioms outsideMassBound
#print axioms outsideCouplingBound
#print axioms erasedOffsetBound
#print axioms originalFormalPass
end SFT.Physics.HiggsObservationInputProofs
