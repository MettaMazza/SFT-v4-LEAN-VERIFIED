import SFT.Physics.NuclearBindingRadius
namespace SFT.Physics.NuclearBindingTail
open LeptonIntervals VacuumLedgerProofs GeneratorOperations NuclearBindingCurve NuclearBindingRadius
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def tailCutoffMass : Except String Nat := do
 let blocks ← AlphaBlocks.fineStructureBlocks
 let binary ← AlphaCovers.binaryCount
 AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat (blocks.down+blocks.up)))
structure Bounds where
 cutoffMass : Nat
 cutoffRadius : Int
 lowChargeUpper : Rat
 highChargeUpper : Rat
 coulombTailSuccessorMonotone : Bool
def tailUpperBounds : Except String Bounds := do
 let cutoff ← tailCutoffMass
 let radii ← exactCubeRootEnclosure (.integer (.ofNat cutoff)) (.integer 1)
 if !(radii.1 == radii.2) then throw "forced tail cutoff lacks an exact cubic radius"
 let asym ← asymmetryShare
 let pairing ← pairingShare
 let lowAsymmetry := multiply asym (normalize 9 25 (by decide))
 let maxPairing ← LeptonRatios.divide (← LeptonRatios.divide pairing (wholeRatio cutoff)) radii.1
 let lowUpper := add (← RunningConvergence.positiveTake (wholeRatio 1) lowAsymmetry) maxPairing
 let blocks ← AlphaBlocks.fineStructureBlocks
 let leastCharge := cutoff/blocks.down+1
 let previous ← positivePredecessor (.integer (.ofNat leastCharge))
 let paths := leastCharge*previous
 let alpha ← electromagneticShare
 let highCoulomb ← LeptonRatios.divide (multiply alpha (← LeptonRatios.divide (wholeRatio paths) (wholeRatio cutoff))) radii.1
 let highUpper := add (← RunningConvergence.positiveTake (wholeRatio 1) highCoulomb) maxPairing
 let binary ← AlphaCovers.binaryCount
 let generator ← FoldFirstReturn.generatorPeriod
 let monotone := binary*cutoff*cutoff > binary*binary*generator*cutoff+14
 pure ⟨cutoff,radii.1.num,lowUpper,highUpper,monotone⟩
theorem forcedCutoff : tailCutoffMass = .ok 4096 := rfl
end SFT.Physics.NuclearBindingTail
