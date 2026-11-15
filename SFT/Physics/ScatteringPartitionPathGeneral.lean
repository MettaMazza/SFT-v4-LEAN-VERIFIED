import SFT.Physics.ScatteringPartitionPath
import SFT.Physics.VacuumScaleProofs
import SFT.Physics.CommonScaleAxisAlgebra
namespace SFT.Physics.ScatteringPartitionPathGeneral
open ScatteringPartitionPath LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
theorem originalContainedSection (successful incident : Nat) (positive : 0<successful) (contained : successful≤incident) :
 crossSection (.integer (.ofNat successful)) (.integer (.ofNat incident))=
 .ok (natRatio successful incident (Nat.lt_of_lt_of_le positive contained)) := by
 cases successful with
 | zero => cases positive
 | succ s =>
  unfold crossSection
  dsimp only
  rw [dif_pos contained]
  rfl
theorem originalMeanFreePath (n d a b : Nat) (hn : 0<n) (hd : 0<d) (ha : 0<a) (hb : 0<b) :
 meanFreePath (.fraction (natRatio n d hd)) (.fraction (natRatio a b hb))=
 .ok (natRatio (d*b) (n*a) (Nat.mul_pos hn ha)) := by
 unfold meanFreePath SymmetryActionPaths.positiveCoordinate
 dsimp only
 rw [positiveNormalized n d hn hd,positiveNormalized a b ha hb]
 change LeptonRatios.divide (natRatio 1 1 (by decide)) (multiply (natRatio n d hd) (natRatio a b hb))=_
 rw [multiplyNormalized,divideNormalized 1 1 (n*a) (d*b) (by decide) (Nat.mul_pos hn ha) (Nat.mul_pos hd hb)]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.one_mul]
theorem originalLargerSectionShortensPath (n d a b c e : Nat)
 (hn : 0<n) (hd : 0<d) (ha : 0<a) (hb : 0<b) (hc : 0<c) (he : 0<e)
 (ordered : a*e<c*b) :
 largerSectionShortensPath (.fraction (natRatio n d hd)) (.fraction (natRatio a b hb)) (.fraction (natRatio c e he))=.ok true := by
 unfold largerSectionShortensPath orderedValue
 dsimp only
 rw [positiveNormalized a b ha hb,CommonScaleAxis.positiveNormalizedLess a b c e ha hb hc he ordered]
 change (do let short ← meanFreePath (.fraction (natRatio n d hd)) (.fraction (natRatio c e he));
            let long ← meanFreePath (.fraction (natRatio n d hd)) (.fraction (natRatio a b hb));
            pure (short.blt long))=Except.ok true
 rw [originalMeanFreePath n d c e hn hd hc he,originalMeanFreePath n d a b hn hd ha hb]
 dsimp only [Except.bind,Bind.bind]
 have cross : (d*e)*(n*a)<(d*b)*(n*c) := by
  have left : (d*e)*(n*a)=(d*n)*(a*e) := by
   conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
   all_goals conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  have right : (d*b)*(n*c)=(d*n)*(c*b) := by
   conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
   all_goals conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  rw [left,right]
  exact Nat.mul_lt_mul_of_pos_left ordered (Nat.mul_pos hd hn)
 rw [CommonScaleAxis.positiveNormalizedLess (d*e) (n*c) (d*b) (n*a) (Nat.mul_pos hd he) (Nat.mul_pos hn hc) (Nat.mul_pos hd hb) (Nat.mul_pos hn ha) cross]
 rfl
theorem originalTwoDistinctOutcomes (first second : String) (distinct : SFT.Host.Text.equal first second=false) :
 twoFibreOutcomeMeasure [first,second]=.ok (ScatteringPartitionPath.half,ScatteringPartitionPath.half) := by
 have check : exactlyTwoLabelsFrom first none [second]=true := by
  change (if SFT.Host.Text.equal first second then false else true)=true
  rw [distinct]
  rfl
 change (if exactlyTwoLabelsFrom first none [second] then Except.ok (ScatteringPartitionPath.half,ScatteringPartitionPath.half) else Except.error "the two Fold outcomes must remain distinguishable")=_
 rw [check]
 rfl

theorem originalTwoCellPartition (first second : String) (distinct : SFT.Host.Text.equal first second=false) :
 partitionIsComplete [first,second]=.ok true := by
 unfold partitionIsComplete
 rw [originalTwoDistinctOutcomes first second distinct]
 rfl
theorem originalEncounterSuccessor (n d a b : Nat) (hd : 0<d) (hb : 0<b) :
 multiply (add (natRatio n d hd) (natRatio 1 d hd)) (natRatio a b hb)=
 add (multiply (natRatio n d hd) (natRatio a b hb)) (multiply (natRatio 1 d hd) (natRatio a b hb)) := by
 rw [addNormalized,multiplyNormalized,multiplyNormalized,multiplyNormalized,addNormalized]
 apply natRatioCongruence
 rw [addMul,Nat.one_mul]
theorem originalEncounterPathReassemblesOne (n d a b : Nat) (hn : 0<n) (hd : 0<d) (ha : 0<a) (hb : 0<b) :
 (do let path ← meanFreePath (.fraction (natRatio n d hd)) (.fraction (natRatio a b hb));
     pure (multiply path (multiply (natRatio n d hd) (natRatio a b hb))))=Except.ok one := by
 rw [originalMeanFreePath n d a b hn hd ha hb]
 dsimp only [Except.bind,Bind.bind]
 rw [multiplyNormalized,multiplyNormalized]
 apply congrArg Except.ok
 change natRatio _ _ _=natRatio 1 1 (by decide)
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.mul_one,Nat.mul_comm (d*b) (n*a)]
end SFT.Physics.ScatteringPartitionPathGeneral
