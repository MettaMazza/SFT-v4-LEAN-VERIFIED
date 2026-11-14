import SFT.Physics.VacuumLedgerProofs
import SFT.Physics.LeptonRatios
import SFT.Physics.AlphaRatio
namespace SFT.Physics.TerminalTurn
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
def terminalTurnSupport : Except String Nat := do
 let binary ← AlphaCovers.binaryCount
 let rungs ← AlphaPromotion.promotionRungs
 AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat rungs.length))
def terminalTurnProjection : Except String Rat := do
 let generator ← FoldFirstReturn.generatorPeriod
 let blocks ← AlphaBlocks.fineStructureBlocks
 let support ← terminalTurnSupport
 let terminal ← LeptonRatios.divide (wholeRatio 1) (wholeRatio support)
 let residue ← LeptonRatios.divide (wholeRatio 1) (add (wholeRatio blocks.up) terminal)
 pure (add (wholeRatio generator) residue)
theorem completeSupport : terminalTurnSupport = .ok 16 := rfl
theorem completeProjection : terminalTurnProjection = .ok (normalize 355 113 (by decide)) := rfl
theorem exactReturn : add (wholeRatio 3) (normalize 16 113 (by decide)) = normalize 355 113 (by decide) := rfl
end SFT.Physics.TerminalTurn
