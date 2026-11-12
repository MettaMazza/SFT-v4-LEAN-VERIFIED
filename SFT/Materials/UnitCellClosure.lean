import SFT.Materials.UnitCellSeedCount
namespace SFT.Materials.UnitCellClosure
open UnitCellSeedCount
open SFT.Mathematics.DiscreteObjects

def minima (l : Lattice.Record) : List FamilyRow :=
 (UnitCellFamily.jointFamily l).filter (fun r =>
   (UnitCellFamily.jointFamily l).all (fun other => decide (familySize r≤familySize other)))

theorem minimaMeaning (l : Lattice.Record) (r : FamilyRow) :
 r∈minima l ↔ r∈UnitCellFamily.jointFamily l ∧
 ∀ other, other∈UnitCellFamily.jointFamily l → familySize r≤familySize other := by
 constructor
 · intro h
   have p := (filterMemberIff _ _ _).mp h
   exact ⟨p.1,fun other held => of_decide_eq_true
     ((SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mp p.2 other held)⟩
 · intro h
   exact (filterMemberIff _ _ _).mpr ⟨h.1,
     (SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mpr
       (fun other held => decide_eq_true (h.2 other held))⟩

theorem leastFamilyMember (first : FamilyRow) (rest : List FamilyRow) :
 ∃ best, best∈first::rest ∧ ∀ other, other∈first::rest → familySize best≤familySize other := by
 induction rest generalizing first with
 | nil =>
   refine ⟨first,List.Mem.head [],?_⟩
   intro other h
   cases h with
   | head => exact Nat.le_refl _
   | tail _ h => cases h
 | cons next rest ih =>
   obtain ⟨best,hb,bound⟩ := ih next
   cases Nat.le_total (familySize first) (familySize best) with
   | inl h =>
     refine ⟨first,List.Mem.head _,?_⟩
     intro other member
     cases member with
     | head => exact Nat.le_refl _
     | tail _ hm => exact Nat.le_trans h (bound other hm)
   | inr h =>
     refine ⟨best,List.Mem.tail first hb,?_⟩
     intro other member
     cases member with
     | head => exact h
     | tail _ hm => exact bound other hm

theorem minimumExists (l : Lattice.Record) : ∃ r, r∈minima l := by
 have witness := UnitCellFamily.identityInFamily l
 cases h : UnitCellFamily.jointFamily l with
 | nil => rw [h] at witness; cases witness
 | cons first rest =>
   obtain ⟨best,held,bound⟩ := leastFamilyMember first rest
   refine ⟨best,(minimaMeaning l best).mpr ?_⟩
   rw [h]
   exact ⟨held,bound⟩

def GlobalMinimum (l : Lattice.Record) (t : UnitCellReconstruction.Trace) : Prop :=
 t.lattice=l ∧ UnitCellMinimum.admissible t ∧
 ∀ other : UnitCellReconstruction.Trace, other.lattice=l → UnitCellMinimum.admissible other →
 UnitCellMinimum.size t≤UnitCellMinimum.size other

theorem minimumRealizesGlobal (l : Lattice.Record) (r : FamilyRow) (held : r∈minima l) :
 ∃ t, GlobalMinimum l t ∧ UnitCellMinimum.size t=familySize r := by
 have h := (minimaMeaning l r).mp held
 obtain ⟨t,same,valid,size⟩ := everyFamilySizeRealized l r h.1
 refine ⟨t,⟨same,valid,?_⟩,size⟩
 intro other sameOther validOther
 obtain ⟨otherRow,member,equal⟩ := everyTraceSizeInFamily other validOther
 rw [sameOther] at member
 rw [size,←equal]
 exact h.2 otherRow member

theorem globalRepresentedByMinimum (l : Lattice.Record) (t : UnitCellReconstruction.Trace)
 (global : GlobalMinimum l t) : ∃ r, r∈minima l ∧ familySize r=UnitCellMinimum.size t := by
 obtain ⟨r,held,size⟩ := everyTraceSizeInFamily t global.2.1
 rw [global.1] at held
 refine ⟨r,(minimaMeaning l r).mpr ⟨held,?_⟩,size⟩
 intro other member
 obtain ⟨trace,same,valid,equal⟩ := everyFamilySizeRealized l other member
 rw [size,←equal]
 exact global.2.2 trace same valid

theorem globalMinimumExists (l : Lattice.Record) : ∃ t, GlobalMinimum l t := by
 obtain ⟨r,held⟩ := minimumExists l
 obtain ⟨t,global,_⟩ := minimumRealizesGlobal l r held
 exact ⟨t,global⟩

theorem minimumCountUnique (l : Lattice.Record) (a b : UnitCellReconstruction.Trace)
 (ha : GlobalMinimum l a) (hb : GlobalMinimum l b) : UnitCellMinimum.size a=UnitCellMinimum.size b :=
 Nat.le_antisymm (ha.2.2 b hb.1 hb.2.1) (hb.2.2 a ha.1 ha.2.1)

theorem minimumBasesReconstructSame (l : Lattice.Record) (a b : UnitCellReconstruction.Trace)
 (ha : GlobalMinimum l a) (hb : GlobalMinimum l b) :
 (∀ x, UnitCellReconstruction.occurrence x (UnitCellReconstruction.sites a)=
   UnitCellReconstruction.occurrence x (UnitCellReconstruction.sites b)) ∧
 (∀ e, UnitCellReconstruction.occurrence e (UnitCellReconstruction.relations a)=
   UnitCellReconstruction.occurrence e (UnitCellReconstruction.relations b)) :=
 UnitCellReconstruction.presentationIndependent a b
   (congrArg (fun l : Lattice.Record => l.cells.graph.nodes) (ha.1.trans hb.1.symm))
   (congrArg (fun l : Lattice.Record => l.cells.graph.edges) (ha.1.trans hb.1.symm))
   ha.2.1.2 hb.2.1.2

theorem positiveSeedCount (t : UnitCellReconstruction.Trace) (valid : UnitCellMinimum.admissible t) :
 0<UnitCellMinimum.size t := by
 have graphEq := Lattice.completeSiteCarrier t.lattice
 have generated := t.lattice.cells.generated
 rw [graphEq] at generated
 have nonempty := ((SFT.Mathematics.GraphOperations.graphConstructorMeaning _ _).mp generated).1
 have nodesNonempty : t.lattice.cells.graph.nodes.isEmpty=false := by rw [graphEq]; exact nonempty
 cases steps : t.siteSteps with
 | nil =>
   cases nodes : t.lattice.cells.graph.nodes with
   | nil => rw [nodes] at nodesNonempty; cases nodesNonempty
   | cons first rest =>
     have held : first∈t.lattice.cells.graph.nodes := by rw [nodes]; exact List.Mem.head _
     have one := UnitCellReconstruction.reconstructedSitesOnce t valid.2 first held
     unfold UnitCellReconstruction.sites at one
     rw [steps] at one
     cases one
 | cons first rest =>
   have held : first.2∈SFT.Mathematics.ProbabilityIndependence.firstLabels (t.siteSteps.map Prod.snd) :=
     (SFT.Mathematics.ProbabilityIndependence.firstLabelsMembership _ _).mpr (by rw [steps]; exact List.Mem.head _)
   unfold UnitCellMinimum.size UnitCellMinimum.seedSites
   cases h : SFT.Mathematics.ProbabilityIndependence.firstLabels (t.siteSteps.map Prod.snd) with
   | nil => rw [h] at held; cases held
   | cons x xs => exact Nat.zero_lt_succ _

theorem primitiveCellExists (l : Lattice.Record) :
 ∃ t : UnitCellReconstruction.Trace, GlobalMinimum l t ∧ 0<UnitCellMinimum.size t ∧
 (∀ x, x∈l.cells.graph.nodes → UnitCellReconstruction.occurrence x (UnitCellReconstruction.sites t)=1) ∧
 (∀ e, e∈l.cells.graph.edges → UnitCellReconstruction.occurrence e (UnitCellReconstruction.relations t)=1) := by
 obtain ⟨t,h⟩ := globalMinimumExists l
 refine ⟨t,h,positiveSeedCount t h.2.1,?_,?_⟩
 · intro x held
   rw [←h.1] at held
   exact UnitCellReconstruction.reconstructedSitesOnce t h.2.1.2 x held
 · intro e held
   rw [←h.1] at held
   exact UnitCellReconstruction.reconstructedRelationsOnce t h.2.1.2 e held
end SFT.Materials.UnitCellClosure
