import SFT.Physics.TerminalElectronAnomaly
import SFT.Physics.MassRatioFamily
namespace SFT.Physics.TerminalMuonAnomaly
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def muonGenerationCorrection : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let alpha ← LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse)
 let binary ← AlphaCovers.binaryCount
 let generator ← FoldFirstReturn.generatorPeriod
 let depthTwo ← MassRatioFamily.massRatioFamily (.integer (.ofNat binary))
 let depthThree ← MassRatioFamily.massRatioFamily (.integer (.ofNat generator))
 if depthTwo.heavyOverLight.den != 1 then throw "muon depth-two complement is not a whole count"
 if depthThree.heavyOverLight.den != 1 then throw "muon depth-three complement is not a whole count"
 let first ← LeptonRatios.divide (wholeRatio binary) (normalize depthTwo.heavyOverLight.num 1 (by decide))
 let successor ← LeptonRatios.divide alpha (normalize (Int.ofNat binary*depthThree.heavyOverLight.num) 1 (by decide))
 let support ← TerminalTurn.terminalTurnSupport
 let blocks ← AlphaBlocks.fineStructureBlocks
 let terminalDenominator := Int.ofNat support*depthThree.heavyOverLight.num+Int.ofNat blocks.down
 let square := multiply alpha alpha
 let terminal ← LeptonRatios.divide square (normalize terminalDenominator 1 (by decide))
 let correction := multiply square (add (add first successor) terminal)
 if !(@decide (terminalDenominator = 853) (Int.decEq terminalDenominator 853)) then throw "muon terminal generation support changed"
 pure correction
def terminalMuonAnomaly : Except String Rat := do
 let electron ← TerminalElectronAnomaly.terminalElectronAnomaly
 let correction ← muonGenerationCorrection
 pure (add electron correction)
def muonGenerationCorrectionExpected : Rat := normalize 310479169992349922722961830242428547204076304956 49529785361563432125548098065237971768251524099149113 (by decide)
theorem muonGenerationCorrectionComplete : muonGenerationCorrection = .ok muonGenerationCorrectionExpected := rfl
def terminalMuonAnomalyExpected : Rat := normalize 619745274311623050916605735634604124523304559300692711407964753527 531550101425149592524472125682179988053522781617335787441469519636100 (by decide)
theorem terminalMuonAnomalyComplete : terminalMuonAnomaly = .ok terminalMuonAnomalyExpected := rfl
end SFT.Physics.TerminalMuonAnomaly
