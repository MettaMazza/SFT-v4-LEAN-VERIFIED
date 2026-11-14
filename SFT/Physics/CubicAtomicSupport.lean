import SFT.Physics.VacuumLedgerProofs
import SFT.Physics.LeptonRatios
namespace SFT.Physics.CubicAtomicSupport
open LeptonIntervals VacuumLedgerProofs
def cubicCoordination : Except String Nat := do
 let binary ← AlphaCovers.binaryCount
 let generator ← FoldFirstReturn.generatorPeriod
 pure (binary*generator)
def cubicNeighbourWeight : Except String Rat := do
 let binary ← AlphaCovers.binaryCount
 let coordination ← cubicCoordination
 LeptonRatios.divide (wholeRatio 1) (wholeRatio (binary*coordination))
def cubicBalance : Except String Rat := do
 let coordination ← cubicCoordination
 let weight ← cubicNeighbourWeight
 pure (multiply (wholeRatio coordination) weight)
theorem completeCoordination : cubicCoordination=.ok 6 := rfl
theorem completeNeighbourWeight : cubicNeighbourWeight=.ok (normalize 1 12 (by decide)) := rfl
theorem completeBalance : cubicBalance=.ok (normalize 1 2 (by decide)) := rfl
end SFT.Physics.CubicAtomicSupport
