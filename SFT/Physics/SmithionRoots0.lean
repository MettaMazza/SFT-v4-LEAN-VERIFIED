import SFT.Physics.SmithionRoots
namespace SFT.Physics.SmithionRoots0
open SmithionRoots LeptonIntervals
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem originalCompleteRoots : spectrumRootBrackets (.integer (5)) "down" (.integer 60) = .ok [(some (normalize (30235766713143459) 590295810358705651712 (by decide)),(normalize (60471533426286919) 1180591620717411303424 (by decide))),(some (normalize (172820649824972217329) 1180591620717411303424 (by decide)),(normalize (86410324912486108665) 590295810358705651712 (by decide))),(some (normalize (125963812419876599897) 147573952589676412928 (by decide)),(normalize (1007710499359012799177) 1180591620717411303424 (by decide)))] := rfl
#print axioms originalCompleteRoots
end SFT.Physics.SmithionRoots0
