import SFT.Physics.AtomicFieldSplitting
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.AtomicFieldSplittingProofs
open AtomicFieldSplitting VacuumLedgerProofs VacuumScaleProofs LeptonIntervals
set_option maxRecDepth 20000
theorem positiveCarrierAccepted (message : String) (n d : Nat) (hn : 0<n) (hd : 0<d) :
 positiveCarrier message (.fraction (natRatio n d hd))=.ok (natRatio n d hd) := by
 unfold positiveCarrier
 change (if !zero.blt (natRatio n d hd) then _ else _)=_
 rw [positiveNormalized n d hn hd]
 rfl

theorem exactZeeman (g gd m b bd : Nat) (hg : 0<g) (hgd : 0<gd) (hb : 0<b) (hbd : 0<bd) :
 zeemanShiftMagnitude (.fraction (natRatio g gd hgd)) (.count (.integer (.ofNat (m+1)))) (.fraction (natRatio b bd hbd)) =
 .ok (natRatio (g*(m+1)*b) (gd*bd) (Nat.mul_pos hgd hbd)) := by
 unfold zeemanShiftMagnitude
 rw [positiveCarrierAccepted _ g gd hg hgd]
 change (do
  let field ← positiveCarrier "field magnitude must be exact and positive" (.fraction (natRatio b bd hbd))
  pure (multiply (multiply (natRatio g gd hgd) (wholeRatio (m+1))) field))=_
 rw [positiveCarrierAccepted _ b bd hb hbd]
 change Except.ok (multiply (multiply (natRatio g gd hgd) (wholeRatio (m+1))) (natRatio b bd hbd))=_
 rw [←natRatioWhole (m+1),multiplyNormalized,multiplyNormalized]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.mul_one]

theorem exactLinearStark (p pd b bd : Nat) (hp : 0<p) (hpd : 0<pd) (hb : 0<b) (hbd : 0<bd) :
 linearStarkMagnitude (.fraction (natRatio p pd hpd)) (.fraction (natRatio b bd hbd)) =
 .ok (natRatio (p*b) (pd*bd) (Nat.mul_pos hpd hbd)) := by
 unfold linearStarkMagnitude
 rw [positiveCarrierAccepted _ p pd hp hpd,positiveCarrierAccepted _ b bd hb hbd]
 change Except.ok (multiply (natRatio p pd hpd) (natRatio b bd hbd))=_
 rw [multiplyNormalized]

theorem exactQuadraticStark (p pd b bd : Nat) (hp : 0<p) (hpd : 0<pd) (hb : 0<b) (hbd : 0<bd) :
 quadraticStarkMagnitude (.fraction (natRatio p pd hpd)) (.fraction (natRatio b bd hbd)) =
 .ok (natRatio (p*b*b) (pd*bd*bd*2) (Nat.mul_pos (Nat.mul_pos (Nat.mul_pos hpd hbd) hbd) (by decide))) := by
 unfold quadraticStarkMagnitude
 rw [positiveCarrierAccepted _ p pd hp hpd,positiveCarrierAccepted _ b bd hb hbd]
 change LeptonRatios.divide (multiply (multiply (natRatio p pd hpd) (natRatio b bd hbd)) (natRatio b bd hbd)) (wholeRatio 2)=_
 rw [multiplyNormalized,multiplyNormalized,←natRatioWhole 2,divideNormalized _ _ _ _ _ (by decide) (by decide),Nat.mul_one]

theorem commonZeemanStep (g gd m b bd : Nat) (hg : 0<g) (hgd : 0<gd) (hb : 0<b) (hbd : 0<bd) :
 zeemanShiftMagnitude (.fraction (natRatio g gd hgd)) (.count (.integer (.ofNat (m+2)))) (.fraction (natRatio b bd hbd)) =
 .ok (add (natRatio (g*(m+1)*b) (gd*bd) (Nat.mul_pos hgd hbd)) (natRatio (g*b) (gd*bd) (Nat.mul_pos hgd hbd))) := by
 rw [exactZeeman g gd (m+1) b bd hg hgd hb hbd,addNormalized]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.mul_succ g (m+1),addMul]
end SFT.Physics.AtomicFieldSplittingProofs
