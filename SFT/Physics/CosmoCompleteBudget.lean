import SFT.Physics.CosmicRatios
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.CosmoCompleteBudget
set_option maxRecDepth 20000
open AlphaCovers GeneratorOperations FoldFirstReturn AlphaBlocks LeptonIntervals

structure Budget where
 depth : Nat
 support : Nat
 pinned : Nat
 free : Nat
 matter : Rat
 vacuum : Rat
 baryonWithinMatter : Rat
 darkWithinMatter : Rat
 baryon : Rat
 coldDark : Rat

def cosmicBudgetStructure : Except String Budget := do
 let binary ← binaryCount
 let generator ← generatorPeriod
 let blocks ← fineStructureBlocks
 let depth := blocks.down
 let support ← positivePower (.integer (.ofNat binary)) (.integer (.ofNat depth))
 if positive : 0 < support then
  let pinned := binary*depth
  let free := support-pinned
  let matter := normalize (.ofNat pinned) support positive
  let vacuum := normalize (.ofNat free) support positive
  let baryonWithin := normalize (.ofNat depth) support positive
  let darkWithin := normalize (.ofNat (generator^generator)) support positive
  .ok ⟨depth,support,pinned,free,matter,vacuum,baryonWithin,darkWithin,
       multiply matter baryonWithin,multiply matter darkWithin⟩
 else .error "positive power must retain positive support"

def pair (q : Rat) := (q.num,q.den)
def record (b : Budget) := (b.depth,b.support,b.pinned,b.free,
 pair b.matter,pair b.vacuum,pair b.baryonWithinMatter,pair b.darkWithinMatter,pair b.baryon,pair b.coldDark)

theorem exactTenFields : cosmicBudgetStructure.map record =
 .ok (5,32,10,22,(5,16),(11,16),(5,32),(27,32),(25,512),(135,512)) := rfl

theorem supportPartition : cosmicBudgetStructure.map (fun b => decide (b.pinned+b.free=b.support)) = .ok true := rfl

def globalClosure : Bool := match cosmicBudgetStructure with
 | .error _ => false
 | .ok b => add b.matter b.vacuum == normalize 1 1 (by decide)
def matterClosure : Bool := match cosmicBudgetStructure with
 | .error _ => false
 | .ok b => add b.baryon b.coldDark == b.matter

theorem globalClosurePassed : globalClosure=true := rfl
theorem matterClosurePassed : matterClosure=true := rfl

def boundaryPairs : Nat → Nat
 | 0 => 0
 | n+1 => boundaryPairs n+2

theorem boundaryPairsExactly (n : Nat) : boundaryPairs n=2*n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change boundaryPairs n+2=2*n+2
  exact congrArg (fun k => k+2) ih

theorem completeBoundaryCount : boundaryPairs 5=10 := rfl

theorem inheritedWithinMatter : cosmicBudgetStructure.map (fun b => (pair b.baryonWithinMatter,pair b.darkWithinMatter)) =
 CosmicRatios.darkBaryonStructure.map (fun b => ((Int.ofNat b.baryonShare.numerator,b.baryonShare.denominator),(Int.ofNat b.darkShare.numerator,b.darkShare.denominator))) := rfl

end SFT.Physics.CosmoCompleteBudget
