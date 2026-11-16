import SFT.Physics.ChirpObservationValidation
import SFT.Physics.ChirpObservationAnalysisProofs
namespace SFT.Physics.ChirpObservationInputProofs
open ChirpObservationValidation ChirpObservationAnalysisProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem reversedFrequencyBound : reversedFrequency originalTarget=.ok reversedFrequencyTarget := rfl
#print axioms reversedFrequencyBound
theorem erasedRemnantBound : erasedRemnant originalTarget=.ok erasedRemnantTarget := rfl
#print axioms erasedRemnantBound
theorem relabelledDevelopmentBound : relabelledDevelopment originalTarget=.ok relabelledDevelopmentTarget := rfl
#print axioms relabelledDevelopmentBound
theorem erasedScopeBound : erasedScope originalTarget=.ok erasedScopeTarget := rfl
#print axioms erasedScopeBound
theorem originalFormalPass : formalPass=true := rfl
#print axioms originalFormalPass
end SFT.Physics.ChirpObservationInputProofs
