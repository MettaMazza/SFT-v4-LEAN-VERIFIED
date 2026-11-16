import SFT.Physics.ThermalHistoryTransport
import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Physics.ThermalHistoryVisibility
open ThermalHistory LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxHeartbeats 100000000
-- The exact rising-and-reflected weights from visibility_ledger.
def weights (radius : Nat) : List Nat :=
 ((List.range (radius+1)).map (fun n => n+1)) ++
 ((List.range radius).map (fun n => n+1)).reverse

theorem sumRetains (xs : List Nat) (acc : Nat) : acc ≤ xs.foldl Nat.add acc := by
 induction xs generalizing acc with
 | nil => exact Nat.le_refl _
 | cons x xs ih => exact Nat.le_trans (Nat.le_add_right acc x) (ih (acc+x))

theorem originalWeightTotalPositive (radius : Nat) : 0 < (weights radius).foldl Nat.add 0 := by
 unfold weights
 rw [foldAppend]
 apply Nat.lt_of_lt_of_le _ (sumRetains _ _)
 rw [rangeSuccessor,SFT.Mathematics.ExactTraceArithmetic.mapAppend,foldAppend]
 change 0 < ((List.range radius).map (fun n => n+1)).foldl Nat.add 0 + (radius+1)
 exact Nat.add_pos_right _ (Nat.zero_lt_succ radius)

private theorem reverseAuxAppend {α : Type} (xs ys zs : List α) :
 xs.reverseAux (ys++zs) = xs.reverseAux ys ++ zs := by
 induction xs generalizing ys with
 | nil => rfl
 | cons a xs ih => exact ih (a::ys)
private theorem reverseCons {α : Type} (x : α) (xs : List α) :
 (x::xs).reverse = xs.reverse ++ [x] := reverseAuxAppend xs [] [x]
private theorem appendNil {α : Type} (xs : List α) : xs++[] = xs := by
 induction xs with
 | nil => rfl
 | cons a xs ih => exact congrArg (List.cons a) ih
private theorem normalizedLoop (xs : List Nat) (total : Nat) (positive : 0<total) (acc : List Rat) :
 List.mapM.loop (fun n => LeptonRatios.divide (wholeRatio n) (wholeRatio total)) xs acc =
 .ok (acc.reverse ++ xs.map (fun n => natRatio n total positive)) := by
 induction xs generalizing acc with
 | nil => exact congrArg Except.ok (appendNil acc.reverse).symm
 | cons x xs ih =>
   rw [List.mapM.loop.eq_2]
   have d : LeptonRatios.divide (wholeRatio x) (wholeRatio total) = .ok (natRatio x total positive) := by
    rw [← natRatioWhole x,← natRatioWhole total,divideNormalized x 1 total 1 (by decide) positive (by decide)]
    apply congrArg Except.ok
    apply natRatioCongruence
    rw [Nat.mul_one,Nat.one_mul]
   rw [d]
   change List.mapM.loop _ xs (_::acc) = _
   rw [ih,reverseCons]
   exact congrArg Except.ok (appendAssociative acc.reverse [_] _)
theorem originalNormalizedWeights (xs : List Nat) (total : Nat) (positive : 0<total) :
 xs.mapM (fun n => LeptonRatios.divide (wholeRatio n) (wholeRatio total)) =
 .ok (xs.map (fun n => natRatio n total positive)) := by
 change List.mapM.loop _ xs [] = _
 rw [normalizedLoop]
 rfl

theorem originalNormalizedTotal (xs : List Nat) (positive : 0<xs.foldl Nat.add 0) :
 ((xs.map (fun n => natRatio n (xs.foldl Nat.add 0) positive)).foldl add zero) = wholeRatio 1 := by
 have z : zero = natRatio 0 (xs.foldl Nat.add 0) positive := by
  change natRatio 0 1 (by decide) = _
  apply natRatioCongruence
  rw [Nat.zero_mul,Nat.zero_mul]
 rw [z,foldNormalized]
 rw [← natRatioWhole 1]
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.one_mul]

theorem originalVisibilityComplete (radius : Nat) (positive : 0<radius) :
 (visibilityLedger radius).toOption.map Visibility.complete = some true := by
 have nonzero : (radius == 0)=false := by
  cases radius with
  | zero => cases positive
  | succ n => rfl
 unfold visibilityLedger
 rw [nonzero]
 simp only [Bool.false_or]
 rw [if_neg (by intro h; cases h)]
 have h := originalNormalizedWeights (weights radius) ((weights radius).foldl (fun a b => a+b) 0)
  (originalWeightTotalPositive radius)
 dsimp only [weights] at h
 rw [h]
 change some (VelocityComposition.ratEqual
  (((weights radius).map (fun n => natRatio n ((weights radius).foldl Nat.add 0)
    (originalWeightTotalPositive radius))).foldl add zero) (wholeRatio 1)) = some true
 rw [originalNormalizedTotal]
 exact congrArg some (decide_eq_true rfl)
-- Complete source support: the rising side, one midpoint, and its reflected side.
theorem originalMidpointDecomposition (radius : Nat) :
 weights radius = (((List.range radius).map (fun n => n+1)) ++ [radius+1]) ++
   ((List.range radius).map (fun n => n+1)).reverse := by
 unfold weights
 rw [rangeSuccessor,SFT.Mathematics.ExactTraceArithmetic.mapAppend]
 rfl

private theorem rangeBound (n x : Nat) (h : x ∈ List.range n) : x<n := by
 induction n with
 | zero => cases h
 | succ n ih =>
  rw [rangeSuccessor] at h
  cases SFT.Foundation.Count.TraceDerivation.memAppendCases x _ _ h with
  | inl left => exact Nat.lt_succ_of_lt (ih left)
  | inr right =>
    cases right with
    | head => exact Nat.lt_succ_self _
    | tail _ impossible => cases impossible
private theorem reverseAuxMembers {α : Type} (xs acc : List α) (x : α)
 (h : x ∈ xs.reverseAux acc) : x ∈ xs ∨ x ∈ acc := by
 induction xs generalizing acc with
 | nil => exact Or.inr h
 | cons a xs ih =>
   cases ih (a::acc) h with
   | inl left => exact Or.inl (List.Mem.tail _ left)
   | inr right =>
     cases right with
     | head => exact Or.inl (List.Mem.head _)
     | tail _ tail => exact Or.inr tail
private theorem reverseMembers {α : Type} (xs : List α) (x : α)
 (h : x ∈ xs.reverse) : x ∈ xs := by
 cases reverseAuxMembers xs [] x h with
 | inl left => exact left
 | inr right => cases right

theorem originalSideBelowMidpoint (radius x : Nat)
 (h : x ∈ (List.range radius).map (fun n => n+1)) : 0<x ∧ x<radius+1 := by
 obtain ⟨n,member,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ x _ h
 cases eq
 exact ⟨Nat.zero_lt_succ n,Nat.succ_lt_succ (rangeBound radius n member)⟩

theorem originalReflectedSideBelowMidpoint (radius x : Nat)
 (h : x ∈ ((List.range radius).map (fun n => n+1)).reverse) : 0<x ∧ x<radius+1 :=
 originalSideBelowMidpoint radius x (reverseMembers _ x h)

theorem originalEveryWeightPositive (radius x : Nat) (h : x ∈ weights radius) : 0<x := by
 unfold weights at h
 cases SFT.Foundation.Count.TraceDerivation.memAppendCases x _ _ h with
 | inl left => exact (originalSideBelowMidpoint (radius+1) x left).1
 | inr right => exact (originalReflectedSideBelowMidpoint radius x right).1

theorem originalNormalizedRecord (radius : Nat) (positive : 0<radius) :
 (visibilityLedger radius).toOption.map Visibility.normalized =
 some ((weights radius).map (fun n => natRatio n ((weights radius).foldl Nat.add 0)
  (originalWeightTotalPositive radius))) := by
 have nonzero : (radius == 0)=false := by
  cases radius with
  | zero => cases positive
  | succ n => rfl
 unfold visibilityLedger
 rw [nonzero]
 change (do
   let normalized ← (weights radius).mapM (fun n => LeptonRatios.divide (wholeRatio n)
    (wholeRatio ((weights radius).foldl (fun a b => a+b) 0)))
   pure (⟨radius,weights radius,normalized,radius,
    VelocityComposition.ratEqual (visibilityAt normalized radius)
      (normalized.foldl (fun a b => if a.blt b then b else a) zero) &&
      (normalized.filter (VelocityComposition.ratEqual (visibilityAt normalized radius))).length == 1,
    VelocityComposition.ratEqual (normalized.foldl add zero) (wholeRatio 1)⟩ : Visibility)).toOption.map Visibility.normalized = _
 rw [originalNormalizedWeights (weights radius) ((weights radius).foldl (fun a b => a+b) 0) (originalWeightTotalPositive radius)]
 rfl

theorem originalNormalizedMidpointDecomposition (radius : Nat) :
 let total := (weights radius).foldl Nat.add 0
 let norm := fun n => natRatio n total (originalWeightTotalPositive radius)
 (weights radius).map norm =
 (((List.range radius).map (fun n => n+1)).map norm ++ [norm (radius+1)]) ++
 (((List.range radius).map (fun n => n+1)).reverse.map norm) := by
 dsimp only
 let norm := fun n => natRatio n ((weights radius).foldl Nat.add 0) (originalWeightTotalPositive radius)
 have h := congrArg (fun xs => xs.map norm) (originalMidpointDecomposition radius)
 rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend] at h
 exact h

theorem originalNormalizedSideStrict (radius x : Nat)
 (member : x ∈ (List.range radius).map (fun n => n+1)) :
 let total := (weights radius).foldl Nat.add 0
 (natRatio x total (originalWeightTotalPositive radius)).blt
  (natRatio (radius+1) total (originalWeightTotalPositive radius)) = true := by
 have bounds := originalSideBelowMidpoint radius x member
 apply CommonScaleAxis.positiveNormalizedLess x _ (radius+1) _ bounds.1
  (originalWeightTotalPositive radius) (Nat.zero_lt_succ radius) (originalWeightTotalPositive radius)
 exact Nat.mul_lt_mul_of_pos_right bounds.2 (originalWeightTotalPositive radius)

theorem originalNormalizedReflectedSideStrict (radius x : Nat)
 (member : x ∈ ((List.range radius).map (fun n => n+1)).reverse) :
 let total := (weights radius).foldl Nat.add 0
 (natRatio x total (originalWeightTotalPositive radius)).blt
  (natRatio (radius+1) total (originalWeightTotalPositive radius)) = true :=
 originalNormalizedSideStrict radius x (reverseMembers _ x member)

theorem originalUniqueNormalizedMidpoint (radius : Nat) (positive : 0<radius) :
 let peak := natRatio (radius+1) ((weights radius).foldl Nat.add 0) (originalWeightTotalPositive radius)
 ∃ left right : List Rat,
  (visibilityLedger radius).toOption.map Visibility.normalized = some ((left++[peak])++right) ∧
  (∀ q,q ∈ left → q.blt peak=true) ∧ (∀ q,q ∈ right → q.blt peak=true) := by
 let norm := fun n => natRatio n ((weights radius).foldl Nat.add 0) (originalWeightTotalPositive radius)
 let side := (List.range radius).map (fun n => n+1)
 refine ⟨side.map norm,side.reverse.map norm,?_,?_,?_⟩
 · rw [originalNormalizedRecord radius positive,originalNormalizedMidpointDecomposition]
 · intro q member
   obtain ⟨x,hx,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage norm q side member
   cases eq
   exact originalNormalizedSideStrict radius x hx
 · intro q member
   obtain ⟨x,hx,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage norm q side.reverse member
   cases eq
   exact originalNormalizedReflectedSideStrict radius x hx
end SFT.Physics.ThermalHistoryVisibility
