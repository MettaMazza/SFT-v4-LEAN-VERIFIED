import SFT.Physics.StaticExteriorClockCertificate
namespace SFT.Physics.StaticExteriorClockGeneral
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar
open LeptonIntervals GravitySourceProofs VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
set_option maxHeartbeats 100000000
theorem originalFieldFormula (horizon radius : PositiveFraction) :
 LeptonRatios.divide (BoundaryGrowth.asFraction horizon)
  (multiply (BoundaryGrowth.asFraction radius) (BoundaryGrowth.asFraction radius))=
 .ok (BoundaryGrowth.asFraction (InverseSquare.exactResponse horizon radius)) := by
 rw [sourceProduct,sourceQuotient]
 rfl
theorem originalFluxIdentity (horizon radius : PositiveFraction) :
 (do let field ← LeptonRatios.divide (BoundaryGrowth.asFraction horizon)
       (multiply (BoundaryGrowth.asFraction radius) (BoundaryGrowth.asFraction radius))
     pure (multiply (multiply field (BoundaryGrowth.asFraction radius)) (BoundaryGrowth.asFraction radius)))=
 .ok (BoundaryGrowth.asFraction horizon) := by
 rw [originalFieldFormula]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceProduct,sourceProduct,CoulombGauss.sequentialFluxReturnsSource]
 rfl
theorem originalWellRadiusIdentity (horizon radius : PositiveFraction) :
 (do let well ← LeptonRatios.divide (BoundaryGrowth.asFraction horizon) (BoundaryGrowth.asFraction radius)
     pure (multiply well (BoundaryGrowth.asFraction radius)))=.ok (BoundaryGrowth.asFraction horizon) := by
 rw [sourceQuotient]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceProduct,InverseSquare.recomposes]
 rfl
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




theorem originalPositiveComplement (n d : Nat) (hn : 0<n) (hd : 0<d) (proper : n<d) :
 StaticExteriorClock.positiveRemainder (.fraction (normalize 1 1 (by decide))) (.fraction (natRatio n d hd))=
 .ok (some (natRatio (d-n) d hd)) := by
 have small : (natRatio n d hd).blt (normalize 1 1 (by decide))=true := by
  apply CommonScaleAxis.positiveNormalizedLess n d 1 1 hn hd (by decide) (by decide)
  rw [Nat.mul_one,Nat.one_mul]
  exact proper
 have notAbove : (normalize 1 1 (by decide)).blt (natRatio n d hd)=false := by
  apply normalizedNotLess 1 1 n d (by decide) (by decide) hn hd
  rw [Nat.mul_one,Nat.one_mul]
  exact proper
 have unequal : natRatio n d hd ≠ normalize 1 1 (by decide) := by
  intro eq
  rw [eq] at small
  contradiction
 have different : (natRatio n d hd == normalize 1 1 (by decide))=false := by
  change decide (natRatio n d hd = normalize 1 1 (by decide))=false
  exact decide_eq_false unequal
 have one : normalize 1 1 (by decide)=natRatio d d hd := by
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_one]
 unfold StaticExteriorClock.positiveRemainder
 dsimp only
 rw [positiveNormalized n d hn hd,notAbove,different]
 rw [one,subtractNormalized d n d hd (Nat.le_of_lt proper)]
 rw [positiveNormalized (d-n) d (SFT.Foundation.ExactCast.subtractPositive _ _ proper) hd]
 rfl

theorem originalComplementCompletesOne (n d : Nat) (hn : 0<n) (hd : 0<d) (proper : n<d) :
 (do let complement ← StaticExteriorClock.positiveRemainder (.fraction (normalize 1 1 (by decide))) (.fraction (natRatio n d hd))
     match complement with
     | none => .error "empty"
     | some value => pure (add value (natRatio n d hd)))=.ok (normalize 1 1 (by decide)) := by
 rw [originalPositiveComplement n d hn hd proper]
 dsimp only [Except.bind,Bind.bind]
 rw [addNormalized,subtractAdd d n (Nat.le_of_lt proper)]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.mul_one]

theorem originalEveryExteriorComplement (horizon radius : PositiveFraction)
 (outside : horizon.numerator*radius.denominator<radius.numerator*horizon.denominator) :
 (do let well ← LeptonRatios.divide (BoundaryGrowth.asFraction horizon) (BoundaryGrowth.asFraction radius)
     StaticExteriorClock.positiveRemainder (.fraction (normalize 1 1 (by decide))) (.fraction well))=
 .ok (some (natRatio ((quotientMagnitude horizon radius).denominator-(quotientMagnitude horizon radius).numerator)
  (quotientMagnitude horizon radius).denominator (Nat.pos_of_ne_zero (quotientMagnitude horizon radius).denominatorNonzero))) := by
 rw [sourceQuotient]
 dsimp only [Except.bind,Bind.bind]
 rw [positiveCarrierRepresentation]
 exact originalPositiveComplement _ _ (quotientMagnitude horizon radius).positive _ (CoulombGauss.quotientBelowOne horizon radius outside)

private theorem productLeftComm (a b c : Nat) : a*(b*c)=b*(a*c) := by
 rw [←mulAssoc,Nat.mul_comm a b,mulAssoc]

theorem originalEveryRadiusWellHalving (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e) :
 (do let next ← LeptonRatios.divide (natRatio n d hd) (multiply (natRatio m e he) (natRatio 2 1 (by decide)))
     pure (multiply next (natRatio 2 1 (by decide))))=
 LeptonRatios.divide (natRatio n d hd) (natRatio m e he) := by
 rw [multiplyNormalized,divideNormalized _ _ _ _ _ (Nat.mul_pos hm (by decide)),divideNormalized _ _ _ _ _ hm]
 dsimp only [Except.bind,Bind.bind]
 rw [multiplyNormalized]
 apply congrArg Except.ok
 apply natRatioCongruence
 conv => lhs; simp only [Nat.mul_one,mulAssoc,Nat.mul_comm,productLeftComm]
 conv => rhs; simp only [Nat.mul_one,mulAssoc,Nat.mul_comm,productLeftComm]

theorem originalEveryRadiusFieldQuartering (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e) :
 (do let doubled := multiply (natRatio m e he) (natRatio 2 1 (by decide))
     let next ← LeptonRatios.divide (natRatio n d hd) (multiply doubled doubled)
     pure (multiply next (natRatio 4 1 (by decide))))=
 LeptonRatios.divide (natRatio n d hd) (multiply (natRatio m e he) (natRatio m e he)) := by
 dsimp only
 rw [multiplyNormalized,multiplyNormalized,multiplyNormalized]
 rw [divideNormalized _ _ _ _ _ (Nat.mul_pos (Nat.mul_pos hm (by decide)) (Nat.mul_pos hm (by decide))),divideNormalized _ _ _ _ _ (Nat.mul_pos hm hm)]
 dsimp only [Except.bind,Bind.bind]
 rw [multiplyNormalized]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [show 4=2*2 from rfl]
 conv => lhs; simp only [Nat.mul_one,mulAssoc,Nat.mul_comm,productLeftComm]
 conv => rhs; simp only [Nat.mul_one,mulAssoc,Nat.mul_comm,productLeftComm]

theorem originalEverySuccessorComplementIncreases (n g : Nat) (hn : 0<n) (hg : 0<g) :
 (do let old ← StaticExteriorClock.positiveRemainder (.fraction (normalize 1 1 (by decide))) (.fraction (natRatio n (n+g) (Nat.add_pos_left hn g)))
     let next ← StaticExteriorClock.positiveRemainder (.fraction (normalize 1 1 (by decide))) (.fraction (natRatio n (2*(n+g)) (Nat.mul_pos (by decide) (Nat.add_pos_left hn g))))
     match old,next with
     | some a,some b => pure (a.blt b)
     | none,none => .error "empty"
     | none,some _ => .error "empty"
     | some _,none => .error "empty")=.ok true := by
 have twice (x : Nat) : 2*x=x+x := by
  rw [show 2=1+1 from rfl,addMul,Nat.one_mul]
 have proper : n<n+g := Nat.lt_add_of_pos_right hg
 have doubleProper : n<2*(n+g) := by
  apply Nat.lt_of_lt_of_le proper
  rw [twice]
  exact Nat.le_add_right _ _
 have doubleTake : 2*(n+g)-n=n+2*g := by
  rw [twice]
  have counts : (n+g)+(n+g)=n+(n+(g+g)) := by
   conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
  rw [counts,RunningConvergence.addSubtractLeft,twice]
 rw [originalPositiveComplement n (n+g) hn _ proper,originalPositiveComplement n (2*(n+g)) hn _ doubleProper]
 dsimp only [Except.bind,Bind.bind]
 rw [RunningConvergence.addSubtractLeft,doubleTake]
 apply congrArg Except.ok
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ hg _ (Nat.add_pos_left hn _) _
 rw [←mulAssoc g 2 (n+g),Nat.mul_comm g 2]
 exact Nat.mul_lt_mul_of_pos_right (Nat.lt_add_of_pos_left hn) (Nat.add_pos_left hn g)

theorem originalGeneratedHorizonFormula (n d : Nat) (hn : 0<n) (hd : 0<d) (within : 2*n≤d) :
 StaticExteriorClock.generatedHorizonRadius (.fraction (natRatio n d hd))=.ok (natRatio (2*n) d hd) := by
 have notAbove : (normalize 1 2 (by decide)).blt (natRatio n d hd)=false := by
  cases Nat.lt_or_eq_of_le within with
  | inl strict =>
   apply normalizedNotLess 1 2 n d (by decide) (by decide) hn hd
   rw [Nat.one_mul,Nat.mul_comm n 2]
   exact strict
  | inr equal =>
   have same : natRatio n d hd=normalize 1 2 (by decide) := by
    apply natRatioCongruence
    rw [Nat.one_mul,Nat.mul_comm n 2,equal]
   rw [same]
   rfl
 change (if !(zero.blt (natRatio n d hd)) || (normalize 1 2 (by decide)).blt (natRatio n d hd)
  then Except.error "mass must retain a positive doubled radius no greater than the One"
  else Except.ok (multiply (natRatio 2 1 (by decide)) (natRatio n d hd)))=_
 rw [positiveNormalized n d hn hd,notAbove]
 change Except.ok (multiply (natRatio 2 1 (by decide)) (natRatio n d hd))=_
 rw [multiplyNormalized]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.one_mul]

theorem uniqueOriginalPositiveComplement (n d c e : Nat) (hd : 0<d) (he : 0<e) (proper : n<d)
 (completes : add (natRatio c e he) (natRatio n d hd)=normalize 1 1 (by decide)) :
 natRatio c e he=natRatio (d-n) d hd := by
 have ca : natRatio c e he=natRatio (c*d) (e*d) (Nat.mul_pos he hd) := by
  apply natRatioCongruence
  rw [mulAssoc,Nat.mul_comm d e]
 have na : natRatio n d hd=natRatio (n*e) (e*d) (Nat.mul_pos he hd) := by
  apply natRatioCongruence
  rw [mulAssoc]
 have raw := completes
 rw [ca,na,addNormalized] at raw
 have counts := natRatioValue (c*d+n*e) (e*d) (Nat.mul_pos he hd)
 rw [raw] at counts
 change (c*d+n*e)*1=1*(e*d) at counts
 rw [Nat.mul_one,Nat.one_mul,Nat.mul_comm e d] at counts
 have retained : c*d=(d-n)*e := by
  have same : c*d+n*e=(d-n)*e+n*e := by
   rw [counts,←addMul,subtractAdd d n (Nat.le_of_lt proper)]
  have taken := congrArg (fun x => x-n*e) same
  rw [Nat.add_comm (c*d) (n*e),Nat.add_comm ((d-n)*e) (n*e),RunningConvergence.addSubtractLeft,RunningConvergence.addSubtractLeft] at taken
  exact taken
 apply natRatioCongruence
 exact retained

theorem originalEveryBoundaryEmpty (horizon : PositiveFraction) :
 (do let well ← LeptonRatios.divide (BoundaryGrowth.asFraction horizon) (BoundaryGrowth.asFraction horizon)
     StaticExteriorClock.positiveRemainder (.fraction (normalize 1 1 (by decide))) (.fraction well))=.ok none := by
 rw [positiveCarrierRepresentation,divideNormalized _ _ _ _ _ horizon.positive]
 have unit : natRatio (horizon.numerator*horizon.denominator) (horizon.denominator*horizon.numerator)
  (Nat.mul_pos (Nat.pos_of_ne_zero horizon.denominatorNonzero) horizon.positive)=normalize 1 1 (by decide) := by
  apply natRatioCongruence
  rw [Nat.mul_one,Nat.one_mul,Nat.mul_comm]
 rw [unit]
 rfl
end SFT.Physics.StaticExteriorClockGeneral






