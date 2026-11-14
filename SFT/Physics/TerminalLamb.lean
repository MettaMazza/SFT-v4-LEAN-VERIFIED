import SFT.Physics.TerminalMuonAnomaly
namespace SFT.Physics.TerminalLamb
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def exactAlpha : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure none
 LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse)
def depthThreeHeavyComplement : Except String Int := do
 let generator ← FoldFirstReturn.generatorPeriod
 let family ← MassRatioFamily.massRatioFamily (.integer (.ofNat generator))
 if family.heavyOverLight.den != 1 then throw "depth-three heavy complement is not a positive count"
 pure family.heavyOverLight.num
def terminalBinarySupport : Except String Nat := TerminalTurn.terminalTurnSupport
def predecessorUpSupport : Except String Nat := do
 let blocks ← AlphaBlocks.fineStructureBlocks
 let predecessor ← positivePredecessor (.integer (.ofNat blocks.up))
 let binary ← AlphaCovers.binaryCount
 AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat predecessor))
def terminalLambCarrier : Except String Rat := do
 let alpha ← exactAlpha
 let colour ← FoldFirstReturn.generatorPeriod
 let blocks ← AlphaBlocks.fineStructureBlocks
 let heavy ← depthThreeHeavyComplement
 let support ← predecessorUpSupport
 let binary ← AlphaCovers.binaryCount
 let bridge := Int.ofNat binary*heavy+Int.ofNat colour
 let leading ← LeptonRatios.divide (normalize heavy 1 (by decide)) (wholeRatio support)
 let firstWeight ← LeptonRatios.divide (wholeRatio (binary*blocks.down)) (normalize bridge 1 (by decide))
 let firstReturn := multiply firstWeight alpha
 let square := (List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let cube := (List.range colour).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let secondReturn ← LeptonRatios.divide square (normalize (Int.ofNat colour*heavy*Int.ofNat support) 1 (by decide))
 let terminalReturn ← LeptonRatios.divide cube (normalize (heavy*Int.ofNat support) 1 (by decide))
 let retained ← RunningConvergence.positiveTake leading firstReturn
 let retained ← RunningConvergence.positiveTake retained secondReturn
 let retained ← RunningConvergence.positiveTake retained terminalReturn
 let result := multiply cube retained
 let expectedFirst ← RunningConvergence.positiveTake (normalize 53 64 (by decide)) (multiply (normalize 10 109 (by decide)) alpha)
 let expectedSecond ← RunningConvergence.positiveTake expectedFirst (← LeptonRatios.divide (multiply alpha alpha) (wholeRatio (3*53*64)))
 let expectedThird ← RunningConvergence.positiveTake expectedSecond (← LeptonRatios.divide (multiply (multiply alpha alpha) alpha) (wholeRatio (53*64)))
 let expected := multiply (multiply (multiply alpha alpha) alpha) expectedThird
 if !(result == expected) then throw "terminal Lamb carrier routes disagree"
 pure result
theorem heavyComplementComplete : depthThreeHeavyComplement=.ok 53 := rfl
theorem predecessorSupportComplete : predecessorUpSupport=.ok 64 := rfl
theorem binarySupportComplete : terminalBinarySupport=.ok 16 := rfl
def terminalLambExpected : Rat := normalize 729362090351873829404169174186118182778940082180699933485077304755943 2268310718538302656048786406607447143222718581718034472517872248199509059288 (by decide)
theorem terminalLambComplete : terminalLambCarrier=.ok terminalLambExpected := rfl
end SFT.Physics.TerminalLamb
