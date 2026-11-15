import SFT.Physics.AccumulatedSeparationGeneral
namespace SFT.Physics.AccumulatedSeparationLedger
open AccumulatedSeparation AccumulatedSeparationGeneral LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
open SFT.Mathematics.SelfSimilarConvergence
set_option maxHeartbeats 100000000
theorem originalDenominatorDoubles (k : Nat) :
 2*gapDenominator (k+1)<gapDenominator (k+2) := by
 unfold gapDenominator
 rw [Nat.add_comm 2 (2^(k+1)),Nat.add_comm 3 (2^(k+1)),Nat.add_comm 2 (2^(k+2)),Nat.add_comm 3 (2^(k+2))]
 change 2*((2^(k+1)+2)*(2^(k+1)+3))<(2^(k+1)*2+2)*(2^(k+1)*2+3)
 rw [Nat.mul_comm (2^(k+1)) 2]
 apply originalSupportContractionCross
 change 2≤2^k*2
 exact Nat.mul_le_mul_right 2 (Nat.pow_pos (by decide))
theorem originalDenominatorMajorant (k count : Nat) :
 gapDenominator (k+1)*2^count ≤ gapDenominator (k+1+count) := by
 induction count with
 | zero => rw [Nat.pow_zero,Nat.mul_one,Nat.add_zero]; exact Nat.le_refl _
 | succ count ih =>
  rw [Nat.pow_succ,←mulAssoc]
  have step := originalDenominatorDoubles (k+count)
  have idx : k+count+1=k+1+count := Nat.add_right_comm k count 1
  have idx2 : k+count+2=k+1+(count+1) := congrArg Nat.succ idx
  rw [idx,idx2] at step
  exact Nat.le_trans (Nat.mul_le_mul_right 2 ih) (Nat.le_of_lt (by
   rw [Nat.mul_comm _ 2]
   exact step))
theorem originalFiniteBudget (k count : Nat) :
 (partialLedger (k+1) count).1*(gapDenominator (k+1)*2^count)+2*(partialLedger (k+1) count).2 ≤
 2*(2^count)*(partialLedger (k+1) count).2 := by
 induction count with
 | zero =>
  change 0*(gapDenominator (k+1)*1)+2≤2
  rw [Nat.zero_mul,Nat.zero_add]
  exact Nat.le_refl _
 | succ count ih =>
  change ((partialLedger (k+1) count).1*gapDenominator (k+1+count)+(partialLedger (k+1) count).2)*
   (gapDenominator (k+1)*2^(count+1))+2*((partialLedger (k+1) count).2*gapDenominator (k+1+count)) ≤
   2*(2^(count+1))*((partialLedger (k+1) count).2*gapDenominator (k+1+count))
  rw [Nat.pow_succ,←mulAssoc (gapDenominator (k+1)) (2^count) 2]
  exact budgetStep _ _ _ _ _ (originalDenominatorMajorant k count) ih
theorem originalEveryFiniteTailCross (k count : Nat) :
 (partialLedger (k+1) count).1*gapDenominator (k+1)<2*(partialLedger (k+1) count).2 := by
 have strict := Nat.lt_of_lt_of_le
  (Nat.lt_add_of_pos_right (Nat.mul_pos (by decide : 0<2) (ledgerDenominatorPositive (k+1) count)))
  (originalFiniteBudget k count)
 rw [←mulAssoc] at strict
 have arrange : 2*2^count*(partialLedger (k+1) count).2=
  (2*(partialLedger (k+1) count).2)*2^count := by
  rw [mulAssoc,Nat.mul_comm (2^count) _,←mulAssoc]
 rw [arrange] at strict
 apply Nat.lt_of_not_ge
 intro opposite
 exact Nat.not_lt_of_ge (Nat.mul_le_mul_right (2^count) opposite) strict
-- Exact rational addition step used by the original accumulation loop.
theorem originalAppendGap (n q d : Nat) (hq : 0<q) (hd : 0<d) :
 add (natRatio n q hq) (natRatio 1 d hd)=natRatio (n*d+q) (q*d) (Nat.mul_pos hq hd) := by
 apply addCommonDenominator _ _ (n*d) q (q*d) (Nat.mul_pos hq hd)
  (natRatioNonnegative n q hq) (natRatioNonnegative 1 d hd)
 · rw [mulRightComm n d _,natRatioValue,mulAssoc]
 · have v := natRatioValue 1 d hd
   rw [Nat.one_mul] at v
   rw [v]
   exact mulLeftComm q _ d
theorem originalGapLedger (depth : Nat) : adjacentSectorGap (.integer (.ofNat (depth+1)))=
 .ok (natRatio 1 (gapDenominator depth) (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _))) := by
 rw [originalEveryGap]
 apply congrArg Except.ok
 apply natRatioCongruence
 unfold gapDenominator
 rw [Nat.one_mul,Nat.one_mul,Nat.add_comm 2 (2^depth),Nat.add_comm 3 (2^depth)]
theorem originalAccumulateLedger (depth count offset : Nat) :
 accumulate count (depth+offset+1)
  (natRatio (partialLedger depth offset).1 (partialLedger depth offset).2 (ledgerDenominatorPositive depth offset))=
 .ok (natRatio (partialLedger depth (offset+count)).1 (partialLedger depth (offset+count)).2 (ledgerDenominatorPositive depth (offset+count))) := by
 induction count generalizing offset with
 | zero => rw [Nat.add_zero]; rfl
 | succ count ih =>
  unfold accumulate
  rw [originalGapLedger]
  dsimp only [Except.bind,Bind.bind]
  rw [originalAppendGap (partialLedger depth offset).1 (partialLedger depth offset).2 (gapDenominator (depth+offset)) (ledgerDenominatorPositive depth offset) (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _))]
  change accumulate count (depth+offset+1+1)
   (natRatio (partialLedger depth (offset+1)).1 (partialLedger depth (offset+1)).2 (ledgerDenominatorPositive depth (offset+1)))=_
  rw [Nat.add_assoc depth offset 1,ih]
  rw [Nat.add_right_comm offset 1 count,Nat.add_assoc]
theorem originalFirstLedger (depth : Nat) :
 natRatio (partialLedger depth 1).1 (partialLedger depth 1).2 (ledgerDenominatorPositive depth 1)=
 natRatio 1 (gapDenominator depth) (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _)) := by
 change natRatio (0*gapDenominator (depth+0)+1) (1*gapDenominator (depth+0)) _=_
 apply natRatioCongruence
 rw [Nat.zero_mul,Nat.zero_add,Nat.one_mul,Nat.add_zero,Nat.one_mul,Nat.one_mul]
theorem originalEveryPartialSum (k : Nat) :
 finitePartialAccumulation (.integer (.ofNat (k+1)))=
 .ok (natRatio (partialLedger 0 (k+1)).1 (partialLedger 0 (k+1)).2 (ledgerDenominatorPositive 0 (k+1))) := by
 unfold finitePartialAccumulation
 dsimp only
 rw [originalFirstGap]
 dsimp only [Except.bind,Bind.bind]
 change accumulate k 2 (natRatio 1 (gapDenominator 0) _) = _
 rw [←originalFirstLedger 0]
 rw [originalAccumulateLedger 0 k 1,Nat.add_comm 1 k]
theorem originalPositiveLedgerNumerator (depth count : Nat) :
 0<(partialLedger depth (count+1)).1 :=
 Nat.add_pos_right _ (ledgerDenominatorPositive depth count)
theorem originalTailRatioBound (k count : Nat) :
 (natRatio (partialLedger (k+1) (count+1)).1 (partialLedger (k+1) (count+1)).2 (ledgerDenominatorPositive (k+1) (count+1))).blt
 (natRatio 2 (gapDenominator (k+1)) (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _)))=true :=
 CommonScaleAxis.positiveNormalizedLess _ _ _ _ (originalPositiveLedgerNumerator _ _) (ledgerDenominatorPositive _ _)
 (by decide) (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _))
 (originalEveryFiniteTailCross k (count+1))
theorem originalEveryFiniteTail (k count : Nat) :
 finiteTailEnvelope (.integer (.ofNat (k+2))) (.integer (.ofNat (k+2+count)))=.ok true := by
 unfold finiteTailEnvelope
 dsimp only [Except.bind,Bind.bind]
 rw [if_neg (Nat.not_lt_of_ge (Nat.le_add_right (k+2) count))]
 rw [originalGapLedger (k+1)]
 dsimp only [Except.bind,Bind.bind]
 rw [RunningConvergence.addSubtractLeft]
 rw [←originalFirstLedger (k+1)]
 rw [originalAccumulateLedger (k+1) count 1]
 dsimp only [Except.bind,Bind.bind]
 rw [originalFirstLedger (k+1),addNormalized 1 1 (gapDenominator (k+1)) (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _)),Nat.add_comm 1 count]
 rw [originalTailRatioBound]
 rfl
end SFT.Physics.AccumulatedSeparationLedger
