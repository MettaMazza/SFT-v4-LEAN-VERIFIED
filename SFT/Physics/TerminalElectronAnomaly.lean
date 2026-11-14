import SFT.Physics.TerminalTurn
import SFT.Physics.RunningConvergence
namespace SFT.Physics.TerminalElectronAnomaly
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def electronLoopCarrier : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let alpha ← LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse)
 let colour ← FoldFirstReturn.generatorPeriod
 let volume ← AlphaCovers.positivePower (.integer (.ofNat colour)) (.integer (.ofNat colour))
 let openBulk ← RunningConvergence.positiveTake (wholeRatio volume) (wholeRatio colour)
 let blocks ← AlphaBlocks.fineStructureBlocks
 let binary ← AlphaCovers.binaryCount
 let firstHeld ← LeptonRatios.divide (wholeRatio blocks.down) (normalize openBulk.num 1 (by decide))
 let firstWeight ← LeptonRatios.divide (wholeRatio binary) (wholeRatio (blocks.down*colour))
 let firstReturn := multiply firstWeight alpha
 let secondWeight ← LeptonRatios.divide (wholeRatio 1) (wholeRatio (blocks.down*colour))
 let secondHeld := multiply secondWeight (multiply alpha alpha)
 let terminalWeight ← LeptonRatios.divide (wholeRatio blocks.up) (wholeRatio (volume+colour))
 let terminalReturn := multiply terminalWeight (multiply (multiply alpha alpha) alpha)
 let firstPair ← RunningConvergence.positiveTake firstHeld firstReturn
 let secondPair ← RunningConvergence.positiveTake secondHeld terminalReturn
 if !(add firstPair firstReturn == firstHeld) then throw "electron first held/return pair failed to recompose"
 if !(add secondPair terminalReturn == secondHeld) then throw "electron terminal held/return pair failed to recompose"
 let carrier := add firstPair secondPair
 if !(carrier == add firstPair secondPair) then throw "electron radiative carrier routes disagree"
 pure carrier
def electronAnomalyRetention : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let alpha ← LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse)
 let loop ← electronLoopCarrier
 RunningConvergence.positiveTake (wholeRatio 1) (multiply alpha loop)
def terminalElectronAnomaly : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let alpha ← LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse)
 let binary ← AlphaCovers.binaryCount
 let turn ← TerminalTurn.terminalTurnProjection
 let leading ← LeptonRatios.divide alpha (multiply (wholeRatio binary) turn)
 let retention ← electronAnomalyRetention
 pure (multiply leading retention)
def electronLoopCarrierExpected : Rat := normalize 3182795114292575489155907760862130413 15348845477447574186616254353993605080 (by decide)
theorem electronLoopCarrierComplete : electronLoopCarrier = .ok electronLoopCarrierExpected := rfl
def electronAnomalyRetentionExpected : Rat := normalize 3860879071540620541668151957392454145886918802951 3866730234211311292172284649092877532317343691260 (by decide)
theorem electronAnomalyRetentionComplete : electronAnomalyRetention = .ok electronAnomalyRetentionExpected := rfl
def terminalElectronAnomalyExpected : Rat := normalize 802043885254987612353732350015309596419810381071082962486959 691624522219221826633260329062771192166997958003333260609833700 (by decide)
theorem terminalElectronAnomalyComplete : terminalElectronAnomaly = .ok terminalElectronAnomalyExpected := rfl
end SFT.Physics.TerminalElectronAnomaly
