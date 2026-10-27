import SFT.Mathematics.AlgebraReturns
namespace SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

theorem returnRowsSuccessIff (table : OperationTable) (identity : String) (items : List String) :
    (∃ rows, returnRows table identity items = .ok (some rows)) ↔
      ∀ item, item ∈ items → ∃ mate, returnCandidates table identity item = .ok [mate] := by
  constructor
  · intro h item member
    obtain ⟨rows,success⟩ := h
    have projection := returnRowsPreserveCarrier table identity items rows success
    rw [← projection] at member
    obtain ⟨row,retained,eq⟩ := memMapPreimage Prod.fst item rows member
    refine ⟨row.2,?_⟩
    rw [← eq]
    exact returnRowsEachUniqueSearch table identity items rows success row retained
  · intro all
    induction items with
    | nil => exact ⟨[],rfl⟩
    | cons item items ih =>
      obtain ⟨mate,search⟩ := all item (List.Mem.head _)
      obtain ⟨later,success⟩ := ih (fun x h => all x (List.Mem.tail _ h))
      refine ⟨(item,mate)::later,?_⟩
      rw [returnRows,search]
      dsimp only [Bind.bind,Except.bind,Pure.pure,Except.pure]
      rw [success]
      rfl

theorem returnMatesSuccessfulParts (table : OperationTable) (identity : String)
    (rows : List (String × String)) (success : returnMates table identity = .ok (some rows)) :
    hasIdentity table identity = .ok true ∧ returnRows table identity table.carrier = .ok (some rows) := by
  unfold returnMates at success
  cases h : hasIdentity table identity with
  | error e => rw [h] at success; cases success
  | ok valid =>
    rw [h] at success
    cases valid with
    | false => cases success
    | true => exact ⟨rfl,success⟩

theorem returnMatesSuccessIff (table : OperationTable) (identity : String) :
    (∃ rows, returnMates table identity = .ok (some rows)) ↔
      hasIdentity table identity = .ok true ∧
      ∀ item, item ∈ table.carrier → ∃ mate, returnCandidates table identity item = .ok [mate] := by
  constructor
  · intro h
    obtain ⟨rows,success⟩ := h
    have parts := returnMatesSuccessfulParts table identity rows success
    exact ⟨parts.1,(returnRowsSuccessIff table identity table.carrier).mp ⟨rows,parts.2⟩⟩
  · intro h
    obtain ⟨rows,success⟩ := (returnRowsSuccessIff table identity table.carrier).mpr h.2
    refine ⟨rows,?_⟩
    unfold returnMates
    rw [h.1]
    exact success

theorem returnedMateUniqueMeaning (table : OperationTable) (identity : String)
    (rows : List (String × String)) (success : returnMates table identity = .ok (some rows)) :
    rows.map Prod.fst = table.carrier ∧ ∀ row, row ∈ rows →
      row.2 ∈ table.carrier ∧ applyOperation table row.1 row.2 = .ok identity ∧
      applyOperation table row.2 row.1 = .ok identity ∧
      ∀ other, other ∈ table.carrier → applyOperation table row.1 other = .ok identity →
        applyOperation table other row.1 = .ok identity → other = row.2 := by
  have parts := returnMatesSuccessfulParts table identity rows success
  refine ⟨returnRowsPreserveCarrier table identity table.carrier rows parts.2,?_⟩
  intro row member
  have search := returnRowsEachUniqueSearch table identity table.carrier rows parts.2 row member
  have semantics := returnCandidatesExact table identity row.1 [row.2] search
  have mate := (semantics row.2).mp (List.Mem.head _)
  refine ⟨mate.1,mate.2.1,mate.2.2,?_⟩
  intro other retained left right
  have single := (semantics other).mpr ⟨retained,left,right⟩
  cases single with
  | head => rfl
  | tail _ impossible => cases impossible

theorem acceptedCommutationMeaning (table : OperationTable)
    (accepted : makeTable table.carrier table.rows = .ok table) :
    isCommutative table = .ok true ↔
      ∀ a, a ∈ table.carrier → ∀ b, b ∈ table.carrier → ∀ left right,
        applyOperation table a b = .ok left → applyOperation table b a = .ok right → left = right := by
  constructor
  · intro passed a ha b hb left right hl hr
    exact (commutationCellExact table a b left right hl hr).mp
      ((commutationExhaustiveIff table).mp passed a ha b hb)
  · intro equation
    apply (commutationExhaustiveIff table).mpr
    intro a ha b hb
    obtain ⟨left,hl,_⟩ := acceptedLookupTotal _ _ table accepted a b ha hb
    obtain ⟨right,hr,_⟩ := acceptedLookupTotal _ _ table accepted b a hb ha
    exact (commutationCellExact table a b left right hl hr).mpr (equation a ha b hb left right hl hr)

end SFT.Mathematics.AlgebraOperations
