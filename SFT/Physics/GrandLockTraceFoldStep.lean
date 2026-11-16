import SFT.Physics.GrandLockDependency
namespace SFT.Physics.GrandLockDependency
-- The defining cons equation of the source's ordered, exception-preserving fold.
theorem sourceFoldCons {α β : Type} (f : β → α → Except String β) (b : β) (a : α) (as : List α) :
 recordFold f b (a :: as) = (f b a >>= fun next => recordFold f next as) := rfl
#print axioms sourceFoldCons

theorem sourceFoldCall {α β : Type} (f : β → α → Except String β) (before after terminal : β) (a : α) (rest : List α)
 (h : f before a = .ok after) (tail : recordFold f after rest = .ok terminal) :
 recordFold f before (a :: rest) = .ok terminal :=
 (sourceFoldCons f before a rest).trans ((congrArg (fun result : Except String β => result >>= fun next => recordFold f next rest) h).trans tail)
#print axioms sourceFoldCall
end SFT.Physics.GrandLockDependency
