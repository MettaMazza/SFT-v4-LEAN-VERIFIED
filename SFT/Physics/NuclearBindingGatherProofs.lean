import SFT.Physics.NuclearBindingCensus
namespace SFT.Physics.NuclearBindingGatherProofs
open NuclearBindingCensus
set_option maxRecDepth 20000
abbrev gather := finitePeakCandidatesWithin.gather
theorem appendGather (fuel : Nat) (xs ys : List Nat) (left right : List (Nat × Nat))
 (hx : gather fuel xs = .ok (some left)) (hy : gather fuel ys = .ok (some right)) :
 gather fuel (xs++ys) = .ok (some (left++right)) := by
 induction xs generalizing left with
 | nil =>
   have same := Option.some.inj (Except.ok.inj hx)
   cases same
   exact hy
 | cons a xs ih =>
   change gather fuel (a::(xs++ys)) = _
   unfold gather finitePeakCandidatesWithin.gather at hx ⊢
   cases hc : candidatesWithin (.integer (.ofNat a)) fuel 1 with
   | error e => rw [hc] at hx; cases hx
   | ok step =>
     cases step with
     | none => rw [hc] at hx; cases hx
     | some charges =>
       rw [hc] at hx
       dsimp only [Except.bind,Bind.bind]
       cases ht : finitePeakCandidatesWithin.gather fuel xs with
       | error e => rw [ht] at hx; cases hx
       | ok result =>
         cases result with
         | none => rw [ht] at hx; cases hx
         | some rest =>
           rw [ht] at hx
           have same := Option.some.inj (Except.ok.inj hx)
           cases same
           have hr : finitePeakCandidatesWithin.gather fuel (xs++ys) = .ok (some (rest++right)) := ih rest ht
           rw [hr]
           exact congrArg Except.ok (congrArg Option.some (SFT.Physics.VacuumLedgerProofs.appendAssociative _ _ _).symm)
end SFT.Physics.NuclearBindingGatherProofs
