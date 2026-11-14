import SFT.Mathematics.PrimePairCensus
namespace SFT.Mathematics.PrimePairDerivation
open PrimePairCensus

theorem generatedSplitCount (even left count : Nat) :
 (generatedSplits even left count).length=count := by
 induction count generalizing left with
 | zero => rfl
 | succ count ih => exact congrArg Nat.succ (ih (left+1))

theorem firstGeneratedPrimePair (even left count : Nat) :
 pairSearch even left count =
 (generatedSplits even left count).find? (fun p => isPrime p.1 && isPrime p.2) := by
 induction count generalizing left with
 | zero => rfl
 | succ count ih =>
   rw [pairSearch,generatedSplits,List.find?_cons]
   cases h : isPrime left && isPrime (even-left) with
   | false => exact ih (left+1)
   | true => rfl

theorem everySplitGenerated (even left count index : Nat) (inside : index<count) :
 (left+index,even-(left+index)) ∈ generatedSplits even left count := by
 induction count generalizing left index with
 | zero => exact False.elim (Nat.not_lt_zero index inside)
 | succ count ih =>
   cases index with
   | zero => exact List.Mem.head _
   | succ index =>
     have member := ih (left+1) index (Nat.lt_of_succ_lt_succ inside)
     have shape : (left+1)+index=left+(index+1) := Nat.add_right_comm _ _ _
     rw [shape] at member
     exact List.Mem.tail _ member

theorem everyGeneratedSplitInRange (even left count : Nat) (pair : Nat × Nat)
 (member : pair ∈ generatedSplits even left count) :
 ∃ index, index<count ∧ pair=(left+index,even-(left+index)) := by
 induction count generalizing left with
 | zero => cases member
 | succ count ih =>
   cases member with
   | head => exact ⟨0,Nat.zero_lt_succ _,rfl⟩
   | tail _ member =>
     obtain ⟨i,hi,shape⟩ := ih (left+1) member
     refine ⟨i+1,Nat.succ_lt_succ hi,?_⟩
     exact shape.trans (congrArg (fun n => (n,even-n)) (Nat.add_right_comm left 1 i))

theorem splitJoinsWhole (even left : Nat) (bound : left≤even) :
 left+(even-left)=even := (Nat.add_comm _ _).trans (SFT.Foundation.FractionReduction.subtractAdd even left bound)

theorem allAppend {α : Type} (test : α → Bool) (xs ys : List α) :
 (xs++ys).all test = (xs.all test && ys.all test) := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
   change (test x && (xs++ys).all test) = ((test x && xs.all test) && ys.all test)
   rw [ih]
   cases test x <;> rfl

-- Every continuing source iteration increments the divisor by exactly one.
-- The existing sourceLoopStep and successorCapacity prove that the derived
-- finite counter never terminates a still-enabled square-bound iteration.
theorem originalPrimeLoop (n : Nat) (admitted : ¬n<2) :
 isPrime n=(if 2*2≤n then (if n%2==0 then false else trial n 3 (n-1)) else true) := by
 unfold isPrime
 rw [ite_eq_right admitted]
 exact sourceLoopStep n 2 n (Nat.le_refl _) (originalCapacity n)

end SFT.Mathematics.PrimePairDerivation
