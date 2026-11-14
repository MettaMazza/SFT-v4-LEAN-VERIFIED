import SFT.Physics.LatticeCurvature
namespace SFT.Physics.LatticeCurvatureProofs
open SFT.Foundation ExactOperations ExactPartCarrier FractionReduction ExactCast
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs

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

private theorem secondDifferenceCounts (x h : Nat) :
 ((x+h)+h)*((x+h)+h)+x*x=2*((x+h)*(x+h))+2*(h*h) := by
 conv => lhs; simp only [Nat.mul_add,addMul,mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_succ,Nat.mul_zero,Nat.zero_mul,Nat.one_mul,Nat.mul_one,Nat.zero_add,Nat.add_zero]
 conv => rhs; simp only [Nat.mul_add,addMul,mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_succ,Nat.mul_zero,Nat.zero_mul,Nat.one_mul,Nat.mul_one,Nat.zero_add,Nat.add_zero]

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


private theorem takeSum (n m d : Nat) (hn : 0<n) (hm : 0<m) (hd : 0<d) :
 GravityFlux.positiveTake (.fraction (natRatio (n+m) d hd)) (.fraction (natRatio n d hd))=
 .ok (some (natRatio m d hd)) := by
 have less : n*d<(n+m)*d := Nat.mul_lt_mul_of_pos_right (Nat.lt_add_of_pos_right hm) hd
 unfold GravityFlux.positiveTake
 dsimp only
 rw [normalizedNotLess (n+m) d n d (Nat.add_pos_left hn m) hd hn hd less,
  positiveNormalized n d hn hd,
  CommonScaleAxis.positiveNormalizedLess n d (n+m) d hn hd (Nat.add_pos_left hn m) hd less]
 rw [subtractNormalized (n+m) n d hd (Nat.le_add_right n m),RunningConvergence.addSubtractLeft]
 rfl

private theorem squareAtPredecessor (x h d : Nat) (hx : 0<x) (hh : 0<h) (hd : 0<d) :
 LatticeCurvature.squareLatticeCurvature (.fraction (natRatio (x+h) d hd)) (.fraction (natRatio h d hd))=
 .ok (natRatio 2 1 (by decide)) := by
 have less : h*d<(x+h)*d := Nat.mul_lt_mul_of_pos_right (Nat.lt_add_of_pos_left hx) hd
 unfold LatticeCurvature.squareLatticeCurvature
 dsimp only
 rw [positiveNormalized h d hh hd,
  CommonScaleAxis.positiveNormalizedLess h d (x+h) d hh hd (Nat.add_pos_left hx h) hd less]
 rw [addNormalized,subtractNormalized (x+h) h d hd (Nat.le_add_left h x)]
 have take : x+h-h=x := by rw [Nat.add_comm x h,RunningConvergence.addSubtractLeft]
 rw [take,AlphaCovers.binaryCountTwo]
 change (do
  let numerator ← GravityFlux.positiveTake
   (.fraction (add (multiply (natRatio (x+h+h) d hd) (natRatio (x+h+h) d hd))
    (multiply (natRatio x d hd) (natRatio x d hd))))
   (.fraction (multiply (multiply (natRatio 2 1 (by decide)) (natRatio (x+h) d hd)) (natRatio (x+h) d hd)))
  match numerator with
  | none => .error "quadratic curvature cannot be empty"
  | some numerator => LeptonRatios.divide numerator (multiply (natRatio h d hd) (natRatio h d hd)))= _
 rw [multiplyNormalized,multiplyNormalized,addNormalized,multiplyNormalized]
 simp only [Nat.one_mul]
 rw [multiplyNormalized]
 rw [mulAssoc 2 (x+h) (x+h),secondDifferenceCounts]
 rw [takeSum _ _ _ (Nat.mul_pos (by decide) (Nat.mul_pos (Nat.add_pos_left hx h) (Nat.add_pos_left hx h)))
  (Nat.mul_pos (by decide) (Nat.mul_pos hh hh)) (Nat.mul_pos hd hd)]
 dsimp only [Except.bind,Bind.bind]
 rw [multiplyNormalized,divideNormalized _ _ _ _ (Nat.mul_pos hd hd) (Nat.mul_pos hh hh) (Nat.mul_pos hd hd)]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.mul_comm (d*d) (h*h),mulAssoc]

theorem everyNormalizedSpacing (n h d : Nat) (hh : 0<h) (less : h<n) (hd : 0<d) :
 LatticeCurvature.squareLatticeCurvature (.fraction (natRatio n d hd)) (.fraction (natRatio h d hd))=
 .ok (natRatio 2 1 (by decide)) := by
 have result := squareAtPredecessor (n-h) h d (subtractPositive n h less) hh hd
 rw [subtractAdd n h (Nat.le_of_lt less)] at result
 exact result

theorem everyPositiveSpacing (position spacing : PositiveFraction)
 (ordered : spacing.numerator*position.denominator<position.numerator*spacing.denominator) :
 LatticeCurvature.squareLatticeCurvature (.fraction (BoundaryGrowth.asFraction position)) (.fraction (BoundaryGrowth.asFraction spacing))=
 .ok (natRatio 2 1 (by decide)) := by
 let n := position.numerator*spacing.denominator
 let h := spacing.numerator*position.denominator
 let d := position.denominator*spacing.denominator
 have dp : 0<d := Nat.mul_pos (Nat.pos_of_ne_zero position.denominatorNonzero) (Nat.pos_of_ne_zero spacing.denominatorNonzero)
 have pr : BoundaryGrowth.asFraction position=natRatio n d dp := by
  rw [positiveCarrierRepresentation]
  apply natRatioCongruence
  dsimp only [n,d]
  rw [mulRightComm,mulAssoc]
 have sr : BoundaryGrowth.asFraction spacing=natRatio h d dp := by
  rw [positiveCarrierRepresentation]
  apply natRatioCongruence
  dsimp only [h,d]
  rw [mulAssoc]
 rw [pr,sr]
 exact everyNormalizedSpacing n h d (Nat.mul_pos spacing.positive (Nat.pos_of_ne_zero position.denominatorNonzero)) ordered dp
theorem everyGeneratedAxisFamily (spacing : PositiveFraction)
 (ordered : spacing.numerator*2<spacing.denominator) :
 (LatticeCurvature.latticeLaplacian (.integer 1) (.fraction (BoundaryGrowth.asFraction spacing)),
  LatticeCurvature.latticeLaplacian (.integer 2) (.fraction (BoundaryGrowth.asFraction spacing)),
  LatticeCurvature.latticeLaplacian (.integer 3) (.fraction (BoundaryGrowth.asFraction spacing)))=(.ok 2,.ok 4,.ok 6) := by
 let position : PositiveFraction := ⟨1,2,by decide,by decide,by decide⟩
 have less : spacing.numerator*position.denominator<position.numerator*spacing.denominator := by
  change spacing.numerator*2<1*spacing.denominator
  rw [Nat.one_mul]
  exact ordered
 have perAxis := everyPositiveSpacing position spacing less
 change LatticeCurvature.squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) (.fraction (BoundaryGrowth.asFraction spacing))=.ok (natRatio 2 1 (by decide)) at perAxis
 unfold LatticeCurvature.latticeLaplacian
 rw [SpatialStability.spatialDimensionThree]
 dsimp only
 rw [perAxis]
 rfl
end SFT.Physics.LatticeCurvatureProofs
