import SFT.Physics.NuclearBindingPeak
namespace SFT.Physics.NuclearBindingScoreComposition
open NuclearBindingPeak VacuumLedgerProofs
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
private def recMap {α β : Type} (f : α → Except String β) : List α → Except String (List β)
 | [] => .ok []
 | a::xs => do
   let b ← f a
   let bs ← recMap f xs
   pure (b::bs)
private theorem loopRec {α β : Type} (f : α → Except String β) (xs : List α) (acc : List β) :
 List.mapM.loop f xs acc = (recMap f xs).map (fun rows => acc.reverse ++ rows) := by
 induction xs generalizing acc with
 | nil => exact congrArg Except.ok (appendNil acc.reverse).symm
 | cons a xs ih =>
   rw [List.mapM.loop.eq_2]
   unfold recMap
   cases hf : f a with
   | error e => rfl
   | ok b =>
     change List.mapM.loop f xs (b::acc) = _
     rw [ih]
     cases hr : recMap f xs with
     | error e => rfl
     | ok bs =>
       change Except.ok ((b::acc).reverse ++ bs) = Except.ok (acc.reverse ++ b::bs)
       rw [reverseCons]
       exact congrArg Except.ok (appendAssociative acc.reverse [b] bs)
private theorem mapRec {α β : Type} (f : α → Except String β) (xs : List α) : xs.mapM f = recMap f xs := by
 change List.mapM.loop f xs [] = _
 rw [loopRec]
 cases recMap f xs <;> rfl
private theorem recAppend {α β : Type} (f : α → Except String β) (xs ys : List α)
 (left right : List β) (hx : recMap f xs = .ok left) (hy : recMap f ys = .ok right) :
 recMap f (xs++ys) = .ok (left++right) := by
 induction xs generalizing left with
 | nil => cases hx; exact hy
 | cons a xs ih =>
   change recMap f (a::(xs++ys)) = _
   unfold recMap at hx ⊢
   cases hf : f a with
   | error e => rw [hf] at hx; cases hx
   | ok b =>
     rw [hf] at hx
     cases ht : recMap f xs with
     | error e => rw [ht] at hx; cases hx
     | ok bs =>
       rw [ht] at hx
       cases hx
       have h := ih bs ht
       change (do let rs ← recMap f (xs++ys); pure (b::rs)) = _
       rw [h]
       rfl
theorem scoreAppend (n : Nat) (xs ys : List (Nat × Nat)) (left right : List Scored)
 (hx : scoreCandidates n xs = .ok left) (hy : scoreCandidates n ys = .ok right) :
 scoreCandidates n (xs++ys) = .ok (left++right) := by
 unfold scoreCandidates at hx hy ⊢
 rw [mapRec] at hx hy ⊢
 exact recAppend _ xs ys left right hx hy
end SFT.Physics.NuclearBindingScoreComposition
