import SFT.Mathematics.OrderBoundExistence
namespace SFT.Mathematics.OrderOperations
open DiscreteObjects AlgebraOperations

theorem monotoneMeaning (source target : Relation) (mapping : List (String × String)) :
    isMonotone source target mapping = true ↔
      ∀ a b, (a,b) ∈ source → ∃ left right,
        imageLookup (buildImages mapping) a = some left ∧
        imageLookup (buildImages mapping) b = some right ∧ (left,right) ∈ target := by
  constructor
  · intro passed a b held
    have cell := allTrueAtMember _ _ passed (a,b) held
    change (match imageLookup (buildImages mapping) a with
      | none => false
      | some left => match imageLookup (buildImages mapping) b with
        | none => false
        | some right => has target (left,right)) = true at cell
    cases first : imageLookup (buildImages mapping) a with
    | none => rw [first] at cell; cases cell
    | some left =>
      rw [first] at cell
      cases second : imageLookup (buildImages mapping) b with
      | none => rw [second] at cell; cases cell
      | some right =>
        rw [second] at cell
        exact ⟨left,right,rfl,rfl,(hasIff _ _).mp cell⟩
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro pair held
    obtain ⟨left,right,first,second,retained⟩ := h pair.1 pair.2 held
    rw [first,second]
    exact (hasIff _ _).mpr retained

theorem emptySourceMonotone (target : Relation) (mapping : List (String × String)) :
    isMonotone [] target mapping = true := rfl

end SFT.Mathematics.OrderOperations
