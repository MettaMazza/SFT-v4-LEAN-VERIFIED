import SFT.Physics.LatticeCurvatureProofs
import SFT.Physics.CoupledEnsembleSynchronization
namespace SFT.Physics.CoupledEnsembleSynchronizationBalance
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.ExactOperations
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
-- Original balance_relation: the two equal coupled moves exhaust the separation.
-- Positive separation cancels; no historical ensemble or measured coordinate enters.
theorem equalMovesExhaustSeparationIffHalf (c d n e : Nat)
 (hd : 0<d) (hn : 0<n) (he : 0<e) :
 add (multiply (natRatio c d hd) (natRatio n e he))
     (multiply (natRatio c d hd) (natRatio n e he))=natRatio n e he ↔
 natRatio c d hd=CoupledEnsembleSynchronization.halfOneValue := by
 rw [multiplyNormalized,addNormalized,CoupledEnsembleSynchronization.halfOneValueExact]
 change natRatio (c*n+c*n) (d*e) _=natRatio n e he ↔ natRatio c d hd=natRatio 1 2 (by decide)
 constructor
 · intro balance
   have cross := normalizedEqualityCross (c*n+c*n) (d*e) n e (Nat.mul_pos hd he) he balance
   have counts : c+c=d := by
    have cancelled : c*n+c*n=n*d := Nat.eq_of_mul_eq_mul_right he (by rw [mulAssoc];exact cross)
    rw [←addMul,Nat.mul_comm n d] at cancelled
    exact Nat.eq_of_mul_eq_mul_right hn cancelled
   apply natRatioCongruence
   rw [Nat.mul_succ,Nat.mul_one,Nat.one_mul,counts]
 · intro half
   have cross := normalizedEqualityCross c d 1 2 hd (by decide) half
   have counts : c+c=d := by rw [Nat.mul_succ,Nat.mul_one,Nat.one_mul] at cross;exact cross
   apply natRatioCongruence
   rw [←addMul,counts,Nat.mul_comm d n,mulAssoc]
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

theorem returnedCoordinatesEqualIffBalance (a b m d : Nat) (hd : 0<d)
 (ordered : a≤b) (moveBelow : m≤b) :
 add (natRatio a d hd) (natRatio m d hd)=subtract (natRatio b d hd) (natRatio m d hd) ↔
 add (natRatio m d hd) (natRatio m d hd)=subtract (natRatio b d hd) (natRatio a d hd) := by
 rw [addNormalized,addNormalized,subtractNormalized b m d hd moveBelow,subtractNormalized b a d hd ordered]
 constructor
 · intro same
   have cross := normalizedEqualityCross (a+m) d (b-m) d hd hd same
   have eq := Nat.eq_of_mul_eq_mul_right hd cross
   have sum : a+(m+m)=b := by
    have h := congrArg (fun x => x+m) eq
    rw [subtractAdd b m moveBelow,Nat.add_assoc] at h
    exact h
   apply natRatioCongruence
   have diff : m+m=b-a := by
    rw [←sum,RunningConvergence.addSubtractLeft]
   rw [diff]
 · intro balance
   have cross := normalizedEqualityCross (m+m) d (b-a) d hd hd balance
   have eq := Nat.eq_of_mul_eq_mul_right hd cross
   have sum : b=(a+m)+m := by
    have h := subtractAdd b a ordered
    rw [←eq,Nat.add_comm (m+m) a,←Nat.add_assoc] at h
    exact h.symm
   apply natRatioCongruence
   rw [sum,Nat.add_comm (a+m) m,RunningConvergence.addSubtractLeft]
private theorem positiveTakeOrdered (n d m e : Nat) (hn : 0<n) (hd : 0<d)
 (hm : 0<m) (he : 0<e) (ordered : m*d<n*e) :
 CoupledEnsembleSynchronization.positiveTake (natRatio n d hd) (natRatio m e he)=
 .ok (subtract (natRatio n d hd) (natRatio m e he)) := by
 unfold CoupledEnsembleSynchronization.positiveTake
 rw [positiveNormalized m e hm he,CommonScaleAxis.positiveNormalizedLess m e n d hm he hn hd ordered]
 rfl

theorem originalPairedMove (a b d c e : Nat) (ha : 0<a) (hab : a<b) (hd : 0<d)
 (hc : 0<c) (hce : c<e)
 (upperWithin : (normalize 1 1 (by decide)).blt (natRatio b d hd)=false) :
 CoupledEnsembleSynchronization.pairedMove (natRatio a d hd) (natRatio b d hd) (natRatio c e (Nat.lt_trans hc hce))=
 .ok (add (natRatio a d hd) (multiply (natRatio c e (Nat.lt_trans hc hce)) (natRatio (b-a) d hd)),
      subtract (natRatio b d hd) (multiply (natRatio c e (Nat.lt_trans hc hce)) (natRatio (b-a) d hd))) := by
 have hb := Nat.lt_trans ha hab
 have he := Nat.lt_trans hc hce
 have hp := RunningConvergence.orderedDifferencePositive a b hab
 have separation : CoupledEnsembleSynchronization.pairSeparation (natRatio a d hd) (natRatio b d hd)=.ok (natRatio (b-a) d hd) := by
  unfold CoupledEnsembleSynchronization.pairSeparation
  rw [positiveNormalized a d ha hd,CommonScaleAxis.positiveNormalizedLess a d b d ha hd hb hd (Nat.mul_lt_mul_of_pos_right hab hd),upperWithin]
  change CoupledEnsembleSynchronization.positiveTake (natRatio b d hd) (natRatio a d hd)=_
  rw [positiveTakeOrdered b d a d hb hd ha hd (Nat.mul_lt_mul_of_pos_right hab hd),subtractNormalized b a d hd (Nat.le_of_lt hab)]
 have bound : c*(b-a)<b*e := by
  exact Nat.lt_of_lt_of_le (Nat.mul_lt_mul_of_pos_right hce hp) (by rw [Nat.mul_comm b e];exact Nat.mul_le_mul_left e (Nat.sub_le b a))
 have taken : CoupledEnsembleSynchronization.positiveTake (natRatio b d hd)
  (multiply (natRatio c e he) (natRatio (b-a) d hd))=
  .ok (subtract (natRatio b d hd) (multiply (natRatio c e he) (natRatio (b-a) d hd))) := by
  rw [multiplyNormalized]
  apply positiveTakeOrdered b d (c*(b-a)) (e*d) hb hd (Nat.mul_pos hc hp) (Nat.mul_pos he hd)
  rw [←mulAssoc]
  exact Nat.mul_lt_mul_of_pos_right bound hd
 unfold CoupledEnsembleSynchronization.pairedMove
 have proper : c*1<1*e := by rw [Nat.mul_one,Nat.one_mul];exact hce
 have couplingLess : (natRatio c e he).blt (normalize 1 1 (by decide))=true := CommonScaleAxis.positiveNormalizedLess c e 1 1 hc he (by decide) (by decide) proper
 rw [positiveNormalized c e hc he,couplingLess]
 dsimp only [Bool.not_true,Bool.false_or,ite_false,Except.bind,Bind.bind]
 rw [separation]
 change (do let upper ← CoupledEnsembleSynchronization.positiveTake (natRatio b d hd) (multiply (natRatio c e he) (natRatio (b-a) d hd));pure (add (natRatio a d hd) (multiply (natRatio c e he) (natRatio (b-a) d hd)),upper))=_
 rw [taken]
 rfl

theorem originalPairEqualityIffHalf (a b d c e : Nat) (ha : 0<a) (hab : a<b) (hd : 0<d)
 (hc : 0<c) (hce : c<e) :
 add (natRatio a d hd) (multiply (natRatio c e (Nat.lt_trans hc hce)) (natRatio (b-a) d hd))=
 subtract (natRatio b d hd) (multiply (natRatio c e (Nat.lt_trans hc hce)) (natRatio (b-a) d hd)) ↔
 natRatio c e (Nat.lt_trans hc hce)=CoupledEnsembleSynchronization.halfOneValue := by
 have he := Nat.lt_trans hc hce
 have hp := RunningConvergence.orderedDifferencePositive a b hab
 have lower : natRatio a d hd=natRatio (a*e) (e*d) (Nat.mul_pos he hd) := by
  apply natRatioCongruence
  rw [mulAssoc]
 have upper : natRatio b d hd=natRatio (b*e) (e*d) (Nat.mul_pos he hd) := by
  apply natRatioCongruence
  rw [mulAssoc]
 have bound : c*(b-a)<b*e :=
  Nat.lt_of_lt_of_le (Nat.mul_lt_mul_of_pos_right hce hp) (by rw [Nat.mul_comm b e];exact Nat.mul_le_mul_left e (Nat.sub_le b a))
 have coordinates := returnedCoordinatesEqualIffBalance (a*e) (b*e) (c*(b-a)) (e*d) (Nat.mul_pos he hd)
  (Nat.mul_le_mul_right e (Nat.le_of_lt hab)) (Nat.le_of_lt bound)
 have balance := equalMovesExhaustSeparationIffHalf c e (b-a) d he hp hd
 rw [multiplyNormalized] at balance ⊢
 rw [←lower,←upper] at coordinates
 rw [subtractNormalized b a d hd (Nat.le_of_lt hab)] at coordinates
 exact coordinates.trans balance
theorem originalResidualEmptyIffHalf (a b d c e : Nat) (ha : 0<a) (hab : a<b) (hd : 0<d)
 (hc : 0<c) (hce : c<e)
 (upperWithin : (normalize 1 1 (by decide)).blt (natRatio b d hd)=false) :
 CoupledEnsembleSynchronization.residualRecord (natRatio a d hd) (natRatio b d hd) (natRatio c e (Nat.lt_trans hc hce))=.ok [] ↔
 natRatio c e (Nat.lt_trans hc hce)=CoupledEnsembleSynchronization.halfOneValue := by
 apply Iff.trans ?_ (originalPairEqualityIffHalf a b d c e ha hab hd hc hce)
 unfold CoupledEnsembleSynchronization.residualRecord
 rw [originalPairedMove a b d c e ha hab hd hc hce upperWithin]
 dsimp only [Except.bind,Bind.bind]
 let lower := add (natRatio a d hd) (multiply (natRatio c e (Nat.lt_trans hc hce)) (natRatio (b-a) d hd))
 let upper := subtract (natRatio b d hd) (multiply (natRatio c e (Nat.lt_trans hc hce)) (natRatio (b-a) d hd))
 change (if decide (lower=upper) then Except.ok [] else
  (do let delta ← CoupledEnsembleSynchronization.positiveTake (if lower.blt upper then upper else lower) (if lower.blt upper then lower else upper);pure [delta]))=Except.ok [] ↔ lower=upper
 by_cases equal : lower=upper
 · rw [decide_eq_true equal]
   exact ⟨fun _ => equal,fun _ => rfl⟩
 · rw [decide_eq_false equal]
   cases h : CoupledEnsembleSynchronization.positiveTake (if lower.blt upper then upper else lower) (if lower.blt upper then lower else upper) with
   | error message =>
    constructor
    · intro bad; change Except.error message=Except.ok [] at bad; cases bad
    · intro bad; exact False.elim (equal bad)
   | ok delta =>
    constructor
    · intro bad; change Except.ok [delta]=Except.ok [] at bad; cases bad
    · intro bad; exact False.elim (equal bad)
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


theorem originalResidualPositiveOffHalf (a b d c e : Nat) (ha : 0<a) (hab : a<b) (hd : 0<d)
 (hc : 0<c) (hce : c<e)
 (upperWithin : (normalize 1 1 (by decide)).blt (natRatio b d hd)=false)
 (offHalf : natRatio c e (Nat.lt_trans hc hce)≠CoupledEnsembleSynchronization.halfOneValue) :
 ∃ residual, CoupledEnsembleSynchronization.residualRecord (natRatio a d hd) (natRatio b d hd) (natRatio c e (Nat.lt_trans hc hce))=.ok [residual] ∧ zero.blt residual=true := by
 have he := Nat.lt_trans hc hce
 have hp := RunningConvergence.orderedDifferencePositive a b hab
 let D := e*d
 have hD : 0<D := Nat.mul_pos he hd
 let M := c*(b-a)
 let A := a*e+M
 let B := b*e-M
 have moveBelow : M<b*e :=
  Nat.lt_of_lt_of_le (Nat.mul_lt_mul_of_pos_right hce hp) (by rw [Nat.mul_comm b e];exact Nat.mul_le_mul_left e (Nat.sub_le b a))
 have hA : 0<A := Nat.add_pos_left (Nat.mul_pos ha he) M
 have hB : 0<B := RunningConvergence.orderedDifferencePositive M (b*e) moveBelow
 have lower : natRatio a d hd=natRatio (a*e) D hD := by apply natRatioCongruence;exact (mulAssoc a e d).symm
 have upper : natRatio b d hd=natRatio (b*e) D hD := by apply natRatioCongruence;exact (mulAssoc b e d).symm
 have leftValue : add (natRatio a d hd) (multiply (natRatio c e he) (natRatio (b-a) d hd))=natRatio A D hD := by
  rw [multiplyNormalized,lower];exact addNormalized (a*e) M D hD
 have rightValue : subtract (natRatio b d hd) (multiply (natRatio c e he) (natRatio (b-a) d hd))=natRatio B D hD := by
  rw [multiplyNormalized,upper];exact subtractNormalized (b*e) M D hD (Nat.le_of_lt moveBelow)
 have distinct : natRatio A D hD≠natRatio B D hD := by
  intro same
  apply offHalf
  apply (originalPairEqualityIffHalf a b d c e ha hab hd hc hce).mp
  exact leftValue.trans (same.trans rightValue.symm)
 have countsDistinct : A≠B := fun h => distinct (congrArg (fun n => natRatio n D hD) h)
 unfold CoupledEnsembleSynchronization.residualRecord
 rw [originalPairedMove a b d c e ha hab hd hc hce upperWithin]
 dsimp only [Except.bind,Bind.bind]
 rw [leftValue,rightValue]
 have unequal : (natRatio A D hD==natRatio B D hD)=false := decide_eq_false distinct
 rw [unequal]
 by_cases less : A<B
 · have cross := Nat.mul_lt_mul_of_pos_right less hD
   rw [CommonScaleAxis.positiveNormalizedLess A D B D hA hD hB hD cross]
   refine ⟨natRatio (B-A) D hD,?_,positiveNormalized (B-A) D (RunningConvergence.orderedDifferencePositive A B less) hD⟩
   change (do let delta ← CoupledEnsembleSynchronization.positiveTake (natRatio B D hD) (natRatio A D hD);pure [delta])=.ok _
   rw [positiveTakeOrdered B D A D hB hD hA hD cross,subtractNormalized B A D hD (Nat.le_of_lt less)]
   rfl
 · have reversed : B<A := Nat.lt_of_le_of_ne (Nat.le_of_not_gt less) (fun equal => countsDistinct equal.symm)
   have cross := Nat.mul_lt_mul_of_pos_right reversed hD
   rw [normalizedNotLess A D B D hA hD hB hD cross]
   refine ⟨natRatio (A-B) D hD,?_,positiveNormalized (A-B) D (RunningConvergence.orderedDifferencePositive B A reversed) hD⟩
   change (do let delta ← CoupledEnsembleSynchronization.positiveTake (natRatio A D hD) (natRatio B D hD);pure [delta])=.ok _
   rw [positiveTakeOrdered A D B D hA hD hB hD cross,subtractNormalized A B D hD (Nat.le_of_lt reversed)]
   rfl
private theorem originalCommonDenominator (lower upper : PositiveFraction) :
 let D := lower.denominator*upper.denominator
 let hd := Nat.mul_pos (Nat.pos_of_ne_zero lower.denominatorNonzero) (Nat.pos_of_ne_zero upper.denominatorNonzero)
 BoundaryGrowth.asFraction lower=natRatio (lower.numerator*upper.denominator) D hd ∧
 BoundaryGrowth.asFraction upper=natRatio (upper.numerator*lower.denominator) D hd := by
 dsimp only
 constructor
 · rw [positiveCarrierRepresentation];apply natRatioCongruence
   rw [mulRightComm,mulAssoc]
 · rw [positiveCarrierRepresentation];apply natRatioCongruence
   rw [mulAssoc]

theorem everyAdmittedPairEmptyIffHalf (lower upper coupling : PositiveFraction)
 (ordered : lower.numerator*upper.denominator<upper.numerator*lower.denominator)
 (proper : coupling.numerator<coupling.denominator)
 (upperWithin : (normalize 1 1 (by decide)).blt (BoundaryGrowth.asFraction upper)=false) :
 CoupledEnsembleSynchronization.residualRecord (BoundaryGrowth.asFraction lower) (BoundaryGrowth.asFraction upper) (BoundaryGrowth.asFraction coupling)=.ok [] ↔
 BoundaryGrowth.asFraction coupling=CoupledEnsembleSynchronization.halfOneValue := by
 have reps := originalCommonDenominator lower upper
 rw [reps.2] at upperWithin
 rw [reps.1,reps.2,positiveCarrierRepresentation coupling]
 exact originalResidualEmptyIffHalf _ _ _ _ _
  (Nat.mul_pos lower.positive (Nat.pos_of_ne_zero upper.denominatorNonzero)) ordered
  (Nat.mul_pos (Nat.pos_of_ne_zero lower.denominatorNonzero) (Nat.pos_of_ne_zero upper.denominatorNonzero))
  coupling.positive proper upperWithin

theorem everyAdmittedOffHalfResidualPositive (lower upper coupling : PositiveFraction)
 (ordered : lower.numerator*upper.denominator<upper.numerator*lower.denominator)
 (proper : coupling.numerator<coupling.denominator)
 (upperWithin : (normalize 1 1 (by decide)).blt (BoundaryGrowth.asFraction upper)=false)
 (offHalf : BoundaryGrowth.asFraction coupling≠CoupledEnsembleSynchronization.halfOneValue) :
 ∃ residual, CoupledEnsembleSynchronization.residualRecord (BoundaryGrowth.asFraction lower) (BoundaryGrowth.asFraction upper) (BoundaryGrowth.asFraction coupling)=.ok [residual] ∧ zero.blt residual=true := by
 have reps := originalCommonDenominator lower upper
 rw [reps.2] at upperWithin
 rw [positiveCarrierRepresentation coupling] at offHalf
 rw [reps.1,reps.2,positiveCarrierRepresentation coupling]
 exact originalResidualPositiveOffHalf _ _ _ _ _
  (Nat.mul_pos lower.positive (Nat.pos_of_ne_zero upper.denominatorNonzero)) ordered
  (Nat.mul_pos (Nat.pos_of_ne_zero lower.denominatorNonzero) (Nat.pos_of_ne_zero upper.denominatorNonzero))
  coupling.positive proper upperWithin offHalf
end SFT.Physics.CoupledEnsembleSynchronizationBalance

