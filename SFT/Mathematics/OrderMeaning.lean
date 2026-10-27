import SFT.Mathematics.OrderOperations
namespace SFT.Mathematics.OrderOperations
open DiscreteObjects AlgebraOperations

theorem partialOrderChecksIff (carrier : List String) (relation : Relation) :
    isPartialOrder carrier relation = true ↔
      (carrier.isEmpty || !distinct carrier || !distinct relation) = false ∧
      relation.any (fun pair => !has carrier pair.1 || !has carrier pair.2) = false ∧
      carrier.all (fun item => has relation (item,item)) = true ∧
      relation.all (fun pair => decide (pair.1 = pair.2) || !has relation (pair.2,pair.1)) = true ∧
      relation.all (fun pair => relation.all (fun next =>
        if pair.2 = next.1 then has relation (pair.1,next.2) else true)) = true := by
  constructor
  · intro passed
    unfold isPartialOrder at passed
    cases guard : carrier.isEmpty || !distinct carrier || !distinct relation <;> rw [guard] at passed
    · cases outside : relation.any (fun pair => !has carrier pair.1 || !has carrier pair.2) <;> rw [outside] at passed
      · refine ⟨rfl,rfl,?_⟩
        cases reflex : carrier.all (fun item => has relation (item,item)) <;>
          cases anti : relation.all (fun pair => decide (pair.1 = pair.2) || !has relation (pair.2,pair.1)) <;>
          cases trans : relation.all (fun pair => relation.all (fun next =>
            if pair.2 = next.1 then has relation (pair.1,next.2) else true)) <;>
          rw [reflex,anti,trans] at passed
        all_goals try cases passed
        exact ⟨rfl,rfl,rfl⟩
      · cases passed
    · cases passed
  · intro h
    unfold isPartialOrder
    rw [h.1,h.2.1]
    change (_ && _ && _) = true
    rw [h.2.2.1,h.2.2.2.1,h.2.2.2.2]
    rfl

theorem orderCarrierGuardIff (carrier : List String) (relation : Relation) :
    (carrier.isEmpty || !distinct carrier || !distinct relation) = false ↔
      carrier.isEmpty = false ∧ distinct carrier = true ∧ distinct relation = true := by
  constructor
  · intro h
    cases e : carrier.isEmpty <;> cases c : distinct carrier <;> cases r : distinct relation <;> rw [e,c,r] at h
    all_goals try cases h
    exact ⟨rfl,rfl,rfl⟩
  · intro h; rw [h.1,h.2.1,h.2.2]; rfl

theorem orderEndpointsIff (carrier : List String) (relation : Relation) :
    relation.any (fun pair => !has carrier pair.1 || !has carrier pair.2) = false ↔
      ∀ pair, pair ∈ relation → pair.1 ∈ carrier ∧ pair.2 ∈ carrier := by
  constructor
  · intro checked pair held
    have each := anyFalseAtMember _ _ checked pair held
    have both : has carrier pair.1 = true ∧ has carrier pair.2 = true := by
      cases a : has carrier pair.1 <;> cases b : has carrier pair.2 <;> rw [a,b] at each
      all_goals try cases each
      exact ⟨rfl,rfl⟩
    exact ⟨(hasIff _ _).mp both.1,(hasIff _ _).mp both.2⟩
  · intro checked
    apply anyFalseOfMembers
    intro pair held
    have both := checked pair held
    rw [(hasIff _ _).mpr both.1,(hasIff _ _).mpr both.2]
    rfl

theorem reflexiveCheckIff (carrier : List String) (relation : Relation) :
    carrier.all (fun item => has relation (item,item)) = true ↔
      ∀ item, item ∈ carrier → (item,item) ∈ relation := by
  exact ⟨fun h item held => (hasIff _ _).mp (allTrueAtMember _ _ h item held),
    fun h => (allTrueIffMembers _ _).mpr (fun item held => (hasIff _ _).mpr (h item held))⟩

theorem antisymmetricCheckIff (relation : Relation) :
    relation.all (fun pair => decide (pair.1 = pair.2) || !has relation (pair.2,pair.1)) = true ↔
      ∀ a b, (a,b) ∈ relation → (b,a) ∈ relation → a = b := by
  constructor
  · intro h a b forward reverse
    have cell := allTrueAtMember _ _ h (a,b) forward
    change (decide (a = b) || !has relation (b,a)) = true at cell
    rw [(hasIff _ _).mpr reverse] at cell
    have yes : decide (a = b) = true := by
      cases same : decide (a = b) <;> rw [same] at cell
      · cases cell
    exact of_decide_eq_true yes
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro pair held
    by_cases same : pair.1 = pair.2
    · rw [decide_eq_true same]; rfl
    · have reverse : has relation (pair.2,pair.1) = false := by
        cases r : has relation (pair.2,pair.1) with
        | false => rfl
        | true => exact False.elim (same (h pair.1 pair.2 held ((hasIff _ _).mp r)))
      rw [decide_eq_false same,reverse]
      rfl

theorem transitiveCheckIff (relation : Relation) :
    relation.all (fun pair => relation.all (fun next =>
      if pair.2 = next.1 then has relation (pair.1,next.2) else true)) = true ↔
      ∀ a b c, (a,b) ∈ relation → (b,c) ∈ relation → (a,c) ∈ relation := by
  constructor
  · intro h a b c first second
    have cell := allTrueAtMember _ _ (allTrueAtMember _ _ h (a,b) first) (b,c) second
    change (if b = b then has relation (a,c) else true) = true at cell
    rw [ite_eq_left rfl] at cell
    exact (hasIff _ _).mp cell
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro pair first
    apply (allTrueIffMembers _ _).mpr
    intro next second
    by_cases connected : pair.2 = next.1
    · rw [ite_eq_left connected]
      apply (hasIff _ _).mpr
      have linked : (pair.2,next.2) ∈ relation := connected ▸ second
      exact h pair.1 pair.2 next.2 first linked
    · rw [ite_eq_right connected]

theorem partialOrderMeaning (carrier : List String) (relation : Relation) :
    isPartialOrder carrier relation = true ↔
      carrier.isEmpty = false ∧ distinct carrier = true ∧ distinct relation = true ∧
      (∀ pair, pair ∈ relation → pair.1 ∈ carrier ∧ pair.2 ∈ carrier) ∧
      (∀ item, item ∈ carrier → (item,item) ∈ relation) ∧
      (∀ a b, (a,b) ∈ relation → (b,a) ∈ relation → a = b) ∧
      (∀ a b c, (a,b) ∈ relation → (b,c) ∈ relation → (a,c) ∈ relation) := by
  constructor
  · intro h
    have checks := (partialOrderChecksIff carrier relation).mp h
    have guards := (orderCarrierGuardIff carrier relation).mp checks.1
    exact ⟨guards.1,guards.2.1,guards.2.2,(orderEndpointsIff carrier relation).mp checks.2.1,
      (reflexiveCheckIff carrier relation).mp checks.2.2.1,
      (antisymmetricCheckIff relation).mp checks.2.2.2.1,
      (transitiveCheckIff relation).mp checks.2.2.2.2⟩
  · intro h
    apply (partialOrderChecksIff carrier relation).mpr
    exact ⟨(orderCarrierGuardIff carrier relation).mpr ⟨h.1,h.2.1,h.2.2.1⟩,
      (orderEndpointsIff carrier relation).mpr h.2.2.2.1,
      (reflexiveCheckIff carrier relation).mpr h.2.2.2.2.1,
      (antisymmetricCheckIff relation).mpr h.2.2.2.2.2.1,
      (transitiveCheckIff relation).mpr h.2.2.2.2.2.2⟩

end SFT.Mathematics.OrderOperations
