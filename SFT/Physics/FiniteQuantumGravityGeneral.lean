import SFT.Physics.FiniteQuantumGravity
namespace SFT.Physics.FiniteQuantumGravityGeneral
open FiniteQuantumGravity LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation FractionReduction
open SFT.Mathematics.DyadicClosure (weights total completeLedger weightSuccessor)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
private theorem floorValue (support : Nat) (positive : 0<support) :
 LeptonRatios.divide FiniteQuantumGravity.one (wholeRatio support)=
 .ok (natRatio 1 support positive) := by
 rw [← natRatioWhole]
 change LeptonRatios.divide (natRatio 1 1 (by decide)) (natRatio support 1 (by decide))=_
 rw [divideNormalized 1 1 support 1 (by decide) positive (by decide)]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.one_mul]
private theorem quarterValue (support : Nat) :
 LeptonRatios.divide (wholeRatio support) (wholeRatio 4)=.ok (natRatio support 4 (by decide)) := by
 rw [← natRatioWhole,← natRatioWhole]
 rw [divideNormalized _ _ _ _ (by decide) (by decide) (by decide),Nat.mul_one]
private theorem equalSelf (q : Rat) : SFT.Mathematics.LimitComputations.equalRat q q=true := by
 unfold SFT.Mathematics.LimitComputations.equalRat SFT.Mathematics.LimitComputations.equalInt
 have same (n : Nat) : (n==n)=true := CommonRefinement.naturalEqualityReflexive n
 cases q.num with
 | ofNat n => change (n==n && q.den==q.den)=true; rw [same,same]; rfl
 | negSucc n => change (n==n && q.den==q.den)=true; rw [same,same]; rfl

theorem originalQuarterArea (support : Nat) :
 multiply (natRatio support 4 (by decide)) (wholeRatio 4)=wholeRatio support := by
 rw [← natRatioWhole 4,multiplyNormalized]
 rw [← natRatioWhole support]
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.mul_one]

theorem originalEveryDepth (n : Nat) : finiteQuantumGravityModel (.integer (.ofNat (n+1)))=
 .ok ⟨"single-finite-Fold-lattice",n+1,3,4,2,10,4,4,2,emptyOne,FiniteQuantumGravity.one,
  2^(n+1),natRatio 1 (2^(n+1)) (Nat.pow_pos (by decide)),
  natRatio (total (weights (n+1))) (2^(n+1)) (Nat.pow_pos (by decide)),
  2^(n+1),natRatio (2^(n+1)) 4 (by decide),true,emptyOne,false⟩ := by
 unfold finiteQuantumGravityModel LatticeOperator.positiveCount
 dsimp only
 rw [if_pos (Nat.zero_lt_succ n)]
 change (do
  let floor ← LeptonRatios.divide FiniteQuantumGravity.one (wholeRatio (doubleSupport (n+1) 1))
  let records ← LeptonRatios.divide (wholeRatio (doubleSupport (n+1) 1)) (wholeRatio 4)
  let loops ← finiteLoopSum (.integer (.ofNat (n+1)))
  pure (⟨"single-finite-Fold-lattice",n+1,3,4,2,10,4,4,2,emptyOne,FiniteQuantumGravity.one,
   doubleSupport (n+1) 1,floor,loops,doubleSupport (n+1) 1,records,
   SFT.Mathematics.LimitComputations.equalRat (multiply records (wholeRatio 4)) (wholeRatio (doubleSupport (n+1) 1)),emptyOne,false⟩ : Model))=_
 rw [originalSupportAtDepth,floorValue _ (Nat.pow_pos (by decide)),quarterValue,originalFiniteLoop]
 dsimp only [Except.bind,Bind.bind,Except.pure,Pure.pure]
 rw [originalQuarterArea,equalSelf]

theorem originalFloorPositive (depth : Nat) :
 zero.blt (natRatio 1 (2^depth) (Nat.pow_pos (by decide)))=true :=
 positiveNormalized 1 (2^depth) (by decide) (Nat.pow_pos (by decide))
theorem originalFloorDecreases (depth : Nat) :
 (natRatio 1 (2^(depth+1)) (Nat.pow_pos (by decide))).blt
  (natRatio 1 (2^depth) (Nat.pow_pos (by decide)))=true := by
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (by decide) (Nat.pow_pos (by decide)) (by decide) (Nat.pow_pos (by decide))
 rw [Nat.one_mul,Nat.one_mul,Nat.pow_succ,Nat.mul_two]
 exact Nat.lt_add_of_pos_right (Nat.pow_pos (by decide))
private theorem loopPositive (n : Nat) : 0<total (weights (n+1)) := by
 rw [weightSuccessor]
 exact Nat.zero_lt_succ _
theorem originalLoopPositive (n : Nat) :
 zero.blt (natRatio (total (weights (n+1))) (2^(n+1)) (Nat.pow_pos (by decide)))=true :=
 positiveNormalized _ _ (loopPositive n) (Nat.pow_pos (by decide))
theorem originalLoopBelowOne (n : Nat) :
 (natRatio (total (weights (n+1))) (2^(n+1)) (Nat.pow_pos (by decide))).blt FiniteQuantumGravity.one=true := by
 apply CommonScaleAxis.positiveNormalizedLess _ _ 1 1 (loopPositive n) (Nat.pow_pos (by decide)) (by decide) (by decide)
 rw [Nat.mul_one,Nat.one_mul,← completeLedger (n+1)]
 exact Nat.lt_succ_self _
theorem originalLoopIncreases (n : Nat) :
 (natRatio (total (weights (n+1))) (2^(n+1)) (Nat.pow_pos (by decide))).blt
  (natRatio (total (weights (n+2))) (2^(n+2)) (Nat.pow_pos (by decide)))=true := by
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (loopPositive n) (Nat.pow_pos (by decide)) (loopPositive (n+1)) (Nat.pow_pos (by decide))
 rw [weightSuccessor (n+1),Nat.pow_succ (2 : Nat) (n+1)]
 have same : total (weights (n+1))*(2^(n+1)*2)=
  (total (weights (n+1))+total (weights (n+1)))*2^(n+1) := by
  rw [Nat.mul_two,addMul,Nat.mul_add]
 rw [same,addMul (total (weights (n+1))+total (weights (n+1))) 1 (2^(n+1)),Nat.one_mul]
 exact Nat.lt_add_of_pos_right (Nat.pow_pos (by decide))

theorem originalEverySuccessor (n : Nat) : successorPreservesModel (.integer (.ofNat (n+1)))=.ok true := by
 unfold successorPreservesModel
 rw [originalEveryDepth n]
 dsimp only [Except.bind,Bind.bind]
 rw [originalEveryDepth (n+1)]
 dsimp only [Except.bind,Bind.bind,Except.pure,Pure.pure]
 rw [originalFloorDecreases (n+1),originalFloorPositive (n+2),originalLoopIncreases n,originalLoopBelowOne (n+1)]
 have support : 2^(n+1+1)=2*2^(n+1) := (Nat.pow_succ 2 (n+1)).trans (Nat.mul_comm _ _)
 rw [support,CommonRefinement.naturalEqualityReflexive (2*2^(n+1))]
 rfl
theorem originalCompleteWordSupport (depth : Nat) :
 doubleSupport depth 1=(FoldAssembly.supportAfterExtensions depth).length :=
 (originalSupportAtDepth depth).trans (AlphaCovers.completeBinarySupport depth).symm
end SFT.Physics.FiniteQuantumGravityGeneral
