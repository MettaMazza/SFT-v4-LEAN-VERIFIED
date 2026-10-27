import SFT.Mathematics.AlgebraDictionaryExtension
namespace SFT.Mathematics.OrderOperations
open DiscreteObjects AlgebraOperations

abbrev Relation := List (String × String)

def isPartialOrder (carrier : List String) (relation : Relation) : Bool :=
  if carrier.isEmpty || !distinct carrier || !distinct relation then false
  else if relation.any (fun pair => !has carrier pair.1 || !has carrier pair.2) then false
  else
    let reflexive := carrier.all (fun item => has relation (item,item))
    let antisymmetric := relation.all (fun pair => decide (pair.1 = pair.2) || !has relation (pair.2,pair.1))
    let transitive := relation.all (fun pair => relation.all (fun next =>
      if pair.2 = next.1 then has relation (pair.1,next.2) else true))
    reflexive && antisymmetric && transitive

def comparable (relation : Relation) (left right : String) : Bool :=
  has relation (left,right) || has relation (right,left)

def isTotal (carrier : List String) (relation : Relation) : Bool :=
  isPartialOrder carrier relation && carrier.all (fun left => carrier.all (comparable relation left))

def lowerBounds (carrier : List String) (relation : Relation) (held : List String) : Except String (List String) :=
  if held.isEmpty || held.any (fun item => !has carrier item) then
    .error "ValueError: bounds require a nonempty held carrier selection"
  else .ok (carrier.filter (fun candidate => held.all (fun item => has relation (candidate,item))))

def upperBounds (carrier : List String) (relation : Relation) (held : List String) : Except String (List String) :=
  if held.isEmpty || held.any (fun item => !has carrier item) then
    .error "ValueError: bounds require a nonempty held carrier selection"
  else .ok (carrier.filter (fun candidate => held.all (fun item => has relation (item,candidate))))

def uniqueGreatest (bounds : List String) (relation : Relation) : Option String :=
  match bounds.filter (fun candidate => bounds.all (fun other => has relation (other,candidate))) with
  | [] => none
  | value::[] => some value
  | _::_::_ => none

def uniqueLeast (bounds : List String) (relation : Relation) : Option String :=
  match bounds.filter (fun candidate => bounds.all (fun other => has relation (candidate,other))) with
  | [] => none
  | value::[] => some value
  | _::_::_ => none

def meet (carrier : List String) (relation : Relation) (held : List String) : Except String (Option String) := do
  let bounds ← lowerBounds carrier relation held
  pure (uniqueGreatest bounds relation)

def join (carrier : List String) (relation : Relation) (held : List String) : Except String (Option String) := do
  let bounds ← upperBounds carrier relation held
  pure (uniqueLeast bounds relation)

def isMonotone (source target : Relation) (mapping : List (String × String)) : Bool :=
  let images := buildImages mapping
  source.all (fun pair =>
    match imageLookup images pair.1 with
    | none => false
    | some left => match imageLookup images pair.2 with
      | none => false
      | some right => has target (left,right))

theorem comparableIff (relation : Relation) (left right : String) :
    comparable relation left right = true ↔ (left,right) ∈ relation ∨ (right,left) ∈ relation := by
  unfold comparable
  cases first : has relation (left,right) <;> cases second : has relation (right,left)
  · constructor
    · intro h; cases h
    · intro h
      cases h with
      | inl h => have bad := (hasIff _ _).mpr h; rw [first] at bad; cases bad
      | inr h => have bad := (hasIff _ _).mpr h; rw [second] at bad; cases bad
  · exact ⟨fun _ => Or.inr ((hasIff _ _).mp second),fun _ => rfl⟩
  · exact ⟨fun _ => Or.inl ((hasIff _ _).mp first),fun _ => rfl⟩
  · exact ⟨fun _ => Or.inl ((hasIff _ _).mp first),fun _ => rfl⟩

theorem totalIff (carrier : List String) (relation : Relation) :
    isTotal carrier relation = true ↔ isPartialOrder carrier relation = true ∧
      ∀ left, left ∈ carrier → ∀ right, right ∈ carrier →
        (left,right) ∈ relation ∨ (right,left) ∈ relation := by
  constructor
  · intro h
    have first : isPartialOrder carrier relation = true := by
      cases p : isPartialOrder carrier relation with
      | false => unfold isTotal at h; rw [p] at h; cases h
      | true => rfl
    have all : carrier.all (fun left => carrier.all (comparable relation left)) = true := by
      unfold isTotal at h; rw [first] at h; exact h
    exact ⟨first,fun left hl right hr => (comparableIff relation left right).mp
      (allTrueAtMember _ _ (allTrueAtMember _ _ all left hl) right hr)⟩
  · intro h
    unfold isTotal
    rw [h.1]
    change carrier.all (fun left => carrier.all (comparable relation left)) = true
    exact (allTrueIffMembers _ _).mpr (fun left hl => (allTrueIffMembers _ _).mpr
      (fun right hr => (comparableIff relation left right).mpr (h.2 left hl right hr)))

theorem lowerBoundsResult (carrier : List String) (relation : Relation) (held result : List String)
    (success : lowerBounds carrier relation held = .ok result) :
    result = carrier.filter (fun candidate => held.all (fun item => has relation (candidate,item))) := by
  unfold lowerBounds at success
  cases guard : held.isEmpty || held.any (fun item => !has carrier item) <;> rw [guard] at success
  · exact (Except.ok.inj success).symm
  · cases success

theorem upperBoundsResult (carrier : List String) (relation : Relation) (held result : List String)
    (success : upperBounds carrier relation held = .ok result) :
    result = carrier.filter (fun candidate => held.all (fun item => has relation (item,candidate))) := by
  unfold upperBounds at success
  cases guard : held.isEmpty || held.any (fun item => !has carrier item) <;> rw [guard] at success
  · exact (Except.ok.inj success).symm
  · cases success

theorem lowerBoundsMembership (carrier : List String) (relation : Relation) (held result : List String)
    (success : lowerBounds carrier relation held = .ok result) (candidate : String) :
    candidate ∈ result ↔ candidate ∈ carrier ∧ ∀ item, item ∈ held → (candidate,item) ∈ relation := by
  rw [lowerBoundsResult carrier relation held result success]
  constructor
  · intro h
    have parts := (filterMemberIff _ carrier candidate).mp h
    exact ⟨parts.1,fun item member => (hasIff _ _).mp (allTrueAtMember _ _ parts.2 item member)⟩
  · intro h
    apply (filterMemberIff _ carrier candidate).mpr
    exact ⟨h.1,(allTrueIffMembers _ _).mpr (fun item member => (hasIff _ _).mpr (h.2 item member))⟩

theorem upperBoundsMembership (carrier : List String) (relation : Relation) (held result : List String)
    (success : upperBounds carrier relation held = .ok result) (candidate : String) :
    candidate ∈ result ↔ candidate ∈ carrier ∧ ∀ item, item ∈ held → (item,candidate) ∈ relation := by
  rw [upperBoundsResult carrier relation held result success]
  constructor
  · intro h
    have parts := (filterMemberIff _ carrier candidate).mp h
    exact ⟨parts.1,fun item member => (hasIff _ _).mp (allTrueAtMember _ _ parts.2 item member)⟩
  · intro h
    apply (filterMemberIff _ carrier candidate).mpr
    exact ⟨h.1,(allTrueIffMembers _ _).mpr (fun item member => (hasIff _ _).mpr (h.2 item member))⟩

theorem emptyLowerSelectionRejected (carrier : List String) (relation : Relation) :
    lowerBounds carrier relation [] = .error "ValueError: bounds require a nonempty held carrier selection" := rfl

theorem emptyUpperSelectionRejected (carrier : List String) (relation : Relation) :
    upperBounds carrier relation [] = .error "ValueError: bounds require a nonempty held carrier selection" := rfl

end SFT.Mathematics.OrderOperations
