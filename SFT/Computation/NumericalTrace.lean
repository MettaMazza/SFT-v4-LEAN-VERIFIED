import SFT.Computation.NumericalLedger
namespace SFT.Computation.NumericalTrace
open NumericalError NumericalLedger StateTransition StateComposition
open SFT.InformationScience.EncodingMaps

abbrev ValueTable := List (String × List Number)
abbrev Record := String × List Number × List NumericalError.Row

-- The numerical carrier of each retained generated state is resolved through
-- its exact registered table row; its error record uses the original kernel.
def records (table : ValueTable) (reference : List Number) : List String → Option (List Record)
 | [] => some []
 | state :: rest => match lookupFirst table state with
   | none => none
   | some approximation => match exactErrorLedger reference approximation with
     | .error _ => none
     | .ok ledger => match records table reference rest with
       | none => none
       | some suffix => some ((state,approximation,ledger) :: suffix)

inductive Records (table : ValueTable) (reference : List Number) : List String → List Record → Prop where
 | base : Records table reference [] []
 | next (state : String) (states : List String) (approximation : List Number) (ledger : List NumericalError.Row) (rest : List Record)
     (registered : lookupFirst table state = some approximation)
     (exact : exactErrorLedger reference approximation = .ok ledger)
     (tail : Records table reference states rest) :
     Records table reference (state :: states) ((state,approximation,ledger) :: rest)

theorem replay (table : ValueTable) (reference : List Number) (states : List String) (rows : List Record)
    (certificate : Records table reference states rows) : records table reference states = some rows := by
  induction certificate with
  | base => rfl
  | next state states approximation ledger rest registered exact tail ih =>
    unfold records; rw [registered]; dsimp only; rw [exact]; dsimp only; rw [ih]

theorem reconstruct (table : ValueTable) (reference : List Number) (states : List String) (rows : List Record)
    (accepted : records table reference states = some rows) : Records table reference states rows := by
  induction states generalizing rows with
  | nil => cases accepted; exact .base
  | cons state states ih =>
    unfold records at accepted
    cases registered : lookupFirst table state with
    | none => rw [registered] at accepted; cases accepted
    | some approximation =>
      rw [registered] at accepted
      dsimp only at accepted
      cases exact : exactErrorLedger reference approximation with
      | error reason => rw [exact] at accepted; cases accepted
      | ok ledger =>
        rw [exact] at accepted
        dsimp only at accepted
        cases suffix : records table reference states with
        | none => rw [suffix] at accepted; cases accepted
        | some rest => rw [suffix] at accepted; cases accepted; exact .next _ _ _ _ _ registered exact (ih _ suffix)

theorem correspondence (table : ValueTable) (reference : List Number) (states : List String) (rows : List Record) :
    records table reference states = some rows ↔ Records table reference states rows :=
  ⟨reconstruct _ _ _ _,replay _ _ _ _⟩

theorem identityTrace (table : ValueTable) (reference : List Number) (states : List String) (rows : List Record)
    (certificate : Records table reference states rows) : rows.map Prod.fst = states := by
  induction certificate with
  | base => rfl
  | next state states approximation ledger rest registered exact tail ih => exact congrArg (List.cons state) ih

theorem recordCount (table : ValueTable) (reference : List Number) (states : List String) (rows : List Record)
    (certificate : Records table reference states rows) : rows.length = states.length := by
  induction certificate with
  | base => rfl
  | next state states approximation ledger rest registered exact tail ih => exact congrArg Nat.succ ih

theorem eachRecord (table : ValueTable) (reference : List Number) (states : List String) (rows : List Record)
    (certificate : Records table reference states rows) :
    ∀ row, row ∈ rows → (row.1,row.2.1) ∈ table ∧ reference ≠ [] ∧ Rows 1 reference row.2.1 row.2.2 := by
  induction certificate with
  | base => intro row impossible; cases impossible
  | next state states approximation ledger rest registered exact tail ih =>
    intro row member
    cases member with
    | head => exact ⟨lookupRow _ _ _ registered,(exactAdmission _ _ _).mp exact⟩
    | tail _ member => exact ih row member

theorem composition (table : ValueTable) (reference : List Number) (left right : List String) (a b : List Record)
    (first : Records table reference left a) (second : Records table reference right b) :
    Records table reference (left++right) (a++b) := by
  induction first with
  | base => exact second
  | next state states approximation ledger rest registered exact tail ih =>
    exact .next _ _ _ _ _ registered exact ih

theorem nativeUpdateTrace (table : ValueTable) (reference : List Number) (system : System)
    (initial : String) (actions states : List String) (rows : List Record)
    (execution : run system initial actions = .ok states)
    (observation : records table reference states = some rows) :
    initial ∈ system.states ∧ (∃ before terminal, states = before++[terminal] ∧ Path system initial actions before terminal) ∧
      Records table reference states rows ∧ rows.map Prod.fst = states := by
  have trace := nativePath _ _ _ _ execution
  have retained := reconstruct _ _ _ _ observation
  exact ⟨trace.1,trace.2,retained,identityTrace _ _ _ _ retained⟩

theorem missingStateRejects (table : ValueTable) (reference : List Number) (state : String) (rest : List String)
    (missing : lookupFirst table state = none) : records table reference (state::rest) = none := by
  unfold records; rw [missing]

theorem invalidLedgerRejects (table : ValueTable) (reference approximation : List Number)
    (state : String) (rest : List String) (reason : String)
    (registered : lookupFirst table state = some approximation)
    (invalid : exactErrorLedger reference approximation = .error reason) : records table reference (state::rest) = none := by
  unfold records; rw [registered]; dsimp only; rw [invalid]


theorem successorRecord (table : ValueTable) (reference : List Number) (states : List String) (rows : List Record)
    (retained : Records table reference states rows) (next : String) (approximation : List Number) (ledger : List NumericalError.Row)
    (registered : lookupFirst table next = some approximation)
    (exact : exactErrorLedger reference approximation = .ok ledger) :
    Records table reference (states++[next]) (rows++[(next,approximation,ledger)]) :=
  composition _ _ _ _ _ _ retained (.next _ _ _ _ _ registered exact .base)

theorem nativeCount (table : ValueTable) (reference : List Number) (system : System)
    (initial : String) (actions states : List String) (rows : List Record)
    (execution : run system initial actions = .ok states)
    (observation : records table reference states = some rows) : rows.length = actions.length+1 := by
  have accepted := (runAdmission _ _ _ _).mp execution
  have path := (runFromMeaning _ _ _ _).mp accepted.2
  exact (recordCount _ _ _ _ (reconstruct _ _ _ _ observation)).trans (executionLength _ _ _ _ path)

theorem updateSuccessor (table : ValueTable) (reference : List Number) (system : System)
    (initial terminal next : String) (actions before : List String) (rows : List Record)
    (held : initial ∈ system.states) (path : Path system initial actions before terminal)
    (retained : Records table reference (before++[terminal]) rows)
    (action : String) (edge : step system terminal action = .ok next)
    (approximation : List Number) (ledger : List NumericalError.Row)
    (registered : lookupFirst table next = some approximation)
    (exact : exactErrorLedger reference approximation = .ok ledger) :
    run system initial (actions++[action]) = .ok ((before++[terminal])++[next]) ∧
      records table reference ((before++[terminal])++[next]) = some (rows++[(next,approximation,ledger)]) := by
  constructor
  · exact (runAdmission _ _ _ _).mpr ⟨held,successorTrace _ _ _ _ _ _ path action edge⟩
  · exact replay _ _ _ _ (successorRecord _ _ _ _ retained _ _ _ registered exact)

end SFT.Computation.NumericalTrace
