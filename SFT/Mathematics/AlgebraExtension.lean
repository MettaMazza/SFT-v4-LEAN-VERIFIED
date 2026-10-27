import SFT.Mathematics.AlgebraInduction
namespace SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

theorem extendedCarrierMember (carrier : List String) (fresh item : String) :
    item ∈ carrier ++ [fresh] ↔ item ∈ carrier ∨ item = fresh := by
  constructor
  · intro member
    cases memAppendCases item carrier [fresh] member with
    | inl h => exact Or.inl h
    | inr h =>
      cases h with
      | head => exact Or.inr rfl
      | tail _ h => cases h
  · intro h
    cases h with
    | inl h => exact memAppendLeft _ _ _ h
    | inr h => cases h; exact memAppendRight _ _ _ (List.Mem.head [])

-- Original short-circuit/error order, including a failing old prefix.
theorem allCheckedAppend (test : α → Except String Bool) (old added : List α) :
    allChecked test (old ++ added) = (do
      let passed ← allChecked test old
      if passed then allChecked test added else pure false) := by
  induction old with
  | nil => rfl
  | cons item old ih =>
    cases cell : test item with
    | error e => rw [show (item::old) ++ added = item :: (old ++ added) from rfl,allChecked,cell,allChecked,cell]; rfl
    | ok value =>
      cases value with
      | false => rw [show (item::old) ++ added = item :: (old ++ added) from rfl,allChecked,cell,allChecked,cell]; rfl
      | true =>
        change (do
          let passed ← test item
          if passed then allChecked test (old ++ added) else pure false) = _
        rw [cell]
        change allChecked test (old ++ added) = _
        rw [ih,allChecked,cell]
        rfl

theorem extendedIdentityIff (table : OperationTable) (carrier : List String)
    (fresh identity : String) (shape : table.carrier = carrier ++ [fresh])
    (held : identity ∈ carrier) :
    hasIdentity table identity = .ok true ↔
      (∀ item, item ∈ carrier → applyOperation table identity item = .ok item ∧
        applyOperation table item identity = .ok item) ∧
      (applyOperation table identity fresh = .ok fresh ∧ applyOperation table fresh identity = .ok fresh) := by
  constructor
  · intro passed
    have checked := (hasIdentityTrueIff table identity).mp passed
    constructor
    · intro item member
      apply checked.2 item
      rw [shape]; exact memAppendLeft _ _ _ member
    · apply checked.2 fresh
      rw [shape]; exact memAppendRight _ _ _ (List.Mem.head [])
  · intro checked
    apply (hasIdentityTrueIff table identity).mpr
    constructor
    · rw [shape]; exact memAppendLeft _ _ _ held
    · intro item member
      rw [shape] at member
      cases (extendedCarrierMember carrier fresh item).mp member with
      | inl h => exact checked.1 item h
      | inr h => cases h; exact checked.2

theorem identityPreservedByExtension (old extended : OperationTable) (fresh identity : String)
    (shape : extended.carrier = old.carrier ++ [fresh])
    (agrees : ∀ a, a ∈ old.carrier → ∀ b, b ∈ old.carrier →
      applyOperation extended a b = applyOperation old a b)
    (oldIdentity : hasIdentity old identity = .ok true) :
    hasIdentity extended identity = .ok true ↔
      applyOperation extended identity fresh = .ok fresh ∧
      applyOperation extended fresh identity = .ok fresh := by
  have prior := (hasIdentityTrueIff old identity).mp oldIdentity
  have split := extendedIdentityIff extended old.carrier fresh identity shape prior.1
  constructor
  · intro h; exact (split.mp h).2
  · intro added
    apply split.mpr
    refine ⟨?_,added⟩
    intro item member
    rw [agrees identity prior.1 item member,agrees item member identity prior.1]
    exact prior.2 item member

-- All old triples plus every triple containing the added member, without
-- omitting any of the seven new-coordinate combinations.
theorem extendedAssociationIff (table : OperationTable) (carrier : List String)
    (fresh : String) (shape : table.carrier = carrier ++ [fresh]) :
    isAssociative table = .ok true ↔
      (∀ a, a ∈ carrier → ∀ b, b ∈ carrier → ∀ c, c ∈ carrier →
        associationCell table a b c = .ok true) ∧
      (∀ a, a ∈ table.carrier → ∀ b, b ∈ table.carrier → ∀ c, c ∈ table.carrier →
        (a = fresh ∨ b = fresh ∨ c = fresh) → associationCell table a b c = .ok true) := by
  constructor
  · intro passed
    have checked := (associativityExhaustiveIff table).mp passed
    constructor
    · intro a ha b hb c hc
      have embed (x : String) (hx : x ∈ carrier) : x ∈ table.carrier := by
        rw [shape]; exact memAppendLeft _ _ _ hx
      exact checked a (embed a ha) b (embed b hb) c (embed c hc)
    · intro a ha b hb c hc _; exact checked a ha b hb c hc
  · intro checks
    apply (associativityExhaustiveIff table).mpr
    intro a ha b hb c hc
    have classify (x : String) (hx : x ∈ table.carrier) : x ∈ carrier ∨ x = fresh := by
      rw [shape] at hx
      exact (extendedCarrierMember carrier fresh x).mp hx
    cases classify a ha with
    | inr h => exact checks.2 a ha b hb c hc (Or.inl h)
    | inl oldA =>
      cases classify b hb with
      | inr h => exact checks.2 a ha b hb c hc (Or.inr (Or.inl h))
      | inl oldB =>
        cases classify c hc with
        | inr h => exact checks.2 a ha b hb c hc (Or.inr (Or.inr h))
        | inl oldC => exact checks.1 a oldA b oldB c oldC

theorem oldAssociationCellPreserved (old extended : OperationTable)
    (accepted : makeTable old.carrier old.rows = .ok old)
    (agrees : ∀ a, a ∈ old.carrier → ∀ b, b ∈ old.carrier →
      applyOperation extended a b = applyOperation old a b)
    (a b c : String) (ha : a ∈ old.carrier) (hb : b ∈ old.carrier) (hc : c ∈ old.carrier) :
    associationCell extended a b c = associationCell old a b c := by
  obtain ⟨ab,hab,abMember⟩ := acceptedLookupTotal _ _ old accepted a b ha hb
  obtain ⟨bc,hbc,bcMember⟩ := acceptedLookupTotal _ _ old accepted b c hb hc
  unfold associationCell
  rw [agrees a ha b hb,hab]
  dsimp only [Bind.bind,Except.bind,Pure.pure,Except.pure]
  rw [agrees ab abMember c hc]
  cases left : applyOperation old ab c with
  | error e => rfl
  | ok value =>
    dsimp only [Bind.bind,Except.bind,Pure.pure,Except.pure]
    rw [agrees b hb c hc,hbc]
    dsimp only [Bind.bind,Except.bind,Pure.pure,Except.pure]
    rw [agrees a ha bc bcMember]

theorem associationPreservedByExtension (old extended : OperationTable) (fresh : String)
    (accepted : makeTable old.carrier old.rows = .ok old)
    (shape : extended.carrier = old.carrier ++ [fresh])
    (agrees : ∀ a, a ∈ old.carrier → ∀ b, b ∈ old.carrier →
      applyOperation extended a b = applyOperation old a b)
    (prior : isAssociative old = .ok true) :
    isAssociative extended = .ok true ↔
      ∀ a, a ∈ extended.carrier → ∀ b, b ∈ extended.carrier → ∀ c, c ∈ extended.carrier →
        (a = fresh ∨ b = fresh ∨ c = fresh) → associationCell extended a b c = .ok true := by
  have split := extendedAssociationIff extended old.carrier fresh shape
  constructor
  · intro h; exact (split.mp h).2
  · intro added
    apply split.mpr
    refine ⟨?_,added⟩
    intro a ha b hb c hc
    rw [oldAssociationCellPreserved old extended accepted agrees a b c ha hb hc]
    exact (associativityExhaustiveIff old).mp prior a ha b hb c hc

end SFT.Mathematics.AlgebraOperations
