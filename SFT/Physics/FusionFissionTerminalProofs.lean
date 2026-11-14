import SFT.Physics.FusionFissionTerminal
namespace SFT.Physics.FusionFissionTerminalProofs
open FusionFissionTerminal LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem fusion0 : fusionOperationIsForced "identity" = .ok false := rfl
theorem fusion1 : fusionOperationIsForced "binary-junction" = .ok true := rfl
theorem fusion2 : fusionOperationIsForced "binary-decomposition" = .ok false := rfl
theorem fission0 : fissionOperationIsForced "identity" = .ok false := rfl
theorem fission1 : fissionOperationIsForced "binary-junction" = .ok false := rfl
theorem fission2 : fissionOperationIsForced "binary-decomposition" = .ok true := rfl
theorem direction0 : bindingDirectionIsForced "toward-higher-binding" = .ok true := rfl
theorem direction1 : bindingDirectionIsForced "toward-lower-binding" = .ok false := rfl
theorem barrier0 : barrierIsForced "quarter-One" = .ok false := rfl
theorem barrier1 : barrierIsForced "half-One" = .ok true := rfl
theorem barrier2 : barrierIsForced "three-quarter-One" = .ok false := rfl
theorem barrier3 : barrierIsForced "One" = .ok false := rfl
theorem release0 : releaseAccountingIsForced "complete-held-release" = .ok true := rfl
theorem release1 : releaseAccountingIsForced "unrecorded-release" = .ok false := rfl
theorem target0 : targetBoundaryIsForced "sealed-before-release" = .ok true := rfl
theorem target1 : targetBoundaryIsForced "readable-before-seal" = .ok false := rfl
theorem extension0 : extensionIsForced "empty-extension" = .ok true := rfl
theorem extension1 : extensionIsForced "free-correction" = .ok false := rfl
theorem peak0 : peakClosureIsForced "unique-unbounded-peak" = .ok true := rfl
theorem peak1 : peakClosureIsForced "selected-finite-peak" = .ok false := rfl
def fusionGain : Rat × Rat := (normalize 2926277249829938741248 4328012171030491490769 (by decide),normalize 228620220225888455168 338125106092421744575 (by decide))
theorem fusionGainEvaluated : (do bindingGainEnclosure (← fusionTrace "binary-junction")) = .ok (some fusionGain) := rfl
theorem fusionGainPositive : 0 < fusionGain.1.num := by decide
def fissionGain : Rat × Rat := (normalize 92313110137103492694016 54968911987144862587125 (by decide),normalize 13847735287713655957504 8245342074980990733773 (by decide))
theorem fissionGainEvaluated : (do bindingGainEnclosure (← fissionTrace "binary-decomposition")) = .ok (some fissionGain) := rfl
theorem fissionGainPositive : 0 < fissionGain.1.num := by decide
end SFT.Physics.FusionFissionTerminalProofs
