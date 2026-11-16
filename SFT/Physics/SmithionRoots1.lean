import SFT.Physics.SmithionRoots
namespace SFT.Physics.SmithionRoots1
open SmithionRoots LeptonIntervals
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalCompleteRoots : spectrumRootBrackets (.integer (5)) "up" (.integer 60) = .ok [(some (normalize (1208950653683681) 1180591620717411303424 (by decide)),(normalize (604475326841841) 590295810358705651712 (by decide))),(some (normalize (15579476635683129833) 295147905179352825856 (by decide)),(normalize (62317906542732519333) 1180591620717411303424 (by decide))),(some (normalize (559136252612012550205) 590295810358705651712 (by decide)),(normalize (1118272505224025100411) 1180591620717411303424 (by decide)))] := rfl
#print axioms originalCompleteRoots
end SFT.Physics.SmithionRoots1
