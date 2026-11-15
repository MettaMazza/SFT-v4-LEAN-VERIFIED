import SFT.Physics.InteractionUnification
import SFT.Physics.CommonScaleAxisAlgebra
import SFT.Physics.MagneticCovariance
namespace SFT.Physics.InteractionUnificationRunning
open InteractionUnification LeptonIntervals VacuumLedgerProofs
open SFT.Foundation FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
private theorem multiplyDifference (n m k : Nat) (bound : m≤n) : (n-m)*k=n*k-m*k := by
 conv => rhs;rw [← subtractAdd n m bound,addMul,Nat.add_comm ((n-m)*k) (m*k),RunningConvergence.addSubtractLeft]

private theorem subtractNormalized (n m d : Nat) (hd : 0<d) (bound : m≤n) :
 subtract (natRatio n d hd) (natRatio m d hd)=natRatio (n-m) d hd := by
 let a := natRatio n d hd
 let b := natRatio m d hd
 have av := natRatioValue n d hd
 have bv := natRatioValue m d hd
 have avc : (a.num.natAbs*b.den)*d=n*(a.den*b.den) := by
  rw [mulRightComm,← av,mulAssoc]
 have bvc : (b.num.natAbs*a.den)*d=m*(a.den*b.den) := by
  rw [mulRightComm,← bv,mulAssoc,Nat.mul_comm b.den a.den]
 have ordered : b.num.natAbs*a.den≤a.num.natAbs*b.den := by
  apply Nat.le_of_mul_le_mul_right _ hd
  rw [avc,bvc]
  exact Nat.mul_le_mul_right _ bound
 have intDiff : Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)=
  Int.ofNat (a.num.natAbs*b.den-b.num.natAbs*a.den) := by
  generalize h : b.num.natAbs*a.den = k at ordered ⊢
  cases k with
  | zero => rw [Nat.sub_zero];rfl
  | succ k =>
   change Int.subNatNat _ _ = _
   unfold Int.subNatNat
   rw [CommonScaleAxis.subtractionZeroOfBound _ _ ordered]
 change subtract a b = _
 unfold subtract
 rw [natRatioNonnegative n d hd,natRatioNonnegative m d hd]
 change normalize (Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)) (a.den*b.den) _ = _
 rw [intDiff]
 apply natRatioCongruence
 rw [multiplyDifference _ _ _ ordered,avc,bvc,multiplyDifference _ _ _ bound]

theorem originalRunningFormula (sector : GeneratorOperations.CountInput) (p k : Nat)
 (admitted : SectorInventory.chargeKindCount sector=.ok p) :
 runningShare sector (.integer (.ofNat (k+1)))=.ok (natRatio (p+k) (p+k+1) (Nat.zero_lt_succ _)) := by
 unfold runningShare
 rw [SectorInventory.runningAtEveryPositiveSupport sector p k admitted]
 rfl
theorem originalShortfall (sector : GeneratorOperations.CountInput) (p k : Nat)
 (positive : 0<p) (admitted : SectorInventory.chargeKindCount sector=.ok p) :
 runningShortfall sector (.integer (.ofNat (k+1)))=.ok (natRatio 1 (p+k+1) (Nat.zero_lt_succ _)) := by
 unfold runningShortfall
 rw [originalRunningFormula sector p k admitted]
 dsimp only [Bind.bind,Except.bind]
 change Except.ok (subtract (ExactPartCarrier.asFraction ExactOperations.one)
  (natRatio (p+k) (p+k+1) _))=_
 rw [MagneticCovariance.subtractOneNormalized (p+k) (p+k+1)
  (Nat.lt_of_lt_of_le positive (Nat.le_add_right p k)) (Nat.lt_succ_self _)]
 rw [RunningConvergence.finitePositiveShortfall p k]
theorem originalHoldingOrder (a b : Nat) (positive : 0<a) (ordered : a<b) :
 (natRatio a (a+1) (Nat.zero_lt_succ _)).blt (natRatio b (b+1) (Nat.zero_lt_succ _))=true := by
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ positive (Nat.zero_lt_succ _)
  (Nat.lt_trans positive ordered) (Nat.zero_lt_succ _)
 rw [Nat.mul_succ,Nat.mul_succ,Nat.mul_comm b a]
 exact Nat.add_lt_add_left ordered _
theorem originalHoldingDistinct (a b : Nat) (positive : 0<a) (ordered : a<b) :
 natRatio a (a+1) (Nat.zero_lt_succ _)≠natRatio b (b+1) (Nat.zero_lt_succ _) := by
 intro same
 have yes := originalHoldingOrder a b positive ordered
 rw [same] at yes
 have no : (natRatio b (b+1) (Nat.zero_lt_succ _)).blt (natRatio b (b+1) (Nat.zero_lt_succ _))=false := by
  rw [← MagneticCovariance.normalizedPartRatio b (b+1) (Nat.lt_trans positive ordered) (Nat.le_succ _)]
  exact MagneticCovariance.partNotLessSelf _
 rw [no] at yes
 cases yes
theorem originalHoldingGap (a b : Nat) (ordered : a<b) :
 subtract (natRatio b (b+1) (Nat.zero_lt_succ _)) (natRatio a (a+1) (Nat.zero_lt_succ _))=
 natRatio (b-a) ((a+1)*(b+1)) (Nat.mul_pos (Nat.zero_lt_succ _) (Nat.zero_lt_succ _)) := by
 let d := (a+1)*(b+1)
 have hd : 0<d := Nat.mul_pos (Nat.zero_lt_succ _) (Nat.zero_lt_succ _)
 have left : natRatio b (b+1) (Nat.zero_lt_succ _)=natRatio (b*(a+1)) d hd := by
  apply natRatioCongruence
  exact (mulAssoc b (a+1) (b+1)).symm
 have right : natRatio a (a+1) (Nat.zero_lt_succ _)=natRatio (a*(b+1)) d hd := by
  apply natRatioCongruence
  exact (mulAssoc a (a+1) (b+1)).symm.trans
   ((mulRightComm a (a+1) (b+1)))
 have cross : a*(b+1)≤b*(a+1) := by
  rw [Nat.mul_succ,Nat.mul_succ,Nat.mul_comm b a]
  exact Nat.add_le_add_left (Nat.le_of_lt ordered) _
 rw [left,right,subtractNormalized _ _ d hd cross,SectorInventory.gapCommonNumerator]
theorem originalRunningOrder (lower upper : GeneratorOperations.CountInput) (p q k : Nat)
 (hp : 0<p) (ordered : p<q)
 (lo : SectorInventory.chargeKindCount lower=.ok p)
 (hi : SectorInventory.chargeKindCount upper=.ok q) :
 ∃ a b, runningShare lower (.integer (.ofNat (k+1)))=.ok a ∧
 runningShare upper (.integer (.ofNat (k+1)))=.ok b ∧ a.blt b=true ∧ a≠b := by
 exact ⟨_,_,originalRunningFormula lower p k lo,originalRunningFormula upper q k hi,
 originalHoldingOrder (p+k) (q+k) (Nat.lt_of_lt_of_le hp (Nat.le_add_right p k))
 (Nat.add_lt_add_right ordered k),
 originalHoldingDistinct (p+k) (q+k) (Nat.lt_of_lt_of_le hp (Nat.le_add_right p k))
 (Nat.add_lt_add_right ordered k)⟩
theorem originalRunningGap (lower upper : GeneratorOperations.CountInput) (p q k : Nat)
 (ordered : p<q) (guard : SectorInventory.countValue lower < SectorInventory.countValue upper)
 (lo : SectorInventory.chargeKindCount lower=.ok p)
 (hi : SectorInventory.chargeKindCount upper=.ok q) :
 runningGap lower upper (.integer (.ofNat (k+1)))=
 .ok (natRatio (q-p) ((p+k+1)*(q+k+1)) (Nat.mul_pos (Nat.zero_lt_succ _) (Nat.zero_lt_succ _))) := by
 unfold runningGap
 rw [lo,hi]
 dsimp only [Except.mapError,Bind.bind,Except.bind]
 rw [if_pos guard,originalRunningFormula upper q k hi,originalRunningFormula lower p k lo]
 dsimp only [Bind.bind,Except.bind,Pure.pure,Except.pure]
 rw [originalHoldingGap (p+k) (q+k) (Nat.add_lt_add_right ordered k)]
 rw [FractionReduction.addSubtractSame]
theorem originalPositiveGap (p q k : Nat) (ordered : p<q) :
 zero.blt (natRatio (q-p) ((p+k+1)*(q+k+1))
 (Nat.mul_pos (Nat.zero_lt_succ _) (Nat.zero_lt_succ _)))=true :=
 VacuumScaleProofs.positiveNormalized _ _ (RunningConvergence.orderedDifferencePositive p q ordered) _
theorem originalGapShrinks (p q r : Nat) (ordered : p<q) (positive : 0<r) :
 (natRatio (q-p) ((p+r*2)*(q+r*2))
 (Nat.mul_pos (Nat.add_pos_right _ (Nat.mul_pos positive (by decide)))
 (Nat.add_pos_right _ (Nat.mul_pos positive (by decide))))).blt
 (natRatio (q-p) ((p+r)*(q+r))
 (Nat.mul_pos (Nat.add_pos_right _ positive) (Nat.add_pos_right _ positive)))=true := by
 exact CommonScaleAxis.positiveNormalizedLess _ _ _ _
  (RunningConvergence.orderedDifferencePositive p q ordered)
  (Nat.mul_pos (Nat.add_pos_right _ (Nat.mul_pos positive (by decide : 0<2))) (Nat.add_pos_right _ (Nat.mul_pos positive (by decide : 0<2))))
  (RunningConvergence.orderedDifferencePositive p q ordered)
  (Nat.mul_pos (Nat.add_pos_right _ positive) (Nat.add_pos_right _ positive))
  (Nat.mul_lt_mul_of_pos_left (RunningConvergence.doubledGapDenominatorIncreases p q r positive)
    (RunningConvergence.orderedDifferencePositive p q ordered))
end SFT.Physics.InteractionUnificationRunning
