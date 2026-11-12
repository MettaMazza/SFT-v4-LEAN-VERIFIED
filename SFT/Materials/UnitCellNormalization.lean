import SFT.Materials.UnitCellFamily
namespace SFT.Materials.UnitCellNormalization
open UnitCellReconstruction
open SFT.Foundation.Count.TraceDerivation

-- Exact reordering of the retained reconstruction rows; no row is discarded.
theorem appendMap {α β : Type} (f : α → β) (xs ys : List α) :
 (xs++ys).map f=xs.map f++ys.map f := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons (f x)) ih

theorem occurrenceAppend {α : Type} [DecidableEq α] (x : α) (xs ys : List α) :
 occurrence x (xs++ys)=occurrence x xs+occurrence x ys := by
 induction xs with
 | nil => exact (Nat.zero_add _).symm
 | cons a xs ih =>
   change (if x=a then 1 else 0)+occurrence x (xs++ys)=((if x=a then 1 else 0)+occurrence x xs)+occurrence x ys
   rw [ih,Nat.add_assoc]

theorem positiveMember {α : Type} [DecidableEq α] (x : α) (xs : List α)
 (positive : 0<occurrence x xs) : x∈xs := by
 induction xs with
 | nil => exact False.elim (Nat.not_lt_zero _ positive)
 | cons a xs ih =>
   by_cases same : x=a
   · cases same; exact List.Mem.head _
   · change 0<(if x=a then 1 else 0)+occurrence x xs at positive
     rw [ite_eq_right same,Nat.zero_add] at positive
     exact List.Mem.tail _ (ih positive)

theorem splitMember {α : Type} (x : α) (xs : List α) (held : x∈xs) :
 ∃ before after, xs=before++x::after := by
 induction xs with
 | nil => cases held
 | cons a xs ih =>
   cases held with
   | head => exact ⟨[],xs,rfl⟩
   | tail _ h =>
     obtain ⟨before,after,eq⟩ := ih h
     exact ⟨a::before,after,congrArg (List.cons a) eq⟩

theorem permutationRefl {α : Type} (xs : List α) : List.Perm xs xs := by
 induction xs with
 | nil => exact List.Perm.nil
 | cons x xs ih => exact List.Perm.cons x ih

theorem moveToFront {α : Type} (before after : List α) (x : α) :
 List.Perm (before++x::after) (x::(before++after)) := by
 induction before with
 | nil => exact permutationRefl _
 | cons a before ih =>
   exact List.Perm.trans (List.Perm.cons a ih) (List.Perm.swap x a _)

theorem cancelPrefixCount (k a b : Nat) (h : k+a=k+b) : a=b := by
 induction k with
 | zero => rw [Nat.zero_add,Nat.zero_add] at h; exact h
 | succ k ih =>
   rw [Nat.succ_add,Nat.succ_add] at h
   exact ih (Nat.succ.inj h)

theorem reorderRows {α β : Type} [DecidableEq β] (f : α → β)
 (targets : List β) (rows : List α)
 (same : ∀ y, occurrence y (rows.map f)=occurrence y targets) :
 ∃ ordered, List.Perm rows ordered ∧ ordered.map f=targets := by
 induction targets generalizing rows with
 | nil =>
   cases rows with
   | nil => exact ⟨[],List.Perm.nil,rfl⟩
   | cons first rest =>
     have h := same (f first)
     change (if f first=f first then 1 else 0)+occurrence (f first) (rest.map f)=0 at h
     rw [ite_eq_left rfl,Nat.add_comm] at h
     cases h
 | cons target rest ih =>
   have positive : 0<occurrence target (rows.map f) := by
     rw [same target]
     exact occurrenceMember target (target::rest) (List.Mem.head _)
   obtain ⟨row,member,output⟩ := memMapPreimage f target rows (positiveMember target _ positive)
   obtain ⟨before,after,split⟩ := splitMember row rows member
   have smaller : ∀ y, occurrence y ((before++after).map f)=occurrence y rest := by
     intro y
     have h := same y
     rw [split,appendMap,occurrenceAppend] at h
     change occurrence y (before.map f)+((if y=f row then 1 else 0)+occurrence y (after.map f))=
       (if y=target then 1 else 0)+occurrence y rest at h
     rw [output,Nat.add_left_comm] at h
     have cancelled := cancelPrefixCount _ _ _ h
     rw [appendMap,occurrenceAppend]
     exact cancelled
   obtain ⟨ordered,perm,outputs⟩ := ih (before++after) smaller
   refine ⟨row::ordered,?_,?_⟩
   · rw [split]
     exact List.Perm.trans (moveToFront before after row) (List.Perm.cons row perm)
   · change f row::ordered.map f=target::rest
     rw [output,outputs]

theorem normalizeSiteRows (t : UnitCellReconstruction.Trace) (exactTrace : reconstructsOnce t) :
 ∃ ordered, List.Perm t.siteSteps ordered ∧
 ordered.map (fun row => Lattice.translate t.lattice row.1 row.2)=t.lattice.cells.graph.nodes :=
 reorderRows _ _ t.siteSteps exactTrace.1

theorem normalizeRelationRows (t : UnitCellReconstruction.Trace) (exactTrace : reconstructsOnce t) :
 ∃ ordered, List.Perm t.relationSteps ordered ∧
 ordered.map (fun row => UnitCellRelationSupport.iterate t.lattice row.1 row.2)=t.lattice.cells.graph.edges :=
 reorderRows _ _ t.relationSteps exactTrace.2

theorem permMember {α : Type} {xs ys : List α} (p : List.Perm xs ys) (x : α) : x∈xs ↔ x∈ys := by
 induction p with
 | nil => exact Iff.rfl
 | cons a p ih =>
   constructor
   · intro h
     cases h with
     | head => exact List.Mem.head _
     | tail _ h => exact List.Mem.tail _ (ih.mp h)
   · intro h
     cases h with
     | head => exact List.Mem.head _
     | tail _ h => exact List.Mem.tail _ (ih.mpr h)
 | swap a b xs =>
   constructor
   all_goals
     intro h
     cases h with
     | head => exact List.Mem.tail _ (List.Mem.head _)
     | tail _ h =>
       cases h with
       | head => exact List.Mem.head _
       | tail _ h => exact List.Mem.tail _ (List.Mem.tail _ h)
 | trans _ _ ih1 ih2 => exact ih1.trans ih2

def siteRows (l : Lattice.Record) (steps : List (Nat × String)) :=
 steps.map (fun row => (row.2,Lattice.translate l row.1 row.2))
def relationRows (l : Lattice.Record) (steps : List (Nat × SFT.Mathematics.GraphOperations.Edge)) :=
 steps.map (fun row => (row.2,UnitCellRelationSupport.iterate l row.1 row.2))

theorem siteRowsMatch (l : Lattice.Record) (steps : List (Nat × String))
 (held : ∀ row, row∈steps → row.2∈l.cells.graph.nodes) :
 UnitCellFamily.Matches (UnitCellSourceChoices.siteChoices l)
 (steps.map (fun row => Lattice.translate l row.1 row.2)) (siteRows l steps) := by
 induction steps with
 | nil => exact UnitCellFamily.Matches.nil
 | cons first rest ih =>
   exact UnitCellFamily.Matches.cons
     ((UnitCellSourceChoices.siteChoicesMeaning l first.2 _).mpr
       ⟨held first (List.Mem.head _),⟨first.1,rfl⟩⟩)
     (ih (fun row hr => held row (List.Mem.tail first hr)))

theorem relationRowsMatch (l : Lattice.Record) (steps : List (Nat × SFT.Mathematics.GraphOperations.Edge))
 (held : ∀ row, row∈steps → row.2∈l.cells.graph.edges) :
 UnitCellFamily.Matches (UnitCellSourceChoices.relationChoices l)
 (steps.map (fun row => UnitCellRelationSupport.iterate l row.1 row.2)) (relationRows l steps) := by
 induction steps with
 | nil => exact UnitCellFamily.Matches.nil
 | cons first rest ih =>
   exact UnitCellFamily.Matches.cons
     ((UnitCellSourceChoices.relationChoicesMeaning l first.2 _).mpr
       ⟨held first (List.Mem.head _),⟨first.1,rfl⟩⟩)
     (ih (fun row hr => held row (List.Mem.tail first hr)))

theorem everyTraceInFamily (t : UnitCellReconstruction.Trace) (valid : UnitCellMinimum.admissible t) :
 ∃ ps qs, List.Perm t.siteSteps ps ∧ List.Perm t.relationSteps qs ∧
 (siteRows t.lattice ps,relationRows t.lattice qs)∈UnitCellFamily.jointFamily t.lattice := by
 obtain ⟨ps,pp,po⟩ := normalizeSiteRows t valid.2
 obtain ⟨qs,qp,qo⟩ := normalizeRelationRows t valid.2
 have seeds := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp valid.1
 have sh := (SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mp seeds.1
 have eh := (SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mp seeds.2
 have sm := siteRowsMatch t.lattice ps (fun row hr =>
   (SFT.Mathematics.DiscreteObjects.hasIff _ _).mp (sh row ((permMember pp row).mpr hr)))
 have em := relationRowsMatch t.lattice qs (fun row hr =>
   (SFT.Mathematics.DiscreteObjects.hasIff _ _).mp (eh row ((permMember qp row).mpr hr)))
 rw [po] at sm
 rw [qo] at em
 exact ⟨ps,qs,pp,qp,(UnitCellFamily.jointFamilyMeaning _ _ _).mpr ⟨sm,em⟩⟩
end SFT.Materials.UnitCellNormalization
