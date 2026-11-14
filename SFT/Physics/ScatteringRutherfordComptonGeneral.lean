import SFT.Physics.ScatteringRutherfordCompton
import SFT.Physics.CommonScaleAxisAlgebra
namespace SFT.Physics.ScatteringRutherfordComptonGeneral
open ScatteringRutherfordCompton LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction SFT.Foundation.ExactCast
set_option maxHeartbeats 100000000
-- The hypotheses are exactly the executable source guards on the Fraction carriers.
theorem pairedDensityForEveryAdmittedPart (n d : Nat) (hn : 0<n) (hd : 0<d)
 (admitted : ((natRatio n d hd).num < 1 || (wholeRatio 1).blt (natRatio n d hd)) = false) :
 pairedOverlapDensity (natRatio n d hd) = .ok (natRatio (d*d) (n*n) (Nat.mul_pos hn hn)) := by
 unfold pairedOverlapDensity overlapLeg
 rw [admitted]
 change (do let leg ← LeptonRatios.divide (wholeRatio 1) (natRatio n d hd); pure (multiply leg leg)) = _
 rw [← natRatioWhole 1,divideNormalized 1 1 n d (by decide) hn hd]
 change Except.ok (multiply (natRatio (1*d) (1*n) _) (natRatio (1*d) (1*n) _)) = _
 rw [multiplyNormalized]
 apply congrArg Except.ok
 apply natRatioCongruence
 repeat rw [Nat.one_mul]
theorem shiftForEveryAdmittedPart (n d : Nat) (hd : 0<d)
 (admitted : ((natRatio n d hd).num < 1 || (wholeRatio 1).blt (natRatio n d hd)) = false) :
 photonShiftInComptonCarriers (natRatio n d hd) = .ok (natRatio (2*n) d hd) := by
 unfold photonShiftInComptonCarriers
 rw [admitted]
 change Except.ok (multiply (wholeRatio 2) (natRatio n d hd)) = _
 rw [← natRatioWhole 2,multiplyNormalized]
 apply congrArg Except.ok
 apply natRatioCongruence
 repeat rw [Nat.one_mul]
theorem pairedDensityIsReciprocalSquare (n d : Nat) (hn : 0<n) (hd : 0<d)
 (admitted : ((natRatio n d hd).num < 1 || (wholeRatio 1).blt (natRatio n d hd)) = false) :
 pairedOverlapDensity (natRatio n d hd) =
 LeptonRatios.divide (wholeRatio 1) (multiply (natRatio n d hd) (natRatio n d hd)) := by
 rw [pairedDensityForEveryAdmittedPart n d hn hd admitted,multiplyNormalized,← natRatioWhole 1,
  divideNormalized 1 1 (n*n) (d*d) (by decide) (Nat.mul_pos hn hn) (Nat.mul_pos hd hd)]
 apply congrArg Except.ok
 apply natRatioCongruence
 repeat rw [Nat.one_mul]
private theorem onePlusCarrier (n d : Nat) (hd : 0<d) :
 add (wholeRatio 1) (natRatio n d hd) = natRatio (d+n) d hd := by
 have one : wholeRatio 1 = natRatio d d hd := by
  rw [← natRatioWhole 1]
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_one]
 rw [one,addNormalized]
theorem energyRatioForEveryAdmittedCarrier (p q a b : Nat) (hq : 0<q) (hb : 0<b)
 (admitted : ((natRatio p q hq).num < 1 || (natRatio a b hb).num < 1 || (wholeRatio 1).blt (natRatio a b hb)) = false) :
 scatteredPhotonEnergyRatio (natRatio p q hq) (natRatio a b hb) =
 .ok (natRatio (q*b) (q*b+2*p*a) (Nat.add_pos_left (Nat.mul_pos hq hb) _)) := by
 unfold scatteredPhotonEnergyRatio
 rw [admitted]
 change LeptonRatios.divide (wholeRatio 1) (add (wholeRatio 1) (multiply (multiply (wholeRatio 2) (natRatio p q hq)) (natRatio a b hb))) = _
 have twoProduct : multiply (wholeRatio 2) (natRatio p q hq) = natRatio (2*p) q hq := by
  rw [← natRatioWhole 2,multiplyNormalized]
  apply natRatioCongruence
  rw [Nat.one_mul]
 rw [twoProduct,multiplyNormalized,onePlusCarrier,← natRatioWhole 1,
  divideNormalized 1 1 (q*b+2*p*a) (q*b) (by decide) (Nat.add_pos_left (Nat.mul_pos hq hb) _) (Nat.mul_pos hq hb)]
 apply congrArg Except.ok
 apply natRatioCongruence
 repeat rw [Nat.one_mul]
theorem restEnergyForEveryAdmittedCarrier (p q a b : Nat) (hq : 0<q) (hb : 0<b)
 (admitted : ((natRatio p q hq).num < 1 || (natRatio a b hb).num < 1 || (wholeRatio 1).blt (natRatio a b hb)) = false) :
 scatteredPhotonInRestUnits (natRatio p q hq) (natRatio a b hb) =
 .ok (natRatio (p*b) (q*b+2*p*a) (Nat.add_pos_left (Nat.mul_pos hq hb) _)) := by
 unfold scatteredPhotonInRestUnits
 rw [energyRatioForEveryAdmittedCarrier p q a b hq hb admitted]
 change Except.ok (multiply _ _) = _
 rw [multiplyNormalized]
 apply congrArg Except.ok
 apply natRatioCongruence
 conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
theorem ceilingForEveryAdmittedPart (a b : Nat) (ha : 0<a) (hb : 0<b)
 (admitted : ((natRatio a b hb).num < 1 || (wholeRatio 1).blt (natRatio a b hb)) = false) :
 highEnergyCeilingInRestUnits (natRatio a b hb) =
 .ok (natRatio b (2*a) (Nat.mul_pos (by decide) ha)) := by
 unfold highEnergyCeilingInRestUnits
 rw [admitted]
 change LeptonRatios.divide (wholeRatio 1) (multiply (wholeRatio 2) (natRatio a b hb)) = _
 rw [← natRatioWhole 2,multiplyNormalized,← natRatioWhole 1,
  divideNormalized 1 1 (2*a) (1*b) (by decide) (Nat.mul_pos (by decide) ha) (Nat.mul_pos (by decide) hb)]
 apply congrArg Except.ok
 apply natRatioCongruence
 repeat rw [Nat.one_mul]
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

private theorem subtractCrossRemainder (n d m e k : Nat) (hd : 0<d) (he : 0<e)
 (balance : n*e=m*d+k) :
 subtract (natRatio n d hd) (natRatio m e he)=natRatio k (d*e) (Nat.mul_pos hd he) := by
 have left : natRatio n d hd=natRatio (n*e) (d*e) (Nat.mul_pos hd he) := by
  apply natRatioCongruence
  conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 have right : natRatio m e he=natRatio (m*d) (d*e) (Nat.mul_pos hd he) := by
  apply natRatioCongruence
  conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 rw [left,right]
 have bound : m*d≤n*e := by rw [balance]; exact Nat.le_add_right _ _
 rw [subtractNormalized _ _ _ _ bound]
 apply natRatioCongruence
 rw [balance,RunningConvergence.addSubtractLeft]
private theorem positiveDepthGuard (n : Nat) : decide (Int.ofNat (n+1)<1)=false := by
 apply decide_eq_false
 intro h
 change Int.NonNeg (Int.subNatNat 1 (n+2)) at h
 unfold Int.subNatNat at h
 rw [Nat.succ_sub_succ_eq_sub,Nat.sub_zero] at h
 cases h
private theorem depthEnergy (n a b : Nat) (hb : 0<b)
 (admitted : ((natRatio a b hb).num < 1 || (wholeRatio 1).blt (natRatio a b hb)) = false) :
 scatteredPhotonInRestUnits (natRatio (n+1) 1 (by decide)) (natRatio a b hb) =
 .ok (natRatio ((n+1)*b) (b+2*(n+1)*a) (Nat.add_pos_left hb _)) := by
 have energyAdmitted : ((natRatio (n+1) 1 (by decide)).num < 1 || (natRatio a b hb).num < 1 || (wholeRatio 1).blt (natRatio a b hb)) = false := by
  rw [natRatioWhole]
  change ((decide (Int.ofNat (n+1)<1) || decide ((natRatio a b hb).num<1)) || (wholeRatio 1).blt (natRatio a b hb))=false
  rw [positiveDepthGuard]
  exact admitted
 have full := restEnergyForEveryAdmittedCarrier (n+1) 1 a b (by decide) hb energyAdmitted
 apply full.trans
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.one_mul]
theorem everyPositiveDepthGap (n a b : Nat) (ha : 0<a) (hb : 0<b)
 (admitted : ((natRatio a b hb).num < 1 || (wholeRatio 1).blt (natRatio a b hb)) = false) :
 highEnergyGap (.ofNat (n+1)) (natRatio a b hb) =
 .ok (natRatio (b*b) ((2*a)*(b+2*(n+1)*a)) (Nat.mul_pos (Nat.mul_pos (by decide) ha) (Nat.add_pos_left hb _))) := by
 unfold highEnergyGap
 rw [if_neg (of_decide_eq_false (positiveDepthGuard n))]
 change (do let ceiling ← highEnergyCeilingInRestUnits (natRatio a b hb); let outgoing ← scatteredPhotonInRestUnits (natRatio (n+1) 1 (by decide)) (natRatio a b hb); pure (subtract ceiling outgoing)) = _
 rw [ceilingForEveryAdmittedPart a b ha hb admitted,depthEnergy n a b hb admitted]
 change Except.ok (subtract _ _) = _
 apply congrArg Except.ok
 apply subtractCrossRemainder
 conv => lhs; simp only [Nat.mul_add,VacuumLedgerProofs.addMul,SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
 conv => rhs; simp only [Nat.mul_add,VacuumLedgerProofs.addMul,SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
theorem everyPositiveDepthStep (n a b : Nat) (hb : 0<b)
 (admitted : ((natRatio a b hb).num < 1 || (wholeRatio 1).blt (natRatio a b hb)) = false) :
 highEnergyStep (.ofNat (n+1)) (natRatio a b hb) =
 .ok (natRatio (b*b) ((b+2*(n+2)*a)*(b+2*(n+1)*a)) (Nat.mul_pos (Nat.add_pos_left hb _) (Nat.add_pos_left hb _))) := by
 unfold highEnergyStep
 rw [if_neg (of_decide_eq_false (positiveDepthGuard n))]
 change (do let present ← scatteredPhotonInRestUnits (natRatio (n+1) 1 (by decide)) (natRatio a b hb); let successor ← scatteredPhotonInRestUnits (natRatio (n+2) 1 (by decide)) (natRatio a b hb); pure (subtract successor present)) = _
 rw [depthEnergy n a b hb admitted,depthEnergy (n+1) a b hb admitted]
 change Except.ok (subtract _ _) = _
 apply congrArg Except.ok
 apply subtractCrossRemainder
 conv => lhs; simp only [Nat.mul_add,VacuumLedgerProofs.addMul,SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_succ,Nat.mul_zero,Nat.zero_mul,Nat.one_mul,Nat.mul_one,Nat.zero_add,Nat.add_zero]
 conv => rhs; simp only [Nat.mul_add,VacuumLedgerProofs.addMul,SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_succ,Nat.mul_zero,Nat.zero_mul,Nat.one_mul,Nat.mul_one,Nat.zero_add,Nat.add_zero]
private theorem properPartBelowOne (a d : Nat) (ha : 0<a) (hd : 0<d) (proper : a<d) :
 (natRatio a d hd).blt (wholeRatio 1)=true := by
 rw [←natRatioWhole 1]
 apply CommonScaleAxis.positiveNormalizedLess a d 1 1 ha hd (by decide) (by decide)
 rw [Nat.mul_one,Nat.one_mul]
 exact proper
private theorem properPartNotOne (a d : Nat) (hd : 0<d) (proper : a<d) :
 (natRatio a d hd == wholeRatio 1)=false := by
 change decide (natRatio a d hd=wholeRatio 1)=false
 apply decide_eq_false
 intro h
 have val := natRatioValue a d hd
 rw [h] at val
 change a*1=1*d at val
 rw [Nat.mul_one,Nat.one_mul] at val
 exact Nat.ne_of_lt proper val
theorem cumulativeAreaForEveryProperPart (a d : Nat) (ha : 0<a) (hd : 0<d) (proper : a<d)
 (admitted : ((natRatio a d hd).num < 1 || (wholeRatio 1).blt (natRatio a d hd)) = false) :
 cumulativeImpactArea (natRatio a d hd)=.ok (some (natRatio (d-a) a ha)) := by
 have take : RunningConvergence.positiveTake (wholeRatio 1) (natRatio a d hd)=.ok (natRatio (d-a) d hd) := by
  unfold RunningConvergence.positiveTake
  rw [properPartBelowOne a d ha hd proper,positiveNormalized a d ha hd]
  change Except.ok (subtract _ _) = _
  apply congrArg Except.ok
  have unit : wholeRatio 1=natRatio d d hd := by
   rw [←natRatioWhole 1]
   apply natRatioCongruence
   rw [Nat.one_mul,Nat.mul_one]
  rw [unit,subtractNormalized d a d hd (Nat.le_of_lt proper)]
 unfold cumulativeImpactArea directionComplement
 rw [admitted,properPartNotOne a d hd proper,take]
 change (do let v ← LeptonRatios.divide (natRatio (d-a) d hd) (natRatio a d hd); pure (some v)) = _
 rw [divideNormalized (d-a) d a d hd ha hd]
 apply congrArg Except.ok
 apply congrArg some
 apply natRatioCongruence
 rw [mulAssoc,Nat.mul_comm d a]
theorem terminalAreaIsStructuralEmpty (d : Nat) (hd : 0<d) :
 cumulativeImpactArea (natRatio d d hd)=.ok none := by
 have unit : natRatio d d hd=wholeRatio 1 := by
  rw [←natRatioWhole 1]
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_one]
 rw [unit]
 rfl
private theorem annularCrossBalance (a b d : Nat) (ab : a≤b) (bd : b≤d) :
 (d-a)*b=(d-b)*a+d*(b-a) := by
 have ad := Nat.le_trans ab bd
 have sums : (d-a)*b+a*b=((d-b)*a+d*(b-a))+a*b := by
  calc
   (d-a)*b+a*b = d*b := by rw [←addMul,subtractAdd d a ad]
   _ = d*a+d*(b-a) := by rw [←Nat.mul_add,Nat.add_comm a (b-a),subtractAdd b a ab]
   _ = ((d-b)*a+b*a)+d*(b-a) := by rw [←addMul,subtractAdd d b bd]
   _ = ((d-b)*a+d*(b-a))+a*b := by
    conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_comm]
    conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_comm]
 have same := congrArg (fun x => x-(a*b)) sums
 rw [Nat.add_comm ((d-a)*b) (a*b),Nat.add_comm ((d-b)*a+d*(b-a)) (a*b),RunningConvergence.addSubtractLeft,RunningConvergence.addSubtractLeft] at same
 exact same
theorem annularDensityForEveryInteriorInterval (a b d : Nat) (ha : 0<a) (ab : a<b) (bd : b<d)
 (admittedA : ((natRatio a d (Nat.lt_trans (Nat.lt_trans ha ab) bd)).num < 1 || (wholeRatio 1).blt (natRatio a d (Nat.lt_trans (Nat.lt_trans ha ab) bd))) = false)
 (admittedB : ((natRatio b d (Nat.lt_trans (Nat.lt_trans ha ab) bd)).num < 1 || (wholeRatio 1).blt (natRatio b d (Nat.lt_trans (Nat.lt_trans ha ab) bd))) = false)
 (admittedInterval : ((natRatio a d (Nat.lt_trans (Nat.lt_trans ha ab) bd)).num < 1 || !(natRatio a d (Nat.lt_trans (Nat.lt_trans ha ab) bd)).blt (natRatio b d (Nat.lt_trans (Nat.lt_trans ha ab) bd)) || (wholeRatio 1).blt (natRatio b d (Nat.lt_trans (Nat.lt_trans ha ab) bd))) = false) :
 annularTransferDensity (natRatio a d (Nat.lt_trans (Nat.lt_trans ha ab) bd)) (natRatio b d (Nat.lt_trans (Nat.lt_trans ha ab) bd)) =
 .ok (natRatio (d*d) (a*b) (Nat.mul_pos ha (Nat.lt_trans ha ab))) := by
 let hd := Nat.lt_trans (Nat.lt_trans ha ab) bd
 let hb := Nat.lt_trans ha ab
 let gap := RunningConvergence.orderedDifferencePositive a b ab
 let da := RunningConvergence.orderedDifferencePositive a d (Nat.lt_trans ab bd)
 let db := RunningConvergence.orderedDifferencePositive b d bd
 have balance := annularCrossBalance a b d (Nat.le_of_lt ab) (Nat.le_of_lt bd)
 have order : (d-b)*a < (d-a)*b := by rw [balance]; exact Nat.lt_add_of_pos_right (Nat.mul_pos hd gap)
 have removed : RunningConvergence.positiveTake (natRatio (d-a) a ha) (natRatio (d-b) b hb)=.ok (natRatio (d*(b-a)) (a*b) (Nat.mul_pos ha hb)) := by
  unfold RunningConvergence.positiveTake
  rw [CommonScaleAxis.positiveNormalizedLess (d-b) b (d-a) a db hb da ha order,positiveNormalized (d-b) b db hb]
  change Except.ok (subtract _ _) = _
  exact congrArg Except.ok (subtractCrossRemainder (d-a) a (d-b) b (d*(b-a)) ha hb balance)
 have interval : RunningConvergence.positiveTake (natRatio b d hd) (natRatio a d hd)=.ok (natRatio (b-a) d hd) := by
  unfold RunningConvergence.positiveTake
  rw [CommonScaleAxis.positiveNormalizedLess a d b d ha hd hb hd (Nat.mul_lt_mul_of_pos_right ab hd),positiveNormalized a d ha hd]
  change Except.ok (subtract _ _) = _
  exact congrArg Except.ok (subtractNormalized b a d hd (Nat.le_of_lt ab))
 unfold annularTransferDensity
 rw [admittedInterval,cumulativeAreaForEveryProperPart a d ha hd (Nat.lt_trans ab bd) admittedA,cumulativeAreaForEveryProperPart b d hb hd bd admittedB]
 change (do let removed ← RunningConvergence.positiveTake (natRatio (d-a) a ha) (natRatio (d-b) b hb); let interval ← RunningConvergence.positiveTake (natRatio b d hd) (natRatio a d hd); LeptonRatios.divide removed interval) = _
 rw [removed,interval]
 change LeptonRatios.divide (natRatio (d*(b-a)) (a*b) (Nat.mul_pos ha hb)) (natRatio (b-a) d hd) = _
 rw [divideNormalized (d*(b-a)) (a*b) (b-a) d (Nat.mul_pos ha hb) gap hd]
 apply congrArg Except.ok
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
theorem annularDensityAtBackscatter (a d : Nat) (ha : 0<a) (ad : a<d)
 (admittedA : ((natRatio a d (Nat.lt_trans ha ad)).num < 1 || (wholeRatio 1).blt (natRatio a d (Nat.lt_trans ha ad))) = false)
 (admittedInterval : ((natRatio a d (Nat.lt_trans ha ad)).num < 1 || !(natRatio a d (Nat.lt_trans ha ad)).blt (natRatio d d (Nat.lt_trans ha ad)) || (wholeRatio 1).blt (natRatio d d (Nat.lt_trans ha ad))) = false) :
 annularTransferDensity (natRatio a d (Nat.lt_trans ha ad)) (natRatio d d (Nat.lt_trans ha ad)) =
 .ok (natRatio d a ha) := by
 let hd := Nat.lt_trans ha ad
 have unit : natRatio d d hd=wholeRatio 1 := by
  rw [←natRatioWhole 1]
  apply natRatioCongruence
  rw [Nat.mul_one,Nat.one_mul]
 have interval : RunningConvergence.positiveTake (natRatio d d hd) (natRatio a d hd)=.ok (natRatio (d-a) d hd) := by
  unfold RunningConvergence.positiveTake
  rw [CommonScaleAxis.positiveNormalizedLess a d d d ha hd hd hd (Nat.mul_lt_mul_of_pos_right ad hd),positiveNormalized a d ha hd]
  change Except.ok (subtract _ _) = _
  exact congrArg Except.ok (subtractNormalized d a d hd (Nat.le_of_lt ad))
 unfold annularTransferDensity
 rw [admittedInterval,cumulativeAreaForEveryProperPart a d ha hd ad admittedA,terminalAreaIsStructuralEmpty d hd]
 change (do let gap ← RunningConvergence.positiveTake (natRatio d d hd) (natRatio a d hd); LeptonRatios.divide (natRatio (d-a) a ha) gap) = _
 rw [interval]
 change LeptonRatios.divide (natRatio (d-a) a ha) (natRatio (d-a) d hd) = _
 rw [divideNormalized (d-a) a (d-a) d ha (RunningConvergence.orderedDifferencePositive a d ad) hd]
 apply congrArg Except.ok
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
theorem conservationForEveryAdmittedLoss (p q t v : Nat) (hp : 0<p) (hq : 0<q) (ht : 0<t) (loss : t<v)
 (admitted : ((natRatio p q hq).num < 1 || (natRatio t v (Nat.lt_trans ht loss)).num < 1 || !(natRatio t v (Nat.lt_trans ht loss)).blt (wholeRatio 1)) = false) :
 comptonConservationTransfer (natRatio p q hq) (natRatio t v (Nat.lt_trans ht loss)) =
 .ok (natRatio (q*(v-t)) (p*t) (Nat.mul_pos hp ht)) := by
 let hv := Nat.lt_trans ht loss
 let hpt := Nat.mul_pos hp ht
 have inverseProduct : LeptonRatios.divide (wholeRatio 1) (multiply (natRatio p q hq) (natRatio t v hv))=.ok (natRatio (q*v) (p*t) hpt) := by
  rw [multiplyNormalized,←natRatioWhole 1,divideNormalized 1 1 (p*t) (q*v) (by decide) hpt (Nat.mul_pos hq hv)]
  apply congrArg Except.ok
  apply natRatioCongruence
  repeat rw [Nat.one_mul]
 have inverseIncident : LeptonRatios.divide (wholeRatio 1) (natRatio p q hq)=.ok (natRatio (q*t) (p*t) hpt) := by
  rw [←natRatioWhole 1,divideNormalized 1 1 p q (by decide) hp hq]
  apply congrArg Except.ok
  apply natRatioCongruence
  conv => lhs; simp only [Nat.one_mul,mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [Nat.one_mul,mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 unfold comptonConservationTransfer
 rw [admitted]
 change (do let outgoing ← LeptonRatios.divide (wholeRatio 1) (multiply (natRatio p q hq) (natRatio t v hv)); let incident ← LeptonRatios.divide (wholeRatio 1) (natRatio p q hq); RunningConvergence.positiveTake outgoing incident) = _
 rw [inverseProduct,inverseIncident]
 change RunningConvergence.positiveTake (natRatio (q*v) (p*t) hpt) (natRatio (q*t) (p*t) hpt) = _
 unfold RunningConvergence.positiveTake
 have order : (q*t)*(p*t)<(q*v)*(p*t) := Nat.mul_lt_mul_of_pos_right (Nat.mul_lt_mul_of_pos_left loss hq) hpt
 rw [CommonScaleAxis.positiveNormalizedLess (q*t) (p*t) (q*v) (p*t) (Nat.mul_pos hq ht) hpt (Nat.mul_pos hq hv) hpt order,positiveNormalized (q*t) (p*t) (Nat.mul_pos hq ht) hpt]
 change Except.ok (subtract _ _) = _
 rw [subtractNormalized (q*v) (q*t) (p*t) hpt (Nat.mul_le_mul_left q (Nat.le_of_lt loss))]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.mul_comm q v,Nat.mul_comm q t,←multiplyDifference v t q (Nat.le_of_lt loss),Nat.mul_comm (v-t) q]
private theorem equalRatiosCross (n d m e : Nat) (hd : 0<d) (he : 0<e)
 (same : natRatio n d hd=natRatio m e he) : n*e=m*d := by
 have nv := natRatioValue n d hd
 have mv := natRatioValue m e he
 rw [same] at nv
 apply Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero (natRatio m e he).den_nz)
 calc
  (n*e)*(natRatio m e he).den = (n*(natRatio m e he).den)*e := mulRightComm _ _ _
  _ = ((natRatio m e he).num.natAbs*d)*e := congrArg (fun z => z*e) nv
  _ = ((natRatio m e he).num.natAbs*e)*d := mulRightComm _ _ _
  _ = (m*(natRatio m e he).den)*d := congrArg (fun z => z*d) mv.symm
  _ = (m*d)*(natRatio m e he).den := mulRightComm _ _ _
theorem conservationUniquelyFixesEnergyRatio (p q t v a b : Nat)
 (hp : 0<p) (hq : 0<q) (ht : 0<t) (hb : 0<b) (loss : t<v)
 (admitted : ((natRatio p q hq).num < 1 || (natRatio t v (Nat.lt_trans ht loss)).num < 1 || !(natRatio t v (Nat.lt_trans ht loss)).blt (wholeRatio 1)) = false)
 (conservation : comptonConservationTransfer (natRatio p q hq) (natRatio t v (Nat.lt_trans ht loss))=.ok (natRatio (2*a) b hb)) :
 natRatio t v (Nat.lt_trans ht loss)=natRatio (q*b) (q*b+2*p*a) (Nat.add_pos_left (Nat.mul_pos hq hb) _) := by
 rw [conservationForEveryAdmittedLoss p q t v hp hq ht loss admitted] at conservation
 have cross := equalRatiosCross (q*(v-t)) (p*t) (2*a) b (Nat.mul_pos hp ht) hb (Except.ok.inj conservation)
 apply natRatioCongruence
 have split : v=(v-t)+t := (subtractAdd v t (Nat.le_of_lt loss)).symm
 calc
  t*(q*b+2*p*a) = (2*a)*(p*t)+(q*t)*b := by
   conv => lhs; simp only [Nat.mul_add,addMul,mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
   conv => rhs; simp only [Nat.mul_add,addMul,mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
  _ = (q*(v-t))*b+(q*t)*b := congrArg (fun z => z+(q*t)*b) cross.symm
  _ = (q*b)*((v-t)+t) := by
   conv => lhs; simp only [Nat.mul_add,addMul,mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
   conv => rhs; simp only [Nat.mul_add,addMul,mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
  _ = (q*b)*v := congrArg (fun z => (q*b)*z) split.symm
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


private theorem positiveNumeratorGuard (n d : Nat) (hn : 0<n) (hd : 0<d) :
 decide ((natRatio n d hd).num<1)=false := by
 rw [natRatioNonnegative n d hd]
 have pos := positiveNormalizedNumerator n d hn hd
 generalize h : (natRatio n d hd).num.natAbs=k at pos ⊢
 cases k with
 | zero => cases pos
 | succ k => exact positiveDepthGuard k
theorem everyPositivePartAdmitted (a b : Nat) (ha : 0<a) (hb : 0<b) (part : a≤b) :
 ((natRatio a b hb).num < 1 || (wholeRatio 1).blt (natRatio a b hb)) = false := by
 rw [positiveNumeratorGuard a b ha hb]
 change (wholeRatio 1).blt (natRatio a b hb)=false
 cases Nat.lt_or_eq_of_le part with
 | inl proper =>
  rw [←natRatioWhole 1]
  apply normalizedNotLess 1 1 a b (by decide) (by decide) ha hb
  rw [Nat.mul_one,Nat.one_mul]
  exact proper
 | inr same =>
  cases same
  have unit : natRatio a a hb=wholeRatio 1 := by
   rw [←natRatioWhole 1]
   apply natRatioCongruence
   rw [Nat.mul_one,Nat.one_mul]
  rw [unit]
  rfl
theorem everyPositiveIncidentAdmitted (p q a b : Nat) (hp : 0<p) (hq : 0<q) (ha : 0<a) (hb : 0<b) (part : a≤b) :
 ((natRatio p q hq).num < 1 || (natRatio a b hb).num < 1 || (wholeRatio 1).blt (natRatio a b hb)) = false := by
 rw [positiveNumeratorGuard p q hp hq]
 exact everyPositivePartAdmitted a b ha hb part
theorem everyPositiveLossAdmitted (p q t v : Nat) (hp : 0<p) (hq : 0<q) (ht : 0<t) (loss : t<v) :
 ((natRatio p q hq).num < 1 || (natRatio t v (Nat.lt_trans ht loss)).num < 1 || !(natRatio t v (Nat.lt_trans ht loss)).blt (wholeRatio 1)) = false := by
 rw [positiveNumeratorGuard p q hp hq,positiveNumeratorGuard t v ht (Nat.lt_trans ht loss),properPartBelowOne t v ht (Nat.lt_trans ht loss) loss]
 rfl
theorem everyOrderedIntervalAdmitted (a b d : Nat) (ha : 0<a) (ab : a<b) (bd : b≤d) :
 ((natRatio a d (Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd)).num < 1 || !(natRatio a d (Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd)).blt (natRatio b d (Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd)) || (wholeRatio 1).blt (natRatio b d (Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd))) = false := by
 let hd := Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd
 rw [positiveNumeratorGuard a d ha hd,CommonScaleAxis.positiveNormalizedLess a d b d ha hd (Nat.lt_trans ha ab) hd (Nat.mul_lt_mul_of_pos_right ab hd)]
 have guard := everyPositivePartAdmitted b d (Nat.lt_trans ha ab) hd bd
 rw [positiveNumeratorGuard b d (Nat.lt_trans ha ab) hd] at guard
 exact guard
theorem allPositiveDepthGaps (n a b : Nat) (ha : 0<a) (hb : 0<b) (part : a≤b) :
 (highEnergyGap (.ofNat (n+1)) (natRatio a b hb)).map (fun r => zero.blt r)=.ok true := by
 rw [everyPositiveDepthGap n a b ha hb (everyPositivePartAdmitted a b ha hb part)]
 change Except.ok (zero.blt (natRatio (b*b) _ _))=.ok true
 rw [positiveNormalized (b*b) _ (Nat.mul_pos hb hb)]
theorem allPositiveDepthSteps (n a b : Nat) (ha : 0<a) (hb : 0<b) (part : a≤b) :
 (highEnergyStep (.ofNat (n+1)) (natRatio a b hb)).map (fun r => zero.blt r)=.ok true := by
 rw [everyPositiveDepthStep n a b hb (everyPositivePartAdmitted a b ha hb part)]
 change Except.ok (zero.blt (natRatio (b*b) _ _))=.ok true
 rw [positiveNormalized (b*b) _ (Nat.mul_pos hb hb)]
theorem energySolutionConserves (p q a b : Nat) (hp : 0<p) (hq : 0<q) (ha : 0<a) (hb : 0<b) :
 comptonConservationTransfer (natRatio p q hq)
  (natRatio (q*b) (q*b+2*p*a) (Nat.add_pos_left (Nat.mul_pos hq hb) _))=.ok (natRatio (2*a) b hb) := by
 have loss : q*b<q*b+2*p*a := Nat.lt_add_of_pos_right (Nat.mul_pos (Nat.mul_pos (by decide) hp) ha)
 rw [conservationForEveryAdmittedLoss p q (q*b) (q*b+2*p*a) hp hq (Nat.mul_pos hq hb) loss
  (everyPositiveLossAdmitted p q (q*b) (q*b+2*p*a) hp hq (Nat.mul_pos hq hb) loss)]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [RunningConvergence.addSubtractLeft]
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
theorem everyOrderedAnnularDensity (a b d : Nat) (ha : 0<a) (ab : a<b) (bd : b≤d) :
 annularTransferDensity (natRatio a d (Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd)) (natRatio b d (Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd)) =
 .ok (natRatio (d*d) (a*b) (Nat.mul_pos ha (Nat.lt_trans ha ab))) := by
 let hd := Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd
 cases Nat.lt_or_eq_of_le bd with
 | inl proper =>
  exact annularDensityForEveryInteriorInterval a b d ha ab proper
   (everyPositivePartAdmitted a d ha hd (Nat.le_trans (Nat.le_of_lt ab) bd))
   (everyPositivePartAdmitted b d (Nat.lt_trans ha ab) hd bd)
   (everyOrderedIntervalAdmitted a b d ha ab bd)
 | inr equal =>
  cases equal
  rw [annularDensityAtBackscatter a b ha ab (everyPositivePartAdmitted a b ha (Nat.lt_trans ha ab) (Nat.le_of_lt ab)) (everyOrderedIntervalAdmitted a b b ha ab (Nat.le_refl b))]
  apply congrArg Except.ok
  apply natRatioCongruence
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
theorem everyAnnularReciprocalProduct (a b d : Nat) (ha : 0<a) (ab : a<b) (bd : b≤d) :
 annularTransferDensity (natRatio a d (Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd)) (natRatio b d (Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd)) =
 LeptonRatios.divide (wholeRatio 1) (multiply (natRatio a d (Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd)) (natRatio b d (Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd))) := by
 let hd := Nat.lt_of_lt_of_le (Nat.lt_trans ha ab) bd
 rw [everyOrderedAnnularDensity a b d ha ab bd,multiplyNormalized,←natRatioWhole 1,
  divideNormalized 1 1 (a*b) (d*d) (by decide) (Nat.mul_pos ha (Nat.lt_trans ha ab)) (Nat.mul_pos hd hd)]
 apply congrArg Except.ok
 apply natRatioCongruence
 repeat rw [Nat.one_mul]
theorem coulombScaleForEveryPositiveCarrier (n d p q : Nat) (hn : 0<n) (hd : 0<d) (hp : 0<p) (hq : 0<q) :
 coulombBackscatterScale (natRatio n d hd) (natRatio p q hq) =
 .ok (natRatio ((n*q)*(n*q)) ((d*(4*p))*(d*(4*p))) (Nat.mul_pos (Nat.mul_pos hd (Nat.mul_pos (by decide) hp)) (Nat.mul_pos hd (Nat.mul_pos (by decide) hp)))) := by
 unfold coulombBackscatterScale
 rw [positiveNumeratorGuard n d hn hd,positiveNumeratorGuard p q hp hq]
 change (do let approach ← LeptonRatios.divide (natRatio n d hd) (multiply (wholeRatio 4) (natRatio p q hq)); pure (multiply approach approach)) = _
 have four : multiply (wholeRatio 4) (natRatio p q hq)=natRatio (4*p) q hq := by
  rw [←natRatioWhole 4,multiplyNormalized]
  apply natRatioCongruence
  rw [Nat.one_mul]
 rw [four,divideNormalized n d (4*p) q hd (Nat.mul_pos (by decide) hp) hq]
 change Except.ok (multiply _ _) = _
 rw [multiplyNormalized]
theorem actualEnergyRatioSatisfiesConservation (p q a b : Nat) (hp : 0<p) (hq : 0<q) (ha : 0<a) (hb : 0<b) (part : a≤b) :
 (do let r ← scatteredPhotonEnergyRatio (natRatio p q hq) (natRatio a b hb); comptonConservationTransfer (natRatio p q hq) r)=.ok (natRatio (2*a) b hb) := by
 rw [energyRatioForEveryAdmittedCarrier p q a b hq hb (everyPositiveIncidentAdmitted p q a b hp hq ha hb part)]
 change comptonConservationTransfer _ _ = _
 exact energySolutionConserves p q a b hp hq ha hb
end SFT.Physics.ScatteringRutherfordComptonGeneral
