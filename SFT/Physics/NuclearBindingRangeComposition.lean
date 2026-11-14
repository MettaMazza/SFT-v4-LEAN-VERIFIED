import SFT.Physics.NuclearBindingGatherProofs
namespace SFT.Physics.NuclearBindingRangeComposition
theorem mapAdd (a s n : Nat) : (List.range' s n).map (fun x => a+x) = List.range' (a+s) n := by
 induction n generalizing s with
 | zero => rfl
 | succ n ih =>
   change (a+s)::(List.range' (s+1) n).map (fun x => a+x) = (a+s)::List.range' (a+s+1) n
   rw [ih,Nat.add_assoc]
theorem rangeAppend (s m n : Nat) : List.range' s m ++ List.range' (s+m) n = List.range' s (m+n) := by
 induction m generalizing s with
 | zero => rw [Nat.zero_add]; rfl
 | succ m ih =>
   rw [Nat.succ_add]
   change (s::List.range' (s+1) m) ++ List.range' (s+(m+1)) n = s::List.range' (s+1) (m+n)
   have eqn : s+(m+1) = (s+1)+m := (Nat.add_assoc s m 1).symm.trans ((congrArg (fun x => s+x) (Nat.add_comm m 1)).trans (Nat.add_assoc s 1 m).symm)
   rw [eqn]
   exact congrArg (List.cons s) (ih (s+1))
end SFT.Physics.NuclearBindingRangeComposition
