import SFT.Computation.SecurityDefinition
import SFT.Computation.StateTransition
namespace SFT.Computation.PostQuantumBoundary
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

inductive Capability where
  | classical | quantumInterface
  deriving DecidableEq
structure Oracle where
  identity : String
  capability : Capability
  deriving DecidableEq
structure Query where
  oracle : Oracle
  input : String
  response : String
  cost : Nat
  deriving DecidableEq
structure Model where
  scheme : StateTransition.System
  interface : List Oracle
  queryRows : List Query
  queryLimit : Nat
  resourceLimit : Nat
  reductionDependencies : List String

def admitted (m : Model) (q : Query) : Bool := has m.interface q.oracle && has m.queryRows q
def queryCost : List Query → Nat
  | [] => 0
  | q::qs => q.cost + queryCost qs

def ledgerAdmitted (m : Model) (queries : List Query) : Bool :=
  queries.all (admitted m) && decide (queries.length ≤ m.queryLimit) && decide (queryCost queries ≤ m.resourceLimit)

theorem queryMeaning (m : Model) (q : Query) : admitted m q = true ↔ q.oracle ∈ m.interface ∧ q ∈ m.queryRows := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; exact ⟨(hasIff _ _).mp p.1,(hasIff _ _).mp p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(hasIff _ _).mpr h.1,(hasIff _ _).mpr h.2⟩

theorem ledgerMeaning (m : Model) (queries : List Query) : ledgerAdmitted m queries = true ↔
    (∀ q, q ∈ queries → q.oracle ∈ m.interface ∧ q ∈ m.queryRows) ∧
    queries.length ≤ m.queryLimit ∧ queryCost queries ≤ m.resourceLimit := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; have q := (andTrue _ _).mp p.1
    exact ⟨fun x held => (queryMeaning _ _).mp (allTrueAtMember _ _ q.1 x held),of_decide_eq_true q.2,of_decide_eq_true p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(allTrueIffMembers _ _).mpr (fun q held => (queryMeaning _ _).mpr (h.1 q held)),decide_eq_true h.2.1⟩,decide_eq_true h.2.2⟩

def classical (queries : List Query) : Bool := queries.all (fun q => decide (q.oracle.capability = .classical))
structure DeclaredLedger (m : Model) where
  queries : List Query
  admitted : ledgerAdmitted m queries = true
structure ClassicalLedger (m : Model) extends DeclaredLedger m where
  operational : classical queries = true

theorem classicalOnly (m : Model) (ledger : ClassicalLedger m) (q : Query) (held : q ∈ ledger.queries) : q.oracle.capability = .classical :=
  of_decide_eq_true (allTrueAtMember _ _ ledger.operational q held)

theorem declaredQuantumNotClassical (m : Model) (ledger : ClassicalLedger m) (q : Query)
    (held : q ∈ ledger.queries) (quantum : q.oracle.capability = .quantumInterface) : False := by
  have h := classicalOnly m ledger q held
  rw [quantum] at h; cases h

structure ClassicalExecution (m : Model) where
  ledger : ClassicalLedger m
  initial : String
  actions : List String
  trace : List String
  run : StateTransition.run m.scheme initial actions = .ok trace

theorem classicalTrace (m : Model) (e : ClassicalExecution m) :
    StateTransition.Execution m.scheme e.initial e.actions e.trace :=
  (StateTransition.runFromMeaning _ _ _ _).mp ((StateTransition.runAdmission _ _ _ _).mp e.run).2

def unmetDependencies (m : Model) (available : List String) : List String :=
  m.reductionDependencies.filter (fun d => !has available d)

theorem missingDependencyMeaning (m : Model) (available : List String) (d : String) : d ∈ unmetDependencies m available ↔
    d ∈ m.reductionDependencies ∧ d ∉ available := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    refine ⟨p.1,?_⟩; intro yes; have no := (notTrue _).mp p.2
    rw [(hasIff _ _).mpr yes] at no; cases no
  · intro h
    have no : has available d = false := by
      cases test : has available d with
      | false => rfl
      | true => exact False.elim (h.2 ((hasIff _ _).mp test))
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(notTrue _).mpr no⟩

structure Migration (first second : Model) : Prop where
  interface : ∀ x, x ∈ first.interface → x ∈ second.interface
  queries : ∀ x, x ∈ first.queryRows → x ∈ second.queryRows
  queryLimit : first.queryLimit ≤ second.queryLimit
  resourceLimit : first.resourceLimit ≤ second.resourceLimit
  dependencies : ∀ x, x ∈ first.reductionDependencies → x ∈ second.reductionDependencies
  runs : ∀ initial actions trace, StateTransition.run first.scheme initial actions = .ok trace → StateTransition.run second.scheme initial actions = .ok trace

theorem ledgerMigration (first second : Model) (inc : Migration first second) (queries : List Query)
    (h : ledgerAdmitted first queries = true) : ledgerAdmitted second queries = true := by
  have p := (ledgerMeaning _ _).mp h
  exact (ledgerMeaning _ _).mpr ⟨fun q held => ⟨inc.interface _ (p.1 q held).1,inc.queries _ (p.1 q held).2⟩,
    Nat.le_trans p.2.1 inc.queryLimit,Nat.le_trans p.2.2 inc.resourceLimit⟩

def migrateClassical (first second : Model) (inc : Migration first second) (e : ClassicalExecution first) : ClassicalExecution second :=
  ⟨⟨⟨e.ledger.queries,ledgerMigration _ _ inc _ e.ledger.admitted⟩,e.ledger.operational⟩,e.initial,e.actions,e.trace,inc.runs _ _ _ e.run⟩

theorem migrationRetainsQueries (first second : Model) (inc : Migration first second) (e : ClassicalExecution first) :
    (migrateClassical _ _ inc e).ledger.queries = e.ledger.queries := rfl

structure ReductionUse (m : Model) (first second : SecurityDefinition.Model) where
  available : List String
  dependencies : ∀ d, d ∈ m.reductionDependencies → d ∈ available
  certificate : SecurityDefinition.Reduction first second

theorem dependencyComplete (m : Model) (first second : SecurityDefinition.Model) (use : ReductionUse m first second) (d : String) :
    d ∉ unmetDependencies m use.available := by
  intro h; have p := (missingDependencyMeaning _ _ _).mp h
  exact p.2 (use.dependencies d p.1)

theorem certifiedBoundedTransfer (m : Model) (first second : SecurityDefinition.Model) (use : ReductionUse m first second)
    (budget : Nat) (checked : SecurityDefinition.boundedFail second budget = true) :
    SecurityDefinition.boundedFail first budget = true :=
  SecurityDefinition.reductionBoundedFailure _ _ use.certificate budget checked

end SFT.Computation.PostQuantumBoundary
