import SFT.Physics.MagneticRelativity
import SFT.Physics.MagneticCovariance
namespace SFT.Physics.MagneticSourceProofs
open SFT.Foundation ExactOperations ExactPartCarrier ExactCast FractionReduction FoldCastLaws
open VacuumLedgerProofs VacuumScaleProofs LeptonIntervals MagneticCovariance

theorem squareProper (n d : Nat) (hn : 0<n) (proper : n<d) : n*n<d*d :=
 Nat.lt_trans (Nat.mul_lt_mul_of_pos_left proper hn)
  (Nat.mul_lt_mul_of_pos_right proper (Nat.lt_trans hn proper))

theorem squareOffHalf (n d : Nat) (hn : 0<n) : n*n+n*n≠d*d := by
 intro half
 exact MagneticSquare.noHalfSquare d n hn (half.symm.trans (twoTimes (n*n)).symm)

def sourceRecord (n d : Nat) (hn : 0<n) (proper : n<d) : MagneticRelativity.Result :=
 let hd := Nat.lt_trans hn proper
 let hp := Nat.mul_pos hd hd
 let square := n*n
 let support := d*d
 let remainder := support-square
 ⟨natRatio square support hp,natRatio remainder support hp,
 asFraction (foldPart (normalizePart remainder support (subtractPositive support square (squareProper n d hn proper)) (Nat.sub_le _ _)))⟩

theorem everyOriginalSpeed (n d : Nat) (hn : 0<n) (proper : n<d) :
 MagneticRelativity.magneticRelativisticFactor
 (.fraction (natRatio n d (Nat.lt_trans hn proper)))=.ok (sourceRecord n d hn proper) := by
 let hd := Nat.lt_trans hn proper
 have speedPositive := positiveNormalized n d hn hd
 have speedBelow : (natRatio n d hd).blt (asFraction one)=true := by
  change (natRatio n d hd).blt (natRatio 1 1 (by decide))=true
  apply CommonScaleAxis.positiveNormalizedLess n d 1 1 hn hd (by decide) (by decide)
  rw [Nat.mul_one,Nat.one_mul]
  exact proper
 have sqp := Nat.mul_pos hn hn
 have sqb := squareProper n d hn proper
 have remp := subtractPositive (d*d) (n*n) sqb
 unfold MagneticRelativity.magneticRelativisticFactor
 dsimp only
 rw [speedPositive,speedBelow]
 rw [multiplyNormalized,subtractOneNormalized _ _ sqp sqb]
 rw [fromPairRatio _ _ remp (Nat.sub_le _ _)]
 rw [fromPairRatio _ _ sqp (Nat.le_of_lt sqb)]
 change (if !(asFraction (foldPart (normalizePart (d*d-n*n) (d*d) remp (Nat.sub_le _ _)))).blt
    (subtract (asFraction one) (asFraction (foldPart (normalizePart (n*n) (d*d) sqp (Nat.le_of_lt sqb))))) &&
    !(subtract (asFraction one) (asFraction (foldPart (normalizePart (n*n) (d*d) sqp (Nat.le_of_lt sqb))))).blt
     (asFraction (foldPart (normalizePart (d*d-n*n) (d*d) remp (Nat.sub_le _ _)))) then
     Except.ok (sourceRecord n d hn proper)
    else Except.error "magnetic correction does not commute with the Fold") = _
 rw [← foldComplement (n*n) (d*d) sqp sqb (squareOffHalf n d hn)]
 rw [partNotLessSelf]
 rfl

theorem everyPositiveFraction (speed : PositiveFraction)
 (proper : speed.numerator<speed.denominator) :
 MagneticRelativity.magneticRelativisticFactor (.fraction (BoundaryGrowth.asFraction speed))=
 .ok (sourceRecord speed.numerator speed.denominator speed.positive proper) := by
 rw [positiveCarrierRepresentation]
 exact everyOriginalSpeed _ _ speed.positive proper

theorem exactPartition (n d : Nat) (hn : 0<n) (proper : n<d) :
 add (sourceRecord n d hn proper).electricRemainder (sourceRecord n d hn proper).speedSquare=asFraction one := by
 change add (natRatio (d*d-n*n) (d*d) _) (natRatio (n*n) (d*d) _)=_
 rw [addNormalized,subtractAdd _ _ (Nat.le_of_lt (squareProper n d hn proper))]
 have same : natRatio (d*d) (d*d) (Nat.mul_pos (Nat.lt_trans hn proper) (Nat.lt_trans hn proper))=natRatio 1 1 (by decide) := by
  apply natRatioCongruence
  rw [Nat.mul_one,Nat.one_mul]
 exact same

theorem positiveRemainder (n d : Nat) (hn : 0<n) (proper : n<d) :
 zero.blt (sourceRecord n d hn proper).electricRemainder=true :=
 positiveNormalized _ _ (subtractPositive (d*d) (n*n) (squareProper n d hn proper)) _
end SFT.Physics.MagneticSourceProofs
