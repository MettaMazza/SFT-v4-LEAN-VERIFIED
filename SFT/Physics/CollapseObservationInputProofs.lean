import SFT.Physics.CollapseObservationValidation
import SFT.Physics.CollapseObservationAnalysisProofs
namespace SFT.Physics.CollapseObservationInputProofs
open CollapseObservationValidation CollapseObservationAnalysisProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem erasedStageBound : erasedStage originalTarget=.ok erasedStageTarget := rfl
#print axioms erasedStageBound
theorem hiddenIrregularityBound : hiddenIrregularity originalTarget=.ok hiddenIrregularityTarget := rfl
#print axioms hiddenIrregularityBound
theorem erasedDetectorBound : erasedDetector originalTarget=.ok erasedDetectorTarget := rfl
#print axioms erasedDetectorBound
theorem outsideRatioBound : outsideRatio originalTarget=.ok outsideRatioTarget := rfl
#print axioms outsideRatioBound
theorem erasedCaptureBound : erasedCapture originalTarget=.ok erasedCaptureTarget := rfl
#print axioms erasedCaptureBound
theorem originalFormalPass : formalPass=true := rfl
#print axioms originalFormalPass
end SFT.Physics.CollapseObservationInputProofs
