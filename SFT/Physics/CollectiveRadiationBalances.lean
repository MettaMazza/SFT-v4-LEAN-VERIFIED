import SFT.Physics.CollectiveRadiation
import SFT.Physics.ThermalHistoryTransport
namespace SFT.Physics.CollectiveRadiationBalances
open CollectiveRadiation LeptonIntervals VacuumLedgerProofs VacuumScaleProofs GravitySourceProofs
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar

theorem originalPositiveAdmission (p : PositiveFraction) (name : String) :
 requirePositive (BoundaryGrowth.asFraction p) name=.ok (BoundaryGrowth.asFraction p) :=
 ThermalHistoryTransport.admittedPositive p name

theorem originalFourthPower (p : PositiveFraction) :
 radiationPowerRatio (BoundaryGrowth.asFraction p)=.ok
 (BoundaryGrowth.asFraction (BoundaryGrowth.multiply (BoundaryGrowth.multiply (BoundaryGrowth.multiply p p) p) p)) := by
 unfold radiationPowerRatio
 rw [originalPositiveAdmission]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceProduct,sourceProduct,sourceProduct]
 rfl

theorem originalAcousticLadder (p : PositiveFraction) (n : Nat) :
 acousticLadder (BoundaryGrowth.asFraction p) (.integer (.ofNat (n+1))) =
 .ok ((List.range (n+1)).map (fun k => multiply (wholeRatio (k+1)) (BoundaryGrowth.asFraction p))) := by
 unfold acousticLadder
 rw [originalPositiveAdmission]
 rfl

theorem originalPlasmaBalances (n q m e t : PositiveFraction) :
 plasmaSquaredCarriers (BoundaryGrowth.asFraction n) (BoundaryGrowth.asFraction q)
 (BoundaryGrowth.asFraction m) (BoundaryGrowth.asFraction e) (BoundaryGrowth.asFraction t)=
 .ok ⟨BoundaryGrowth.asFraction (quotientMagnitude (BoundaryGrowth.multiply (BoundaryGrowth.multiply n q) q) (BoundaryGrowth.multiply m e)),
 BoundaryGrowth.asFraction (quotientMagnitude (BoundaryGrowth.multiply e t) (BoundaryGrowth.multiply (BoundaryGrowth.multiply n q) q))⟩ := by
 unfold plasmaSquaredCarriers
 rw [originalPositiveAdmission,originalPositiveAdmission,originalPositiveAdmission,originalPositiveAdmission,originalPositiveAdmission]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceProduct,sourceProduct,sourceProduct,sourceProduct,sourceQuotient]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceQuotient]
 rfl

theorem originalAlfvenBalance (b mu rho : PositiveFraction) :
 alfvenSquaredCarrier (BoundaryGrowth.asFraction b) (BoundaryGrowth.asFraction mu) (BoundaryGrowth.asFraction rho)=
 .ok (BoundaryGrowth.asFraction (quotientMagnitude (BoundaryGrowth.multiply b b) (BoundaryGrowth.multiply mu rho))) := by
 unfold alfvenSquaredCarrier
 rw [originalPositiveAdmission,originalPositiveAdmission,originalPositiveAdmission]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceProduct,sourceProduct,sourceQuotient]

theorem originalPositiveLaserLedger (excited lower ticks : Nat) (he : 0<excited) (hl : 0<lower) (ht : 0<ticks)
 (gain loss : PositiveFraction) :
 laserLedger (.integer (.ofNat excited)) (.integer (.ofNat lower))
 (BoundaryGrowth.asFraction gain) (BoundaryGrowth.asFraction loss) (.integer (.ofNat ticks)) =
 .ok ⟨natRatio excited (excited+lower) (Nat.lt_of_lt_of_le he (Nat.le_add_right _ _)),
 (natRatio 1 2 (by decide)).blt (natRatio excited (excited+lower) (Nat.lt_of_lt_of_le he (Nat.le_add_right _ _))),
 VelocityComposition.ratEqual (BoundaryGrowth.asFraction gain) (BoundaryGrowth.asFraction loss),
 (BoundaryGrowth.asFraction loss).blt (BoundaryGrowth.asFraction gain) &&
 (natRatio 1 2 (by decide)).blt (natRatio excited (excited+lower) (Nat.lt_of_lt_of_le he (Nat.le_add_right _ _))),
 natRatio 1 ticks ht,wholeRatio 1⟩ := by
 have inversion : LeptonRatios.divide (wholeRatio excited) (wholeRatio (excited+lower)) =
  .ok (natRatio excited (excited+lower) (Nat.lt_of_lt_of_le he (Nat.le_add_right _ _))) := by
   rw [←natRatioWhole excited,←natRatioWhole (excited+lower)]
   rw [divideNormalized _ _ _ _ (by decide) (Nat.lt_of_lt_of_le he (Nat.le_add_right _ _)) (by decide)]
   apply congrArg Except.ok
   apply natRatioCongruence
   rw [Nat.mul_one,Nat.one_mul]
 have width : LeptonRatios.divide (wholeRatio 1) (wholeRatio ticks)=.ok (natRatio 1 ticks ht) := by
   rw [←natRatioWhole 1,←natRatioWhole ticks]
   rw [divideNormalized _ _ _ _ (by decide) ht (by decide)]
   apply congrArg Except.ok
   apply natRatioCongruence
   repeat first | rw [Nat.one_mul] | rw [Nat.mul_one]
 have closed : multiply (natRatio 1 ticks ht) (wholeRatio ticks)=wholeRatio 1 := by
   rw [←natRatioWhole ticks,←natRatioWhole 1]
   rw [multiplyNormalized]
   apply natRatioCongruence
   repeat first | rw [Nat.one_mul] | rw [Nat.mul_one]
 unfold laserLedger
 cases excited with
 | zero => cases he
 | succ e =>
   cases lower with
   | zero => cases hl
   | succ l =>
     cases ticks with
     | zero => cases ht
     | succ k =>
       dsimp only [positiveCount,Except.bind,Bind.bind]
       rw [originalPositiveAdmission,originalPositiveAdmission]
       dsimp only [Except.bind,Bind.bind]
       rw [inversion]
       dsimp only [Except.bind,Bind.bind]
       rw [width]
       dsimp only [Except.bind,Bind.bind]
       rw [closed]
       rfl
end SFT.Physics.CollectiveRadiationBalances
