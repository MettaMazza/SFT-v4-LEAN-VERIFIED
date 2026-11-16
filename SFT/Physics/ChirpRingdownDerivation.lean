import SFT.Physics.VelocityCompositionReconstruction
import SFT.Physics.ChirpRingdown
import SFT.Physics.CompactHorizonDerivation
namespace SFT.Physics.ChirpRingdownDerivation
open ChirpRingdown LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
private theorem sourceInverse (n d : Nat) (hn : 0<n) (hd : 0<d) :
 LeptonRatios.divide ChirpRingdown.one (natRatio n d hd)=.ok (natRatio d n hn) := by
 change LeptonRatios.divide (wholeRatio 1) (natRatio n d hd)=_
 rw [← natRatioWhole 1,divideNormalized 1 1 n d (by decide) hn hd]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.one_mul]
private theorem sourceBinding (n d : Nat) (hn : 0<n) (hd : 0<d) :
 LeptonRatios.divide ChirpRingdown.half (natRatio n d hd)=.ok (natRatio d (2*n) (Nat.mul_pos (by decide) hn)) := by
 change LeptonRatios.divide (natRatio 1 2 (by decide)) (natRatio n d hd)=_
 rw [divideNormalized 1 2 n d (by decide) hn hd,Nat.one_mul]
theorem originalOrbitalRow (n d : Nat) (hn : 0<n) (hd : 0<d) :
 orbitalRow (natRatio n d hd)=.ok ⟨natRatio n d hd,
 natRatio (n*n*n) (d*d*d) (Nat.mul_pos (Nat.mul_pos hd hd) hd),
 natRatio (d*d*d) (n*n*n) (Nat.mul_pos (Nat.mul_pos hn hn) hn),
 multiply (wholeRatio 4) (natRatio (d*d*d) (n*n*n) (Nat.mul_pos (Nat.mul_pos hn hn) hn)),
 natRatio d (2*n) (Nat.mul_pos (by decide) hn)⟩ := by
 unfold orbitalRow positiveFraction
 rw [positiveNormalized n d hn hd,if_pos rfl]
 dsimp only [Except.bind,Bind.bind]
 rw [multiplyNormalized,multiplyNormalized,sourceInverse _ _ (Nat.mul_pos (Nat.mul_pos hn hn) hn) (Nat.mul_pos (Nat.mul_pos hd hd) hd),sourceBinding n d hn hd]
 rfl
theorem originalMergerContact : PostNewtonianRecords.getDefault mergerRecord "contact_separation"=rat ChirpRingdown.one := rfl
theorem originalHorizonContact : add StrongFieldHorizon.originalRecord.radius StrongFieldHorizon.originalRecord.radius=ChirpRingdown.one := rfl
theorem originalRingdownLength (count tick : Nat) (amplitude : Rat) : (ringdownRows count tick amplitude).length=count := by
 induction count generalizing tick amplitude with
 | zero=>rfl
 | succ count ih=>change (ringdownRows count (tick+1) (multiply amplitude ChirpRingdown.half)).length+1=count+1;rw [ih]
theorem originalRingdownPositive (count tick n d : Nat) (hn : 0<n) (hd : 0<d) :
 (ringdownRows count tick (natRatio n d hd)).all (fun r=>zero.blt r.amplitude)=true := by
 induction count generalizing tick n d with
 | zero=>rfl
 | succ count ih=>
  change (zero.blt (natRatio n d hd) && (ringdownRows count (tick+1) (multiply (natRatio n d hd) ChirpRingdown.half)).all (fun r=>zero.blt r.amplitude))=true
  have halfStep := CompactHorizonDerivation.originalHalving n d hd
  change multiply (natRatio n d hd) ChirpRingdown.half=natRatio n (d*2) (Nat.mul_pos hd (by decide)) at halfStep
  rw [positiveNormalized n d hn hd,halfStep,ih _ _ _ hn (Nat.mul_pos hd (by decide))]
  rfl
theorem originalRingdownDamping (count tick : Nat) (amplitude : Rat) :
 adjacent (fun a b : RingdownRow=>b.amplitude==multiply a.amplitude ChirpRingdown.half) (ringdownRows count tick amplitude)=true := by
 induction count generalizing tick amplitude with
 | zero=>rfl
 | succ count ih=>
  cases count with
  | zero=>rfl
  | succ count=>
   change ((multiply amplitude ChirpRingdown.half==multiply amplitude ChirpRingdown.half) && adjacent (fun a b : RingdownRow=>b.amplitude==multiply a.amplitude ChirpRingdown.half) (ringdownRows (count+1) (tick+1) (multiply amplitude ChirpRingdown.half)))=true
   rw [ratEqualSelf,ih]
   rfl
theorem originalRingdownStrict (count tick n d : Nat) (hn : 0<n) (hd : 0<d) :
 adjacent (fun a b : RingdownRow=>b.amplitude.blt a.amplitude) (ringdownRows count tick (natRatio n d hd))=true := by
 induction count generalizing tick n d with
 | zero=>rfl
 | succ count ih=>
  cases count with
  | zero=>rfl
  | succ count=>
   change ((multiply (natRatio n d hd) ChirpRingdown.half).blt (natRatio n d hd) && adjacent (fun a b : RingdownRow=>b.amplitude.blt a.amplitude) (ringdownRows (count+1) (tick+1) (multiply (natRatio n d hd) ChirpRingdown.half)))=true
   have halfStep := CompactHorizonDerivation.originalHalving n d hd
   change multiply (natRatio n d hd) ChirpRingdown.half=natRatio n (d*2) (Nat.mul_pos hd (by decide)) at halfStep
   rw [halfStep,CompactHorizonDerivation.originalEmissionMassOrder n d hn hd,ih _ _ _ hn (Nat.mul_pos hd (by decide))]
   rfl
theorem originalPositiveTake (a b d : Nat) (ha : 0<a) (hb : 0<b) (hd : 0<d) :
 positiveTake (natRatio (a+b) d hd) (natRatio a d hd)=.ok (natRatio b d hd) := by
 have hab : 0<a+b := Nat.add_pos_left ha b
 have lt : (natRatio a d hd).blt (natRatio (a+b) d hd)=true := by
  apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ ha hd hab hd
  exact Nat.mul_lt_mul_of_pos_right (Nat.lt_add_of_pos_right hb) hd
 unfold positiveTake positiveFraction
 rw [positiveNormalized (a+b) d hab hd,positiveNormalized a d ha hd]
 rw [if_pos rfl,if_pos rfl]
 dsimp only [Except.bind,Bind.bind]
 rw [lt]
 change Except.ok (subtract (natRatio (a+b) d hd) (natRatio a d hd))=_
 rw [VelocityComposition.originalSubtractNormalized _ _ _ hd (Nat.le_add_right a b),RunningConvergence.addSubtractLeft]
theorem originalBinaryBindingTake (s : Nat) (hs : 0<s) :
 positiveTake (natRatio 1 (2*s) (Nat.mul_pos (by decide) hs)) (natRatio 1 (4*s) (Nat.mul_pos (by decide) hs))=
 .ok (natRatio 1 (4*s) (Nat.mul_pos (by decide) hs)) := by
 have double : natRatio 1 (2*s) (Nat.mul_pos (by decide) hs)=natRatio (1+1) (4*s) (Nat.mul_pos (by decide) hs) := by
  apply natRatioCongruence
  rw [Nat.one_mul,← mulAssoc]
 rw [double]
 exact originalPositiveTake 1 1 (4*s) (by decide) (by decide) (Nat.mul_pos (by decide) hs)
theorem originalRingdownOneRemnant (count tick : Nat) (a : Rat) :
 (ringdownRows count tick a).all (fun r=>RunningConvergenceMeasurement.sameValue r.sourceCount (.integer 1))=true := by
 induction count generalizing tick a with
 | zero=>rfl
 | succ count ih=>
  change (true && (ringdownRows count (tick+1) (multiply a ChirpRingdown.half)).all (fun r=>RunningConvergenceMeasurement.sameValue r.sourceCount (.integer 1)))=true
  rw [ih]
  rfl
theorem originalRingdownToneHeld (count tick : Nat) (a : Rat) :
 (ringdownRows count tick a).all (fun r=>RunningConvergenceMeasurement.sameValue r.toneKey (PostNewtonianRecords.getDefault mergerRecord "remnant_labels"))=true := by
 induction count generalizing tick a with
 | zero=>rfl
 | succ count ih=>
  change (true && (ringdownRows count (tick+1) (multiply a ChirpRingdown.half)).all (fun r=>RunningConvergenceMeasurement.sameValue r.toneKey (PostNewtonianRecords.getDefault mergerRecord "remnant_labels")))=true
  rw [ih]
  rfl
theorem originalBinaryCubeOrder (n : Nat) (hn : 0<n) : n*n*n<(2*n)*(2*n)*(2*n) := by
 have grows : n<2*n := by rw [Nat.two_mul];exact Nat.lt_add_of_pos_right hn
 have twice : 0<2*n := Nat.mul_pos (by decide) hn
 have square := Nat.lt_trans (Nat.mul_lt_mul_of_pos_right grows hn) (Nat.mul_lt_mul_of_pos_left grows twice)
 exact Nat.lt_trans (Nat.mul_lt_mul_of_pos_right square hn) (Nat.mul_lt_mul_of_pos_left grows (Nat.mul_pos twice twice))
theorem originalBinaryPeriodFalls (n : Nat) (hn : 0<n) :
 (natRatio (n*n*n) 1 (by decide)).blt (natRatio ((2*n)*(2*n)*(2*n)) 1 (by decide))=true := by
 have twice : 0<2*n := Nat.mul_pos (by decide) hn
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (Nat.mul_pos (Nat.mul_pos hn hn) hn) (by decide) (Nat.mul_pos (Nat.mul_pos twice twice) twice) (by decide)
 rw [Nat.mul_one,Nat.mul_one]
 exact originalBinaryCubeOrder n hn
theorem originalBinaryOrbitalFrequencyRises (n : Nat) (hn : 0<n) :
 (natRatio 1 ((2*n)*(2*n)*(2*n)) (Nat.mul_pos (Nat.mul_pos (Nat.mul_pos (by decide) hn) (Nat.mul_pos (by decide) hn)) (Nat.mul_pos (by decide) hn))).blt
 (natRatio 1 (n*n*n) (Nat.mul_pos (Nat.mul_pos hn hn) hn))=true := by
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (by decide) (Nat.mul_pos (Nat.mul_pos (Nat.mul_pos (by decide) hn) (Nat.mul_pos (by decide) hn)) (Nat.mul_pos (by decide) hn)) (by decide) (Nat.mul_pos (Nat.mul_pos hn hn) hn)
 rw [Nat.one_mul,Nat.one_mul]
 exact originalBinaryCubeOrder n hn
theorem originalBinaryWaveFrequencyRises (n : Nat) (hn : 0<n) :
 (natRatio 4 ((2*n)*(2*n)*(2*n)) (Nat.mul_pos (Nat.mul_pos (Nat.mul_pos (by decide) hn) (Nat.mul_pos (by decide) hn)) (Nat.mul_pos (by decide) hn))).blt
 (natRatio 4 (n*n*n) (Nat.mul_pos (Nat.mul_pos hn hn) hn))=true := by
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (by decide) (Nat.mul_pos (Nat.mul_pos (Nat.mul_pos (by decide) hn) (Nat.mul_pos (by decide) hn)) (Nat.mul_pos (by decide) hn)) (by decide) (Nat.mul_pos (Nat.mul_pos hn hn) hn)
 exact Nat.mul_lt_mul_of_pos_left (originalBinaryCubeOrder n hn) (by decide)
#print axioms originalBinaryCubeOrder
#print axioms originalBinaryPeriodFalls
#print axioms originalBinaryOrbitalFrequencyRises
#print axioms originalBinaryWaveFrequencyRises
#print axioms originalPositiveTake
#print axioms originalBinaryBindingTake
#print axioms originalRingdownOneRemnant
#print axioms originalRingdownToneHeld
#print axioms originalOrbitalRow
#print axioms originalMergerContact
#print axioms originalHorizonContact
#print axioms originalRingdownLength
#print axioms originalRingdownPositive
#print axioms originalRingdownDamping
#print axioms originalRingdownStrict
end SFT.Physics.ChirpRingdownDerivation
