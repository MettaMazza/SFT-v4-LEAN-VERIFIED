import SFT.Physics.LorentzTransfer
import SFT.Physics.MagneticSourceProofs
namespace SFT.Physics.LorentzSourceProofs
open SFT.Foundation ExactOperations ExactPartCarrier FractionReduction
open VacuumLedgerProofs VacuumScaleProofs LeptonIntervals MagneticCovariance

def sourceRecord (a b n d : Nat) (bp : 0<b) (dp : 0<d) : LorentzTransfer.Result :=
 ⟨natRatio (a*(d*d-n*n)) (b*(d*d)) (Nat.mul_pos bp (Nat.mul_pos dp dp)),
  natRatio (a*(n*n)) (b*(d*d)) (Nat.mul_pos bp (Nat.mul_pos dp dp)),natRatio a b bp⟩

theorem exactSourceRecomposition (a b n d : Nat) (bp : 0<b) (np : 0<n) (proper : n<d) :
 add (sourceRecord a b n d bp (Nat.lt_trans np proper)).retainedForce
  (sourceRecord a b n d bp (Nat.lt_trans np proper)).motionShare=natRatio a b bp := by
 change add (natRatio (a*(d*d-n*n)) (b*(d*d)) _) (natRatio (a*(n*n)) (b*(d*d)) _)=_
 rw [addNormalized,← Nat.mul_add,subtractAdd _ _ (Nat.le_of_lt (MagneticSourceProofs.squareProper n d np proper))]
 apply natRatioCongruence
 rw [mulAssoc,Nat.mul_comm (d*d) b]

theorem everyOriginalTransfer (a b n d : Nat) (ap : 0<a) (bp : 0<b) (np : 0<n) (proper : n<d) :
 LorentzTransfer.lorentzTransfer (.fraction (natRatio a b bp))
 (.fraction (natRatio n d (Nat.lt_trans np proper)))=
 .ok (sourceRecord a b n d bp (Nat.lt_trans np proper)) := by
 have positive := positiveNormalized a b ap bp
 have same : (natRatio a b bp).blt (natRatio a b bp)=false := by
  rw [← CommonScaleAxis.normalizedPositiveAsRat a b ap bp]
  exact positiveNotLessSelf _
 unfold LorentzTransfer.lorentzTransfer
 dsimp only
 rw [positive,MagneticSourceProofs.everyOriginalSpeed n d np proper]
 change (if !(add
   (multiply (natRatio a b bp) (natRatio (d*d-n*n) (d*d) _))
   (multiply (natRatio a b bp) (natRatio (n*n) (d*d) _))).blt (natRatio a b bp) &&
   !(natRatio a b bp).blt (add
    (multiply (natRatio a b bp) (natRatio (d*d-n*n) (d*d) _))
    (multiply (natRatio a b bp) (natRatio (n*n) (d*d) _))) then
    Except.ok (⟨multiply (natRatio a b bp) (natRatio (d*d-n*n) (d*d) _),
     multiply (natRatio a b bp) (natRatio (n*n) (d*d) _),natRatio a b bp⟩ : LorentzTransfer.Result)
   else Except.error "Lorentz transfer did not conserve the source force")=_
 rw [multiplyNormalized,multiplyNormalized]
 change (if !(add (sourceRecord a b n d bp (Nat.lt_trans np proper)).retainedForce (sourceRecord a b n d bp (Nat.lt_trans np proper)).motionShare).blt (natRatio a b bp) &&
  !(natRatio a b bp).blt (add (sourceRecord a b n d bp (Nat.lt_trans np proper)).retainedForce (sourceRecord a b n d bp (Nat.lt_trans np proper)).motionShare) then
  Except.ok (sourceRecord a b n d bp (Nat.lt_trans np proper)) else Except.error "Lorentz transfer did not conserve the source force")=_
 rw [exactSourceRecomposition a b n d bp np proper,same]
 rfl

theorem everyPositiveForceAndSpeed (force speed : PositiveFraction)
 (proper : speed.numerator<speed.denominator) :
 LorentzTransfer.lorentzTransfer (.fraction (BoundaryGrowth.asFraction force))
  (.fraction (BoundaryGrowth.asFraction speed))=
 .ok (sourceRecord force.numerator force.denominator speed.numerator speed.denominator
  (Nat.pos_of_ne_zero force.denominatorNonzero) (Nat.lt_trans speed.positive proper)) := by
 rw [positiveCarrierRepresentation,positiveCarrierRepresentation]
 exact everyOriginalTransfer _ _ _ _ force.positive _ speed.positive proper
end SFT.Physics.LorentzSourceProofs
