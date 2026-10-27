import SFT.Mathematics.AlgebraExtension
import SFT.Mathematics.AlgebraReturnMeaning
namespace SFT.Mathematics.AlgebraOperations

theorem filterCheckedCongruent {α : Type} (first second : α → Except String Bool) (items : List α)
    (same : ∀ item, item ∈ items → first item = second item) :
    filterChecked first items = filterChecked second items := by
  induction items with
  | nil => rfl
  | cons item items ih =>
    have head := same item (List.Mem.head _)
    have tail := ih (fun x h => same x (List.Mem.tail _ h))
    rw [filterChecked,filterChecked,head,tail]

theorem filterCheckedAppend {α : Type} (test : α → Except String Bool) (old added : List α) :
    filterChecked test (old ++ added) = (do
      let before ← filterChecked test old
      let after ← filterChecked test added
      pure (before ++ after)) := by
  induction old with
  | nil =>
    change filterChecked test added = (do
      let after ← filterChecked test added
      pure ([] ++ after))
    cases filterChecked test added <;> rfl
  | cons item old ih =>
    change (do
      let yes ← test item
      let rest ← filterChecked test (old ++ added)
      pure (if yes then item::rest else rest)) = _
    rw [ih,filterChecked]
    cases cell : test item with
    | error e => rfl
    | ok yes =>
      cases yes <;> cases before : filterChecked test old <;>
        cases after : filterChecked test added <;> rfl

theorem returnCellPreserved (old extended : OperationTable) (identity item candidate : String)
    (itemHeld : item ∈ old.carrier) (candidateHeld : candidate ∈ old.carrier)
    (agrees : ∀ a, a ∈ old.carrier → ∀ b, b ∈ old.carrier →
      applyOperation extended a b = applyOperation old a b) :
    returnCell extended identity item candidate = returnCell old identity item candidate := by
  unfold returnCell
  rw [agrees item itemHeld candidate candidateHeld,agrees candidate candidateHeld item itemHeld]

theorem returnCandidatesExtension (old extended : OperationTable) (fresh identity item : String)
    (shape : extended.carrier = old.carrier ++ [fresh]) (itemHeld : item ∈ old.carrier)
    (agrees : ∀ a, a ∈ old.carrier → ∀ b, b ∈ old.carrier →
      applyOperation extended a b = applyOperation old a b) :
    returnCandidates extended identity item = (do
      let before ← returnCandidates old identity item
      let yes ← returnCell extended identity item fresh
      pure (if yes then before ++ [fresh] else before)) := by
  unfold returnCandidates
  rw [shape,filterCheckedAppend]
  have priorSearch := filterCheckedCongruent (returnCell extended identity item)
    (returnCell old identity item) old.carrier (fun candidate held =>
      returnCellPreserved old extended identity item candidate itemHeld held agrees)
  rw [priorSearch]
  cases before : filterChecked (returnCell old identity item) old.carrier with
  | error e => rfl
  | ok found =>
    change (do
      let after ← filterChecked (returnCell extended identity item) [fresh]
      pure (found ++ after)) = _
    rw [filterChecked]
    cases cell : returnCell extended identity item fresh with
    | error e => rfl
    | ok yes =>
      cases yes with
      | false => exact congrArg Except.ok (algebraAppendNil found)
      | true => rfl

theorem oldMateRetainedIffFreshFails (old extended : OperationTable) (fresh identity item mate : String)
    (shape : extended.carrier = old.carrier ++ [fresh]) (itemHeld : item ∈ old.carrier)
    (agrees : ∀ a, a ∈ old.carrier → ∀ b, b ∈ old.carrier →
      applyOperation extended a b = applyOperation old a b)
    (prior : returnCandidates old identity item = .ok [mate]) :
    returnCandidates extended identity item = .ok [mate] ↔
      returnCell extended identity item fresh = .ok false := by
  rw [returnCandidatesExtension old extended fresh identity item shape itemHeld agrees,prior]
  cases cell : returnCell extended identity item fresh with
  | error e => constructor <;> intro h <;> cases h
  | ok yes =>
    cases yes with
    | false => exact ⟨fun _ => rfl,fun _ => rfl⟩
    | true => constructor <;> intro h <;> cases h

theorem extendedReturnSuccessIff (table : OperationTable) (carrier : List String) (fresh identity : String)
    (shape : table.carrier = carrier ++ [fresh]) :
    (∃ rows, returnMates table identity = .ok (some rows)) ↔
      hasIdentity table identity = .ok true ∧
      (∀ item, item ∈ carrier → ∃ mate, returnCandidates table identity item = .ok [mate]) ∧
      (∃ mate, returnCandidates table identity fresh = .ok [mate]) := by
  constructor
  · intro h
    have parts := (returnMatesSuccessIff table identity).mp h
    refine ⟨parts.1,?_,?_⟩
    · intro item member
      apply parts.2 item
      rw [shape]; exact SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ member
    · apply parts.2 fresh
      rw [shape]; exact SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (List.Mem.head [])
  · intro checks
    apply (returnMatesSuccessIff table identity).mpr
    refine ⟨checks.1,?_⟩
    intro item member
    rw [shape] at member
    cases (extendedCarrierMember carrier fresh item).mp member with
    | inl h => exact checks.2.1 item h
    | inr h => cases h; exact checks.2.2

theorem oldSearchUniqueIffFreshFails (old extended : OperationTable) (fresh identity item mate : String)
    (shape : extended.carrier = old.carrier ++ [fresh]) (itemHeld : item ∈ old.carrier)
    (agrees : ∀ a, a ∈ old.carrier → ∀ b, b ∈ old.carrier →
      applyOperation extended a b = applyOperation old a b)
    (prior : returnCandidates old identity item = .ok [mate]) :
    (∃ found, returnCandidates extended identity item = .ok [found]) ↔
      returnCell extended identity item fresh = .ok false := by
  rw [returnCandidatesExtension old extended fresh identity item shape itemHeld agrees,prior]
  cases cell : returnCell extended identity item fresh with
  | error e =>
    constructor
    · intro h; obtain ⟨found,h⟩ := h; cases h
    · intro h; cases h
  | ok yes =>
    cases yes with
    | false => exact ⟨fun _ => rfl,fun _ => ⟨mate,rfl⟩⟩
    | true =>
      constructor
      · intro h; obtain ⟨found,h⟩ := h; cases h
      · intro h; cases h

theorem returnMatesPreservedByExtension (old extended : OperationTable) (fresh identity : String)
    (shape : extended.carrier = old.carrier ++ [fresh])
    (agrees : ∀ a, a ∈ old.carrier → ∀ b, b ∈ old.carrier →
      applyOperation extended a b = applyOperation old a b)
    (prior : ∃ rows, returnMates old identity = .ok (some rows)) :
    (∃ rows, returnMates extended identity = .ok (some rows)) ↔
      (applyOperation extended identity fresh = .ok fresh ∧
        applyOperation extended fresh identity = .ok fresh) ∧
      (∀ item, item ∈ old.carrier → returnCell extended identity item fresh = .ok false) ∧
      (∃ mate, returnCandidates extended identity fresh = .ok [mate]) := by
  have oldChecks := (returnMatesSuccessIff old identity).mp prior
  have split := extendedReturnSuccessIff extended old.carrier fresh identity shape
  have idCheck := identityPreservedByExtension old extended fresh identity shape agrees oldChecks.1
  constructor
  · intro passed
    have checks := split.mp passed
    refine ⟨idCheck.mp checks.1,?_,checks.2.2⟩
    intro item held
    obtain ⟨mate,search⟩ := oldChecks.2 item held
    exact (oldSearchUniqueIffFreshFails old extended fresh identity item mate shape held agrees search).mp
      (checks.2.1 item held)
  · intro checks
    apply split.mpr
    refine ⟨idCheck.mpr checks.1,?_,checks.2.2⟩
    intro item held
    obtain ⟨mate,search⟩ := oldChecks.2 item held
    exact (oldSearchUniqueIffFreshFails old extended fresh identity item mate shape held agrees search).mpr
      (checks.2.1 item held)

end SFT.Mathematics.AlgebraOperations
