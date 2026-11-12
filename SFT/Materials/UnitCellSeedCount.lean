import SFT.Materials.UnitCellNormalization
import SFT.Mathematics.ProbabilityEvents
namespace SFT.Materials.UnitCellSeedCount
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.ProbabilityIndependence
open SFT.Foundation.Count.TraceDerivation

def countSeeds (seeds : List String) : Nat := (firstLabels seeds).length

theorem countSameSeedSet (xs ys : List String) (same : ∀ x, x∈xs ↔ x∈ys) :
 countSeeds xs=countSeeds ys := by
 apply Nat.le_antisymm
 · exact SFT.Mathematics.ProbabilityEvents.distinctSubsetLength _ _ (firstLabelsDistinct xs)
     (fun x h => (firstLabelsMembership ys x).mpr ((same x).mp ((firstLabelsMembership xs x).mp h)))
 · exact SFT.Mathematics.ProbabilityEvents.distinctSubsetLength _ _ (firstLabelsDistinct ys)
     (fun x h => (firstLabelsMembership xs x).mpr ((same x).mpr ((firstLabelsMembership ys x).mp h)))

theorem seedMapPerm {α : Type} (f : α → String) (xs ys : List α)
 (permutation : List.Perm xs ys) : countSeeds (xs.map f)=countSeeds (ys.map f) := by
 apply countSameSeedSet
 intro x
 constructor
 · intro h
   obtain ⟨row,held,eq⟩ := memMapPreimage f x xs h
   rw [←eq]
   exact memMap f row ys ((UnitCellNormalization.permMember permutation row).mp held)
 · intro h
   obtain ⟨row,held,eq⟩ := memMapPreimage f x ys h
   rw [←eq]
   exact memMap f row xs ((UnitCellNormalization.permMember permutation row).mpr held)

theorem traceSizePreserved (a b : UnitCellReconstruction.Trace)
 (rows : List.Perm a.siteSteps b.siteSteps) : UnitCellMinimum.size a=UnitCellMinimum.size b :=
 seedMapPerm Prod.snd a.siteSteps b.siteSteps rows

abbrev FamilyRow := List (String × String) × List (SFT.Mathematics.GraphOperations.Edge × SFT.Mathematics.GraphOperations.Edge)
def familySize (r : FamilyRow) : Nat := countSeeds (r.1.map Prod.fst)

theorem siteRowSeeds (l : Lattice.Record) (steps : List (Nat × String)) :
 (UnitCellNormalization.siteRows l steps).map Prod.fst=steps.map Prod.snd := by
 induction steps with
 | nil => rfl
 | cons first rest ih => exact congrArg (List.cons first.2) ih

theorem normalizedSize (t : UnitCellReconstruction.Trace)
 (ps : List (Nat × String)) (qs : List (Nat × SFT.Mathematics.GraphOperations.Edge))
 (permutation : List.Perm t.siteSteps ps) :
 familySize (UnitCellNormalization.siteRows t.lattice ps,UnitCellNormalization.relationRows t.lattice qs)=UnitCellMinimum.size t := by
 unfold familySize
 rw [siteRowSeeds]
 exact (seedMapPerm Prod.snd _ _ permutation).symm

theorem everyTraceSizeInFamily (t : UnitCellReconstruction.Trace) (valid : UnitCellMinimum.admissible t) :
 ∃ r, r∈UnitCellFamily.jointFamily t.lattice ∧ familySize r=UnitCellMinimum.size t := by
 obtain ⟨ps,qs,pp,qp,member⟩ := UnitCellNormalization.everyTraceInFamily t valid
 exact ⟨_,member,normalizedSize t ps qs pp⟩

theorem everyFamilySizeRealized (l : Lattice.Record) (r : FamilyRow)
 (held : r∈UnitCellFamily.jointFamily l) :
 ∃ t : UnitCellReconstruction.Trace, t.lattice=l ∧ UnitCellMinimum.admissible t ∧
 UnitCellMinimum.size t=familySize r := by
 obtain ⟨t,same,valid,seeds,_⟩ := UnitCellFamily.realizeJoint l r.1 r.2 held
 exact ⟨t,same,valid,congrArg countSeeds seeds⟩
end SFT.Materials.UnitCellSeedCount
