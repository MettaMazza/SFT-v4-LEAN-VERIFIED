import SFT.Mathematics.OrderExtrema
namespace SFT.Mathematics.OrderOperations
open DiscreteObjects AlgebraOperations

theorem boundsGuardIff (carrier held : List String) :
    (held.isEmpty || held.any (fun item => !has carrier item)) = false ↔
      held.isEmpty = false ∧ ∀ item, item ∈ held → item ∈ carrier := by
  constructor
  · intro h
    have guards : held.isEmpty = false ∧ held.any (fun item => !has carrier item) = false := by
      cases empty : held.isEmpty <;> cases outside : held.any (fun item => !has carrier item) <;> rw [empty,outside] at h
      all_goals try cases h
      exact ⟨rfl,rfl⟩
    refine ⟨guards.1,?_⟩
    intro item member
    have cell := anyFalseAtMember _ _ guards.2 item member
    apply (hasIff carrier item).mp
    cases found : has carrier item with
    | false => rw [found] at cell; cases cell
    | true => rfl
  · intro h
    have valid : held.any (fun item => !has carrier item) = false := by
      apply anyFalseOfMembers
      intro item member
      rw [(hasIff carrier item).mpr (h.2 item member)]
      rfl
    rw [h.1,valid]
    rfl

theorem validLowerBounds (carrier : List String) (relation : Relation) (held : List String)
    (nonempty : held.isEmpty = false) (within : ∀ item, item ∈ held → item ∈ carrier) :
    lowerBounds carrier relation held = .ok
      (carrier.filter (fun candidate => held.all (fun item => has relation (candidate,item)))) := by
  unfold lowerBounds
  rw [(boundsGuardIff carrier held).mpr ⟨nonempty,within⟩]
  rfl

theorem validUpperBounds (carrier : List String) (relation : Relation) (held : List String)
    (nonempty : held.isEmpty = false) (within : ∀ item, item ∈ held → item ∈ carrier) :
    upperBounds carrier relation held = .ok
      (carrier.filter (fun candidate => held.all (fun item => has relation (item,candidate)))) := by
  unfold upperBounds
  rw [(boundsGuardIff carrier held).mpr ⟨nonempty,within⟩]
  rfl

theorem lowerBoundsDistinct (carrier : List String) (relation : Relation) (held bounds : List String)
    (unique : distinct carrier = true) (computed : lowerBounds carrier relation held = .ok bounds) :
    distinct bounds = true := by
  rw [lowerBoundsResult carrier relation held bounds computed]
  exact filterDistinct _ carrier unique

theorem upperBoundsDistinct (carrier : List String) (relation : Relation) (held bounds : List String)
    (unique : distinct carrier = true) (computed : upperBounds carrier relation held = .ok bounds) :
    distinct bounds = true := by
  rw [upperBoundsResult carrier relation held bounds computed]
  exact filterDistinct _ carrier unique

theorem acceptedMeetIff (carrier : List String) (relation : Relation) (held : List String) (value : String)
    (order : isPartialOrder carrier relation = true)
    (nonempty : held.isEmpty = false) (within : ∀ item, item ∈ held → item ∈ carrier) :
    meet carrier relation held = .ok (some value) ↔
      value ∈ carrier ∧ (∀ item, item ∈ held → (value,item) ∈ relation) ∧
      ∀ other, other ∈ carrier → (∀ item, item ∈ held → (other,item) ∈ relation) → (other,value) ∈ relation := by
  constructor
  · exact meetGreatestLowerBound carrier relation held value
  · intro h
    let bounds := carrier.filter (fun candidate => held.all (fun item => has relation (candidate,item)))
    have computed : lowerBounds carrier relation held = .ok bounds := validLowerBounds carrier relation held nonempty within
    have laws := (partialOrderMeaning carrier relation).mp order
    have member : value ∈ bounds := (lowerBoundsMembership carrier relation held bounds computed value).mpr ⟨h.1,h.2.1⟩
    apply (meetSuccessIff carrier relation held value).mpr
    refine ⟨bounds,computed,(greatestIff bounds relation value (lowerBoundsDistinct carrier relation held bounds laws.2.1 computed)).mpr ?_⟩
    have dominates : ∀ other, other ∈ bounds → (other,value) ∈ relation := by
      intro other retained
      have lower := (lowerBoundsMembership carrier relation held bounds computed other).mp retained
      exact h.2.2 other lower.1 lower.2
    refine ⟨member,dominates,?_⟩
    intro rival rivalHeld rivalDominates
    exact laws.2.2.2.2.2.1 rival value (dominates rival rivalHeld) (rivalDominates value member)

theorem acceptedJoinIff (carrier : List String) (relation : Relation) (held : List String) (value : String)
    (order : isPartialOrder carrier relation = true)
    (nonempty : held.isEmpty = false) (within : ∀ item, item ∈ held → item ∈ carrier) :
    join carrier relation held = .ok (some value) ↔
      value ∈ carrier ∧ (∀ item, item ∈ held → (item,value) ∈ relation) ∧
      ∀ other, other ∈ carrier → (∀ item, item ∈ held → (item,other) ∈ relation) → (value,other) ∈ relation := by
  constructor
  · exact joinLeastUpperBound carrier relation held value
  · intro h
    let bounds := carrier.filter (fun candidate => held.all (fun item => has relation (item,candidate)))
    have computed : upperBounds carrier relation held = .ok bounds := validUpperBounds carrier relation held nonempty within
    have laws := (partialOrderMeaning carrier relation).mp order
    have member : value ∈ bounds := (upperBoundsMembership carrier relation held bounds computed value).mpr ⟨h.1,h.2.1⟩
    apply (joinSuccessIff carrier relation held value).mpr
    refine ⟨bounds,computed,(leastIff bounds relation value (upperBoundsDistinct carrier relation held bounds laws.2.1 computed)).mpr ?_⟩
    have dominates : ∀ other, other ∈ bounds → (value,other) ∈ relation := by
      intro other retained
      have upper := (upperBoundsMembership carrier relation held bounds computed other).mp retained
      exact h.2.2 other upper.1 upper.2
    refine ⟨member,dominates,?_⟩
    intro rival rivalHeld rivalDominates
    exact laws.2.2.2.2.2.1 rival value (rivalDominates value member) (dominates rival rivalHeld)

end SFT.Mathematics.OrderOperations
