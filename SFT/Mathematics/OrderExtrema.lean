import SFT.Mathematics.OrderMeaning
namespace SFT.Mathematics.OrderOperations
open DiscreteObjects AlgebraOperations

theorem filterSingletonMeaning (test : String → Bool) (items : List String) (value : String)
    (single : items.filter test = [value]) :
    value ∈ items ∧ test value = true ∧ ∀ other, other ∈ items → test other = true → other = value := by
  have retained : value ∈ items.filter test := single.symm ▸ List.Mem.head []
  have parts := (filterMemberIff test items value).mp retained
  refine ⟨parts.1,parts.2,?_⟩
  intro other held passes
  have member := (filterMemberIff test items other).mpr ⟨held,passes⟩
  rw [single] at member
  cases member with
  | head => rfl
  | tail _ h => cases h

theorem distinctSingletonFromMembers (items : List String) (value : String)
    (unique : distinct items = true) (held : value ∈ items)
    (only : ∀ other, other ∈ items → other = value) : items = [value] := by
  cases items with
  | nil => cases held
  | cons first rest =>
    have same := only first (List.Mem.head _)
    cases same
    cases rest with
    | nil => rfl
    | cons second tail =>
      have same := only second (List.Mem.tail _ (List.Mem.head _))
      cases same
      have absent := (distinctCons value (value::tail)).mp unique
      exact False.elim ((absentIff _ _).mp absent.1 (List.Mem.head _))

theorem filterSingletonIff (test : String → Bool) (items : List String) (value : String)
    (unique : distinct items = true) :
    items.filter test = [value] ↔
      value ∈ items ∧ test value = true ∧ ∀ other, other ∈ items → test other = true → other = value := by
  constructor
  · exact filterSingletonMeaning test items value
  · intro h
    apply distinctSingletonFromMembers _ value (filterDistinct test items unique)
    · exact (filterMemberIff test items value).mpr ⟨h.1,h.2.1⟩
    · intro other member
      have parts := (filterMemberIff test items other).mp member
      exact h.2.2 other parts.1 parts.2

theorem greatestExactSingleton (bounds : List String) (relation : Relation) (value : String) :
    uniqueGreatest bounds relation = some value ↔
      bounds.filter (fun candidate => bounds.all (fun other => has relation (other,candidate))) = [value] := by
  unfold uniqueGreatest
  cases found : bounds.filter (fun candidate => bounds.all (fun other => has relation (other,candidate))) with
  | nil => constructor <;> intro h <;> cases h
  | cons first rest =>
    cases rest with
    | nil => constructor <;> intro h <;> cases h <;> rfl
    | cons second tail => constructor <;> intro h <;> cases h

theorem leastExactSingleton (bounds : List String) (relation : Relation) (value : String) :
    uniqueLeast bounds relation = some value ↔
      bounds.filter (fun candidate => bounds.all (fun other => has relation (candidate,other))) = [value] := by
  unfold uniqueLeast
  cases found : bounds.filter (fun candidate => bounds.all (fun other => has relation (candidate,other))) with
  | nil => constructor <;> intro h <;> cases h
  | cons first rest =>
    cases rest with
    | nil => constructor <;> intro h <;> cases h <;> rfl
    | cons second tail => constructor <;> intro h <;> cases h

theorem greatestMeaning (bounds : List String) (relation : Relation) (value : String)
    (passed : uniqueGreatest bounds relation = some value) :
    value ∈ bounds ∧ (∀ other, other ∈ bounds → (other,value) ∈ relation) ∧
      ∀ rival, rival ∈ bounds → (∀ other, other ∈ bounds → (other,rival) ∈ relation) → rival = value := by
  have single := (greatestExactSingleton bounds relation value).mp passed
  have parts := filterSingletonMeaning _ bounds value single
  refine ⟨parts.1,?_,?_⟩
  · intro other held
    exact (hasIff _ _).mp (allTrueAtMember _ _ parts.2.1 other held)
  · intro rival held dominates
    exact parts.2.2 rival held ((allTrueIffMembers _ _).mpr (fun other h => (hasIff _ _).mpr (dominates other h)))

theorem leastMeaning (bounds : List String) (relation : Relation) (value : String)
    (passed : uniqueLeast bounds relation = some value) :
    value ∈ bounds ∧ (∀ other, other ∈ bounds → (value,other) ∈ relation) ∧
      ∀ rival, rival ∈ bounds → (∀ other, other ∈ bounds → (rival,other) ∈ relation) → rival = value := by
  have single := (leastExactSingleton bounds relation value).mp passed
  have parts := filterSingletonMeaning _ bounds value single
  refine ⟨parts.1,?_,?_⟩
  · intro other held
    exact (hasIff _ _).mp (allTrueAtMember _ _ parts.2.1 other held)
  · intro rival held dominates
    exact parts.2.2 rival held ((allTrueIffMembers _ _).mpr (fun other h => (hasIff _ _).mpr (dominates other h)))

theorem greatestIff (bounds : List String) (relation : Relation) (value : String)
    (unique : distinct bounds = true) :
    uniqueGreatest bounds relation = some value ↔
      value ∈ bounds ∧ (∀ other, other ∈ bounds → (other,value) ∈ relation) ∧
      ∀ rival, rival ∈ bounds → (∀ other, other ∈ bounds → (other,rival) ∈ relation) → rival = value := by
  constructor
  · exact greatestMeaning bounds relation value
  · intro h
    apply (greatestExactSingleton bounds relation value).mpr
    apply (filterSingletonIff _ bounds value unique).mpr
    refine ⟨h.1,(allTrueIffMembers _ _).mpr (fun other held => (hasIff _ _).mpr (h.2.1 other held)),?_⟩
    intro rival held checked
    exact h.2.2 rival held (fun other member => (hasIff _ _).mp (allTrueAtMember _ _ checked other member))

theorem leastIff (bounds : List String) (relation : Relation) (value : String)
    (unique : distinct bounds = true) :
    uniqueLeast bounds relation = some value ↔
      value ∈ bounds ∧ (∀ other, other ∈ bounds → (value,other) ∈ relation) ∧
      ∀ rival, rival ∈ bounds → (∀ other, other ∈ bounds → (rival,other) ∈ relation) → rival = value := by
  constructor
  · exact leastMeaning bounds relation value
  · intro h
    apply (leastExactSingleton bounds relation value).mpr
    apply (filterSingletonIff _ bounds value unique).mpr
    refine ⟨h.1,(allTrueIffMembers _ _).mpr (fun other held => (hasIff _ _).mpr (h.2.1 other held)),?_⟩
    intro rival held checked
    exact h.2.2 rival held (fun other member => (hasIff _ _).mp (allTrueAtMember _ _ checked other member))

theorem meetSuccessIff (carrier : List String) (relation : Relation) (held : List String) (value : String) :
    meet carrier relation held = .ok (some value) ↔
      ∃ bounds, lowerBounds carrier relation held = .ok bounds ∧ uniqueGreatest bounds relation = some value := by
  unfold meet
  cases result : lowerBounds carrier relation held with
  | error e =>
    constructor
    · intro h; cases h
    · intro h; obtain ⟨bounds,h,_⟩ := h; cases h
  | ok bounds =>
    constructor
    · intro h; exact ⟨bounds,rfl,Except.ok.inj h⟩
    · intro h; obtain ⟨other,eq,extremal⟩ := h; cases eq; exact congrArg Except.ok extremal

theorem joinSuccessIff (carrier : List String) (relation : Relation) (held : List String) (value : String) :
    join carrier relation held = .ok (some value) ↔
      ∃ bounds, upperBounds carrier relation held = .ok bounds ∧ uniqueLeast bounds relation = some value := by
  unfold join
  cases result : upperBounds carrier relation held with
  | error e =>
    constructor
    · intro h; cases h
    · intro h; obtain ⟨bounds,h,_⟩ := h; cases h
  | ok bounds =>
    constructor
    · intro h; exact ⟨bounds,rfl,Except.ok.inj h⟩
    · intro h; obtain ⟨other,eq,extremal⟩ := h; cases eq; exact congrArg Except.ok extremal

theorem meetGreatestLowerBound (carrier : List String) (relation : Relation) (held : List String) (value : String)
    (success : meet carrier relation held = .ok (some value)) :
    value ∈ carrier ∧ (∀ item, item ∈ held → (value,item) ∈ relation) ∧
      ∀ other, other ∈ carrier → (∀ item, item ∈ held → (other,item) ∈ relation) → (other,value) ∈ relation := by
  obtain ⟨bounds,computed,extremal⟩ := (meetSuccessIff carrier relation held value).mp success
  have greatest := greatestMeaning bounds relation value extremal
  have lower := (lowerBoundsMembership carrier relation held bounds computed value).mp greatest.1
  refine ⟨lower.1,lower.2,?_⟩
  intro other member below
  exact greatest.2.1 other ((lowerBoundsMembership carrier relation held bounds computed other).mpr ⟨member,below⟩)

theorem joinLeastUpperBound (carrier : List String) (relation : Relation) (held : List String) (value : String)
    (success : join carrier relation held = .ok (some value)) :
    value ∈ carrier ∧ (∀ item, item ∈ held → (item,value) ∈ relation) ∧
      ∀ other, other ∈ carrier → (∀ item, item ∈ held → (item,other) ∈ relation) → (value,other) ∈ relation := by
  obtain ⟨bounds,computed,extremal⟩ := (joinSuccessIff carrier relation held value).mp success
  have least := leastMeaning bounds relation value extremal
  have upper := (upperBoundsMembership carrier relation held bounds computed value).mp least.1
  refine ⟨upper.1,upper.2,?_⟩
  intro other member above
  exact least.2.1 other ((upperBoundsMembership carrier relation held bounds computed other).mpr ⟨member,above⟩)

end SFT.Mathematics.OrderOperations
