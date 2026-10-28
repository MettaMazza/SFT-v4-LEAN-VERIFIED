import SFT.Computation.ProofBoundary
namespace SFT.Computation.OracleTrace
open SFT.InformationScience.EncodingMaps
open SFT.Computation StateTransition StateComposition RecognitionTrace
open SFT.Foundation.Count.TraceDerivation

-- Typed correspondence for the source's named query alphabet and declared
-- answer relation. No single-valuedness or answer-producing oracle is assumed.
structure Interface where
  queries : List String
  relation : List (String × String)

structure AnswerRecord where
  identity : String
  query : String
  answer : String

def Registered (registry : List (String × Interface)) (record : AnswerRecord) : Prop :=
  ∃ interface, lookupFirst registry record.identity = some interface ∧
    record.query ∈ interface.queries ∧ (record.query,record.answer) ∈ interface.relation

-- An ordered finite nesting record; every level retains the named source.
inductive Ledger where
  | done
  | call (record : AnswerRecord) (nested rest : Ledger)

def records : Ledger → List AnswerRecord
  | .done => []
  | .call record nested rest => record :: (records nested ++ records rest)

inductive Valid (registry : List (String × Interface)) : Ledger → Prop where
  | done : Valid registry .done
  | call (record : AnswerRecord) (nested rest : Ledger) :
      Registered registry record → Valid registry nested → Valid registry rest →
      Valid registry (.call record nested rest)

theorem retainedSource (registry : List (String × Interface)) (ledger : Ledger)
    (valid : Valid registry ledger) (record : AnswerRecord) (held : record ∈ records ledger) :
    Registered registry record := by
  induction valid with
  | done => cases held
  | call entry nested rest registered left right ihLeft ihRight =>
    cases held with
    | head => exact registered
    | tail _ member =>
      cases memAppendCases record (records nested) (records rest) member with
      | inl nestedMember => exact ihLeft nestedMember
      | inr restMember => exact ihRight restMember

theorem undeclaredSourceExcluded (registry : List (String × Interface)) (ledger : Ledger)
    (record : AnswerRecord) (held : record ∈ records ledger)
    (absent : lookupFirst registry record.identity = none) : ¬ Valid registry ledger := by
  intro valid
  obtain ⟨interface,selected,query,answer⟩ := retainedSource _ _ valid _ held
  rw [absent] at selected
  cases selected

theorem undeclaredAnswerExcluded (registry : List (String × Interface)) (ledger : Ledger)
    (record : AnswerRecord) (held : record ∈ records ledger)
    (interface : Interface) (selected : lookupFirst registry record.identity = some interface)
    (absent : ¬ (record.query,record.answer) ∈ interface.relation) : ¬ Valid registry ledger := by
  intro valid
  obtain ⟨actual,lookup,query,answer⟩ := retainedSource _ _ valid _ held
  rw [selected] at lookup
  cases Option.some.inj lookup
  exact absent answer

def append : Ledger → Ledger → Ledger
  | .done, next => next
  | .call record nested rest, next => .call record nested (append rest next)

theorem recordsAppend (first second : Ledger) :
    records (append first second) = records first ++ records second := by
  induction first with
  | done => rfl
  | call record nested rest ihNested ihRest =>
    change record :: (records nested ++ records (append rest second)) = _
    rw [ihRest]
    change record :: (records nested ++ (records rest ++ records second)) =
      record :: ((records nested ++ records rest) ++ records second)
    rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative]

theorem validAppend (registry : List (String × Interface)) (first second : Ledger)
    (left : Valid registry first) (right : Valid registry second) :
    Valid registry (append first second) := by
  induction left with
  | done => exact right
  | call record nested rest registered nestedValid restValid ihNested ihRest =>
    exact .call _ _ _ registered nestedValid ihRest

theorem nestingBoundary (registry : List (String × Interface))
    (record : AnswerRecord) (nested rest : Ledger) :
    Valid registry (.call record nested rest) ↔
      Registered registry record ∧ Valid registry nested ∧ Valid registry rest := by
  constructor
  · intro valid
    cases valid with
    | call _ _ _ registered left right => exact ⟨registered,left,right⟩
  · intro valid
    exact .call _ _ _ valid.1 valid.2.1 valid.2.2

theorem retainedRegistry (old extended : List (String × Interface))
    (retained : ∀ name interface, lookupFirst old name = some interface →
      lookupFirst extended name = some interface)
    (ledger : Ledger) (valid : Valid old ledger) : Valid extended ledger := by
  induction valid with
  | done => exact .done
  | call record nested rest registered left right ihLeft ihRight =>
    obtain ⟨interface,selected,query,answer⟩ := registered
    exact .call _ _ _ ⟨interface,retained _ _ selected,query,answer⟩ ihLeft ihRight

-- The relative certificate retains the original base execution and the
-- complete declared external record, without turning that record into power.
def RelativeTrace (registry : List (String × Interface)) (ledger : Ledger)
    (system : System) (initial : String) (actions before : List String) (terminal : String) : Prop :=
  Valid registry ledger ∧ initial ∈ system.states ∧ Path system initial actions before terminal

theorem replay (registry : List (String × Interface)) (ledger : Ledger)
    (system : System) (initial : String) (actions before : List String) (terminal : String)
    (relative : RelativeTrace registry ledger system initial actions before terminal) :
    run system initial actions = .ok (before ++ [terminal]) ∧
      ∀ record, record ∈ records ledger → Registered registry record :=
  ⟨(runAdmission _ _ _ _).mpr ⟨relative.2.1,
      (runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ relative.2.2)⟩,
    fun record held => retainedSource _ _ relative.1 record held⟩

theorem relativeRecognition (registry : List (String × Interface)) (ledger : Ledger)
    (system : System) (initial : String) (actions before : List String) (terminal : String)
    (valid : Valid registry ledger) (decision : Decision system initial actions before terminal) :
    RelativeTrace registry ledger system initial actions before terminal ∧
      (terminal = "accept" ∨ terminal = "reject") :=
  ⟨⟨valid,decision.1.1,decision.1.2.1⟩,decision.2⟩

theorem identityBase (registry : List (String × Interface)) (system : System) (state : String)
    (held : state ∈ system.states) : RelativeTrace registry .done system state [] [] state :=
  ⟨.done,held,.identity state⟩

theorem relativeComposition (registry : List (String × Interface)) (first second : Ledger)
    (system : System) (initial middle terminal : String) (left right before after : List String)
    (prior : RelativeTrace registry first system initial left before middle)
    (later : RelativeTrace registry second system middle right after terminal) :
    RelativeTrace registry (append first second) system initial (left ++ right) (before ++ after) terminal :=
  ⟨validAppend _ _ _ prior.1 later.1,prior.2.1,
    pathSerial _ _ _ _ _ _ _ _ prior.2.2 later.2.2⟩
end SFT.Computation.OracleTrace
