import SFT.Physics.SmithionRoots
namespace SFT.Physics.SmithionRoots2
open SmithionRoots LeptonIntervals
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalCompleteRoots : spectrumRootBrackets (.integer (7)) "down" (.integer 60) = .ok [(some (normalize (117024738198375) 1180591620717411303424 (by decide)),(normalize (14628092274797) 147573952589676412928 (by decide))),(some (normalize (172893498686722081059) 1180591620717411303424 (by decide)),(normalize (43223374671680520265) 295147905179352825856 (by decide))),(some (normalize (251924501251487755997) 295147905179352825856 (by decide)),(normalize (1007698005005951023989) 1180591620717411303424 (by decide)))] := rfl
#print axioms originalCompleteRoots
end SFT.Physics.SmithionRoots2
