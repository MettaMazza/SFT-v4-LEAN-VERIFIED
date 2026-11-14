import SFT.Physics.StrongFieldHorizon
namespace SFT.Physics.QuarkDressing
open SFT.Foundation.ExactOperations SFT.Foundation.ExactPartCarrier
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
structure Factors where
 centralDownLift : Rat
 upperUpRetention : Rat

def quarkDressingFactors : Except String Factors := do
 let blocks ← AlphaBlocks.fineStructureBlocks
 let inverse ← AlphaRatio.inverseFineStructure none
 let lift := blocks.up - blocks.down
 let binary ← AlphaCovers.binaryCount
 if lift != binary then throw "central lift and Fold fibre count did not cross-lock"
 let alphaInverse := natRatio inverse.numerator inverse.denominator (Nat.pos_of_ne_zero inverse.denominatorNonzero)
 let central ← LeptonRatios.divide (add alphaInverse (wholeRatio lift)) alphaInverse
 let upper ← LeptonRatios.divide alphaInverse (add alphaInverse (wholeRatio blocks.up))
 pure ⟨central,upper⟩

theorem coverGap : (AlphaBlocks.fineStructureBlocks.map (fun b => b.up-b.down))=.ok 2 := rfl

def originalFactors : Factors :=
 ⟨⟨511199885041,503846395469,by decide,by decide⟩,
  ⟨503846395469,529583608971,by decide,by decide⟩⟩

theorem completeSourceFactors : quarkDressingFactors=.ok originalFactors := rfl

theorem centralLiftAboveOne : (asFraction one).blt originalFactors.centralDownLift=true := rfl

theorem upperRetentionPositive : zero.blt originalFactors.upperUpRetention=true := rfl

theorem upperRetentionBelowOne : originalFactors.upperUpRetention.blt (asFraction one)=true := rfl
end SFT.Physics.QuarkDressing
