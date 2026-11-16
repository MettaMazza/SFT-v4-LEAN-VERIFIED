import SFT.Physics.ThermalEquilibriumResponse
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.ThermalEquilibriumTemperature
open ThermalEquilibriumResponse LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxHeartbeats 100000000

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

private theorem retainedLoop (throws acc : List Rat)
 (positive : ∀ x ∈ throws, zero.blt x=true) :
 List.mapM.loop (fun x => CollectiveRadiation.requirePositive x "throw") throws acc = .ok (acc.reverse++throws) := by
 induction throws generalizing acc with
 | nil => exact congrArg Except.ok (appendNil acc.reverse).symm
 | cons x xs ih =>
   have hx := positive x (.head xs)
   have admitted : CollectiveRadiation.requirePositive x "throw" = .ok x := by
    unfold CollectiveRadiation.requirePositive
    rw [hx]
    rfl
   change (do let y ← CollectiveRadiation.requirePositive x "throw"
              List.mapM.loop _ xs (y::acc)) = _
   rw [admitted]
   change List.mapM.loop _ xs (x::acc) = _
   rw [ih (x::acc) (fun y hy => positive y (.tail x hy)),reverseCons]
   exact congrArg Except.ok (appendAssociative acc.reverse [x] xs)

private theorem retainedThrows (throws : List Rat)
 (positive : ∀ x ∈ throws, zero.blt x=true) :
 throws.mapM (fun x => CollectiveRadiation.requirePositive x "throw") = .ok throws := by
 change List.mapM.loop _ throws [] = _
 rw [retainedLoop throws [] positive]
 rfl

private theorem positiveNumerator (x : Rat) (h : zero.blt x=true) :
 x.num = Int.ofNat x.num.natAbs := by
 cases hn : x.num with
 | ofNat n => rfl
 | negSucc n =>
   unfold Rat.blt zero at h
   rw [hn] at h
   contradiction

private theorem sumNumerator (throws : List Rat)
 (positive : ∀ x ∈ throws, zero.blt x=true) (acc : Rat)
 (ha : acc.num = Int.ofNat acc.num.natAbs) :
 (throws.foldl add acc).num = Int.ofNat (throws.foldl add acc).num.natAbs := by
 induction throws generalizing acc with
 | nil => exact ha
 | cons x xs ih =>
   have hx := positiveNumerator x (positive x (.head xs))
   have sum : add acc x = natRatio (acc.num.natAbs*x.den+x.num.natAbs*acc.den)
     (acc.den*x.den) (Nat.mul_pos (Nat.pos_of_ne_zero acc.den_nz) (Nat.pos_of_ne_zero x.den_nz)) := by
    unfold add
    rw [ha,hx]
    rfl
   apply ih (fun y hy => positive y (.tail x hy)) (add acc x)
   rw [sum]
   exact natRatioNonnegative _ _ _

private theorem positiveMagnitude (x : Rat) (h : zero.blt x=true) : 0<x.num.natAbs := by
 cases hn : x.num with
 | ofNat n =>
   cases n with
   | zero => unfold Rat.blt zero at h; rw [hn] at h; contradiction
   | succ n => exact Nat.zero_lt_succ _
 | negSucc n => exact Nat.zero_lt_succ _

private theorem positiveIncrement (acc x : Rat)
 (ha : acc.num = Int.ofNat acc.num.natAbs) (hx : zero.blt x=true) :
 zero.blt (add acc x)=true := by
 have hn := positiveNumerator x hx
 have sum : add acc x = natRatio (acc.num.natAbs*x.den+x.num.natAbs*acc.den)
   (acc.den*x.den) (Nat.mul_pos (Nat.pos_of_ne_zero acc.den_nz) (Nat.pos_of_ne_zero x.den_nz)) := by
  unfold add
  rw [ha,hn]
  rfl
 rw [sum]
 exact positiveNormalized _ _ (Nat.add_pos_right _
   (Nat.mul_pos (positiveMagnitude x hx) (Nat.pos_of_ne_zero acc.den_nz))) _

private theorem positiveFold (xs : List Rat)
 (positive : ∀ x ∈ xs, zero.blt x=true) (acc : Rat) (ha : zero.blt acc=true) :
 zero.blt (xs.foldl add acc)=true := by
 induction xs generalizing acc with
 | nil => exact ha
 | cons x xs ih =>
   exact ih (fun y hy => positive y (.tail x hy)) (add acc x)
     (positiveIncrement acc x (positiveNumerator acc ha) (positive x (.head xs)))

theorem originalExactMean (x : Rat) (xs : List Rat)
 (positive : ∀ y ∈ x::xs, zero.blt y=true) :
 exactTemperature (x::xs) = LeptonRatios.divide ((x::xs).foldl add zero) (wholeRatio (xs.length+1)) := by
 unfold exactTemperature
 change (do let exact ← (x::xs).mapM (fun y => CollectiveRadiation.requirePositive y "throw")
            LeptonRatios.divide (exact.foldl add zero) (wholeRatio exact.length)) = _
 rw [retainedThrows (x::xs) positive]
 rfl

theorem originalPositiveTemperature (x : Rat) (xs : List Rat)
 (positive : ∀ y ∈ x::xs, zero.blt y=true) :
 ∃ temperature, exactTemperature (x::xs)=.ok temperature ∧ zero.blt temperature=true := by
 let total := (x::xs).foldl add zero
 have hp : zero.blt total=true := positiveFold xs (fun y hy => positive y (.tail x hy))
   (add zero x) (positiveIncrement zero x rfl (positive x (.head xs)))
 have ht : total=natRatio total.num.natAbs total.den (Nat.pos_of_ne_zero total.den_nz) :=
   representedIdentity total _ _ _ (positiveNumerator total hp) rfl
 refine ⟨natRatio (total.num.natAbs*1) (total.den*(xs.length+1))
   (Nat.mul_pos (Nat.pos_of_ne_zero total.den_nz) (Nat.zero_lt_succ _)), ?_, ?_⟩
 · rw [originalExactMean x xs positive]
   change LeptonRatios.divide total (wholeRatio (xs.length+1)) = _
   rw (occs := .pos [1]) [ht]
   rw [←natRatioWhole,divideNormalized _ _ _ _ _ (Nat.zero_lt_succ _) (by decide)]
 · exact positiveNormalized _ _ (Nat.mul_pos (positiveMagnitude total hp) (by decide)) _

theorem originalTotalThrowIdentity (x : Rat) (xs : List Rat)
 (positive : ∀ y ∈ x::xs, zero.blt y=true) :
 totalThrowIdentity (x::xs) = .ok true := by
 let total := (x::xs).foldl add zero
 have hn := sumNumerator (x::xs) positive zero (by rfl)
 have ht : total = natRatio total.num.natAbs total.den (Nat.pos_of_ne_zero total.den_nz) :=
   representedIdentity total _ _ _ hn rfl
 have hm : exactTemperature (x::xs) = .ok (natRatio (total.num.natAbs*1)
   (total.den*(xs.length+1)) (Nat.mul_pos (Nat.pos_of_ne_zero total.den_nz) (Nat.zero_lt_succ _))) := by
  rw [originalExactMean x xs positive]
  change LeptonRatios.divide total (wholeRatio (xs.length+1)) = _
  rw (occs := .pos [1]) [ht]
  rw [←natRatioWhole,divideNormalized _ _ _ _ _ (Nat.zero_lt_succ _) (by decide)]
 have product : multiply (wholeRatio (xs.length+1))
   (natRatio (total.num.natAbs*1) (total.den*(xs.length+1))
    (Nat.mul_pos (Nat.pos_of_ne_zero total.den_nz) (Nat.zero_lt_succ _))) = total := by
  rw [←natRatioWhole,multiplyNormalized]
  apply Eq.trans _ ht.symm
  apply natRatioCongruence
  rw [Nat.mul_one,Nat.one_mul,Nat.mul_comm (xs.length+1) total.num.natAbs,
   SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm (xs.length+1) total.den]
 unfold totalThrowIdentity
 rw [hm]
 change (Except.ok (VelocityComposition.ratEqual total (multiply (wholeRatio (xs.length+1)) _)) : Except String Bool) = _
 rw [product]
 apply congrArg Except.ok
 unfold VelocityComposition.ratEqual
 exact decide_eq_true rfl
end SFT.Physics.ThermalEquilibriumTemperature
