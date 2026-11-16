import SFT.Physics.SpinStatisticsOccupationCounts
import SFT.Physics.ThermalHistoryVisibility
namespace SFT.Physics.SpinStatisticsOccupationWeights
open SpinStatisticsCondensation LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.Count.TraceDerivation
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
-- These are the original score expression and its complete source denominator.
def score (raw : List Nat) (depth : Nat) (word : List Nat) : Nat :=
 (raw.zip word).foldl (fun value (weight,occupied) => value*weight^(depth*occupied)) 1
def total (raw : List Nat) (depth : Nat) (words : List (List Nat)) : Nat :=
 (words.map (score raw depth)).foldl Nat.add 0
private theorem productPositive (raw word : List Nat) (depth acc : Nat)
 (positive : ∀ w∈raw,0<w) (initial : 0<acc) :
 0<(raw.zip word).foldl (fun value (weight,occupied) => value*weight^(depth*occupied)) acc := by
 induction raw generalizing word acc with
 | nil => exact initial
 | cons w ws ih =>
   cases word with
   | nil => exact initial
   | cons c cs =>
     exact ih cs _ (fun v hv => positive v (.tail w hv))
       (Nat.mul_pos initial (Nat.pow_pos (positive w (.head ws))))
theorem originalScorePositive (levels depth : Nat) (word : List Nat) :
 0<score ((List.range levels).map (fun i => 2^(levels-i-1))) depth word := by
 apply productPositive _ _ _ 1 _ (Nat.zero_lt_succ _)
 intro w hw
 obtain ⟨i,_,eq⟩ := memMapPreimage _ _ _ hw
 rw [←eq]
 exact Nat.pow_pos (by decide)
theorem originalTotalPositive (levels depth : Nat) (words : List (List Nat)) (nonempty : words≠[]) :
 0<total ((List.range levels).map (fun i => 2^(levels-i-1))) depth words := by
 cases words with
 | nil => exact False.elim (nonempty rfl)
 | cons word rest =>
   unfold total
   change 0<(rest.map (score _ depth)).foldl Nat.add (0+score _ depth word)
   rw [Nat.zero_add]
   exact Nat.lt_of_lt_of_le (originalScorePositive levels depth word)
     (ThermalHistoryVisibility.sumRetains _ _)
private theorem reverseAuxAppend {α : Type} (xs ys zs : List α) :
 xs.reverseAux (ys++zs)=xs.reverseAux ys++zs := by
 induction xs generalizing ys with
 | nil => rfl
 | cons x xs ih => exact ih (x::ys)
private theorem appendNil {α : Type} (xs : List α) : xs++[]=xs := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih
private theorem pairedLoop (words : List (List Nat)) (scores : List Nat→Nat) (sum : Nat)
 (positive : 0<sum) (acc : List (List Nat×Rat)) :
 List.mapM.loop (fun (word,value) => do
   let weight ← LeptonRatios.divide (wholeRatio value) (wholeRatio sum)
   pure (word,weight)) (words.zip (words.map scores)) acc =
 .ok (acc.reverse++words.map (fun word => (word,natRatio (scores word) sum positive))) := by
 induction words generalizing acc with
 | nil => exact congrArg Except.ok (appendNil acc.reverse).symm
 | cons word words ih =>
   rw [List.map_cons,List.zip_cons_cons,List.mapM.loop.eq_2]
   have d : LeptonRatios.divide (wholeRatio (scores word)) (wholeRatio sum)=.ok (natRatio (scores word) sum positive) := by
     rw [←natRatioWhole (scores word),←natRatioWhole sum,divideNormalized _ 1 _ 1 (by decide) positive (by decide)]
     apply congrArg Except.ok
     apply natRatioCongruence
     rw [Nat.mul_one,Nat.one_mul]
   dsimp only
   rw [d]
   change List.mapM.loop _ _ ((word,natRatio (scores word) sum positive)::acc)=_
   rw [ih]
   have reversed : ((word,natRatio (scores word) sum positive)::acc).reverse=
     acc.reverse++[(word,natRatio (scores word) sum positive)] := reverseAuxAppend acc [] [_]
   rw [reversed]
   exact congrArg Except.ok (appendAssociative acc.reverse [_] _)
private theorem projectedWeights (words : List (List Nat)) (scores : List Nat→Nat) (sum : Nat) (positive : 0<sum) :
 ((words.map (fun word => (word,natRatio (scores word) sum positive))).map Prod.snd)=
 (words.map scores).map (fun n => natRatio n sum positive) := by
 induction words with
 | nil => rfl
 | cons word words ih => exact congrArg (List.cons _) ih
-- Exact native measure, retaining each original word alongside its rational weight.
theorem originalWeightAssembly (n l d : Nat) (exchange : String) (words : List (List Nat))
 (generated : occupationVectors (.integer (.ofNat (n+1))) (.integer (.ofNat (l+1))) exchange=.ok words)
 (nonempty : words≠[]) :
 canonicalOccupationWeights (.integer (.ofNat (n+1))) (.integer (.ofNat (l+1))) exchange (.integer (.ofNat (d+1))) =
 .ok (words.map (fun word => (word,natRatio
   (score ((List.range (l+1)).map (fun i => 2^(l+1-i-1))) (d+1) word)
   (total ((List.range (l+1)).map (fun i => 2^(l+1-i-1))) (d+1) words)
   (originalTotalPositive (l+1) (d+1) words nonempty)))) := by
 unfold canonicalOccupationWeights
 rw [generated]
 cases words with
 | nil => exact False.elim (nonempty rfl)
 | cons word rest =>
   change List.mapM.loop _ _ []=_
   rw [pairedLoop]
   rfl

theorem originalEveryAdmittedMeasureNormalizes (n l d : Nat) (exchange : String) (words : List (List Nat))
 (generated : occupationVectors (.integer (.ofNat (n+1))) (.integer (.ofNat (l+1))) exchange=.ok words)
 (nonempty : words≠[]) :
 (canonicalOccupationWeights (.integer (.ofNat (n+1))) (.integer (.ofNat (l+1))) exchange (.integer (.ofNat (d+1)))).map
   (fun rows => (rows.map Prod.snd).foldl add zero)=.ok (wholeRatio 1) := by
 rw [originalWeightAssembly n l d exchange words generated nonempty]
 change Except.ok _=_
 dsimp only
 rw [projectedWeights]
 exact congrArg Except.ok (ThermalHistoryVisibility.originalNormalizedTotal _
   (originalTotalPositive (l+1) (d+1) words nonempty))
end SFT.Physics.SpinStatisticsOccupationWeights
