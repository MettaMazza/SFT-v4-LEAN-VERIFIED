import SFT.Physics.NuclearBindingScoreComposition
namespace SFT.Physics.NuclearBindingFoldComposition
open NuclearBindingPeak
private theorem foldAppend {α β : Type} (f : β → α → β) (xs ys : List α) (seed : β) :
 (xs++ys).foldl f seed = ys.foldl f (xs.foldl f seed) := by
 induction xs generalizing seed with
 | nil => rfl
 | cons a xs ih => exact ih (f seed a)
private theorem filterAppend {α : Type} (f : α → Bool) (xs ys : List α) :
 (xs++ys).filter f = xs.filter f ++ ys.filter f := by
 induction xs with
 | nil => rfl
 | cons a xs ih =>
   change (bif f a then a::(xs++ys).filter f else (xs++ys).filter f) =
     (bif f a then a::xs.filter f else xs.filter f) ++ ys.filter f
   cases h : f a
   · exact ih
   · exact congrArg (List.cons a) ih
def bestStep (best row : Scored) : Scored := if best.lower.blt row.lower then row else best
def upperStep (best : Rat) (row : Scored) : Rat := if best.blt row.upper then row.upper else best
theorem bestAppend (xs ys : List Scored) (seed : Scored) :
 (xs++ys).foldl bestStep seed = ys.foldl bestStep (xs.foldl bestStep seed) := foldAppend _ _ _ _
theorem rivalsAppend (winner : Scored) (xs ys : List Scored) (seed : Rat) :
 ((xs++ys).filter (fun row => !sameCoordinate row winner)).foldl upperStep seed =
 (ys.filter (fun row => !sameCoordinate row winner)).foldl upperStep
 ((xs.filter (fun row => !sameCoordinate row winner)).foldl upperStep seed) := by
 rw [filterAppend,foldAppend]
end SFT.Physics.NuclearBindingFoldComposition
