import SFT.Materials.CubicCoordination
import SFT.Mathematics.DiscreteComplement
namespace SFT.Materials.CubicCoordinationProofs
open CubicCoordination SFT.Mathematics.DiscreteObjects

theorem completeNeighbours (generators : List String) (row : OrientedNeighbour) :
 row ∈ neighbours generators ↔ row.generator ∈ generators ∧
 (row.orientation = "first-fibre" ∨ row.orientation = "second-fibre") := by
 induction generators with
 | nil => constructor; intro h; cases h; intro h; cases h.1
 | cons g rest ih =>
   constructor
   · intro h
     cases h with
     | head => exact ⟨List.Mem.head _,Or.inl rfl⟩
     | tail _ h => cases h with
       | head => exact ⟨List.Mem.head _,Or.inr rfl⟩
       | tail _ h => have h' := ih.mp h; exact ⟨List.Mem.tail _ h'.1,h'.2⟩
   · intro h
     cases row with
     | mk name orientation =>
       cases h.1 with
       | head => cases h.2 with
         | inl same => cases same; exact List.Mem.head _
         | inr same => cases same; exact List.Mem.tail _ (List.Mem.head _)
       | tail _ held => exact List.Mem.tail _ (List.Mem.tail _ (ih.mpr ⟨held,h.2⟩))

theorem noDuplicateNeighbours (generators : List String) (unique : distinct generators = true) :
 distinct (neighbours generators) = true := by
 induction generators with
 | nil => rfl
 | cons g rest ih =>
   have parts := (distinctCons g rest).mp unique
   have absent : g ∉ rest := (absentIff rest g).mp parts.1
   apply (distinctCons _ _).mpr
   refine ⟨(absentIff _ _).mpr ?_,?_⟩
   · intro h
     have split : ∀ (xs : List OrientedNeighbour) (x y : OrientedNeighbour), x ∈ y::xs → x=y ∨ x∈xs := by
       intro xs x y held
       cases held with
       | head => exact Or.inl rfl
       | tail _ ht => exact Or.inr ht
     cases split _ _ _ h with
     | inl same => exact (by decide : ("first-fibre" : String) ≠ "second-fibre") (congrArg OrientedNeighbour.orientation same)
     | inr h => exact absent ((completeNeighbours rest _).mp h).1
   · apply (distinctCons _ _).mpr
     exact ⟨(absentIff _ _).mpr (fun h => absent ((completeNeighbours rest _).mp h).1),ih parts.2⟩

theorem acceptedDomain (generators : List String) (rows : List OrientedNeighbour)
 (accepted : simpleCubicNeighbours generators = .ok rows) :
 generators.isEmpty = false ∧ distinct generators = true ∧ rows = neighbours generators := by
 unfold simpleCubicNeighbours at accepted
 cases he : generators.isEmpty with
 | false =>
   cases hd : distinct generators with
   | false => rw [he,hd] at accepted; cases accepted
   | true => rw [he,hd] at accepted; exact ⟨rfl,rfl,(Except.ok.inj accepted).symm⟩
 | true => rw [he] at accepted; cases accepted

theorem admissibleAccepted (generators : List String)
 (nonempty : generators.isEmpty = false) (unique : distinct generators = true) :
 simpleCubicNeighbours generators = .ok (neighbours generators) := by
 unfold simpleCubicNeighbours
 rw [nonempty,unique]
 rfl

theorem acceptedCardinality (generators : List String) (rows : List OrientedNeighbour)
 (accepted : simpleCubicNeighbours generators = .ok rows) : rows.length = generators.length * 2 := by
 rw [(acceptedDomain generators rows accepted).2.2]
 exact neighbourCount generators
theorem repeatedDirectionsRejected (generators : List String)
 (repeated : distinct generators = false) : simpleCubicNeighbours generators =
 .error "directions must be a nonempty distinct generated carrier" := by
 unfold simpleCubicNeighbours
 rw [repeated]
 cases generators <;> rfl

theorem emptyLabelRetained : simpleCubicNeighbours [""] =
 .ok [⟨"","first-fibre"⟩,⟨"","second-fibre"⟩] := rfl
end SFT.Materials.CubicCoordinationProofs
