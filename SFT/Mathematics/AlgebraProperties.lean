import SFT.Mathematics.AlgebraTableCoverage
namespace SFT.Mathematics.AlgebraOperations
open DiscreteObjects

def allChecked {α : Type} (test : α → Except String Bool) : List α → Except String Bool
  | [] => .ok true
  | x::xs => do
    let yes ← test x
    if yes then allChecked test xs else .ok false

def identityCell (table : OperationTable) (identity item : String) : Except String Bool := do
  let left ← applyOperation table identity item
  if left = item then
    let right ← applyOperation table item identity
    pure (decide (right = item))
  else pure false

def hasIdentity (table : OperationTable) (identity : String) : Except String Bool :=
  if has table.carrier identity then allChecked (identityCell table identity) table.carrier else .ok false

def associationCell (table : OperationTable) (a b c : String) : Except String Bool := do
  let ab ← applyOperation table a b
  let left ← applyOperation table ab c
  let bc ← applyOperation table b c
  let right ← applyOperation table a bc
  pure (decide (left = right))

def isAssociative (table : OperationTable) : Except String Bool :=
  allChecked (fun a => allChecked (fun b => allChecked (associationCell table a b) table.carrier) table.carrier) table.carrier

theorem allCheckedTrueIff {α : Type} (test : α → Except String Bool) (xs : List α) :
    allChecked test xs = .ok true ↔ ∀ x, x ∈ xs → test x = .ok true := by
  induction xs with
  | nil =>
    constructor
    · intro _ x h; cases h
    · intro _; rfl
  | cons x xs ih =>
    cases hx : test x with
    | error e =>
      constructor
      · intro h; unfold allChecked at h; rw [hx] at h; cases h
      · intro h; have bad := h x (List.Mem.head _); rw [hx] at bad; cases bad
    | ok value =>
      cases value with
      | false =>
        constructor
        · intro h; unfold allChecked at h; rw [hx] at h; cases h
        · intro h; have bad := h x (List.Mem.head _); rw [hx] at bad; cases bad
      | true =>
        have step : allChecked test (x::xs) = allChecked test xs := by
          rw [allChecked,hx]; rfl
        rw [step]
        constructor
        · intro h y member
          cases member with
          | head => exact hx
          | tail _ m => exact ih.mp h y m
        · intro h
          exact ih.mpr (fun y m => h y (List.Mem.tail _ m))

theorem identityCellTrueIff (table : OperationTable) (identity item : String) :
    identityCell table identity item = .ok true ↔
      applyOperation table identity item = .ok item ∧ applyOperation table item identity = .ok item := by
  unfold identityCell
  cases hl : applyOperation table identity item with
  | error e => constructor <;> intro h; cases h; cases h.1
  | ok left =>
    try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
    by_cases same : left = item
    · rw [ite_eq_left same]
      cases hr : applyOperation table item identity with
      | error e => constructor <;> intro h; cases h; cases h.2
      | ok right =>
        try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
        constructor
        · intro h
          have eq := of_decide_eq_true (Except.ok.inj h)
          exact ⟨congrArg Except.ok same,congrArg Except.ok eq⟩
        · intro h
          have eq := Except.ok.inj h.2
          rw [decide_eq_true eq]
    · rw [ite_eq_right same]
      constructor
      · intro h; cases h
      · intro h; exact False.elim (same (Except.ok.inj h.1))

theorem hasIdentityTrueIff (table : OperationTable) (identity : String) :
    hasIdentity table identity = .ok true ↔ identity ∈ table.carrier ∧
      ∀ item, item ∈ table.carrier →
        applyOperation table identity item = .ok item ∧ applyOperation table item identity = .ok item := by
  unfold hasIdentity
  cases member : has table.carrier identity with
  | false =>
    constructor
    · intro h; cases h
    · intro h; have yes := (hasIff _ _).mpr h.1; rw [member] at yes; cases yes
  | true =>
    change allChecked _ _ = .ok true ↔ _
    constructor
    · intro h
      exact ⟨(hasIff _ _).mp member,fun item hi => (identityCellTrueIff table identity item).mp
        ((allCheckedTrueIff _ _).mp h item hi)⟩
    · intro h
      exact (allCheckedTrueIff _ _).mpr (fun item hi => (identityCellTrueIff table identity item).mpr (h.2 item hi))

theorem associativityExhaustiveIff (table : OperationTable) :
    isAssociative table = .ok true ↔
      ∀ a, a ∈ table.carrier → ∀ b, b ∈ table.carrier → ∀ c, c ∈ table.carrier →
        associationCell table a b c = .ok true := by
  constructor
  · intro h a ha b hb c hc
    exact (allCheckedTrueIff _ _).mp
      ((allCheckedTrueIff _ _).mp ((allCheckedTrueIff _ _).mp h a ha) b hb) c hc
  · intro h
    exact (allCheckedTrueIff _ _).mpr (fun a ha =>
      (allCheckedTrueIff _ _).mpr (fun b hb => (allCheckedTrueIff _ _).mpr (fun c hc => h a ha b hb c hc)))

theorem associationCellExact (table : OperationTable) (a b c ab left bc right : String)
    (hab : applyOperation table a b = .ok ab) (hl : applyOperation table ab c = .ok left)
    (hbc : applyOperation table b c = .ok bc) (hr : applyOperation table a bc = .ok right) :
    associationCell table a b c = .ok true ↔ left = right := by
  unfold associationCell
  rw [hab]
  try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
  rw [hl]
  try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
  rw [hbc]
  try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
  rw [hr]
  try dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
  exact ⟨fun h => of_decide_eq_true (Except.ok.inj h),fun h => congrArg Except.ok (decide_eq_true h)⟩


theorem acceptedAssociativityMeaning (table : OperationTable)
    (accepted : makeTable table.carrier table.rows = .ok table) :
    isAssociative table = .ok true ↔
      ∀ a, a ∈ table.carrier → ∀ b, b ∈ table.carrier → ∀ c, c ∈ table.carrier →
      ∀ ab left bc right,
        applyOperation table a b = .ok ab → applyOperation table ab c = .ok left →
        applyOperation table b c = .ok bc → applyOperation table a bc = .ok right → left = right := by
  constructor
  · intro passed a ha b hb c hc ab left bc right hab hl hbc hr
    exact (associationCellExact table a b c ab left bc right hab hl hbc hr).mp
      ((associativityExhaustiveIff table).mp passed a ha b hb c hc)
  · intro equation
    apply (associativityExhaustiveIff table).mpr
    intro a ha b hb c hc
    obtain ⟨ab,hab,abMember⟩ := acceptedLookupTotal _ _ table accepted a b ha hb
    obtain ⟨left,hl,_⟩ := acceptedLookupTotal _ _ table accepted ab c abMember hc
    obtain ⟨bc,hbc,bcMember⟩ := acceptedLookupTotal _ _ table accepted b c hb hc
    obtain ⟨right,hr,_⟩ := acceptedLookupTotal _ _ table accepted a bc ha bcMember
    exact (associationCellExact table a b c ab left bc right hab hl hbc hr).mpr
      (equation a ha b hb c hc ab left bc right hab hl hbc hr)

end SFT.Mathematics.AlgebraOperations
