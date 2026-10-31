import SFT.Physics.CommonScaleAxis
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.CommonScaleAxis
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
open VacuumLedgerProofs VacuumScaleProofs LeptonIntervals

theorem multiplyLeftComm (a b c : Nat) : a*(b*c)=b*(a*c) := by
 rw [←mulAssoc,Nat.mul_comm a b,mulAssoc]

theorem commonUnitCancellation (n d m e q f : Nat)
 (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e) (hq : 0<q) (hf : 0<f) :
 commonRationalRescalingRatio (.fraction (natRatio n d hd)) (.fraction (natRatio m e he)) (.fraction (natRatio q f hf))=
 LeptonRatios.divide (natRatio n d hd) (natRatio m e he) := by
 dsimp only [commonRationalRescalingRatio]
 rw [positiveNormalized n d hn hd,positiveNormalized m e hm he,positiveNormalized q f hq hf]
 change LeptonRatios.divide (multiply (natRatio n d hd) (natRatio q f hf))
  (multiply (natRatio m e he) (natRatio q f hf))=_
 rw [multiplyNormalized,multiplyNormalized,divideNormalized _ _ _ _ _ (Nat.mul_pos hm hq) _,divideNormalized _ _ _ _ _ hm _]
 apply congrArg Except.ok
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]

theorem everyPositiveUnitCancels (a b unit : PositiveFraction) :
 commonRationalRescalingRatio (.fraction (BoundaryGrowth.asFraction a)) (.fraction (BoundaryGrowth.asFraction b))
  (.fraction (BoundaryGrowth.asFraction unit))=
 LeptonRatios.divide (BoundaryGrowth.asFraction a) (BoundaryGrowth.asFraction b) := by
 rw [positiveCarrierRepresentation a,positiveCarrierRepresentation b,positiveCarrierRepresentation unit]
 exact commonUnitCancellation _ _ _ _ _ _ a.positive _ b.positive _ unit.positive _

theorem positiveSpacing (n : Nat) (positive : 0<n) :
 (match n with | 0 => Except.error "generated support must remain positive"
               | k+1 => Except.ok (normalize 1 (k+1) (Nat.zero_lt_succ k)))=
 Except.ok (natRatio 1 n positive) := by
 cases n with
 | zero => cases positive
 | succ k => rfl

theorem spacingAtEveryLevel (k : Nat) :
 scaleSpacing (.integer (.ofNat (k+1)))=.ok (natRatio 1 (2^k) (Nat.pow_pos (by decide))) := by
 unfold scaleSpacing
 rw [RunningConvergence.everyPositiveLevel]
 exact positiveSpacing _ (Nat.pow_pos (by decide))

theorem everySpacingHalves (k : Nat) :
 multiply (natRatio 1 (2^(k+1)) (Nat.pow_pos (by decide))) (natRatio 2 1 (by decide))=
 natRatio 1 (2^k) (Nat.pow_pos (by decide)) := by
 rw [multiplyNormalized]
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.one_mul,Nat.one_mul,Nat.pow_succ,Nat.mul_comm]

theorem powersMonotone (a b : Nat) (bound : a≤b) : 2^a≤2^b := by
 induction bound with
 | refl => exact Nat.le_refl _
 | @step b bound ih =>
  apply Nat.le_trans ih
  rw [Nat.pow_succ,Nat.mul_succ,Nat.mul_one]
  exact Nat.le_add_right _ _

theorem powerAtLeastFour (k : Nat) : 4≤2^(k+2) :=
 powersMonotone 2 (k+2) (Nat.le_add_left 2 k)

theorem binarySourceHasOnlyOneAnchor (k m : Nat) (same : 2+2^k=2^m) : k=1 := by
 cases k with
 | zero =>
  cases m with
  | zero => exact False.elim ((by decide : (3:Nat)≠1) same)
  | succ m =>
   cases m with
   | zero => exact False.elim ((by decide : (3:Nat)≠2) same)
   | succ m =>
    have impossible := powerAtLeastFour m
    rw [←same] at impossible
    exact False.elim ((by decide : ¬(4≤3)) impossible)
 | succ k =>
  cases k with
  | zero => rfl
  | succ k =>
   have moreThanTwo : 2<2^(k+2) := Nat.lt_of_lt_of_le (by decide) (powerAtLeastFour k)
   have lower : 2^(k+2)<2+2^(k+2) := by
    rw [Nat.add_comm 2 _]
    exact Nat.lt_add_of_pos_right (by decide)
   have upper : 2+2^(k+2)<2^(k+3) := by
    change 2+2^(k+2)<2^(k+2)*2
    calc
     2+2^(k+2)<2^(k+2)+2^(k+2) := Nat.add_lt_add_right moreThanTwo _
     _ = 2^(k+2)*2 := by rw [Nat.mul_succ,Nat.mul_one]
   by_cases before : m≤k+2
   · have impossible := Nat.lt_of_lt_of_le lower (same.symm ▸ powersMonotone m (k+2) before)
     exact False.elim (Nat.lt_irrefl _ impossible)
   · have after : k+3≤m := Nat.succ_le_of_lt (Nat.lt_of_not_ge before)
     have impossible := Nat.lt_of_lt_of_le upper (powersMonotone (k+3) m after)
     rw [same] at impossible
     exact False.elim (Nat.lt_irrefl _ impossible)

end SFT.Physics.CommonScaleAxis
