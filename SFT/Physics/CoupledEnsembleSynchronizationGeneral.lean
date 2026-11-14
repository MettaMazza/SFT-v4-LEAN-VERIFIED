import SFT.Physics.CoupledEnsembleSynchronization
namespace SFT.Physics.CoupledEnsembleSynchronizationGeneral
open CoupledEnsembleSynchronization LeptonIntervals
set_option maxHeartbeats 100000000
-- Original synchronized_ensemble_successor: one common Fold image at every position.
theorem originalSynchronizedSuccessor (point : Rat) (n : Nat)
 (domain : (!zero.blt point || (normalize 1 1 (by decide)).blt point)=false) :
 synchronizedEnsembleSuccessor point (.integer (.ofNat (n+2)))=
 .ok ((List.range (n+2)).map (fun _ =>
  if (normalize 1 1 (by decide)).blt (add point point)
  then subtract (add point point) (normalize 1 1 (by decide)) else add point point)) := by
 unfold synchronizedEnsembleSuccessor
 rw [domain]
 rfl
private theorem mappedMember (xs : List Nat) (point q : Rat)
 (member : q ∈ xs.map (fun _ => point)) : q=point := by
 induction xs with
 | nil => cases member
 | cons a tail ih =>
  cases member with
  | head => rfl
  | tail _ h => exact ih h
-- Equality is about every member of the actual returned ensemble, not samples.
theorem everyReturnedMemberEqual (point : Rat) (n : Nat) (xs : List Rat)
 (domain : (!zero.blt point || (normalize 1 1 (by decide)).blt point)=false)
 (output : synchronizedEnsembleSuccessor point (.integer (.ofNat (n+2)))=.ok xs)
 (a b : Rat) (ha : a∈xs) (hb : b∈xs) : a=b := by
 rw [originalSynchronizedSuccessor point n domain] at output
 cases output
 exact (mappedMember _ _ a ha).trans (mappedMember _ _ b hb).symm
private theorem constantLength (xs : List Nat) (point : Rat) :
 (xs.map (fun _ => point)).length=xs.length := by
 induction xs with
 | nil => rfl
 | cons a tail ih => exact congrArg Nat.succ ih
theorem allMembersRetained (point : Rat) (n : Nat) (xs : List Rat)
 (domain : (!zero.blt point || (normalize 1 1 (by decide)).blt point)=false)
 (output : synchronizedEnsembleSuccessor point (.integer (.ofNat (n+2)))=.ok xs) :
 xs.length=n+2 := by
 rw [originalSynchronizedSuccessor point n domain] at output
 cases output
 rw [constantLength,List.range_eq_range',List.length_range']
end SFT.Physics.CoupledEnsembleSynchronizationGeneral
