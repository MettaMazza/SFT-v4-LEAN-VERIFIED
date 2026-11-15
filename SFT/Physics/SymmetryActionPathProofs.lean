import SFT.Physics.SymmetryActionPaths
import SFT.Physics.CommonScaleAxisAlgebra
import SFT.Physics.VacuumScaleProofs
import SFT.Computation.ErrorBound
namespace SFT.Physics.SymmetryActionPathProofs
open SymmetryActionPaths LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
open SFT.Mathematics.LimitComputations
open SFT.Computation.ErrorBound
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
-- Reuse the retained exact common-denominator subtraction argument.
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
 unfold LeptonIntervals.subtract
 rw [natRatioNonnegative n d hd,natRatioNonnegative m d hd]
 change normalize (Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)) (a.den*b.den) _ = _
 rw [intDiff]
 apply natRatioCongruence
 rw [multiplyDifference _ _ _ ordered,avc,bvc,multiplyDifference _ _ _ bound]


private theorem equalIntSound (a b : Int) (h : equalInt a b=true) : a=b := by
 cases a with
 | ofNat a =>
  cases b with
  | ofNat b => exact congrArg Int.ofNat (Nat.eq_of_beq_eq_true h)
  | negSucc b => cases h
 | negSucc a =>
  cases b with
  | ofNat b => cases h
  | negSucc b => exact congrArg Int.negSucc (Nat.eq_of_beq_eq_true h)
private theorem equalRatSound (a b : Rat) (h : equalRat a b=true) : a=b := by
 have parts : equalInt a.num b.num=true ∧ (a.den==b.den)=true := by
  cases x : equalInt a.num b.num <;> cases y : a.den==b.den <;> rw [equalRat,x,y] at h
  all_goals try cases h
  all_goals exact ⟨rfl,rfl⟩
 exact Rat.ext (equalIntSound _ _ parts.1) (Nat.eq_of_beq_eq_true parts.2)
private theorem natEqualSelf (n : Nat) : (n==n)=true := by
 induction n with
 | zero => rfl
 | succ n ih => exact ih
private theorem equalRatSelf (a : Rat) : equalRat a a=true := by
 unfold equalRat equalInt
 cases a.num with
 | ofNat n => change (n==n && a.den==a.den)=true; rw [show (n==n)=true from natEqualSelf n,show (a.den==a.den)=true from natEqualSelf _];rfl
 | negSucc n => change (n==n && a.den==a.den)=true; rw [show (n==n)=true from natEqualSelf n,show (a.den==a.den)=true from natEqualSelf _];rfl
private theorem ratioDifferent (a b d : Nat) (hd : 0<d) (different : a≠b) :
 equalRat (natRatio a d hd) (natRatio b d hd)=false := by
 cases checked : equalRat (natRatio a d hd) (natRatio b d hd) with
 | false => rfl
 | true =>
  have same := equalRatSound _ _ checked
  have av := natRatioValue a d hd
  have bv := natRatioValue b d hd
  rw [same] at av
  exact False.elim (different (Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero (natRatio b d hd).den_nz) (av.trans bv.symm)))
theorem originalDownwardMagnitude (a b d : Nat) (hd : 0<d) (hb : 0<b) (lower : b<a) :
 orientedMagnitude (.fraction (natRatio a d hd)) (.fraction (natRatio b d hd))=
 .ok (.step .lower (natRatio (a-b) d hd)) := by
 unfold orientedMagnitude positiveCoordinate
 dsimp only
 rw [positiveNormalized a d (Nat.lt_trans hb lower) hd,positiveNormalized b d hb hd]
 change (if equalRat (natRatio a d hd) (natRatio b d hd) then Except.ok Magnitude.empty
  else if (natRatio b d hd).blt (natRatio a d hd) then Except.ok (.step .lower (subtract (natRatio a d hd) (natRatio b d hd)))
  else Except.ok (.step .upper (subtract (natRatio b d hd) (natRatio a d hd)))) = _
 rw [ratioDifferent a b d hd (Nat.ne_of_gt lower)]
 rw [CommonScaleAxis.positiveNormalizedLess b d a d hb hd (Nat.lt_trans hb lower) hd (Nat.mul_lt_mul_of_pos_right lower hd)]
 rw [subtractNormalized a b d hd (Nat.le_of_lt lower)]
 rfl

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
 have less : (natRatio m e he).num.natAbs*(natRatio n d hd).den ≤ (natRatio n d hd).num.natAbs*(natRatio m e he).den := by
  cases Nat.eq_or_lt_of_le cross with
  | inl same =>
   have equal := natRatioCongruence m e n d he hd same
   rw [equal]
   exact Nat.le_refl _
  | inr strict => exact Nat.le_of_lt (CommonScaleAxis.normalizedCrossLess m e n d he hd strict)
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
theorem originalUpwardMagnitude (a b d : Nat) (hd : 0<d) (ha : 0<a) (upper : a<b) :
 orientedMagnitude (.fraction (natRatio a d hd)) (.fraction (natRatio b d hd))=
 .ok (.step .upper (natRatio (b-a) d hd)) := by
 unfold orientedMagnitude positiveCoordinate
 dsimp only
 rw [positiveNormalized a d ha hd,positiveNormalized b d (Nat.lt_trans ha upper) hd]
 change (if equalRat (natRatio a d hd) (natRatio b d hd) then Except.ok Magnitude.empty
  else if (natRatio b d hd).blt (natRatio a d hd) then Except.ok (.step .lower (subtract (natRatio a d hd) (natRatio b d hd)))
  else Except.ok (.step .upper (subtract (natRatio b d hd) (natRatio a d hd)))) = _
 rw [ratioDifferent a b d hd (Nat.ne_of_lt upper)]
 rw [normalizedNotLess b d a d (Nat.lt_trans ha upper) hd ha hd (Nat.mul_le_mul_right d (Nat.le_of_lt upper))]
 rw [subtractNormalized b a d hd (Nat.le_of_lt upper)]
 rfl
theorem originalStepMagnitude (a b d : Nat) (hd : 0<d) (ha : 0<a) (hb : 0<b) (different : a≠b) :
 stepValue (.fraction (natRatio a d hd)) (.fraction (natRatio b d hd))=.ok (natRatio (gap a b) d hd) := by
 cases Nat.lt_or_gt_of_ne different with
 | inl upper =>
  unfold stepValue
  rw [originalUpwardMagnitude a b d hd ha upper,gapOfLE a b (Nat.le_of_lt upper)]
  rfl
 | inr lower =>
  unfold stepValue
  rw [originalDownwardMagnitude a b d hd hb lower,gapSymmetry a b,gapOfLE b a (Nat.le_of_lt lower)]
  rfl
theorem originalNonlowerAction (a b d : Nat) (hd : 0<d) (ha : 0<a) (hb : 0<b) (bound : b≤a) :
 (!(natRatio a d hd).blt (natRatio b d hd))=true := by
 rw [normalizedNotLess a d b d ha hd hb hd (Nat.mul_le_mul_right d bound)]
 rfl
theorem originalSameAction (value : Rat) : equalRat value value=true := equalRatSelf value
end SFT.Physics.SymmetryActionPathProofs
