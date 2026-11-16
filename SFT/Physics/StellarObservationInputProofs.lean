import SFT.Physics.StellarObservationValidation
import SFT.Physics.StellarObservationAnalysisProofs
namespace SFT.Physics.StellarObservationInputProofs
open StellarObservationValidation StellarObservationAnalysisProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem erasedStellarBound : erasedStellar originalTarget=.ok erasedStellarTarget := rfl
theorem centralOnlyBound : centralOnly originalTarget=.ok centralOnlyTarget := rfl
theorem falseLunarLockBound : falseLunarLock originalTarget=.ok falseLunarLockTarget := rfl
theorem erasedMercuryBound : erasedMercury originalTarget=.ok erasedMercuryTarget := rfl
theorem originalFormalPass : formalPass=true := rfl
#print axioms erasedStellarBound
#print axioms centralOnlyBound
#print axioms falseLunarLockBound
#print axioms erasedMercuryBound
#print axioms originalFormalPass
end SFT.Physics.StellarObservationInputProofs
