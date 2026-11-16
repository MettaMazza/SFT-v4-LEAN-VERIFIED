import SFT.Physics.HorizonObservationValidation
import SFT.Physics.HorizonObservationAnalysisProofs
namespace SFT.Physics.HorizonObservationInputProofs
open HorizonObservationValidation HorizonObservationAnalysisProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem reversedOrderBound : reversedOrder originalTarget=.ok reversedOrderTarget := rfl
#print axioms reversedOrderBound
theorem collapsedUpperBound : collapsedUpper originalTarget=.ok collapsedUpperTarget := rfl
#print axioms collapsedUpperBound
theorem erasedConditionBound : erasedCondition originalTarget=.ok erasedConditionTarget := rfl
#print axioms erasedConditionBound
theorem originalFormalPass : formalPass=true := rfl
#print axioms originalFormalPass
end SFT.Physics.HorizonObservationInputProofs
