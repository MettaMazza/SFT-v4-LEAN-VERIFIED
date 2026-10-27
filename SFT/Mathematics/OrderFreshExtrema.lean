import SFT.Mathematics.OrderHeldExtension
namespace SFT.Mathematics.OrderOperations
open DiscreteObjects AlgebraOperations SFT.Foundation.Count.TraceDerivation

theorem freshMeetIff (carrier held bounds : List String) (relation extended : Relation) (fresh : String)
    (computed : lowerBounds carrier relation held = .ok bounds)
    (order : isPartialOrder (carrier ++ [fresh]) extended = true)
    (retained : ∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ((a,b) ∈ extended ↔ (a,b) ∈ relation)) :
    meet (carrier ++ [fresh]) extended held = .ok (some fresh) ↔
      (∀ item, item ∈ held → (fresh,item) ∈ extended) ∧
      (∀ other, other ∈ bounds → (other,fresh) ∈ extended) := by
  have valid := lowerSelectionValid carrier relation held bounds computed
  have freshMember : fresh ∈ carrier ++ [fresh] := memAppendRight _ _ _ (List.Mem.head [])
  constructor
  · intro passed
    have result := meetGreatestLowerBound (carrier ++ [fresh]) extended held fresh passed
    refine ⟨result.2.1, ?_⟩
    intro other member
    have old := (lowerBoundsMembership carrier relation held bounds computed other).mp member
    apply result.2.2 other (memAppendLeft _ _ _ old.1)
    intro item hi
    exact (retained other old.1 item (valid.2 item hi)).mpr (old.2 item hi)
  · intro conditions
    apply (acceptedMeetIff (carrier ++ [fresh]) extended held fresh order valid.1
      (fun item hi => memAppendLeft _ _ _ (valid.2 item hi))).mpr
    refine ⟨freshMember, conditions.1, ?_⟩
    intro other member bound
    cases (extendedCarrierMember carrier fresh other).mp member with
    | inr same =>
      cases same
      exact (partialOrderMeaning (carrier ++ [fresh]) extended).mp order |>.2.2.2.2.1 fresh freshMember
    | inl oldMember =>
      apply conditions.2 other
      apply (lowerBoundsMembership carrier relation held bounds computed other).mpr
      refine ⟨oldMember, ?_⟩
      intro item hi
      exact (retained other oldMember item (valid.2 item hi)).mp (bound item hi)

theorem freshJoinIff (carrier held bounds : List String) (relation extended : Relation) (fresh : String)
    (computed : upperBounds carrier relation held = .ok bounds)
    (order : isPartialOrder (carrier ++ [fresh]) extended = true)
    (retained : ∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ((a,b) ∈ extended ↔ (a,b) ∈ relation)) :
    join (carrier ++ [fresh]) extended held = .ok (some fresh) ↔
      (∀ item, item ∈ held → (item,fresh) ∈ extended) ∧
      (∀ other, other ∈ bounds → (fresh,other) ∈ extended) := by
  have valid := upperSelectionValid carrier relation held bounds computed
  have freshMember : fresh ∈ carrier ++ [fresh] := memAppendRight _ _ _ (List.Mem.head [])
  constructor
  · intro passed
    have result := joinLeastUpperBound (carrier ++ [fresh]) extended held fresh passed
    refine ⟨result.2.1, ?_⟩
    intro other member
    have old := (upperBoundsMembership carrier relation held bounds computed other).mp member
    apply result.2.2 other (memAppendLeft _ _ _ old.1)
    intro item hi
    exact (retained item (valid.2 item hi) other old.1).mpr (old.2 item hi)
  · intro conditions
    apply (acceptedJoinIff (carrier ++ [fresh]) extended held fresh order valid.1
      (fun item hi => memAppendLeft _ _ _ (valid.2 item hi))).mpr
    refine ⟨freshMember, conditions.1, ?_⟩
    intro other member bound
    cases (extendedCarrierMember carrier fresh other).mp member with
    | inr same =>
      cases same
      exact (partialOrderMeaning (carrier ++ [fresh]) extended).mp order |>.2.2.2.2.1 fresh freshMember
    | inl oldMember =>
      apply conditions.2 other
      apply (upperBoundsMembership carrier relation held bounds computed other).mpr
      refine ⟨oldMember, ?_⟩
      intro item hi
      exact (retained item (valid.2 item hi) other oldMember).mp (bound item hi)

end SFT.Mathematics.OrderOperations
