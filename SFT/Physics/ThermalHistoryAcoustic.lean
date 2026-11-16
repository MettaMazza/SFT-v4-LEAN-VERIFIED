import SFT.Physics.ThermalHistoryVisibility
import SFT.QuantumComputation.ReversiblePhase
namespace SFT.Physics.ThermalHistoryAcoustic
open ThermalHistory LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxHeartbeats 100000000
-- Exact row produced by acoustic_mode_ledger at zero-based position n.
def row (count n : Nat) : AcousticMode :=
 ⟨n+1,natRatio (n+1) (count+1) (Nat.zero_lt_succ count),
   if (n+1)%2 == 1 then "compression" else "rarefaction"⟩
def rows (count : Nat) : List AcousticMode := (List.range count).map (row count)
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
private theorem rowsLoop (count : Nat) (xs : List Nat) (acc : List AcousticMode) :
 List.mapM.loop (fun n => do
   let phase ← LeptonRatios.divide (wholeRatio (n+1)) (wholeRatio (count+1))
   pure (⟨n+1,phase,if (n+1)%2 == 1 then "compression" else "rarefaction"⟩ : AcousticMode)) xs acc =
 .ok (acc.reverse ++ xs.map (row count)) := by
 induction xs generalizing acc with
 | nil => exact congrArg Except.ok (appendNil acc.reverse).symm
 | cons n xs ih =>
   rw [List.mapM.loop.eq_2]
   have d : LeptonRatios.divide (wholeRatio (n+1)) (wholeRatio (count+1)) =
    .ok (natRatio (n+1) (count+1) (Nat.zero_lt_succ count)) := by
    rw [← natRatioWhole (n+1),← natRatioWhole (count+1),
      divideNormalized (n+1) 1 (count+1) 1 (by decide) (Nat.zero_lt_succ count) (by decide)]
    apply congrArg Except.ok
    apply natRatioCongruence
    rw [Nat.mul_one,Nat.one_mul]
   rw [d]
   change List.mapM.loop _ xs (row count n::acc) = _
   rw [ih,reverseCons]
   exact congrArg Except.ok (appendAssociative acc.reverse [_] _)

theorem originalModeLedger (count : Nat) (positive : 0<count) :
 acousticModeLedger count = .ok (rows count) := by
 have nonzero : (count == 0)=false := by
  cases count with
  | zero => cases positive
  | succ n => rfl
 unfold acousticModeLedger
 rw [nonzero]
 change List.mapM.loop _ (List.range count) [] = _
 rw [rowsLoop]
 rfl

theorem originalCompleteModeCount (count : Nat) : (rows count).length=count := by
 unfold rows
 rw [SFT.Foundation.CommonRefinement.mapLength]
 exact (VacuumSpectrum.rangeLoopLength count []).trans (Nat.add_zero count)

theorem originalPositiveMode (count n : Nat) : 0 < (row count n).mode := Nat.zero_lt_succ n

theorem originalPhasePositive (count n : Nat) : zero.blt (row count n).phaseSupport = true :=
 positiveNormalized (n+1) (count+1) (Nat.zero_lt_succ n) (Nat.zero_lt_succ count)

theorem originalSuccessiveParity (n : Nat) :
 ((n+1)%2 == 1) = ! (n%2 == 1) := by
 have bound := Nat.mod_lt n (by decide : 0<2)
 rw [← SFT.QuantumComputation.ReversiblePhase.remainderBeforeAddition n 1 2 (by decide)]
 cases h : n%2 with
 | zero => rfl
 | succ k =>
   cases k with
   | zero => rfl
   | succ k =>
     rw [h] at bound
     exact False.elim (Nat.not_lt_of_ge (Nat.le_add_left 2 k) bound)

theorem originalLoadingAlternates (count n : Nat) :
 (row count (n+1)).loading ≠ (row count n).loading := by
 change (if ((n+1)+1)%2 == 1 then "compression" else "rarefaction") ≠
  (if (n+1)%2 == 1 then "compression" else "rarefaction")
 rw [originalSuccessiveParity]
 cases h : ((n+1)%2 == 1) <;> decide
end SFT.Physics.ThermalHistoryAcoustic
