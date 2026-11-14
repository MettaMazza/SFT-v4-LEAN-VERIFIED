import SFT.Physics.VacuumLedgerProofs
import SFT.Physics.LeptonRatios
namespace SFT.Physics.AtomicCorrections
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 20000
def grossAtomicScale : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let alpha ← LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse)
 let binary ← AlphaCovers.binaryCount
 let power := (List.range binary).foldl (fun q _ => multiply q alpha) (wholeRatio 1)
 LeptonRatios.divide power (wholeRatio binary)
def fineToGrossRatio : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let alpha ← LeptonRatios.divide (wholeRatio 1) (BoundaryGrowth.asFraction inverse)
 let binary ← AlphaCovers.binaryCount
 pure ((List.range binary).foldl (fun q _ => multiply q alpha) (wholeRatio 1))
def lambToGrossOrder : Except String Rat := fineToGrossRatio
structure Hierarchy where
 gross : Rat
 fine : Rat
 lamb : Rat
def atomicScaleHierarchy : Except String Hierarchy := do
 let fine ← fineToGrossRatio
 let order ← lambToGrossOrder
 pure ⟨wholeRatio 1,fine,multiply fine order⟩
def grossAtomicScaleExpected : Rat := normalize 6759226110689092898 253861190227103943729961 (by decide)
theorem grossAtomicScaleComplete : grossAtomicScale=.ok grossAtomicScaleExpected := rfl
def fineToGrossRatioExpected : Rat := normalize 13518452221378185796 253861190227103943729961 (by decide)
theorem fineToGrossRatioComplete : fineToGrossRatio=.ok fineToGrossRatioExpected := rfl
def lambToGrossOrderExpected : Rat := normalize 13518452221378185796 253861190227103943729961 (by decide)
theorem lambToGrossOrderComplete : lambToGrossOrder=.ok lambToGrossOrderExpected := rfl
def originalHierarchy : Hierarchy := ⟨normalize 1 1 (by decide),normalize 13518452221378185796 253861190227103943729961 (by decide),normalize 182748550461684806068916730328296153616 64445503903521854869538077484881292205289061521 (by decide)⟩
theorem completeHierarchy : atomicScaleHierarchy=.ok originalHierarchy := rfl
theorem generatedGrossFineRelation : multiply grossAtomicScaleExpected (wholeRatio 2)=fineToGrossRatioExpected := rfl
theorem firstCompleteReturn : multiply originalHierarchy.fine originalHierarchy.fine=originalHierarchy.lamb := rfl
theorem orderedHierarchy : originalHierarchy.lamb.blt originalHierarchy.fine=true ∧ originalHierarchy.fine.blt originalHierarchy.gross=true := ⟨rfl,rfl⟩
end SFT.Physics.AtomicCorrections
