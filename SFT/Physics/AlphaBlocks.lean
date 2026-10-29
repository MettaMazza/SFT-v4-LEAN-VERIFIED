import SFT.Physics.AlphaCovers
namespace SFT.Physics.AlphaBlocks
open AlphaCovers GeneratorOperations FoldFirstReturn
set_option maxRecDepth 20000

structure Blocks where
 binary : Nat
 generator : Nat
 down : Nat
 up : Nat
 tower : Nat
 boundary : Nat
 cover : Nat

def fineStructureBlocks : Except String Blocks := do
 let b ← binaryCount
 let c ← generatorPeriod
 let generationalVolume ← positivePower (.integer (.ofNat c)) (.integer (.ofNat c))
 let successorVolume ← positivePower (.integer (.ofNat c)) (.integer (.ofNat (c+1)))
 let down ← minimalBinaryCover (.integer (.ofNat generationalVolume))
 let up ← minimalBinaryCover (.integer (.ofNat successorVolume))
 if down != b+c || up != c+(c+1) then
   .error "ValueError: independent cover and generator decompositions failed to cross-lock"
 else
   let tower ← positivePower (.integer (.ofNat b)) (.integer (.ofNat up))
   let boundary ← positivePower (.integer (.ofNat c)) (.integer (.ofNat b))
   let product ← positivePower (.integer (.ofNat down)) (.integer (.ofNat c))
   .ok ⟨b,c,down,up,tower,boundary,b*product⟩

theorem forcedBlocks : fineStructureBlocks = .ok ⟨2,3,5,7,128,9,250⟩ := by
 unfold fineStructureBlocks
 rw [binaryCountTwo,generatorPeriodThree]
 rfl

theorem downMinimal : 27 ≤ 2^5 ∧ ∀ k, 0 < k → k < 5 → 2^k < 27 := by
 have h := (leastPositiveCover 27).2
 rw [downCover] at h
 exact h

theorem upMinimal : 81 ≤ 2^7 ∧ ∀ k, 0 < k → k < 7 → 2^k < 81 := by
 have h := (leastPositiveCover 81).2
 rw [upCover] at h
 exact h

theorem coverCrosslock : coverDepth 27 = 2+3 ∧ coverDepth 81 = 3+(3+1) :=
 ⟨downCover,upCover⟩

theorem boundaryCrosslock : BoundarySupport.boundaryRank = .ok 2 ∧
 positivePower (.integer 3) (.integer 2) = .ok 9 := ⟨BoundarySupport.boundaryRankTwo,rfl⟩

theorem nativeBlockDerivation :
 fineStructureBlocks = .ok ⟨2,3,5,7,128,9,250⟩ ∧
 (27 ≤ 2^5 ∧ ∀ k, 0 < k → k < 5 → 2^k < 27) ∧
 (81 ≤ 2^7 ∧ ∀ k, 0 < k → k < 7 → 2^k < 81) :=
 ⟨forcedBlocks,downMinimal,upMinimal⟩
end SFT.Physics.AlphaBlocks
