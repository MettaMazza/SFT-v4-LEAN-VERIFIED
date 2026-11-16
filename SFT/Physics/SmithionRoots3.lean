import SFT.Physics.SmithionRoots
namespace SFT.Physics.SmithionRoots3
open SmithionRoots LeptonIntervals
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalCompleteRoots : spectrumRootBrackets (.integer (7)) "up" (.integer 60) = .ok [(some (normalize (1194129051641) 1180591620717411303424 (by decide)),(normalize (597064525821) 590295810358705651712 (by decide))),(some (normalize (43788083075121748877) 1180591620717411303424 (by decide)),(normalize (21894041537560874439) 590295810358705651712 (by decide))),(some (normalize (1136803536448160502905) 1180591620717411303424 (by decide)),(normalize (568401768224080251453) 590295810358705651712 (by decide)))] := rfl
#print axioms originalCompleteRoots
end SFT.Physics.SmithionRoots3
