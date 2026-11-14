import SFT.Physics.MatterIdentityGraphs
namespace SFT.Physics.NeutrinoLadder
open GeneratorOperations LeptonIntervals VacuumLedgerProofs VacuumScaleProofs

def mersenneCount (depth : CountInput) : Except String Nat := do
 let b ← AlphaCovers.binaryCount
 let power ← AlphaCovers.positivePower (.integer (.ofNat b)) depth
 positivePredecessor (.integer (.ofNat power))

structure Splitting where
 solarRung : Nat
 atmosphericRung : Nat
 rungRatio : Rat
 translationRatio : Rat

def neutrinoSplittingStructure : Except String Splitting := do
 let blocks ← AlphaBlocks.fineStructureBlocks
 let depth := blocks.down
 let doubled := depth+depth
 let solar ← mersenneCount (.integer (.ofNat depth))
 let atmospheric ← mersenneCount (.integer (.ofNat doubled))
 let ratio ← LeptonRatios.divide (wholeRatio atmospheric) (wholeRatio solar)
 let b ← AlphaCovers.binaryCount
 let c ← FoldFirstReturn.generatorPeriod
 let coveringPrime := b+c
 let square := coveringPrime*coveringPrime
 let predecessor ← positivePredecessor (.integer (.ofNat square))
 let support ← AlphaCovers.positivePower (.integer (.ofNat b)) (.integer (.ofNat depth))
 let cell ← LeptonRatios.divide (wholeRatio 1) (wholeRatio support)
 let squarePart ← LeptonRatios.divide (wholeRatio predecessor) (wholeRatio square)
 let translation := multiply cell squarePart
 let expectedSupport ← AlphaCovers.positivePower (.integer (.ofNat b)) (.integer (.ofNat depth))
 if !(decide (ratio=wholeRatio (expectedSupport+1))) || !(decide (translation=(⟨3,100,by decide,by decide⟩ : Rat))) then
  throw "neutrino splitting routes disagree"
 pure ⟨solar,atmospheric,ratio,translation⟩

def originalSplitting : Splitting :=
 ⟨31,1023,⟨33,1,by decide,by decide⟩,⟨3,100,by decide,by decide⟩⟩

theorem completeSplitting : neutrinoSplittingStructure=.ok originalSplitting := rfl

theorem countRatioCrossLock : 1023=31*(32+1) := rfl

theorem exactTranslation : multiply (⟨1,32,by decide,by decide⟩ : Rat) ⟨24,25,by decide,by decide⟩=originalSplitting.translationRatio := rfl

structure MassSquares where
 lightest : Rat
 middle : Rat
 heavy : Rat

def neutrinoMassSquares : Except String MassSquares := do
 let blocks ← AlphaBlocks.fineStructureBlocks
 let b ← AlphaCovers.binaryCount
 let support ← AlphaCovers.positivePower (.integer (.ofNat b)) (.integer (.ofNat blocks.down))
 let lightest ← LeptonRatios.divide (wholeRatio 1) (wholeRatio support)
 let middle := add lightest (wholeRatio 1)
 let splitting ← neutrinoSplittingStructure
 let reciprocal ← LeptonRatios.divide (wholeRatio 1) splitting.translationRatio
 let heavy := add lightest reciprocal
 if !(zero.blt lightest && lightest.blt middle && middle.blt heavy) then
  throw "positive neutrino mass-square ordering failed"
 pure ⟨lightest,middle,heavy⟩

def originalMassSquares : MassSquares :=
 ⟨⟨1,32,by decide,by decide⟩,⟨33,32,by decide,by decide⟩,⟨3203,96,by decide,by decide⟩⟩

theorem completeMassSquares : neutrinoMassSquares=.ok originalMassSquares := rfl

theorem strictPositiveOrdering : zero.blt originalMassSquares.lightest=true ∧
 originalMassSquares.lightest.blt originalMassSquares.middle=true ∧
 originalMassSquares.middle.blt originalMassSquares.heavy=true := ⟨rfl,rfl,rfl⟩
end SFT.Physics.NeutrinoLadder
