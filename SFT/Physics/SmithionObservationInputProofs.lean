import SFT.Physics.SmithionObservationValidation
import SFT.Physics.SmithionObservationAnalysisProofs
namespace SFT.Physics.SmithionObservationInputProofs
open SmithionObservationValidation SmithionObservationAnalysisProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem densityInput : tamperedDensity originalTarget = .ok densityControlTarget := rfl
theorem fabricatedInput : fabricatedRate originalTarget = .ok fabricatedControlTarget := rfl
theorem originalFormal : formalPass=true := rfl
#print axioms densityInput
#print axioms fabricatedInput
#print axioms originalFormal
end SFT.Physics.SmithionObservationInputProofs
