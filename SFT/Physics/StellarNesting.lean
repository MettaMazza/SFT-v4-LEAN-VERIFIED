import SFT.Physics.StellarNuclearStages
namespace SFT.Physics.StellarNesting
open StellarNuclearStages
private def descending : Nat → List Nat
 | 0=>[]
 | n+1=>(n+1)::descending n
private theorem appendNil (xs : List Nat) : xs++[]=xs := by
 induction xs with
 | nil=>rfl
 | cons x xs ih=>exact congrArg (List.cons x) ih
private theorem appendAssoc (xs ys zs : List Nat) : (xs++ys)++zs=xs++(ys++zs) := by
 induction xs with
 | nil=>rfl
 | cons x xs ih=>exact congrArg (List.cons x) ih
private theorem reverseAuxAppend (xs acc more : List Nat) : xs.reverseAux (acc++more)=xs.reverseAux acc++more := by
 induction xs generalizing acc with
 | nil=>rfl
 | cons x xs ih=>exact ih (x::acc)
private theorem reverseCons (x : Nat) (xs : List Nat) : (x::xs).reverse=xs.reverse++[x] := reverseAuxAppend xs [] [x]
private theorem sourceRangeReverse (n : Nat) (acc : List Nat) :
 ((List.range.loop n acc).map (fun i=>i+1)).reverse=(acc.map (fun i=>i+1)).reverse++descending n := by
 induction n generalizing acc with
 | zero=>exact (appendNil _).symm
 | succ n ih=>
  change ((List.range.loop n (n::acc)).map (fun i=>i+1)).reverse=_
  rw [ih]
  change ((n+1)::(acc.map (fun i=>i+1))).reverse++descending n=_
  rw [reverseCons,appendAssoc]
  rfl
private theorem descendingStrict (n : Nat) : adjacentDescending (descending n)=true := by
 induction n with
 | zero=>rfl
 | succ n ih=>
  cases n with
  | zero=>rfl
  | succ k=>
   change (decide (k+1<k+2) && adjacentDescending (descending (k+1)))=true
   rw [decide_eq_true (Nat.lt_succ_self (k+1)),ih]
   rfl
private theorem descendingPositive (n : Nat) : (descending n).all (fun k=>1≤k)=true := by
 induction n with
 | zero=>rfl
 | succ n ih=>
  change (decide (1≤n+1) && (descending n).all (fun k=>1≤k))=true
  rw [decide_eq_true (Nat.le_add_left 1 n),ih]
  rfl
theorem originalNestedStrict (n : Nat) : (nestedStageSupport (.integer (.ofNat (n+1)))).map adjacentDescending=.ok true := by
 change Except.ok (adjacentDescending (((List.range.loop (n+1) []).map (fun i=>i+1)).reverse))=_
 rw [sourceRangeReverse]
 exact congrArg Except.ok (descendingStrict (n+1))
theorem originalNestedPositive (n : Nat) : (nestedStageSupport (.integer (.ofNat (n+1)))).map (fun widths=>widths.all (fun k=>1≤k))=.ok true := by
 change Except.ok ((((List.range.loop (n+1) []).map (fun i=>i+1)).reverse).all (fun k=>1≤k))=_
 rw [sourceRangeReverse]
 exact congrArg Except.ok (descendingPositive (n+1))
#print axioms originalNestedStrict
#print axioms originalNestedPositive
end SFT.Physics.StellarNesting
