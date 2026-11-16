import SFT.Physics.SpinStatisticsColdThreshold
namespace SFT.Physics.SpinStatisticsColdGrowth
open SpinStatisticsCondensation SpinStatisticsOccupationWeights SpinStatisticsColdScores SpinStatisticsColdMeasure
open LeptonIntervals VacuumLedgerProofs ThermalEquilibriumMultinomial
open SFT.Foundation.FractionReduction
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
private theorem scoreBase (raw word : List Nat) : score raw 1 word=powerProduct raw word := by
 rw [originalScorePower]
 change 1*powerProduct raw word=_
 exact Nat.one_mul _
theorem originalScoreSuccessor (raw word : List Nat) (depth : Nat) :
 score raw (depth+1) word=score raw depth word*powerProduct raw word := by
 rw [originalScorePower,originalScorePower,Nat.pow_succ]
private theorem excitedBaseStrict (particles levels : Nat) (word : List Nat)
 (generated : word∈words particles levels) (excited : word≠ground particles levels) :
 powerProduct (ThermalEquilibriumWeights.originalCounts levels) word <
 powerProduct (ThermalEquilibriumWeights.originalCounts levels) (ground particles levels) := by
 have ratio := originalRelativeColdScore particles levels 1 word generated
 rw [scoreBase,scoreBase,Nat.mul_one] at ratio
 have divisor := originalExcitedCoolingFactor particles (levels+1) word generated excited
 have positive := originalScorePositive (levels+2) 1 word
 change 0<score (ThermalEquilibriumWeights.originalCounts levels) 1 word at positive
 rw [scoreBase] at positive
 have strict : powerProduct (ThermalEquilibriumWeights.originalCounts levels) word <
   powerProduct (ThermalEquilibriumWeights.originalCounts levels) word*2 := by
   rw [Nat.mul_succ,Nat.mul_one]
   exact Nat.lt_add_of_pos_right positive
 have upper := Nat.mul_le_mul_left (powerProduct (ThermalEquilibriumWeights.originalCounts levels) word) divisor
 rw [ratio] at upper
 exact Nat.lt_of_lt_of_le strict upper

theorem originalExcitedShareCrossStrict (particles levels depth : Nat) (word : List Nat)
 (generated : word∈words particles levels) (excited : word≠ground particles levels) :
 score (ThermalEquilibriumWeights.originalCounts levels) (depth+1) word *
 score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels) <
 score (ThermalEquilibriumWeights.originalCounts levels) depth word *
 score (ThermalEquilibriumWeights.originalCounts levels) (depth+1) (ground particles levels) := by
 have wp : 0<score (ThermalEquilibriumWeights.originalCounts levels) depth word := originalScorePositive (levels+2) depth word
 have gp : 0<score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels) := originalScorePositive (levels+2) depth (ground particles levels)
 have strict := Nat.mul_lt_mul_of_pos_left (excitedBaseStrict particles levels word generated excited) (Nat.mul_pos wp gp)
 rw [originalScoreSuccessor,originalScoreSuccessor]
 simpa only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm] using strict

def firstExcited (p levels : Nat) : List Nat := p::1::List.replicate levels 0
private theorem zeroLength (n : Nat) : (List.replicate n 0).length=n := by
 induction n with
 | zero => rfl
 | succ n ih => exact congrArg Nat.succ ih
private theorem zeroSum (n acc : Nat) : (List.replicate n 0).foldl Nat.add acc=acc := by
 induction n with
 | zero => rfl
 | succ n ih => exact ih

theorem originalExcitedWordGenerated (p levels : Nat) : firstExcited p levels∈words (p+1) levels := by
 apply (SpinStatisticsOccupationBounds.originalPreservingComplete (p+1) (levels+1) _).mpr
 constructor
 · change (List.replicate levels 0).length+1+1=levels+1+1
   rw [zeroLength]
 · change (List.replicate levels 0).foldl Nat.add (0+p+1)=p+1
   rw [zeroSum,Nat.zero_add]
theorem originalExcitedWordDifferent (p levels : Nat) : firstExcited p levels≠ground (p+1) levels := by
 intro same
 have head := (List.cons.inj same).1
 exact Nat.ne_of_lt (Nat.lt_succ_self p) head
private theorem sumAccumulator (xs : List Nat) (acc : Nat) : xs.foldl Nat.add acc=acc+xs.foldl Nat.add 0 := by
 induction xs generalizing acc with
 | nil => exact (Nat.add_zero acc).symm
 | cons x xs ih =>
   change xs.foldl Nat.add (acc+x)=acc+xs.foldl Nat.add (0+x)
   rw [ih (acc+x),ih (0+x),Nat.zero_add,Nat.add_assoc]
private theorem sumHead (f : List Nat→Nat) (x : List Nat) (xs : List (List Nat)) :
 ((x::xs).map f).foldl Nat.add 0=f x+(xs.map f).foldl Nat.add 0 := by
 change (xs.map f).foldl Nat.add (0+f x)=_
 rw [sumAccumulator,Nat.zero_add]
private theorem sumsWeak (xs : List (List Nat)) (f g : List Nat→Nat)
 (bound : ∀ x∈xs,f x≤g x) : (xs.map f).foldl Nat.add 0≤(xs.map g).foldl Nat.add 0 := by
 induction xs with
 | nil => exact Nat.le_refl _
 | cons x xs ih =>
   rw [sumHead,sumHead]
   exact Nat.add_le_add (bound x (.head xs)) (ih (fun y hy => bound y (.tail x hy)))
private theorem sumsStrict (xs : List (List Nat)) (f g : List Nat→Nat)
 (bound : ∀ x∈xs,f x≤g x) (strict : ∃ x∈xs,f x<g x) :
 (xs.map f).foldl Nat.add 0<(xs.map g).foldl Nat.add 0 := by
 induction xs with
 | nil => obtain ⟨x,h,_⟩ := strict;cases h
 | cons x xs ih =>
   rw [sumHead,sumHead]
   obtain ⟨y,held,better⟩ := strict
   cases held with
   | head => exact Nat.add_lt_add_of_lt_of_le better (sumsWeak xs f g (fun z hz => bound z (.tail x hz)))
   | tail _ h => exact Nat.add_lt_add_of_le_of_lt (bound x (.head xs)) (ih (fun z hz => bound z (.tail x hz)) ⟨y,h,better⟩)
private theorem sumMultiply (xs : List (List Nat)) (f : List Nat→Nat) (k acc : Nat) :
 (xs.map (fun x => f x*k)).foldl Nat.add (acc*k)=(xs.map f).foldl Nat.add acc*k := by
 induction xs generalizing acc with
 | nil => rfl
 | cons x xs ih =>
   change (xs.map (fun x => f x*k)).foldl Nat.add (acc*k+f x*k)=_
   rw [←addMul]
   exact ih (acc+f x)
theorem originalGroundShareCrossStrict (p levels depth : Nat) :
 denominator (p+1) levels (depth+1)*score (ThermalEquilibriumWeights.originalCounts levels) depth (ground (p+1) levels)<
 denominator (p+1) levels depth*score (ThermalEquilibriumWeights.originalCounts levels) (depth+1) (ground (p+1) levels) := by
 let raw := ThermalEquilibriumWeights.originalCounts levels
 let forms := words (p+1) levels
 let g := ground (p+1) levels
 let before := score raw depth
 let after := score raw (depth+1)
 have weak : ∀ word∈forms,after word*before g≤before word*after g := by
   intro word held
   cases decEq word g with
   | isTrue eq => rw [eq,Nat.mul_comm];exact Nat.le_refl _
   | isFalse different => exact Nat.le_of_lt (originalExcitedShareCrossStrict (p+1) levels depth word held different)
 have strong := sumsStrict forms (fun word => after word*before g) (fun word => before word*after g) weak
   ⟨firstExcited p levels,originalExcitedWordGenerated p levels,
    originalExcitedShareCrossStrict (p+1) levels depth _ (originalExcitedWordGenerated p levels) (originalExcitedWordDifferent p levels)⟩
 have left := sumMultiply forms after (before g) 0
 have right := sumMultiply forms before (after g) 0
 rw [Nat.zero_mul] at left right
 rw [left,right] at strong
 exact strong
theorem originalEveryGroundShareIncreases (p l d : Nat) :
 ∃ before after : Rat,
 groundShare (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat (d+1)))=.ok before ∧
 groundShare (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat (d+2)))=.ok after ∧
 before.blt after=true := by
 refine ⟨_,_,originalGroundShareOperation p l d,originalGroundShareOperation p l (d+1),?_⟩
 apply CommonScaleAxis.positiveNormalizedLess
   _ _ _ _ (originalScorePositive (l+2) (d+1) (ground (p+1) l))
   (originalDenominatorPositive (p+1) l (d+1))
   (originalScorePositive (l+2) (d+2) (ground (p+1) l))
   (originalDenominatorPositive (p+1) l (d+2))
 have cross := originalGroundShareCrossStrict p l (d+1)
 rw [Nat.mul_comm (denominator (p+1) l (d+1+1)),Nat.mul_comm (denominator (p+1) l (d+1))] at cross
 exact cross
end SFT.Physics.SpinStatisticsColdGrowth
