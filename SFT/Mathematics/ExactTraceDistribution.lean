import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Mathematics.ExactTraceDistribution
open ExactTraceArithmetic

/-! Distribution by complete generated cell provenance retains multiplicity.
Right distribution reorders the row-major source enumeration, so its exact
relation is a permutation, while left distribution is ordered equality. -/
theorem moveHead {α : Type} (x : α) (a b : List α) :
    List.Perm (x :: (a ++ b)) (a ++ (x :: b)) := by
  induction a with
  | nil => exact List.Perm.refl _
  | cons y ys ih => exact (List.Perm.swap y x (ys ++ b)).trans (List.Perm.cons y ih)

theorem swapBlocks {α : Type} (a b c : List α) :
    List.Perm (a ++ (b ++ c)) (b ++ (a ++ c)) := by
  induction a with
  | nil => exact List.Perm.refl _
  | cons x xs ih => exact (List.Perm.cons x ih).trans (moveHead x b (xs ++ c))

theorem interchangeBlocks {α : Type} (a b c d : List α) :
    List.Perm ((a ++ b) ++ (c ++ d)) ((a ++ c) ++ (b ++ d)) := by
  rw [appendAssociative,appendAssociative]
  exact List.Perm.append (List.Perm.refl a) (swapBlocks b c d)

theorem pairCellsRightDistribute (a b c : Trace) :
    List.Perm (pairCells a (b ++ c)) (pairCells a b ++ pairCells a c) := by
  induction a with
  | nil => exact List.Perm.refl _
  | cons x xs ih =>
    change List.Perm (((b ++ c).map (fun y => x ++ y)) ++ pairCells xs (b ++ c))
      ((b.map (fun y => x ++ y) ++ pairCells xs b) ++ (c.map (fun y => x ++ y) ++ pairCells xs c))
    rw [mapAppend]
    exact (List.Perm.append (List.Perm.refl _) ih).trans
      (interchangeBlocks (b.map (fun y => x ++ y)) (c.map (fun y => x ++ y)) (pairCells xs b) (pairCells xs c))

end SFT.Mathematics.ExactTraceDistribution
