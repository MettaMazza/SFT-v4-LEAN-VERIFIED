import SFT.Physics.ParticleModeFibres
import SFT.Physics.UnifiedConstantsHelpers
namespace SFT.Physics.ParticleModeCover
open GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Cover where
 factor : Nat
 volume : Nat
 depth : Nat
 priorCapacity : Nat
 capacity : Nat
 minimal : Bool

def sourceDepth (base volume : Nat) (hb : 2≤base) : Nat :=
 (UnifiedConstantsHelpers.coverBounded volume base hb volume 1 base
  (Nat.lt_of_lt_of_le (by decide) hb) (Nat.le_add_left volume base)).val

def leastCoverDepth (factor stateVolume : CountInput) : Except String Cover := do
 let base ← SpinStatisticsCondensation.positiveWhole factor "sector Fold factor"
 let volume ← SpinStatisticsCondensation.positiveWhole stateVolume "state volume"
 if hb : base<2 then throw "sector Fold factor must be nontrivial"
 else
  let depth := sourceDepth base volume (Nat.le_of_not_gt hb)
  let prior := base^(depth-1)
  let current := base^depth
  pure ⟨base,volume,depth,prior,current,decide (prior<volume) && decide (volume≤current)⟩
theorem originalTrackedStart (base : Nat) : (base^(1-1),base^1)=(1,base) := by
 change (1,1*base)=(1,base)
 rw [Nat.one_mul]
theorem originalTrackedSuccessor (base depth : Nat) :
 (base^((depth+1)-1),base^(depth+1))=(base^depth,base^depth*base) := by
 rw [Nat.pow_succ];rfl
theorem originalLeastPositiveDepth (base volume : Nat) (hb : 2≤base) :
 0<sourceDepth base volume hb ∧ volume≤base^(sourceDepth base volume hb) ∧
 ∀ k,0<k → k<sourceDepth base volume hb → base^k<volume :=
 UnifiedConstantsHelpers.arbitraryBinaryCover volume base hb

theorem originalPriorStrict (base volume : Nat) (hb : 2≤base) (hv : 1<volume) :
 base^(sourceDepth base volume hb-1)<volume := by
 obtain ⟨positive,covered,least⟩ := originalLeastPositiveDepth base volume hb
 generalize hd : sourceDepth base volume hb = d at positive covered least ⊢
 cases d with
 | zero => cases positive
 | succ d =>
  cases d with
  | zero => exact hv
  | succ k => exact least (k+1) (Nat.zero_lt_succ _) (Nat.lt_succ_self _)
theorem originalBinaryCover : leastCoverDepth (.integer 2) (.integer 27)=.ok ⟨2,27,5,16,32,true⟩ := rfl
theorem originalColourCover : leastCoverDepth (.integer 3) (.integer 27)=.ok ⟨3,27,3,9,27,true⟩ := rfl
theorem originalOneVolume : leastCoverDepth (.integer 2) (.integer 1)=.ok ⟨2,1,1,1,2,false⟩ := rfl
#print axioms leastCoverDepth
#print axioms originalTrackedStart
#print axioms originalTrackedSuccessor
#print axioms originalLeastPositiveDepth
#print axioms originalPriorStrict
#print axioms originalBinaryCover
#print axioms originalColourCover
#print axioms originalOneVolume
end SFT.Physics.ParticleModeCover
