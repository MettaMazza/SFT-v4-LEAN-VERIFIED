import SFT.Physics.SpinStatisticsColdBound
namespace SFT.Physics.SpinStatisticsColdThreshold
open SpinStatisticsCondensation SpinStatisticsOccupationWeights SpinStatisticsColdScores SpinStatisticsColdMeasure SpinStatisticsColdBound
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
private theorem integerNotLess (a b : Nat) (bound : b≤a) : ¬Int.ofNat a<Int.ofNat b := by
 intro h
 change Int.NonNeg (Int.subNatNat b (a+1)) at h
 unfold Int.subNatNat at h
 have positive := RunningConvergence.orderedDifferencePositive _ _ (Nat.lt_succ_of_le bound)
 cases hd : (a+1)-b with
 | zero => rw [hd] at positive; cases positive
 | succ n => rw [hd] at h; cases h

private theorem normalizedNotLess (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (cross : m*d≤n*e) : (natRatio n d hd).blt (natRatio m e he)=false := by
 have ap := positiveNormalizedNumerator n d hn hd
 have bp := positiveNormalizedNumerator m e hm he
 have less : (natRatio m e he).num.natAbs*(natRatio n d hd).den ≤
   (natRatio n d hd).num.natAbs*(natRatio m e he).den := by
   cases Nat.lt_or_eq_of_le cross with
   | inl strict => exact Nat.le_of_lt (CommonScaleAxis.normalizedCrossLess m e n d he hd strict)
   | inr same =>
     have eq : natRatio n d hd=natRatio m e he := natRatioCongruence _ _ _ _ hd he same.symm
     rw [eq]
     exact Nat.le_refl _
 unfold Rat.blt
 rw [natRatioNonnegative n d hd,natRatioNonnegative m e he]
 generalize ha : (natRatio n d hd).num.natAbs=na at ap less ⊢
 generalize hb : (natRatio m e he).num.natAbs=nb at bp less ⊢
 cases na with
 | zero => cases ap
 | succ na =>
  cases nb with
  | zero => cases bp
  | succ nb =>
   have notNeg : ¬Int.ofNat (na+1)<0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (na+2)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   have notZero : Int.ofNat (na+1)≠0 := fun h => Nat.noConfusion (congrArg Int.toNat h)
   have notNonpos : ¬Int.ofNat (nb+1)≤0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (nb+1)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   rw [decide_eq_false notNeg]
   rw [if_neg notZero]
   rw [decide_eq_false notNonpos,Bool.and_false,Bool.false_and]
   change decide (Int.ofNat ((na+1)*(natRatio m e he).den)<Int.ofNat ((nb+1)*(natRatio n d hd).den))=false
   exact decide_eq_false (integerNotLess _ _ less)



theorem originalCoveredDepthPasses (p l d m : Nat)
 (covered : ((words (p+1) l).length-1)*(m+1)≤2^(d+1)) :
 (groundShare (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat (d+1)))).map
 (fun share => !share.blt (natRatio (m+1) (m+2) (Nat.zero_lt_succ _)))=.ok true := by
 rw [originalGroundShareOperation]
 change Except.ok (!(natRatio _ _ _).blt (natRatio (m+1) (m+2) _))=_
 have bound := originalFiniteLockBound (p+1) l (d+1) (m+1) covered
 rw [Nat.mul_comm (m+1+1)] at bound
 rw [normalizedNotLess (score (ThermalEquilibriumWeights.originalCounts l) (d+1) (ground (p+1) l))
   (denominator (p+1) l (d+1)) (m+1) (m+2)
   (originalScorePositive (l+2) (d+1) (ground (p+1) l))
   (originalDenominatorPositive (p+1) l (d+1)) (Nat.zero_lt_succ _) (Nat.zero_lt_succ _) bound]
 rfl

def sufficientDepth (particles levels factorPred : Nat) : Nat :=
 AlphaCovers.coverDepth (max 1 (((words particles levels).length-1)*factorPred))
theorem originalSufficientDepthPositive (particles levels factorPred : Nat) :
 0<sufficientDepth particles levels factorPred := (AlphaCovers.leastPositiveCover _).1

theorem originalSufficientDepthPasses (p l m : Nat) :
 (groundShare (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving"
   (.integer (.ofNat (sufficientDepth (p+1) l (m+1))))).map
 (fun share => !share.blt (natRatio (m+1) (m+2) (Nat.zero_lt_succ _)))=.ok true := by
 have positive := originalSufficientDepthPositive (p+1) l (m+1)
 have covered := originalSearchBoundCovers (p+1) l (m+1)
 change ((words (p+1) l).length-1)*(m+1)≤2^(sufficientDepth (p+1) l (m+1)) at covered
 cases eq : sufficientDepth (p+1) l (m+1) with
 | zero => rw [eq] at positive;exact False.elim (Nat.not_lt_zero _ positive)
 | succ d =>
   rw [eq] at covered
   exact originalCoveredDepthPasses p l d m covered
end SFT.Physics.SpinStatisticsColdThreshold
