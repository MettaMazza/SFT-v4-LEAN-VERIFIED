import SFT.Mathematics.OrderMaps
namespace SFT.Mathematics.OrderOperations
open DiscreteObjects AlgebraOperations SFT.Foundation.Count.TraceDerivation

theorem onePartialOrder : isPartialOrder ["One"] [("One","One")] = true := rfl
theorem oneTotalOrder : isTotal ["One"] [("One","One")] = true := rfl
theorem oneLowerBounds : lowerBounds ["One"] [("One","One")] ["One"] = .ok ["One"] := rfl
theorem oneUpperBounds : upperBounds ["One"] [("One","One")] ["One"] = .ok ["One"] := rfl
theorem oneMeet : meet ["One"] [("One","One")] ["One"] = .ok (some "One") := rfl
theorem oneJoin : join ["One"] [("One","One")] ["One"] = .ok (some "One") := rfl

theorem partialOrderExtensionIff (carrier : List String) (relation extended : Relation) (fresh : String)
    (prior : isPartialOrder carrier relation = true) (new : fresh ∉ carrier)
    (unique : distinct extended = true)
    (endpoints : ∀ pair, pair ∈ extended → pair.1 ∈ carrier ++ [fresh] ∧ pair.2 ∈ carrier ++ [fresh])
    (retained : ∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ((a,b) ∈ extended ↔ (a,b) ∈ relation)) :
    isPartialOrder (carrier ++ [fresh]) extended = true ↔
      (fresh,fresh) ∈ extended ∧
      (∀ a b, (a,b) ∈ extended → (b,a) ∈ extended → (a = fresh ∨ b = fresh) → a = b) ∧
      (∀ a b c, (a,b) ∈ extended → (b,c) ∈ extended →
        (a = fresh ∨ b = fresh ∨ c = fresh) → (a,c) ∈ extended) := by
  have old := (partialOrderMeaning carrier relation).mp prior
  constructor
  · intro passed
    have laws := (partialOrderMeaning (carrier ++ [fresh]) extended).mp passed
    exact ⟨laws.2.2.2.2.1 fresh (memAppendRight _ _ _ (List.Mem.head [])),
      fun a b hab hba _ => laws.2.2.2.2.2.1 a b hab hba,
      fun a b c hab hbc _ => laws.2.2.2.2.2.2 a b c hab hbc⟩
  · intro checks
    apply (partialOrderMeaning (carrier ++ [fresh]) extended).mpr
    have nonempty : (carrier ++ [fresh]).isEmpty = false := by
      cases carrier with
      | nil => rfl
      | cons x xs => rfl
    refine ⟨nonempty,freshAppendDistinct carrier fresh old.2.1 ((absentIff _ _).mpr new),unique,endpoints,?_,?_,?_⟩
    · intro item member
      cases (extendedCarrierMember carrier fresh item).mp member with
      | inl held => exact (retained item held item held).mpr (old.2.2.2.2.1 item held)
      | inr same => cases same; exact checks.1
    · intro a b hab hba
      have members := endpoints (a,b) hab
      cases (extendedCarrierMember carrier fresh a).mp members.1 with
      | inr same => exact checks.2.1 a b hab hba (Or.inl same)
      | inl ha =>
        cases (extendedCarrierMember carrier fresh b).mp members.2 with
        | inr same => exact checks.2.1 a b hab hba (Or.inr same)
        | inl hb => exact old.2.2.2.2.2.1 a b ((retained a ha b hb).mp hab) ((retained b hb a ha).mp hba)
    · intro a b c hab hbc
      have first := endpoints (a,b) hab
      have second := endpoints (b,c) hbc
      cases (extendedCarrierMember carrier fresh a).mp first.1 with
      | inr same => exact checks.2.2 a b c hab hbc (Or.inl same)
      | inl ha =>
        cases (extendedCarrierMember carrier fresh b).mp first.2 with
        | inr same => exact checks.2.2 a b c hab hbc (Or.inr (Or.inl same))
        | inl hb =>
          cases (extendedCarrierMember carrier fresh c).mp second.2 with
          | inr same => exact checks.2.2 a b c hab hbc (Or.inr (Or.inr same))
          | inl hc => exact (retained a ha c hc).mpr (old.2.2.2.2.2.2 a b c
              ((retained a ha b hb).mp hab) ((retained b hb c hc).mp hbc))

theorem totalOrderExtensionIff (carrier : List String) (relation extended : Relation) (fresh : String)
    (prior : isTotal carrier relation = true)
    (extendedOrder : isPartialOrder (carrier ++ [fresh]) extended = true)
    (retained : ∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ((a,b) ∈ extended ↔ (a,b) ∈ relation)) :
    isTotal (carrier ++ [fresh]) extended = true ↔
      ∀ item, item ∈ carrier → (fresh,item) ∈ extended ∨ (item,fresh) ∈ extended := by
  have old := (totalIff carrier relation).mp prior
  have freshHeld : fresh ∈ carrier ++ [fresh] := memAppendRight _ _ _ (List.Mem.head [])
  constructor
  · intro passed item held
    exact (totalIff (carrier ++ [fresh]) extended).mp passed |>.2 fresh freshHeld item (memAppendLeft _ _ _ held)
  · intro checked
    apply (totalIff (carrier ++ [fresh]) extended).mpr
    refine ⟨extendedOrder,?_⟩
    intro a ha b hb
    cases (extendedCarrierMember carrier fresh a).mp ha with
    | inl oldA =>
      cases (extendedCarrierMember carrier fresh b).mp hb with
      | inl oldB =>
        cases old.2 a oldA b oldB with
        | inl h => exact Or.inl ((retained a oldA b oldB).mpr h)
        | inr h => exact Or.inr ((retained b oldB a oldA).mpr h)
      | inr same =>
        cases same
        cases checked a oldA with
        | inl h => exact Or.inr h
        | inr h => exact Or.inl h
    | inr same =>
      cases same
      cases (extendedCarrierMember carrier fresh b).mp hb with
      | inl oldB => exact checked b oldB
      | inr same =>
        cases same
        exact Or.inl ((partialOrderMeaning (carrier ++ [fresh]) extended).mp extendedOrder |>.2.2.2.2.1 fresh freshHeld)

end SFT.Mathematics.OrderOperations
