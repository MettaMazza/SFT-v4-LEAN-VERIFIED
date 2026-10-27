import SFT.Mathematics.OrderBoundExtension
namespace SFT.Mathematics.OrderOperations
open DiscreteObjects AlgebraOperations SFT.Foundation.Count.TraceDerivation

theorem allChecksSnoc {α : Type} (test : α → Bool) (items : List α) (added : α) :
    (items ++ [added]).all test = (items.all test && test added) := by
  induction items with
  | nil => change (test added && true) = (true && test added); cases test added <;> rfl
  | cons item items ih =>
    change (test item && (items ++ [added]).all test) = ((test item && items.all test) && test added)
    rw [ih]
    cases test item <;> cases items.all test <;> cases test added <;> rfl

theorem boundFilterConjunction (first second : String → Bool) (items : List String) :
    items.filter (fun item => first item && second item) = (items.filter first).filter second := by
  induction items with
  | nil => rfl
  | cons item items ih =>
    cases a : first item with
    | false =>
      have combined : (first item && second item) ≠ true := by rw [a]; intro h; cases h
      rw [List.filter_cons_of_neg (p := fun item => first item && second item) combined,
        List.filter_cons_of_neg (p := first) (by rw [a]; intro h; cases h)]
      exact ih
    | true =>
      cases b : second item with
      | false =>
        have combined : (first item && second item) ≠ true := by rw [a,b]; intro h; cases h
        rw [List.filter_cons_of_neg (p := fun item => first item && second item) combined,
          List.filter_cons_of_pos (p := first) a,
          List.filter_cons_of_neg (p := second) (by rw [b]; intro h; cases h)]
        exact ih
      | true =>
        have combined : (first item && second item) = true := by rw [a,b]; rfl
        rw [List.filter_cons_of_pos (p := fun item => first item && second item) combined,
          List.filter_cons_of_pos (p := first) a,List.filter_cons_of_pos (p := second) b]
        exact congrArg (List.cons item) ih

theorem lowerBoundsHeldExtension (carrier held bounds : List String) (relation : Relation) (added : String)
    (computed : lowerBounds carrier relation held = .ok bounds) (member : added ∈ carrier) :
    lowerBounds carrier relation (held ++ [added]) = .ok (bounds.filter (fun candidate => has relation (candidate,added))) := by
  have valid := lowerSelectionValid carrier relation held bounds computed
  have nonempty : (held ++ [added]).isEmpty = false := by cases held <;> rfl
  have within : ∀ item, item ∈ held ++ [added] → item ∈ carrier := by
    intro item hi
    cases (extendedCarrierMember held added item).mp hi with
    | inl h => exact valid.2 item h
    | inr h => cases h; exact member
  rw [validLowerBounds carrier relation (held ++ [added]) nonempty within]
  apply congrArg Except.ok
  have selected := boundFilterCongruent
    (fun candidate => (held ++ [added]).all (fun item => has relation (candidate,item)))
    (fun candidate => held.all (fun item => has relation (candidate,item)) && has relation (candidate,added)) carrier
    (fun candidate _ => allChecksSnoc (fun item => has relation (candidate,item)) held added)
  rw [selected,boundFilterConjunction,← lowerBoundsResult carrier relation held bounds computed]

theorem upperBoundsHeldExtension (carrier held bounds : List String) (relation : Relation) (added : String)
    (computed : upperBounds carrier relation held = .ok bounds) (member : added ∈ carrier) :
    upperBounds carrier relation (held ++ [added]) = .ok (bounds.filter (fun candidate => has relation (added,candidate))) := by
  have valid := upperSelectionValid carrier relation held bounds computed
  have nonempty : (held ++ [added]).isEmpty = false := by cases held <;> rfl
  have within : ∀ item, item ∈ held ++ [added] → item ∈ carrier := by
    intro item hi
    cases (extendedCarrierMember held added item).mp hi with
    | inl h => exact valid.2 item h
    | inr h => cases h; exact member
  rw [validUpperBounds carrier relation (held ++ [added]) nonempty within]
  apply congrArg Except.ok
  have selected := boundFilterCongruent
    (fun candidate => (held ++ [added]).all (fun item => has relation (item,candidate)))
    (fun candidate => held.all (fun item => has relation (item,candidate)) && has relation (added,candidate)) carrier
    (fun candidate _ => allChecksSnoc (fun item => has relation (item,candidate)) held added)
  rw [selected,boundFilterConjunction,← upperBoundsResult carrier relation held bounds computed]

theorem meetRetainedOnHeldExtension (carrier held : List String) (relation : Relation) (added value : String)
    (order : isPartialOrder carrier relation = true) (member : added ∈ carrier)
    (prior : meet carrier relation held = .ok (some value)) :
    meet carrier relation (held ++ [added]) = .ok (some value) ↔ (value,added) ∈ relation := by
  have old := meetGreatestLowerBound carrier relation held value prior
  obtain ⟨bounds,computed,_⟩ := (meetSuccessIff carrier relation held value).mp prior
  have valid := lowerSelectionValid carrier relation held bounds computed
  have nonempty : (held ++ [added]).isEmpty = false := by cases held <;> rfl
  have within : ∀ item, item ∈ held ++ [added] → item ∈ carrier := by
    intro item hi
    cases (extendedCarrierMember held added item).mp hi with
    | inl h => exact valid.2 item h
    | inr h => cases h; exact member
  constructor
  · intro passed
    exact (meetGreatestLowerBound carrier relation (held ++ [added]) value passed).2.1 added
      (memAppendRight _ _ _ (List.Mem.head []))
  · intro below
    apply (acceptedMeetIff carrier relation (held ++ [added]) value order nonempty within).mpr
    refine ⟨old.1,?_,?_⟩
    · intro item hi
      cases (extendedCarrierMember held added item).mp hi with
      | inl h => exact old.2.1 item h
      | inr h => cases h; exact below
    · intro other heldOther lower
      exact old.2.2 other heldOther (fun item hi => lower item (memAppendLeft _ _ _ hi))

theorem joinRetainedOnHeldExtension (carrier held : List String) (relation : Relation) (added value : String)
    (order : isPartialOrder carrier relation = true) (member : added ∈ carrier)
    (prior : join carrier relation held = .ok (some value)) :
    join carrier relation (held ++ [added]) = .ok (some value) ↔ (added,value) ∈ relation := by
  have old := joinLeastUpperBound carrier relation held value prior
  obtain ⟨bounds,computed,_⟩ := (joinSuccessIff carrier relation held value).mp prior
  have valid := upperSelectionValid carrier relation held bounds computed
  have nonempty : (held ++ [added]).isEmpty = false := by cases held <;> rfl
  have within : ∀ item, item ∈ held ++ [added] → item ∈ carrier := by
    intro item hi
    cases (extendedCarrierMember held added item).mp hi with
    | inl h => exact valid.2 item h
    | inr h => cases h; exact member
  constructor
  · intro passed
    exact (joinLeastUpperBound carrier relation (held ++ [added]) value passed).2.1 added
      (memAppendRight _ _ _ (List.Mem.head []))
  · intro above
    apply (acceptedJoinIff carrier relation (held ++ [added]) value order nonempty within).mpr
    refine ⟨old.1,?_,?_⟩
    · intro item hi
      cases (extendedCarrierMember held added item).mp hi with
      | inl h => exact old.2.1 item h
      | inr h => cases h; exact above
    · intro other heldOther upper
      exact old.2.2 other heldOther (fun item hi => upper item (memAppendLeft _ _ _ hi))

theorem meetRetainedOnCarrierExtension (carrier held : List String) (relation extended : Relation) (fresh value : String)
    (order : isPartialOrder (carrier ++ [fresh]) extended = true)
    (retained : ∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ((a,b) ∈ extended ↔ (a,b) ∈ relation))
    (prior : meet carrier relation held = .ok (some value)) :
    meet (carrier ++ [fresh]) extended held = .ok (some value) ↔
      ((∀ item, item ∈ held → (fresh,item) ∈ extended) → (fresh,value) ∈ extended) := by
  have old := meetGreatestLowerBound carrier relation held value prior
  obtain ⟨bounds,computed,_⟩ := (meetSuccessIff carrier relation held value).mp prior
  have valid := lowerSelectionValid carrier relation held bounds computed
  have freshHeld : fresh ∈ carrier ++ [fresh] := memAppendRight _ _ _ (List.Mem.head [])
  constructor
  · intro passed freshLower
    exact (meetGreatestLowerBound (carrier ++ [fresh]) extended held value passed).2.2 fresh freshHeld freshLower
  · intro freshBelow
    apply (acceptedMeetIff (carrier ++ [fresh]) extended held value order valid.1
      (fun item hi => memAppendLeft _ _ _ (valid.2 item hi))).mpr
    refine ⟨memAppendLeft _ _ _ old.1,?_,?_⟩
    · intro item hi
      exact (retained value old.1 item (valid.2 item hi)).mpr (old.2.1 item hi)
    · intro other member lower
      cases (extendedCarrierMember carrier fresh other).mp member with
      | inr same => cases same; exact freshBelow lower
      | inl oldMember =>
        apply (retained other oldMember value old.1).mpr
        exact old.2.2 other oldMember (fun item hi =>
          (retained other oldMember item (valid.2 item hi)).mp (lower item hi))

theorem joinRetainedOnCarrierExtension (carrier held : List String) (relation extended : Relation) (fresh value : String)
    (order : isPartialOrder (carrier ++ [fresh]) extended = true)
    (retained : ∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ((a,b) ∈ extended ↔ (a,b) ∈ relation))
    (prior : join carrier relation held = .ok (some value)) :
    join (carrier ++ [fresh]) extended held = .ok (some value) ↔
      ((∀ item, item ∈ held → (item,fresh) ∈ extended) → (value,fresh) ∈ extended) := by
  have old := joinLeastUpperBound carrier relation held value prior
  obtain ⟨bounds,computed,_⟩ := (joinSuccessIff carrier relation held value).mp prior
  have valid := upperSelectionValid carrier relation held bounds computed
  have freshHeld : fresh ∈ carrier ++ [fresh] := memAppendRight _ _ _ (List.Mem.head [])
  constructor
  · intro passed freshUpper
    exact (joinLeastUpperBound (carrier ++ [fresh]) extended held value passed).2.2 fresh freshHeld freshUpper
  · intro freshAbove
    apply (acceptedJoinIff (carrier ++ [fresh]) extended held value order valid.1
      (fun item hi => memAppendLeft _ _ _ (valid.2 item hi))).mpr
    refine ⟨memAppendLeft _ _ _ old.1,?_,?_⟩
    · intro item hi
      exact (retained item (valid.2 item hi) value old.1).mpr (old.2.1 item hi)
    · intro other member upper
      cases (extendedCarrierMember carrier fresh other).mp member with
      | inr same => cases same; exact freshAbove upper
      | inl oldMember =>
        apply (retained value old.1 other oldMember).mpr
        exact old.2.2 other oldMember (fun item hi =>
          (retained item (valid.2 item hi) other oldMember).mp (upper item hi))

end SFT.Mathematics.OrderOperations
