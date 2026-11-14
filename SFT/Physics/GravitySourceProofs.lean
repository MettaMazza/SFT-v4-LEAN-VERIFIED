import SFT.Physics.GravityFlux
import SFT.Physics.MagneticCovariance
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.GravitySourceProofs
open SFT.Foundation ExactOperations ExactPartCarrier
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Mathematics.FoldScalar

private theorem integerNotLess (a b : Nat) (bound : b≤a) : ¬Int.ofNat a<Int.ofNat b := by
 intro h
 change Int.NonNeg (Int.subNatNat b (a+1)) at h
 unfold Int.subNatNat at h
 have positive := RunningConvergence.orderedDifferencePositive _ _ (Nat.lt_succ_of_le bound)
 cases hd : (a+1)-b with
 | zero => rw [hd] at positive; cases positive
 | succ n => rw [hd] at h; cases h

private theorem oneNotBelow (p : PositiveFraction) (bound : p.numerator≤p.denominator) :
 (asFraction one).blt (BoundaryGrowth.asFraction p)=false := by
 change (⟨1,1,by decide,by decide⟩ : Rat).blt (BoundaryGrowth.asFraction p)=false
 cases p with
 | mk n d dz reduced positive =>
  cases n with
  | zero => cases positive
  | succ n =>
   unfold Rat.blt BoundaryGrowth.asFraction
   dsimp only
   have notNonpos : ¬Int.ofNat (n+1)≤0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (n+1)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   rw [decide_eq_false notNonpos]
   change decide (Int.ofNat (1*d)<Int.ofNat ((n+1)*1))=false
   rw [Nat.one_mul,Nat.mul_one]
   exact decide_eq_false (integerNotLess _ _ bound)

theorem takeBelowOne (p : PositiveFraction) (below : p.numerator<p.denominator) :
 GravityFlux.positiveTake (.fraction (asFraction one)) (.fraction (BoundaryGrowth.asFraction p))=
 .ok (some (subtract (asFraction one) (BoundaryGrowth.asFraction p))) := by
 have pos : zero.blt (BoundaryGrowth.asFraction p)=true := by
  rw [positiveCarrierRepresentation]
  exact positiveNormalized _ _ p.positive _
 have small : (BoundaryGrowth.asFraction p).blt (asFraction one)=true := by
  rw [positiveCarrierRepresentation]
  apply CommonScaleAxis.positiveNormalizedLess _ _ 1 1 p.positive _ (by decide) (by decide)
  rw [Nat.mul_one,Nat.one_mul]
  exact below
 unfold GravityFlux.positiveTake
 dsimp only
 rw [oneNotBelow p (Nat.le_of_lt below),pos,small]
 rfl

theorem sourceProduct (a b : PositiveFraction) :
 multiply (BoundaryGrowth.asFraction a) (BoundaryGrowth.asFraction b)=
 BoundaryGrowth.asFraction (BoundaryGrowth.multiply a b) := by
 change normalize (Int.ofNat (a.numerator*b.numerator)) (a.denominator*b.denominator) _ = _
 exact (CommonScaleAxis.normalizedPositiveAsRat _ _ (Nat.mul_pos a.positive b.positive) _).symm

theorem sourceQuotient (a b : PositiveFraction) :
 LeptonRatios.divide (BoundaryGrowth.asFraction a) (BoundaryGrowth.asFraction b)=
 .ok (BoundaryGrowth.asFraction (quotientMagnitude a b)) := by
 rw [positiveCarrierRepresentation a,positiveCarrierRepresentation b,divideNormalized _ _ _ _ _ b.positive]
 apply congrArg Except.ok
 exact (representedIdentity (BoundaryGrowth.asFraction (quotientMagnitude a b))
  (a.numerator*b.denominator) (a.denominator*b.numerator) _ rfl (quotientExact a b)).symm

theorem admittedSourceRecord (source radius : PositiveFraction)
 (ordered : source.numerator*radius.denominator<radius.numerator*source.denominator)
 (throughOne : radius.numerator≤radius.denominator) :
 GravityFlux.weakGravity (.fraction (BoundaryGrowth.asFraction source)) (.fraction (BoundaryGrowth.asFraction radius))=
 .ok ⟨BoundaryGrowth.asFraction (InverseSquare.exactResponse source radius),BoundaryGrowth.asFraction source,
  subtract (asFraction one) (BoundaryGrowth.asFraction (quotientMagnitude source radius))⟩ := by
 have positive : zero.blt (BoundaryGrowth.asFraction source)=true := by
  rw [positiveCarrierRepresentation];exact positiveNormalized _ _ source.positive _
 have less : (BoundaryGrowth.asFraction source).blt (BoundaryGrowth.asFraction radius)=true := by
  rw [positiveCarrierRepresentation source,positiveCarrierRepresentation radius]
  exact CommonScaleAxis.positiveNormalizedLess _ _ _ _ source.positive _ radius.positive _ ordered
 unfold GravityFlux.weakGravity
 dsimp only
 rw [positive,less,oneNotBelow radius throughOne]
 dsimp only [Bool.not_true,Bool.not_false,Bool.true_and,ite_false,Except.bind,Bind.bind]
 rw [sourceProduct,sourceQuotient,sourceQuotient]
 dsimp only [Except.bind,Bind.bind]
 rw [takeBelowOne _ (CoulombGauss.quotientBelowOne source radius ordered)]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceProduct,sourceProduct]
 change (if !(BoundaryGrowth.asFraction (BoundaryGrowth.multiply (BoundaryGrowth.multiply (InverseSquare.exactResponse source radius) radius) radius)).blt (BoundaryGrowth.asFraction source) &&
  !(BoundaryGrowth.asFraction source).blt (BoundaryGrowth.asFraction (BoundaryGrowth.multiply (BoundaryGrowth.multiply (InverseSquare.exactResponse source radius) radius) radius)) then _ else _) = _
 rw [CoulombGauss.sequentialFluxReturnsSource,MagneticCovariance.positiveNotLessSelf]
 dsimp only [Bool.not_false,Bool.true_and,ite_true,Except.pure,Pure.pure]
 change Except.ok (⟨BoundaryGrowth.asFraction (InverseSquare.exactResponse source radius),
  BoundaryGrowth.asFraction (BoundaryGrowth.multiply (BoundaryGrowth.multiply (InverseSquare.exactResponse source radius) radius) radius),
  subtract (asFraction one) (BoundaryGrowth.asFraction (quotientMagnitude source radius))⟩ : GravityFlux.Result)=_
 rw [CoulombGauss.sequentialFluxReturnsSource]
end SFT.Physics.GravitySourceProofs
