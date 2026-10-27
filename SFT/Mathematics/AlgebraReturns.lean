import SFT.Mathematics.AlgebraProperties
namespace SFT.Mathematics.AlgebraOperations

def filterChecked {α : Type} (test : α → Except String Bool) : List α → Except String (List α)
  | [] => .ok []
  | x::xs => do
    let yes ← test x
    let rest ← filterChecked test xs
    pure (if yes then x::rest else rest)

def returnCell (table : OperationTable) (identity item candidate : String) : Except String Bool := do
  let left ← applyOperation table item candidate
  if left = identity then
    let right ← applyOperation table candidate item
    pure (decide (right = identity))
  else pure false

def returnCandidates (table : OperationTable) (identity item : String) : Except String (List String) :=
  filterChecked (returnCell table identity item) table.carrier

def returnRows (table : OperationTable) (identity : String) : List String → Except String (Option (List (String × String)))
  | [] => .ok (some [])
  | item::items => do
    let found ← returnCandidates table identity item
    match found with
    | [] => pure none
    | mate::[] => do
      let later ← returnRows table identity items
      pure (later.map (List.cons (item,mate)))
    | _::_::_ => pure none

def returnMates (table : OperationTable) (identity : String) : Except String (Option (List (String × String))) := do
  let valid ← hasIdentity table identity
  if valid then returnRows table identity table.carrier else pure none

def commutationCell (table : OperationTable) (a b : String) : Except String Bool := do
  let left ← applyOperation table a b
  let right ← applyOperation table b a
  pure (decide (left = right))

def isCommutative (table : OperationTable) : Except String Bool :=
  allChecked (fun a => allChecked (commutationCell table a) table.carrier) table.carrier

theorem returnCellTrueIff (table : OperationTable) (identity item candidate : String) :
    returnCell table identity item candidate = .ok true ↔
      applyOperation table item candidate = .ok identity ∧ applyOperation table candidate item = .ok identity := by
  unfold returnCell
  cases hl : applyOperation table item candidate with
  | error e => constructor <;> intro h; cases h; cases h.1
  | ok left =>
    dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
    by_cases same : left = identity
    · rw [ite_eq_left same]
      cases hr : applyOperation table candidate item with
      | error e => constructor <;> intro h; cases h; cases h.2
      | ok right =>
        dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
        constructor
        · intro h
          exact ⟨congrArg Except.ok same,congrArg Except.ok (of_decide_eq_true (Except.ok.inj h))⟩
        · intro h
          rw [decide_eq_true (Except.ok.inj h.2)]
    · rw [ite_eq_right same]
      constructor
      · intro h; cases h
      · intro h; exact False.elim (same (Except.ok.inj h.1))

theorem filterCheckedMembership {α : Type} (test : α → Except String Bool)
    (xs output : List α) (success : filterChecked test xs = .ok output) (x : α) :
    x ∈ output ↔ x ∈ xs ∧ test x = .ok true := by
  induction xs generalizing output with
  | nil => cases success; constructor <;> intro h; cases h; cases h.1
  | cons a xs ih =>
    rw [filterChecked] at success
    cases ha : test a with
    | error e => rw [ha] at success; cases success
    | ok yes =>
      rw [ha] at success
      dsimp only [Bind.bind, Except.bind] at success
      cases ht : filterChecked test xs with
      | error e => rw [ht] at success; cases success
      | ok rest =>
        rw [ht] at success
        cases yes with
        | false =>
          cases success
          constructor
          · intro h; have p := (ih rest ht).mp h; exact ⟨List.Mem.tail _ p.1,p.2⟩
          · intro h
            cases h.1 with
            | head => rw [ha] at h; cases h.2
            | tail _ m => exact (ih rest ht).mpr ⟨m,h.2⟩
        | true =>
          cases success
          constructor
          · intro h
            cases h with
            | head => exact ⟨List.Mem.head _,ha⟩
            | tail _ m => have p := (ih rest ht).mp m; exact ⟨List.Mem.tail _ p.1,p.2⟩
          · intro h
            cases h.1 with
            | head => exact List.Mem.head _
            | tail _ m => exact List.Mem.tail _ ((ih rest ht).mpr ⟨m,h.2⟩)

theorem returnCandidatesExact (table : OperationTable) (identity item : String) (output : List String)
    (success : returnCandidates table identity item = .ok output) (candidate : String) :
    candidate ∈ output ↔ candidate ∈ table.carrier ∧
      applyOperation table item candidate = .ok identity ∧ applyOperation table candidate item = .ok identity := by
  constructor
  · intro h
    have p := (filterCheckedMembership _ _ output success candidate).mp h
    exact ⟨p.1,(returnCellTrueIff table identity item candidate).mp p.2⟩
  · intro h
    exact (filterCheckedMembership _ _ output success candidate).mpr
      ⟨h.1,(returnCellTrueIff table identity item candidate).mpr h.2⟩

theorem returnRowsPreserveCarrier (table : OperationTable) (identity : String)
    (items : List String) (rows : List (String × String))
    (success : returnRows table identity items = .ok (some rows)) : rows.map Prod.fst = items := by
  induction items generalizing rows with
  | nil => cases success; rfl
  | cons item items ih =>
    rw [returnRows] at success
    cases hf : returnCandidates table identity item with
    | error e => rw [hf] at success; cases success
    | ok found =>
      rw [hf] at success
      cases found with
      | nil => cases success
      | cons mate rest =>
        cases rest with
        | cons other tail => cases success
        | nil =>
          dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure] at success
          cases hr : returnRows table identity items with
          | error e => rw [hr] at success; cases success
          | ok later =>
            rw [hr] at success
            cases later with
            | none => cases success
            | some tail =>
              cases success
              exact congrArg (List.cons item) (ih tail hr)

theorem returnRowsEachUniqueSearch (table : OperationTable) (identity : String)
    (items : List String) (rows : List (String × String))
    (success : returnRows table identity items = .ok (some rows)) : ∀ row, row ∈ rows → returnCandidates table identity row.1 = .ok [row.2] := by
  induction items generalizing rows with
  | nil => cases success; intro row member; cases member
  | cons item items ih =>
    rw [returnRows] at success
    cases hf : returnCandidates table identity item with
    | error e => rw [hf] at success; cases success
    | ok found =>
      rw [hf] at success
      cases found with
      | nil => cases success
      | cons mate rest =>
        cases rest with
        | cons other tail => cases success
        | nil =>
          dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure] at success
          cases hr : returnRows table identity items with
          | error e => rw [hr] at success; cases success
          | ok later =>
            rw [hr] at success
            cases later with
            | none => cases success
            | some tail =>
              cases success
              intro row member
              cases member with
              | head => exact hf
              | tail _ m => exact ih tail hr row m

theorem noIdentityNoMates (table : OperationTable) (identity : String)
    (absent : hasIdentity table identity = .ok false) : returnMates table identity = .ok none := by
  unfold returnMates
  rw [absent]
  rfl

theorem commutationExhaustiveIff (table : OperationTable) :
    isCommutative table = .ok true ↔ ∀ a, a ∈ table.carrier → ∀ b, b ∈ table.carrier →
      commutationCell table a b = .ok true := by
  constructor
  · intro h a ha b hb
    exact (allCheckedTrueIff _ _).mp ((allCheckedTrueIff _ _).mp h a ha) b hb
  · intro h
    exact (allCheckedTrueIff _ _).mpr (fun a ha => (allCheckedTrueIff _ _).mpr (fun b hb => h a ha b hb))

theorem commutationCellExact (table : OperationTable) (a b left right : String)
    (hl : applyOperation table a b = .ok left) (hr : applyOperation table b a = .ok right) :
    commutationCell table a b = .ok true ↔ left = right := by
  unfold commutationCell
  rw [hl]
  dsimp only [Bind.bind, Except.bind]
  rw [hr]
  dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
  exact ⟨fun h => of_decide_eq_true (Except.ok.inj h),fun h => congrArg Except.ok (decide_eq_true h)⟩

end SFT.Mathematics.AlgebraOperations
