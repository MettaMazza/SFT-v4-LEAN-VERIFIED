import SFT.Physics.CosmicComponentTransport
import SFT.Physics.CommonScaleAxisAlgebra
namespace SFT.Physics.CosmicComponentTransport
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 8000000

def cube (n : Nat) : Nat := n*n*n
theorem cubePositive (n : Nat) (h : 0<n) : 0<cube n := Nat.mul_pos (Nat.mul_pos h h) h

def rateNumerator (n d : Nat) := 11*cube d+5*cube n
theorem ratePositive (n d : Nat) (hd : 0<d) : 0<rateNumerator n d :=
 Nat.add_pos_left (Nat.mul_pos (by decide) (cubePositive d hd)) _

theorem positiveStretchAdmitted (r : Rat) (h : zero.blt r=true) : requirePositiveExact r=.ok r := by
 unfold requirePositiveExact
 rw [h]
 rfl

theorem normalizedStretchAdmitted (n d : Nat) (hn : 0<n) (hd : 0<d) :
 requirePositiveExact (natRatio n d hd)=.ok (natRatio n d hd) :=
 positiveStretchAdmitted _ (positiveNormalized n d hn hd)

theorem matterFromThreeSpace (r : Rat) (h : zero.blt r=true) :
 matterTransport r=.ok (multiply (multiply r r) r) := by
 unfold matterTransport
 rw [positiveStretchAdmitted r h]
 rfl

theorem radiationAddsOneRecurrence (r : Rat) (h : zero.blt r=true) :
 radiationTransport r=(matterTransport r).map (fun volume => multiply volume r) := by
 unfold radiationTransport
 rw [positiveStretchAdmitted r h,matterFromThreeSpace r h]
 rfl

theorem invariantRetainsOne (r : Rat) (h : zero.blt r=true) :
 vacuumTransport r=.ok (normalize 1 1 (by decide)) := by
 unfold vacuumTransport
 rw [positiveStretchAdmitted r h]
 rfl

theorem everyMatterTransport (n d : Nat) (hn : 0<n) (hd : 0<d) :
 matterTransport (natRatio n d hd)=.ok (natRatio (cube n) (cube d) (cubePositive d hd)) := by
 rw [matterFromThreeSpace _ (positiveNormalized n d hn hd),multiplyNormalized,multiplyNormalized]
 rfl

theorem everyRadiationTransport (n d : Nat) (hn : 0<n) (hd : 0<d) :
 radiationTransport (natRatio n d hd)=.ok (natRatio (cube n*n) (cube d*d) (Nat.mul_pos (cubePositive d hd) hd)) := by
 rw [radiationAddsOneRecurrence _ (positiveNormalized n d hn hd),everyMatterTransport n d hn hd]
 change Except.ok (multiply (natRatio (cube n) (cube d) _) (natRatio n d hd))=_
 rw [multiplyNormalized]

theorem vacuumAtCommonDenominator (d : Nat) (hd : 0<d) :
 vacuumToday=natRatio (11*cube d) (16*cube d) (Nat.mul_pos (by decide) (cubePositive d hd)) := by
 change natRatio 11 16 _=_
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]

theorem everySquaredExpansion (n d : Nat) (hn : 0<n) (hd : 0<d) :
 lateSquaredExpansion (natRatio n d hd)=.ok (natRatio (rateNumerator n d) (16*cube d)
  (Nat.mul_pos (by decide) (cubePositive d hd))) := by
 unfold lateSquaredExpansion
 rw [normalizedStretchAdmitted n d hn hd]
 change (do let volume ← matterTransport (natRatio n d hd); Except.ok (add vacuumToday (multiply matterToday volume)))=_
 rw [everyMatterTransport n d hn hd]
 change Except.ok (add vacuumToday (multiply (natRatio 5 16 _) (natRatio (cube n) (cube d) _)))=_
 rw [multiplyNormalized,vacuumAtCommonDenominator d hd,addNormalized]
 rfl

theorem everyMatterFraction (n d : Nat) (hn : 0<n) (hd : 0<d) :
 matterFraction (natRatio n d hd)=.ok (natRatio (5*cube n) (rateNumerator n d) (ratePositive n d hd)) := by
 unfold matterFraction
 rw [normalizedStretchAdmitted n d hn hd]
 change (do let volume ← matterTransport (natRatio n d hd)
            let matter := multiply matterToday volume
            LeptonRatios.divide matter (add vacuumToday matter))=_
 rw [everyMatterTransport n d hn hd]
 change LeptonRatios.divide (multiply (natRatio 5 16 _) (natRatio (cube n) (cube d) _))
  (add vacuumToday (multiply (natRatio 5 16 _) (natRatio (cube n) (cube d) _)))=_
 rw [multiplyNormalized,vacuumAtCommonDenominator d hd,addNormalized]
 change LeptonRatios.divide (natRatio (5*cube n) (16*cube d) _) (natRatio (rateNumerator n d) (16*cube d) _)=_
 rw [divideNormalized _ _ _ _ _ (ratePositive n d hd) _]
 apply congrArg Except.ok
 apply natRatioCongruence
 change (5*cube n*(16*cube d))*rateNumerator n d=(5*cube n)*((16*cube d)*rateNumerator n d)
 exact mulAssoc _ _ _

theorem everyVacuumFraction (n d : Nat) (hn : 0<n) (hd : 0<d) :
 vacuumFraction (natRatio n d hd)=.ok (natRatio (11*cube d) (rateNumerator n d) (ratePositive n d hd)) := by
 unfold vacuumFraction
 rw [normalizedStretchAdmitted n d hn hd]
 change (do let total ← lateSquaredExpansion (natRatio n d hd); LeptonRatios.divide vacuumToday total)=_
 rw [everySquaredExpansion n d hn hd]
 change LeptonRatios.divide (natRatio 11 16 _) (natRatio (rateNumerator n d) (16*cube d) _)=_
 rw [divideNormalized _ _ _ _ _ (ratePositive n d hd) _]
 apply congrArg Except.ok
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]

theorem fractionsCloseAtEveryStretch (n d : Nat) (hn : 0<n) (hd : 0<d) :
 (do let m ← matterFraction (natRatio n d hd)
     let v ← vacuumFraction (natRatio n d hd)
     Except.ok (add m v))=.ok (normalize 1 1 (by decide)) := by
 rw [everyMatterFraction n d hn hd,everyVacuumFraction n d hn hd]
 change Except.ok (add (natRatio (5*cube n) (rateNumerator n d) _) (natRatio (11*cube d) (rateNumerator n d) _))=_
 rw [addNormalized]
 apply congrArg Except.ok
 change natRatio _ _ _=natRatio 1 1 _
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.one_mul]
 exact Nat.add_comm _ _

theorem equalityThresholdSolvesBalance :
 multiply matterToday (normalize 11 5 (by decide))=vacuumToday := rfl

theorem accelerationThresholdSolvesBalance :
 multiply matterToday (normalize 22 5 (by decide))=multiply (normalize 2 1 (by decide)) vacuumToday := rfl

theorem everyPositiveCarrierExpansion (p : PositiveFraction) :
 lateSquaredExpansion (BoundaryGrowth.asFraction p)=.ok (natRatio (rateNumerator p.numerator p.denominator)
 (16*cube p.denominator) (Nat.mul_pos (by decide) (cubePositive _ (Nat.pos_of_ne_zero p.denominatorNonzero)))) := by
 rw [positiveCarrierRepresentation]
 exact everySquaredExpansion _ _ p.positive _

end SFT.Physics.CosmicComponentTransport
