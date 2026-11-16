import SFT.Physics.InflationGrowth
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.InflationGrowthTransport
open InflationGrowth LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.ExactOperations
set_option maxHeartbeats 100000000
-- Source-specific forward retention at every positive exact growth carrier.
theorem originalPositiveTransfer (n d : Nat) (hn : 0<n) (hd : 0<d) :
 forwardComponentTransfer (natRatio n d hd) = .ok
 ⟨natRatio (d*d*d) (n*n*n) (Nat.mul_pos (Nat.mul_pos hn hn) hn),
 natRatio (d*d*d*d) (n*n*n*n) (Nat.mul_pos (Nat.mul_pos (Nat.mul_pos hn hn) hn) hn),
 natRatio n d hd⟩ := by
 have pn3 := Nat.mul_pos (Nat.mul_pos hn hn) hn
 have pd3 := Nat.mul_pos (Nat.mul_pos hd hd) hd
 have pn4 := Nat.mul_pos pn3 hn
 have pd4 := Nat.mul_pos pd3 hd
 have cube : multiply (multiply (natRatio n d hd) (natRatio n d hd)) (natRatio n d hd) =
  natRatio (n*n*n) (d*d*d) pd3 := by rw [multiplyNormalized,multiplyNormalized]
 have fourth : multiply (multiply (multiply (natRatio n d hd) (natRatio n d hd)) (natRatio n d hd)) (natRatio n d hd) =
  natRatio (n*n*n*n) (d*d*d*d) pd4 := by rw [cube,multiplyNormalized]
 have matter : LeptonRatios.divide (wholeRatio 1) (natRatio (n*n*n) (d*d*d) pd3)=
  .ok (natRatio (d*d*d) (n*n*n) pn3) := by
  change LeptonRatios.divide (natRatio 1 1 (by decide)) _ = _
  rw [divideNormalized 1 1 (n*n*n) (d*d*d) (by decide) pn3 pd3]
  apply congrArg Except.ok
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.one_mul]
 have radiation : LeptonRatios.divide (wholeRatio 1) (natRatio (n*n*n*n) (d*d*d*d) pd4)=
  .ok (natRatio (d*d*d*d) (n*n*n*n) pn4) := by
  change LeptonRatios.divide (natRatio 1 1 (by decide)) _ = _
  rw [divideNormalized 1 1 (n*n*n*n) (d*d*d*d) (by decide) pn4 pd4]
  apply congrArg Except.ok
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.one_mul]
 have relative : LeptonRatios.divide (natRatio (d*d*d) (n*n*n) pn3) (natRatio (d*d*d*d) (n*n*n*n) pn4)=
  .ok (natRatio n d hd) := by
  rw [divideNormalized _ _ _ _ pn3 pd4 pn4]
  apply congrArg Except.ok
  apply natRatioCongruence
  let nn := n*n*n
  let dd := d*d*d
  change (dd*(nn*n))*d = n*(nn*(dd*d))
  calc
   (dd*(nn*n))*d = dd*((nn*n)*d) := SFT.Foundation.FractionReduction.mulAssoc _ _ _
   _ = dd*(d*(nn*n)) := congrArg (fun x => dd*x) (Nat.mul_comm _ _)
   _ = (dd*d)*(nn*n) := (SFT.Foundation.FractionReduction.mulAssoc _ _ _).symm
   _ = (nn*n)*(dd*d) := Nat.mul_comm _ _
   _ = (n*nn)*(dd*d) := congrArg (fun x => x*(dd*d)) (Nat.mul_comm _ _)
   _ = n*(nn*(dd*d)) := SFT.Foundation.FractionReduction.mulAssoc _ _ _
 unfold forwardComponentTransfer
 rw [positiveNormalized n d hn hd]
 dsimp only
 rw [fourth,cube,matter]
 dsimp only [Except.bind,Bind.bind]
 rw [radiation]
 dsimp only [Except.bind,Bind.bind]
 rw [relative]
 rfl

theorem originalRelativeGrowth (growth : PositiveFraction) :
 (forwardComponentTransfer (BoundaryGrowth.asFraction growth)).toOption.map Transfer.matterOverRadiation =
 some (BoundaryGrowth.asFraction growth) := by
 rw [positiveCarrierRepresentation]
 rw [originalPositiveTransfer growth.numerator growth.denominator growth.positive (Nat.pos_of_ne_zero growth.denominatorNonzero)]
 rfl
end SFT.Physics.InflationGrowthTransport
