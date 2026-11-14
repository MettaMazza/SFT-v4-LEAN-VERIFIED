import SFT.Physics.AtomicTransitionRate
import SFT.Physics.CommonScaleAxisAlgebra
namespace SFT.Physics.AtomicTransitionRateProofs
open AtomicTransitionRate VacuumLedgerProofs VacuumScaleProofs LeptonIntervals
set_option maxRecDepth 20000
theorem strictGapAccepted (n d : Nat) (hn : 0<n) (hd : 0<d) (part : n<d) :
 strictGap (.fraction (natRatio n d hd))=.ok (natRatio n d hd) := by
 have positive := positiveNormalized n d hn hd
 have below : (natRatio n d hd).blt (wholeRatio 1)=true := by
  change (natRatio n d hd).blt (natRatio 1 1 (by decide))=true
  apply CommonScaleAxis.positiveNormalizedLess n d 1 1 hn hd (by decide) (by decide)
  rw [Nat.mul_one,Nat.one_mul]
  exact part
 unfold strictGap
 change (if !zero.blt (natRatio n d hd) || !(natRatio n d hd).blt (wholeRatio 1) then _ else _)=_
 rw [positive,below]
 rfl

theorem exactSuccessorSquare (n d : Nat) (hn : 0<n) (hd : 0<d) (part : n<d) :
 successorMultipoleRatio (.fraction (natRatio n d hd))=.ok (natRatio (n*n) (d*d) (Nat.mul_pos hd hd)) := by
 unfold successorMultipoleRatio
 rw [strictGapAccepted n d hn hd part]
 change Except.ok (multiply (natRatio n d hd) (natRatio n d hd))=_
 rw [multiplyNormalized]

theorem everySuccessorStrictlySuppressed (n d : Nat) (hn : 0<n) (hd : 0<d) (part : n<d) :
 zero.blt (natRatio (n*n) (d*d) (Nat.mul_pos hd hd))=true ∧
 (natRatio (n*n) (d*d) (Nat.mul_pos hd hd)).blt (wholeRatio 1)=true := by
 constructor
 · exact positiveNormalized (n*n) (d*d) (Nat.mul_pos hn hn) (Nat.mul_pos hd hd)
 · change (natRatio (n*n) (d*d) (Nat.mul_pos hd hd)).blt (natRatio 1 1 (by decide))=true
   apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (Nat.mul_pos hn hn) (Nat.mul_pos hd hd) (by decide) (by decide)
   rw [Nat.mul_one,Nat.one_mul]
   exact Nat.lt_of_lt_of_le (Nat.mul_lt_mul_of_pos_right part hn) (Nat.mul_le_mul_left d (Nat.le_of_lt part))
theorem everyElectricPower (n d exponent : Nat) (hd : 0<d) :
 electricGapPower (natRatio n d hd) exponent=natRatio (n^exponent) (d^exponent) (Nat.pow_pos hd) := by
 induction exponent with
 | zero => exact (natRatioWhole 1).symm
 | succ exponent ih =>
  unfold electricGapPower
  rw [ih,multiplyNormalized]
  rfl

theorem everyNormalizedElectricRate (n d s t w rank : Nat)
 (hn : 0<n) (hd : 0<d) (part : n<d) (hs : 0<s) (ht : 0<t) :
 normalizedElectricRate (.fraction (natRatio n d hd)) (.fraction (natRatio s t ht))
  (.count (.integer (.ofNat (w+1)))) (.count (.integer (.ofNat (rank+1)))) =
 .ok (natRatio (n^(2*(rank+1)+1)*s) (d^(2*(rank+1)+1)*t*(w+1))
  (Nat.mul_pos (Nat.mul_pos (Nat.pow_pos hd) ht) (Nat.zero_lt_succ w))) := by
 have strength : positiveStrength (.fraction (natRatio s t ht))=.ok (natRatio s t ht) := by
  unfold positiveStrength
  change (if !zero.blt (natRatio s t ht) then _ else _)=_
  rw [positiveNormalized s t hs ht]
  rfl
 unfold normalizedElectricRate
 rw [strictGapAccepted n d hn hd part,strength]
 change LeptonRatios.divide (multiply (electricGapPower (natRatio n d hd) (2*(rank+1)+1)) (natRatio s t ht)) (wholeRatio (w+1)) = _
 rw [everyElectricPower,multiplyNormalized]
 rw [← natRatioWhole (w+1)]
 rw [divideNormalized _ _ _ _ _ (Nat.zero_lt_succ w) (by decide),Nat.mul_one]
theorem equalStrengthWeightSuccessor (n d s t w rank : Nat)
 (hn : 0<n) (hd : 0<d) (part : n<d) (hs : 0<s) (ht : 0<t) :
 normalizedElectricRate (.fraction (natRatio n d hd)) (.fraction (natRatio s t ht))
  (.count (.integer (.ofNat (w+1)))) (.count (.integer (.ofNat (rank+2)))) =
 (normalizedElectricRate (.fraction (natRatio n d hd)) (.fraction (natRatio s t ht))
  (.count (.integer (.ofNat (w+1)))) (.count (.integer (.ofNat (rank+1))))).map
   (fun rate => multiply rate (multiply (natRatio n d hd) (natRatio n d hd))) := by
 rw [everyNormalizedElectricRate n d s t w (rank+1) hn hd part hs ht,
     everyNormalizedElectricRate n d s t w rank hn hd part hs ht]
 change Except.ok _ = Except.ok (multiply (natRatio _ _ _) (multiply (natRatio n d hd) (natRatio n d hd)))
 rw [multiplyNormalized,multiplyNormalized]
 let exponent := 2*(rank+1)+1
 have numerator : (n^exponent*s)*(n*n)=n^(exponent+2)*s := by
  rw [Nat.pow_succ n (exponent+1),Nat.pow_succ n exponent]
  rw [SFT.Foundation.FractionReduction.mulAssoc (n^exponent) s (n*n),Nat.mul_comm s (n*n),←SFT.Foundation.FractionReduction.mulAssoc (n^exponent) (n*n) s,←SFT.Foundation.FractionReduction.mulAssoc (n^exponent) n n]
 have denominator : (d^exponent*t*(w+1))*(d*d)=d^(exponent+2)*t*(w+1) := by
  rw [Nat.pow_succ d (exponent+1),Nat.pow_succ d exponent]
  rw [SFT.Foundation.FractionReduction.mulAssoc (d^exponent) t (w+1),SFT.Foundation.FractionReduction.mulAssoc (d^exponent) (t*(w+1)) (d*d),Nat.mul_comm (t*(w+1)) (d*d),←SFT.Foundation.FractionReduction.mulAssoc (d^exponent) (d*d) (t*(w+1)),←SFT.Foundation.FractionReduction.mulAssoc (d^exponent*(d*d)) t (w+1),←SFT.Foundation.FractionReduction.mulAssoc (d^exponent) d d]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [numerator,denominator,exponentSuccessor rank]
end SFT.Physics.AtomicTransitionRateProofs
