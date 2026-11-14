import SFT.Physics.TerminalLamb
import SFT.Physics.AtomicBoundary
namespace SFT.Physics.TerminalFine
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def terminalFineCarrier : Except String Rat := do
 let alpha ← TerminalLamb.exactAlpha
 let binary ← AlphaCovers.binaryCount
 let colour ← FoldFirstReturn.generatorPeriod
 let blocks ← AlphaBlocks.fineStructureBlocks
 let turn ← TerminalTurn.terminalTurnProjection
 let downSupport ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat blocks.down))
 let boundary ← AlphaCovers.positivePower (.integer (.ofNat colour)) (.integer (.ofNat binary))
 let endpoint ← AtomicBoundary.atomicEndpoint
 let binarySquared ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat binary))
 let initial := add (wholeRatio 1) (← LeptonRatios.divide alpha (wholeRatio binarySquared))
 let square := (List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let cube := (List.range colour).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let fourth := (List.range (binary*binary)).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let second := multiply (← LeptonRatios.divide (wholeRatio turn.den) (wholeRatio (downSupport*boundary))) square
 let third ← LeptonRatios.divide cube (wholeRatio downSupport)
 let terminal := multiply (← LeptonRatios.divide (wholeRatio (binary*blocks.down)) (wholeRatio endpoint)) fourth
 let retained ← RunningConvergence.positiveTake initial second
 let retained ← RunningConvergence.positiveTake retained third
 let retained ← RunningConvergence.positiveTake retained terminal
 let support ← TerminalLamb.terminalBinarySupport
 let result := multiply (← LeptonRatios.divide square (wholeRatio support)) retained
 let a2 := multiply alpha alpha
 let a3 := multiply a2 alpha
 let a4 := multiply a3 alpha
 let e0 := add (wholeRatio 1) (← LeptonRatios.divide alpha (wholeRatio 4))
 let e1 ← RunningConvergence.positiveTake e0 (multiply (normalize 113 288 (by decide)) a2)
 let e2 ← RunningConvergence.positiveTake e1 (← LeptonRatios.divide a3 (wholeRatio 32))
 let e3 ← RunningConvergence.positiveTake e2 (multiply (normalize 10 137 (by decide)) a4)
 let expected := multiply (← LeptonRatios.divide a2 (wholeRatio 16)) e3
 if !(result == expected) then throw "terminal fine carrier routes disagree"
 pure result
def terminalFineExpected : Rat := normalize 2152262216955606756832553512106074315750645618246817848702913359852529 645508537524142213353679219744269188758551038314773874471071832445904949536 (by decide)
theorem terminalFineComplete : terminalFineCarrier=.ok terminalFineExpected := rfl
end SFT.Physics.TerminalFine
