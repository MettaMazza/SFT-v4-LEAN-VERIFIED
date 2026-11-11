import SFT.Chemistry.GBlockOrder
namespace SFT.Chemistry.GBlockTraversal
open GBlockOperations GBlockOrder SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.DiscreteObjects SFT.QuantumComputation.ReversibleFaults

def Before (a b : Nat × Nat) : Prop :=
 a.1+a.2 < b.1+b.2 ∨ (a.1+a.2 = b.1+b.2 ∧ a.1 < b.1)

theorem appendOrdered {α : Type} (rel : α → α → Prop) (xs ys : List α)
 (left : xs.Pairwise rel) (right : ys.Pairwise rel)
 (cross : ∀ a, a ∈ xs → ∀ b, b ∈ ys → rel a b) : (xs++ys).Pairwise rel := by
 induction xs with
 | nil => exact right
 | cons a xs ih =>
   cases left with
   | cons head tail =>
     apply List.Pairwise.cons
     · intro b held
       cases memAppendCases b xs ys held with
       | inl old => exact head b old
       | inr fresh => exact cross a (List.Mem.head _) b fresh
     · exact ih tail (fun b hb c hc => cross b (List.Mem.tail _ hb) c hc)

theorem principalRangeAscending (n : Nat) : (List.range n).Pairwise Nat.lt := by
 induction n with
 | zero => exact List.Pairwise.nil
 | succ n ih =>
   rw [SFT.Mathematics.OrbitLoopCompletion.rangeSuccessor]
   apply appendOrdered _ _ _ ih (List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil)
   intro a ha b hb
   cases hb with
   | head => exact (rangeMembership n a).mp ha
   | tail _ h => cases h

theorem filterAscending (test : Nat → Bool) (xs : List Nat)
 (sorted : xs.Pairwise Nat.lt) : (xs.filter test).Pairwise Nat.lt := by
 induction xs with
 | nil => exact List.Pairwise.nil
 | cons a xs ih =>
   cases sorted with
   | cons head tail =>
     cases yes : test a with
     | false =>
       rw [List.filter_cons_of_neg (by rw [yes]; intro h; cases h)]
       exact ih tail
     | true =>
       rw [List.filter_cons_of_pos yes]
       exact List.Pairwise.cons (fun b hb => head b ((filterMemberIff test xs b).mp hb).1) (ih tail)

theorem fixedCoverAscending (cover : Nat) (xs : List Nat) (sorted : xs.Pairwise Nat.lt)
 (bounded : ∀ p, p ∈ xs → p ≤ cover) :
 (xs.map (fun p => (p,cover-p))).Pairwise Before := by
 induction xs with
 | nil => exact List.Pairwise.nil
 | cons a xs ih =>
   cases sorted with
   | cons head tail =>
     apply List.Pairwise.cons
     · intro cell held
       obtain ⟨b,hb,same⟩ := memMapPreimage (fun p => (p,cover-p)) cell xs held
       rw [←same]
       apply Or.inr
       constructor
       · change a+(cover-a)=b+(cover-b)
         rw [Nat.add_comm a, SFT.Foundation.FractionReduction.subtractAdd cover a (bounded a (List.Mem.head _))]
         rw [Nat.add_comm b, SFT.Foundation.FractionReduction.subtractAdd cover b (bounded b (List.Mem.tail _ hb))]
       · exact head b hb
     · exact ih tail (fun p hp => bounded p (List.Mem.tail _ hp))

theorem coverAscending (cover : Nat) : (coverCells cover).Pairwise Before := by
 apply fixedCoverAscending
 · exact filterAscending _ _ (principalRangeAscending cover)
 · intro p hp
   exact Nat.le_of_lt ((rangeMembership cover p).mp ((filterMemberIff _ _ p).mp hp).1)

theorem generatedTraversalAscending (bound : Nat) : (orderThrough bound).Pairwise Before := by
 induction bound with
 | zero => exact List.Pairwise.nil
 | succ bound ih =>
   apply appendOrdered _ _ _ ih (coverAscending _)
   intro a ha b hb
   apply Or.inl
   have prior := (orderSound bound a.1 a.2 ha).2.2.2
   have fresh := (coverCellExactly (bound+1) b.1 b.2).mp hb
   rw [fresh.2.2.2]
   exact Nat.lt_succ_of_le prior
end SFT.Chemistry.GBlockTraversal
