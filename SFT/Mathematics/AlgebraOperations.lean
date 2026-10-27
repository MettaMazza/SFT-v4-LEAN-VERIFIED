import SFT.Mathematics.DiscreteComplement
namespace SFT.Mathematics.AlgebraOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

structure OperationTable where
  carrier : List String
  rows : List (String × String × String)

def pairSupport (carrier : List String) : List (String × String) :=
  carrier.flatMap (fun left => carrier.map (fun right => (left,right)))

def rowInputs (rows : List (String × String × String)) : List (String × String) :=
  rows.map (fun row => (row.1,row.2.1))

def sameSupport (left right : List (String × String)) : Bool :=
  left.all (fun pair => has right pair) && right.all (fun pair => has left pair)

def makeTable (carrier : List String) (rows : List (String × String × String)) : Except String OperationTable :=
  if carrier.isEmpty || !distinct carrier then
    .error "ValueError: an operation requires a nonempty canonical carrier"
  else if !(decide (rows.length = (pairSupport carrier).length)) || !sameSupport (rowInputs rows) (pairSupport carrier) then
    .error "ValueError: the table must assign every generated input pair exactly once"
  else if rows.any (fun row => !has carrier row.2.2) then
    .error "ValueError: operation closure forbids results outside the carrier"
  else .ok ⟨carrier,rows⟩

def matchingResults (table : OperationTable) (left right : String) : List String :=
  (table.rows.filter (fun row => decide (row.1 = left) && decide (row.2.1 = right))).map (fun row => row.2.2)

def applyOperation (table : OperationTable) (left right : String) : Except String String :=
  match matchingResults table left right with
  | [] => .error "ValueError: operation input is outside the complete table"
  | result::[] => .ok result
  | _::_::_ => .error "ValueError: operation input is outside the complete table"

theorem allTrueAtMember {α : Type} (p : α → Bool) (xs : List α)
    (all : xs.all p = true) (x : α) (member : x ∈ xs) : p x = true := by
  induction xs with
  | nil => cases member
  | cons a xs ih =>
    change (p a && xs.all p) = true at all
    have parts : p a = true ∧ xs.all p = true := by
      cases ha : p a <;> cases hs : xs.all p <;> rw [ha,hs] at all
      all_goals try cases all
      exact ⟨rfl,rfl⟩
    cases member with
    | head => exact parts.1
    | tail _ m => exact ih parts.2 m

theorem sameSupportMembership (left right : List (String × String))
    (same : sameSupport left right = true) (pair : String × String) :
    pair ∈ left ↔ pair ∈ right := by
  have parts : left.all (fun pair => has right pair) = true ∧ right.all (fun pair => has left pair) = true := by
    unfold sameSupport at same
    cases hl : left.all (fun pair => has right pair) <;> cases hr : right.all (fun pair => has left pair) <;> rw [hl,hr] at same
    all_goals try cases same
    exact ⟨rfl,rfl⟩
  exact ⟨fun m => (hasIff right pair).mp (allTrueAtMember _ _ parts.1 pair m),
    fun m => (hasIff left pair).mp (allTrueAtMember _ _ parts.2 pair m)⟩

theorem tableAcceptedData (carrier : List String) (rows : List (String × String × String))
    (result : OperationTable) (accepted : makeTable carrier rows = .ok result) :
    result = ⟨carrier,rows⟩ ∧ carrier.isEmpty = false ∧ distinct carrier = true ∧
      rows.length = (pairSupport carrier).length ∧
      sameSupport (rowInputs rows) (pairSupport carrier) = true ∧
      rows.any (fun row => !has carrier row.2.2) = false := by
  unfold makeTable at accepted
  cases empty : carrier.isEmpty <;> cases unique : distinct carrier <;> rw [empty,unique] at accepted
  all_goals try cases accepted
  cases size : decide (rows.length = (pairSupport carrier).length) <;>
    cases support : sameSupport (rowInputs rows) (pairSupport carrier) <;> rw [size,support] at accepted
  all_goals try cases accepted
  cases closed : rows.any (fun row => !has carrier row.2.2) <;> rw [closed] at accepted
  · cases accepted
    exact ⟨rfl,rfl,rfl,of_decide_eq_true size,rfl,rfl⟩
  · cases accepted

theorem acceptedTableClosed (carrier : List String) (rows : List (String × String × String))
    (table : OperationTable) (accepted : makeTable carrier rows = .ok table)
    (row : String × String × String) (member : row ∈ rows) : row.2.2 ∈ carrier := by
  have data := tableAcceptedData carrier rows table accepted
  have checked := anyFalseAtMember _ _ data.2.2.2.2.2 row member
  apply (hasIff carrier row.2.2).mp
  cases h : has carrier row.2.2 with
  | false => rw [h] at checked; cases checked
  | true => rfl

theorem acceptedInputCoverage (carrier : List String) (rows : List (String × String × String))
    (table : OperationTable) (accepted : makeTable carrier rows = .ok table) (pair : String × String) :
    pair ∈ rowInputs rows ↔ pair ∈ pairSupport carrier :=
  sameSupportMembership _ _ (tableAcceptedData carrier rows table accepted).2.2.2.2.1 pair

theorem emptyCarrierRejected (rows : List (String × String × String)) :
    makeTable [] rows = .error "ValueError: an operation requires a nonempty canonical carrier" := rfl

theorem singleMatchApplied (table : OperationTable) (left right result : String)
    (matched : matchingResults table left right = [result]) : applyOperation table left right = .ok result := by
  unfold applyOperation
  rw [matched]

theorem noMatchRejected (table : OperationTable) (left right : String)
    (matched : matchingResults table left right = []) : applyOperation table left right =
      .error "ValueError: operation input is outside the complete table" := by
  unfold applyOperation
  rw [matched]

end SFT.Mathematics.AlgebraOperations
