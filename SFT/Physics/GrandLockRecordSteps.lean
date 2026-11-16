import SFT.Physics.GrandLockDependency
namespace SFT.Physics.GrandLockDependency
-- Defining source equations, used to compose the complete original record.
theorem sourceMapCall {α β : Type} (f : α → Except String β) (x : α) (xs : List α) (y : β) (ys : List β)
 (head : f x = .ok y) (tail : recordMap f xs = .ok ys) : recordMap f (x :: xs) = .ok (y :: ys) := by
 change (do let b ← f x; let bs ← recordMap f xs; pure (b :: bs)) = _
 rewrite [head]
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
 rewrite [tail]
 rfl
theorem sourceUniqueAbsent (x : String) (xs ys : List String) (h : member x xs = false) (tail : unique xs = ys) : unique (x::xs) = x::ys := by
 change (if member x xs then unique xs else x :: unique xs) = _
 rewrite [h]
 rewrite [ite_eq_right Bool.false_ne_true]
 rewrite [tail]
 rfl
#print axioms sourceMapCall
#print axioms sourceUniqueAbsent
end SFT.Physics.GrandLockDependency
