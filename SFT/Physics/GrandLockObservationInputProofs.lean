import SFT.Physics.GrandLockObservationValidation
import SFT.Physics.GrandLockObservationAnalysisProofs
namespace SFT.Physics.GrandLockObservationInputProofs
open GrandLockObservationValidation GrandLockObservationAnalysisProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem missingRowBound : missingRow originalTarget=.ok missingRowTarget := rfl
#print axioms missingRowBound
theorem missingAdverseBound : missingAdverse originalTarget=.ok missingAdverseTarget := rfl
#print axioms missingAdverseBound
theorem selectorBound : selector originalTarget=.ok selectorTarget := rfl
#print axioms selectorBound
theorem falseLegacyBound : falseLegacy originalTarget=falseLegacyTarget := rfl
#print axioms falseLegacyBound
end SFT.Physics.GrandLockObservationInputProofs
