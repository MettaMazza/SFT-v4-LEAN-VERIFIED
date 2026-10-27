import SFT.Mathematics.OrderInduction
import SFT.Mathematics.DiscreteComposition
namespace SFT.Mathematics.OrderOperations
open DiscreteObjects AlgebraOperations SFT.Foundation.Count.TraceDerivation

theorem allChecksCongruent {α : Type} (first second : α → Bool) (items : List α)
    (same : ∀ item, item ∈ items → first item = second item) : items.all first = items.all second := by
  induction items with
  | nil => rfl
  | cons item items ih =>
    change (first item && items.all first) = (second item && items.all second)
    rw [same item (List.Mem.head _),ih (fun x h => same x (List.Mem.tail _ h))]

theorem boundFilterCongruent (first second : String → Bool) (items : List String)
    (same : ∀ item, item ∈ items → first item = second item) : items.filter first = items.filter second := by
  induction items with
  | nil => rfl
  | cons item items ih =>
    have agree := same item (List.Mem.head _)
    have tail := ih (fun x h => same x (List.Mem.tail _ h))
    cases test : first item with
    | false =>
      have other : second item = false := agree.symm.trans test
      rw [List.filter_cons_of_neg (by rw [test]; intro h; cases h),
        List.filter_cons_of_neg (by rw [other]; intro h; cases h)]
      exact tail
    | true =>
      have other : second item = true := agree.symm.trans test
      rw [List.filter_cons_of_pos test,List.filter_cons_of_pos other]
      exact congrArg (List.cons item) tail

theorem retainedComparisonCheck (relation extended : Relation) (a b : String)
    (retained : (a,b) ∈ extended ↔ (a,b) ∈ relation) : has extended (a,b) = has relation (a,b) := by
  cases ext : has extended (a,b) <;> cases old : has relation (a,b)
  · rfl
  · have bad := (hasIff _ _).mpr (retained.mpr ((hasIff _ _).mp old))
    rw [ext] at bad; cases bad
  · have bad := (hasIff _ _).mpr (retained.mp ((hasIff _ _).mp ext))
    rw [old] at bad; cases bad
  · rfl

theorem lowerSelectionValid (carrier : List String) (relation : Relation) (held bounds : List String)
    (computed : lowerBounds carrier relation held = .ok bounds) :
    held.isEmpty = false ∧ ∀ item, item ∈ held → item ∈ carrier := by
  apply (boundsGuardIff carrier held).mp
  unfold lowerBounds at computed
  cases guard : held.isEmpty || held.any (fun item => !has carrier item) with
  | false => rfl
  | true => rw [guard] at computed; cases computed

theorem upperSelectionValid (carrier : List String) (relation : Relation) (held bounds : List String)
    (computed : upperBounds carrier relation held = .ok bounds) :
    held.isEmpty = false ∧ ∀ item, item ∈ held → item ∈ carrier := by
  apply (boundsGuardIff carrier held).mp
  unfold upperBounds at computed
  cases guard : held.isEmpty || held.any (fun item => !has carrier item) with
  | false => rfl
  | true => rw [guard] at computed; cases computed

theorem lowerBoundCheckPreserved (carrier held : List String) (relation extended : Relation)
    (candidate : String) (member : candidate ∈ carrier)
    (within : ∀ item, item ∈ held → item ∈ carrier)
    (retained : ∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ((a,b) ∈ extended ↔ (a,b) ∈ relation)) :
    held.all (fun item => has extended (candidate,item)) = held.all (fun item => has relation (candidate,item)) := by
  apply allChecksCongruent
  intro item hi
  exact retainedComparisonCheck relation extended candidate item (retained candidate member item (within item hi))

theorem upperBoundCheckPreserved (carrier held : List String) (relation extended : Relation)
    (candidate : String) (member : candidate ∈ carrier)
    (within : ∀ item, item ∈ held → item ∈ carrier)
    (retained : ∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ((a,b) ∈ extended ↔ (a,b) ∈ relation)) :
    held.all (fun item => has extended (item,candidate)) = held.all (fun item => has relation (item,candidate)) := by
  apply allChecksCongruent
  intro item hi
  exact retainedComparisonCheck relation extended item candidate (retained item (within item hi) candidate member)

theorem lowerBoundsCarrierExtension (carrier held bounds : List String) (relation extended : Relation)
    (fresh : String) (computed : lowerBounds carrier relation held = .ok bounds)
    (retained : ∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ((a,b) ∈ extended ↔ (a,b) ∈ relation)) :
    lowerBounds (carrier ++ [fresh]) extended held = .ok
      (bounds ++ if held.all (fun item => has extended (fresh,item)) then [fresh] else []) := by
  have valid := lowerSelectionValid carrier relation held bounds computed
  rw [validLowerBounds (carrier ++ [fresh]) extended held valid.1
    (fun item hi => memAppendLeft _ _ _ (valid.2 item hi))]
  apply congrArg Except.ok
  rw [filterAppendExact]
  have old := boundFilterCongruent (fun candidate => held.all (fun item => has extended (candidate,item)))
    (fun candidate => held.all (fun item => has relation (candidate,item))) carrier
    (fun candidate member => lowerBoundCheckPreserved carrier held relation extended candidate member valid.2 retained)
  rw [old,← lowerBoundsResult carrier relation held bounds computed]
  cases test : held.all (fun item => has extended (fresh,item)) with
  | false => rw [List.filter_cons_of_neg (by rw [test]; intro h; cases h)]; rfl
  | true => rw [List.filter_cons_of_pos (p := fun candidate => held.all (fun item => has extended (candidate,item))) test]; rfl

theorem upperBoundsCarrierExtension (carrier held bounds : List String) (relation extended : Relation)
    (fresh : String) (computed : upperBounds carrier relation held = .ok bounds)
    (retained : ∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ((a,b) ∈ extended ↔ (a,b) ∈ relation)) :
    upperBounds (carrier ++ [fresh]) extended held = .ok
      (bounds ++ if held.all (fun item => has extended (item,fresh)) then [fresh] else []) := by
  have valid := upperSelectionValid carrier relation held bounds computed
  rw [validUpperBounds (carrier ++ [fresh]) extended held valid.1
    (fun item hi => memAppendLeft _ _ _ (valid.2 item hi))]
  apply congrArg Except.ok
  rw [filterAppendExact]
  have old := boundFilterCongruent (fun candidate => held.all (fun item => has extended (item,candidate)))
    (fun candidate => held.all (fun item => has relation (item,candidate))) carrier
    (fun candidate member => upperBoundCheckPreserved carrier held relation extended candidate member valid.2 retained)
  rw [old,← upperBoundsResult carrier relation held bounds computed]
  cases test : held.all (fun item => has extended (item,fresh)) with
  | false => rw [List.filter_cons_of_neg (by rw [test]; intro h; cases h)]; rfl
  | true => rw [List.filter_cons_of_pos (p := fun candidate => held.all (fun item => has extended (item,candidate))) test]; rfl

end SFT.Mathematics.OrderOperations
