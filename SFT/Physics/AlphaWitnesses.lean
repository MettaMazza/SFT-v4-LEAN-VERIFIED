import SFT.Physics.AlphaRatio
namespace SFT.Physics.AlphaWitnesses
open AlphaBlocks AlphaPromotion AlphaRatio
set_option maxRecDepth 20000
structure Witness where
 name : String
 statement : String
 passed : Bool

def blocksCheck : Bool := match fineStructureBlocks with
 | .error _ => false
 | .ok b => b.binary == 2 && b.generator == 3 && b.down == 5 && b.up == 7 && b.tower == 128 && b.boundary == 9 && b.cover == 250

def ladderCheck : Bool := match promotionRungs with
 | .error _ => false
 | .ok rungs => rungs == [125,175,245,343]

def pairCheck (result : Except String (Nat × Nat)) (expected : Nat × Nat) : Bool := match result with
 | .error _ => false
 | .ok pair => pair == expected

def terminalCheck : Bool := pairCheck (outputPair (inverseFineStructure (some (.integer 1)))) (34259,250) &&
 pairCheck (outputPair (inverseFineStructure none)) (503846395469,3676744786)

def witnesses : List Witness := [⟨"forced-blocks","The clean construction yields b=2, c=3, down=5, up=7, tower=128, boundary=9 and cover=250.",blocksCheck⟩,⟨"finite-ladder","The complete direction-promotion ladder has rungs 125, 175, 245 and 343.",ladderCheck⟩,⟨"exact-terminal","The first and terminal exact ratios reconstruct without observation.",terminalCheck⟩]

theorem blocksCheckPassed : blocksCheck = true := by
 unfold blocksCheck
 rw [forcedBlocks]
 rfl

theorem ladderCheckPassed : ladderCheck = true := by
 unfold ladderCheck
 rw [forcedRungs]
 rfl

theorem terminalCheckPassed : terminalCheck = true := by
 unfold terminalCheck
 rw [leadingRatio,terminalRatio]
 rfl

theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (blocksCheck && (ladderCheck && (terminalCheck && true))) = true
 rw [blocksCheckPassed,ladderCheckPassed,terminalCheckPassed]
 rfl
end SFT.Physics.AlphaWitnesses
