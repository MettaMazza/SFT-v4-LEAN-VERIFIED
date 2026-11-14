import SFT.Physics.CommonScaleAxisAlgebra
import SFT.Physics.RunningConvergence
namespace SFT.Physics.HydrogenSpectrum
open LeptonIntervals GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def hydrogenLevel (principal : CountInput) : Except String Rat :=
 match SectorInventory.countValue principal with
 | .negSucc _ => .error "principal support must be a positive count"
 | .ofNat 0 => .error "principal support must be a positive count"
 | .ofNat (n+1) => do
   let binary ← AlphaCovers.binaryCount
   pure (normalize 1 ((n+1)^binary) (Nat.pow_pos (Nat.zero_lt_succ _)))
def hydrogenTransition (upper lower : CountInput) : Except String Rat := do
 if @decide (SectorInventory.countValue upper ≤ SectorInventory.countValue lower)
    (Int.decLe (SectorInventory.countValue upper) (SectorInventory.countValue lower)) then
  throw "the emitted transition requires upper principal support above lower support"
 let lowerLevel ← hydrogenLevel lower
 let upperLevel ← hydrogenLevel upper
 RunningConvergence.positiveTake lowerLevel upperLevel
theorem everyPositivePrincipal (n : Nat) : hydrogenLevel (.integer (.ofNat (n+1))) =
 .ok (normalize 1 ((n+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _))) := rfl
theorem positivePrincipalSuccessor (n : Nat) : hydrogenLevel (.integer (.ofNat (n+2))) =
 .ok (normalize 1 ((n+2)^2) (Nat.pow_pos (Nat.zero_lt_succ _))) := rfl
theorem zeroRejected : hydrogenLevel (.integer 0)=.error "principal support must be a positive count" := rfl
theorem negativeRejected (n : Nat) : hydrogenLevel (.integer (.negSucc n))=.error "principal support must be a positive count" := rfl
theorem truePrincipal : hydrogenLevel (.boolean true)=.ok (normalize 1 1 (by decide)) := rfl
theorem falsePrincipalRejected : hydrogenLevel (.boolean false)=.error "principal support must be a positive count" := rfl
theorem groundLevel : hydrogenLevel (.integer 1)=.ok (normalize 1 1 (by decide)) := rfl
theorem lymanAlpha : hydrogenTransition (.integer 2) (.integer 1)=.ok (normalize 3 4 (by decide)) := rfl
theorem balmerAlpha : hydrogenTransition (.integer 3) (.integer 2)=.ok (normalize 5 36 (by decide)) := rfl
theorem principalNumerator (n : Nat) :
 (normalize 1 ((n+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _))).num=1 := by
 unfold normalize BoundaryGrowth.asFraction SFT.Foundation.ExactOperations.normalizePositive
 change Int.ofNat (1 / Nat.gcd 1 ((n+1)^2))=1
 have gcd : Nat.gcd 1 ((n+1)^2)=1 := Nat.le_antisymm
  (SFT.Foundation.FractionReduction.divisorBound _ 1 (by decide)
    (SFT.Foundation.FractionReduction.gcdDivides 1 ((n+1)^2)).1)
  (SFT.Foundation.FractionReduction.gcdPositive 1 ((n+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _)))
 rw [gcd]
 rfl
theorem principalDenominator (n : Nat) :
 (normalize 1 ((n+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _))).den=(n+1)^2 := by
 unfold normalize BoundaryGrowth.asFraction SFT.Foundation.ExactOperations.normalizePositive
 change (n+1)^2 / Nat.gcd 1 ((n+1)^2)=(n+1)^2
 have gcd : Nat.gcd 1 ((n+1)^2)=1 := Nat.le_antisymm
  (SFT.Foundation.FractionReduction.divisorBound _ 1 (by decide)
    (SFT.Foundation.FractionReduction.gcdDivides 1 ((n+1)^2)).1)
  (SFT.Foundation.FractionReduction.gcdPositive 1 ((n+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _)))
 rw [gcd,SFT.Foundation.ExactOperations.divisionOne]
theorem orderedPrincipalSupports (lower upper : Nat) (ordered : lower<upper) :
 (normalize 1 ((upper+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _))).blt
 (normalize 1 ((lower+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _)))=true := by
 unfold Rat.blt
 rw [principalNumerator,principalNumerator,principalDenominator,principalDenominator]
 change decide ((1:Int)*Int.ofNat ((lower+1)^2)<1*Int.ofNat ((upper+1)^2))=true
 rw [Int.one_mul,Int.one_mul]
 have h := Nat.add_lt_add_right ordered 1
 have squares : (lower+1)^2 < (upper+1)^2 := by
  change (1*(lower+1))*(lower+1)<(1*(upper+1))*(upper+1)
  rw [Nat.one_mul,Nat.one_mul]
  exact Nat.lt_trans (Nat.mul_lt_mul_of_pos_right h (Nat.zero_lt_succ lower))
   (Nat.mul_lt_mul_of_pos_left h (Nat.zero_lt_succ upper))
 change @decide (Int.NonNeg (Int.subNatNat ((upper+1)^2) ((lower+1)^2+1)))
   (Int.decNonneg _) = true
 unfold Int.subNatNat
 rw [SFT.Physics.CommonScaleAxis.subtractionZeroOfBound _ _ squares]
 rfl

theorem principalPositive (n : Nat) : zero.blt (normalize 1 ((n+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _)))=true := by
 unfold Rat.blt
 rw [principalNumerator]
 rfl
theorem everyOrderedEmission (lower upper : Nat) (ordered : lower<upper) :
 hydrogenTransition (.integer (.ofNat (upper+1))) (.integer (.ofNat (lower+1))) =
 .ok (subtract (normalize 1 ((lower+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _)))
               (normalize 1 ((upper+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _)))) := by
 have guard : @decide
    (SectorInventory.countValue (.integer (.ofNat (upper+1))) ≤ SectorInventory.countValue (.integer (.ofNat (lower+1))))
    (Int.decLe (SectorInventory.countValue (.integer (.ofNat (upper+1))))
               (SectorInventory.countValue (.integer (.ofNat (lower+1)))))=false := by
  change @decide (Int.NonNeg (Int.subNatNat (lower+1) (upper+1))) (Int.decNonneg _) = false
  have positive := SFT.Foundation.ExactCast.subtractPositive (upper+1) (lower+1) (Nat.add_lt_add_right ordered 1)
  unfold Int.subNatNat
  cases h : (upper+1)-(lower+1) with
  | zero => rw [h] at positive; exact False.elim (Nat.not_lt_zero _ positive)
  | succ k => rfl
 unfold hydrogenTransition
 rw [guard]
 change (do
  let a ← hydrogenLevel (.integer (.ofNat (lower+1)))
  let b ← hydrogenLevel (.integer (.ofNat (upper+1)))
  RunningConvergence.positiveTake a b) = _
 rw [everyPositivePrincipal,everyPositivePrincipal]
 change RunningConvergence.positiveTake
  (normalize 1 ((lower+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _)))
  (normalize 1 ((upper+1)^2) (Nat.pow_pos (Nat.zero_lt_succ _))) = _
 unfold RunningConvergence.positiveTake
 rw [orderedPrincipalSupports lower upper ordered,principalPositive upper]
 rfl
end SFT.Physics.HydrogenSpectrum
