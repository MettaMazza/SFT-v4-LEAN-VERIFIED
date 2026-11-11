import SFT.Chemistry.GBlockOperations
import SFT.Foundation.FractionReduction
import SFT.Foundation.FoldAssembly
import SFT.Mathematics.OrbitLoopCompletion
import SFT.Mathematics.DiscreteComplement
import SFT.QuantumComputation.ReversibleFaults
namespace SFT.Chemistry.GBlockOrder
open GBlockOperations SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.DiscreteObjects SFT.QuantumComputation.ReversibleFaults

theorem coverCellExactly (cover p o : Nat) : (p,o) ∈ coverCells cover ↔
 0 < p ∧ 0 < o ∧ o ≤ p ∧ p+o=cover := by
 constructor
 · intro held
   obtain ⟨i,inside,same⟩ := memMapPreimage (fun p => (p,cover-p)) (p,o) _ held
   have eqs := Prod.mk.inj same
   cases eqs.1
   have data := (filterMemberIff (fun p => 0 < p && cover-p ≤ p) (List.range cover) p).mp inside
   have below := (rangeMembership cover p).mp data.1
   have tests : decide (0<p)=true ∧ decide (cover-p≤p)=true := by
     have accepted := data.2
     cases ha : decide (0<p) <;> cases hb : decide (cover-p≤p)
     all_goals first
       | exact ⟨rfl,rfl⟩
       | (change (decide (0<p) && decide (cover-p≤p))=true at accepted; rw [ha,hb] at accepted; cases accepted)
   have positive : 0<p := of_decide_eq_true tests.1
   have bounded : cover-p≤p := of_decide_eq_true tests.2
   have remainder := SFT.Foundation.ExactCast.subtractPositive cover p below
   have total : p+(cover-p)=cover := by
     rw [Nat.add_comm,SFT.Foundation.FractionReduction.subtractAdd cover p (Nat.le_of_lt below)]
   rw [eqs.2] at bounded remainder total
   exact ⟨positive,remainder,bounded,total⟩
 · intro ⟨hp,ho,hop,total⟩
   have below : p<cover := by
     rw [←total]
     exact Nat.lt_add_of_pos_right ho
   have sub : cover-p=o := by
     rw [←total,Nat.add_comm p o]
     exact SFT.Foundation.ExactCast.addSubtract o p
   rw [←sub]
   apply memMap (fun p => (p,cover-p)) p _
   apply (filterMemberIff (fun p => 0 < p && cover-p ≤ p) (List.range cover) p).mpr
   refine ⟨(rangeMembership cover p).mpr below,?_⟩
   have yesP : decide (0<p)=true := decide_eq_true hp
   have yesO : decide (cover-p≤p)=true := decide_eq_true (by rw [sub]; exact hop)
   change (decide (0<p) && decide (cover-p≤p))=true
   rw [yesP,yesO]
   rfl

theorem orderSound (bound p o : Nat) (held : (p,o) ∈ orderThrough bound) :
 0<p ∧ 0<o ∧ o≤p ∧ p+o≤bound := by
 induction bound with
 | zero => cases held
 | succ bound ih =>
   cases memAppendCases (p,o) (orderThrough bound) (coverCells (bound+1)) held with
   | inl prior =>
     have h := ih prior
     exact ⟨h.1,h.2.1,h.2.2.1,Nat.le_trans h.2.2.2 (Nat.le_succ _)⟩
   | inr fresh =>
     have h := (coverCellExactly (bound+1) p o).mp fresh
     exact ⟨h.1,h.2.1,h.2.2.1,Nat.le_of_eq h.2.2.2⟩

theorem orderComplete (bound p o : Nat) (hp : 0<p) (ho : 0<o)
 (hop : o≤p) (total : p+o≤bound) : (p,o) ∈ orderThrough bound := by
 induction bound with
 | zero =>
   have pos : 0<p+o := Nat.lt_of_lt_of_le hp (Nat.le_add_right _ _)
   exact False.elim (Nat.not_lt_zero _ (Nat.lt_of_lt_of_le pos total))
 | succ bound ih =>
   cases Nat.lt_or_eq_of_le total with
   | inl earlier =>
     exact memAppendLeft _ _ _ (ih (Nat.le_of_lt_succ earlier))
   | inr atEnd =>
     exact memAppendRight _ _ _ ((coverCellExactly (bound+1) p o).mpr ⟨hp,ho,hop,atEnd⟩)

theorem completeSupport (bound p o : Nat) : (p,o) ∈ orderThrough bound ↔
 0<p ∧ 0<o ∧ o≤p ∧ p+o≤bound :=
 ⟨orderSound bound p o,fun h => orderComplete bound p o h.1 h.2.1 h.2.2.1 h.2.2.2⟩

-- The source visits each principal rank once at each joint cover.
theorem principalRangeUnique (n : Nat) : (List.range n).Nodup := by
 induction n with
 | zero => exact List.Pairwise.nil
 | succ n ih =>
   rw [SFT.Mathematics.OrbitLoopCompletion.rangeSuccessor]
   exact nodupAppendFresh _ n ih (fun h => Nat.lt_irrefl n ((rangeMembership n n).mp h))

theorem retainedPrincipalsUnique (test : Nat → Bool) (xs : List Nat)
 (unique : xs.Nodup) : (xs.filter test).Nodup := by
 induction xs with
 | nil => exact List.Pairwise.nil
 | cons x xs ih =>
   cases unique with
   | cons fresh rest =>
     cases accepted : test x with
     | false =>
       rw [List.filter_cons_of_neg (by rw [accepted]; intro h; cases h)]
       exact ih rest
     | true =>
       rw [List.filter_cons_of_pos accepted]
       exact List.Pairwise.cons (fun y hy eq => fresh y ((filterMemberIff test xs y).mp hy).1 eq) (ih rest)

theorem coverUnique (cover : Nat) : (coverCells cover).Nodup :=
 nodupMapInjective (fun p => (p,cover-p))
   (fun _ _ h => (Prod.mk.inj h).1) _
   (retainedPrincipalsUnique _ _ (principalRangeUnique cover))

theorem distinctCovers (bound : Nat) (cell : Nat × Nat)
 (earlier : cell ∈ orderThrough bound) : cell ∉ coverCells (bound+1) := by
 intro later
 have old := orderSound bound cell.1 cell.2 earlier
 have fresh := (coverCellExactly (bound+1) cell.1 cell.2).mp later
 have impossible : bound+1 ≤ bound := by rw [←fresh.2.2.2]; exact old.2.2.2
 exact Nat.not_succ_le_self bound impossible

theorem generatedOrderUnique (bound : Nat) : (orderThrough bound).Nodup := by
 induction bound with
 | zero => exact List.Pairwise.nil
 | succ bound ih =>
   exact SFT.Foundation.FoldAssembly.disjointAppendNodup _ _ ih (coverUnique _)
     (distinctCovers bound)
end SFT.Chemistry.GBlockOrder

