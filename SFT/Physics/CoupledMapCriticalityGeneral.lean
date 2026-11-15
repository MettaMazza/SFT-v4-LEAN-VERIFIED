import SFT.Physics.CoupledMapCriticalityCertificate
import SFT.Physics.LatticeCurvatureProofs
namespace SFT.Physics.CoupledMapCriticalityGeneral
open CoupledMapCriticality LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction SFT.Foundation.ExactCast
set_option maxHeartbeats 100000000
private theorem normalizedEqualityCross (n d m e : Nat) (hd : 0<d) (he : 0<e)
 (same : natRatio n d hd=natRatio m e he) : n*e=m*d := by
 have a := natRatioValue n d hd
 have b := natRatioValue m e he
 rw [same] at a
 have scaled : (n*e)*(natRatio m e he).den=(m*d)*(natRatio m e he).den := by
  rw [mulRightComm n e _,a,mulAssoc,mulRightComm m d _,b,mulAssoc,Nat.mul_comm d e]
 exact Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero (natRatio m e he).den_nz) scaled
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

theorem originalThreshold (m : Nat) : holdingThreshold (.integer (.ofNat (m+2)))=.ok (natRatio (m+1) (m+2) (Nat.zero_lt_succ _)) := rfl
theorem originalMultiplier (m c d : Nat) (hc : 0<c) (proper : c<d) :
 retainedTransverseMultiplier (.integer (.ofNat (m+2))) (natRatio c d (Nat.lt_trans hc proper))=
 .ok (natRatio ((m+2)*(d-c)) d (Nat.lt_trans hc proper)) := by
 have hd := Nat.lt_trans hc proper
 have one : normalize 1 1 (by decide)=natRatio d d hd := by
  change natRatio 1 1 (by decide)=_
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_one]
 have below : (natRatio c d hd).blt (normalize 1 1 (by decide))=true :=
  CommonScaleAxis.positiveNormalizedLess c d 1 1 hc hd (by decide) (by decide) (by rw [Nat.mul_one,Nat.one_mul];exact proper)
 unfold retainedTransverseMultiplier
 change (if !zero.blt (natRatio c d hd) || !(natRatio c d hd).blt (normalize 1 1 (by decide)) then _ else _)=_
 rw [positiveNormalized c d hc hd,below]
 change Except.ok (multiply (natRatio (m+2) 1 (by decide)) (subtract (normalize 1 1 (by decide)) (natRatio c d hd)))=_
 rw [one,subtractNormalized d c d hd (Nat.le_of_lt proper),multiplyNormalized]
 congr 1
 apply natRatioCongruence
 rw [Nat.one_mul]
theorem uniqueNeutralBoundary (m c d : Nat) (hc : 0<c) (proper : c<d) :
 natRatio ((m+2)*(d-c)) d (Nat.lt_trans hc proper)=normalize 1 1 (by decide) ↔
 natRatio c d (Nat.lt_trans hc proper)=natRatio (m+1) (m+2) (Nat.zero_lt_succ _) := by
 have hd := Nat.lt_trans hc proper
 have split : c+(d-c)=d := (Nat.add_comm _ _).trans (subtractAdd d c (Nat.le_of_lt proper))
 constructor
 · intro neutral
   have cross := normalizedEqualityCross ((m+2)*(d-c)) d 1 1 hd (by decide) neutral
   rw [Nat.mul_one,Nat.one_mul] at cross
   have sum : (m+2)*c+d=(m+1)*d+d := by
    calc
     (m+2)*c+d=(m+2)*c+(m+2)*(d-c) := congrArg (fun x => (m+2)*c+x) cross.symm
     _=(m+2)*(c+(d-c)) := (Nat.mul_add _ _ _).symm
     _=(m+2)*d := congrArg (fun x => (m+2)*x) split
     _=(m+1)*d+d := Nat.succ_mul _ _
   apply natRatioCongruence
   rw [Nat.mul_comm c (m+2)]
   have cancelled := congrArg (fun x => x-d) sum
   rw [addSubtract,addSubtract] at cancelled
   exact cancelled
 · intro boundary
   have cross := normalizedEqualityCross c d (m+1) (m+2) hd (Nat.zero_lt_succ _) boundary
   have sum : (m+1)*d+(m+2)*(d-c)=(m+1)*d+d := by
    calc
     (m+1)*d+(m+2)*(d-c)=c*(m+2)+(m+2)*(d-c) := congrArg (fun x => x+(m+2)*(d-c)) cross.symm
     _=(m+2)*(c+(d-c)) := by rw [Nat.mul_comm c (m+2),Nat.mul_add]
     _=(m+2)*d := congrArg (fun x => (m+2)*x) split
     _=(m+1)*d+d := Nat.succ_mul _ _
   change natRatio _ d hd=natRatio 1 1 (by decide)
   apply natRatioCongruence
   rw [Nat.mul_one,Nat.one_mul]
   have cancelled := congrArg (fun x => x-(m+1)*d) sum
   rw [RunningConvergence.addSubtractLeft,RunningConvergence.addSubtractLeft] at cancelled
   exact cancelled
private theorem integerNotLess (a b : Nat) (bound : b≤a) : ¬Int.ofNat a<Int.ofNat b := by
 intro h
 change Int.NonNeg (Int.subNatNat b (a+1)) at h
 unfold Int.subNatNat at h
 have positive := RunningConvergence.orderedDifferencePositive _ _ (Nat.lt_succ_of_le bound)
 cases hd : (a+1)-b with
 | zero => rw [hd] at positive; cases positive
 | succ n => rw [hd] at h; cases h

private theorem normalizedNotLess (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (cross : m*d<n*e) : (natRatio n d hd).blt (natRatio m e he)=false := by
 have ap := positiveNormalizedNumerator n d hn hd
 have bp := positiveNormalizedNumerator m e hm he
 have less := CommonScaleAxis.normalizedCrossLess m e n d he hd cross
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
   exact decide_eq_false (integerNotLess _ _ (Nat.le_of_lt less))



private theorem multiplicationSplit (m c d : Nat) (proper : c<d) :
 (m+2)*c+(m+2)*(d-c)=(m+1)*d+d := by
 rw [←Nat.mul_add,Nat.add_comm c (d-c),subtractAdd d c (Nat.le_of_lt proper),Nat.succ_mul]

theorem originalStrictContraction (m c d : Nat) (hc : 0<c) (proper : c<d)
 (above : (m+1)*d<c*(m+2)) :
 stabilityClass (.integer (.ofNat (m+2))) (natRatio c d (Nat.lt_trans hc proper))=.ok "strict-contraction" := by
 have hd := Nat.lt_trans hc proper
 have sum := multiplicationSplit m c d proper
 have cross : (m+2)*(d-c)<d := by
  have h := above
  rw [Nat.mul_comm c (m+2)] at h
  have added := Nat.add_lt_add_right h d
  rw [←sum] at added
  exact Nat.lt_of_add_lt_add_left added
 have positive := Nat.mul_pos (Nat.zero_lt_succ (m+1)) (RunningConvergence.orderedDifferencePositive c d proper)
 have less := CommonScaleAxis.positiveNormalizedLess ((m+2)*(d-c)) d 1 1 positive hd (by decide) (by decide) (by rw [Nat.mul_one,Nat.one_mul];exact cross)
 have different : natRatio ((m+2)*(d-c)) d hd≠normalize 1 1 (by decide) := by
  intro equal
  have h := normalizedEqualityCross ((m+2)*(d-c)) d 1 1 hd (by decide) equal
  rw [Nat.mul_one,Nat.one_mul] at h
  exact Nat.ne_of_lt cross h
 unfold stabilityClass
 rw [originalMultiplier m c d hc proper]
 change (if decide (natRatio ((m+2)*(d-c)) d hd=normalize 1 1 (by decide)) then _ else _)=_
 change (natRatio ((m+2)*(d-c)) d hd).blt (normalize 1 1 (by decide))=_ at less
 rw [decide_eq_false different,less]
 rfl

theorem originalStrictExpansion (m c d : Nat) (hc : 0<c) (proper : c<d)
 (below : c*(m+2)<(m+1)*d) :
 stabilityClass (.integer (.ofNat (m+2))) (natRatio c d (Nat.lt_trans hc proper))=.ok "strict-expansion" := by
 have hd := Nat.lt_trans hc proper
 have sum := multiplicationSplit m c d proper
 have cross : d<(m+2)*(d-c) := by
  have h := below
  rw [Nat.mul_comm c (m+2)] at h
  have added := Nat.add_lt_add_right h d
  rw [←sum] at added
  exact Nat.lt_of_add_lt_add_left added
 have positive := Nat.mul_pos (Nat.zero_lt_succ (m+1)) (RunningConvergence.orderedDifferencePositive c d proper)
 have less := normalizedNotLess ((m+2)*(d-c)) d 1 1 positive hd (by decide) (by decide) (by rw [Nat.mul_one,Nat.one_mul];exact cross)
 have different : natRatio ((m+2)*(d-c)) d hd≠normalize 1 1 (by decide) := by
  intro equal
  have h := normalizedEqualityCross ((m+2)*(d-c)) d 1 1 hd (by decide) equal
  rw [Nat.mul_one,Nat.one_mul] at h
  exact Nat.ne_of_gt cross h
 unfold stabilityClass
 rw [originalMultiplier m c d hc proper]
 change (if decide (natRatio ((m+2)*(d-c)) d hd=normalize 1 1 (by decide)) then _ else _)=_
 change (natRatio ((m+2)*(d-c)) d hd).blt (normalize 1 1 (by decide))=_ at less
 rw [decide_eq_false different,less]
 rfl

theorem originalNeutral (m c d : Nat) (hc : 0<c) (proper : c<d)
 (boundary : natRatio c d (Nat.lt_trans hc proper)=natRatio (m+1) (m+2) (Nat.zero_lt_succ _)) :
 stabilityClass (.integer (.ofNat (m+2))) (natRatio c d (Nat.lt_trans hc proper))=.ok "neutral-boundary" := by
 unfold stabilityClass
 rw [originalMultiplier m c d hc proper]
 have equal := (uniqueNeutralBoundary m c d hc proper).mpr boundary
 change (if decide (natRatio ((m+2)*(d-c)) d (Nat.lt_trans hc proper)=normalize 1 1 (by decide)) then _ else _)=_
 rw [decide_eq_true equal]
 rfl
end SFT.Physics.CoupledMapCriticalityGeneral
