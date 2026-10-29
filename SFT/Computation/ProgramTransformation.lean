import SFT.Computation.FormalSpecification
import SFT.Computation.SymbolicContext
import SFT.Computation.ResourceRecord
namespace SFT.Computation.ProgramTransformation
open SymbolicEvaluation SymbolicContext
open SFT.Foundation.Count.TraceDerivation

-- Rule identities and both syntactic sides are retained, not inferred from an output.
structure Rule where
  identity : String
  source : Expr
  target : Expr

structure Row where
  rule : Rule
  context : Context

def source (row : Row) : Expr := plug row.context row.rule.source
def target (row : Row) : Expr := plug row.context row.rule.target

def Admitted (rules : List Rule) (support : List Environment) (row : Row) : Prop :=
  row.rule ∈ rules ∧ GeneratedContext row.context ∧ Generated row.rule.source ∧
  Generated row.rule.target ∧ ∀ env, env ∈ support → SameValue env row.rule.source row.rule.target

theorem syntaxPreserved (rules : List Rule) (support : List Environment) (row : Row)
    (held : Admitted rules support row) : Generated (source row) ∧ Generated (target row) :=
  ⟨plugGenerated _ _ held.2.1 held.2.2.1,plugGenerated _ _ held.2.1 held.2.2.2.1⟩

theorem heldSource (row : Row) : focus (source row) (address row.context) = some row.rule.source :=
  heldOccurrence _ _

theorem heldTarget (row : Row) : focus (target row) (address row.context) = some row.rule.target :=
  heldOccurrence _ _

theorem stepCorrespondence (rules : List Rule) (support : List Environment) (row : Row)
    (held : Admitted rules support row) (env : Environment) (input : env ∈ support) :
    SameValue env (source row) (target row) :=
  contextualEquivalence _ _ _ _ (held.2.2.2.2 env input)

inductive Trace (rules : List Rule) (support : List Environment) : Expr → List Row → Expr → Prop where
 | identity (e : Expr) (generated : Generated e) : Trace rules support e [] e
 | next (row : Row) (rest : List Row) (terminal : Expr)
     (held : Admitted rules support row) (tail : Trace rules support (target row) rest terminal) :
     Trace rules support (source row) (row :: rest) terminal

theorem correspondence (rules : List Rule) (support : List Environment)
    (initial terminal : Expr) (rows : List Row) (trace : Trace rules support initial rows terminal)
    (env : Environment) (input : env ∈ support) : SameValue env initial terminal := by
  induction trace with
  | identity e generated => exact sameIdentity _ _
  | next row rest terminal held tail ih =>
    exact sameComposition _ _ _ _ (stepCorrespondence _ _ _ held env input) ih

theorem serial (rules : List Rule) (support : List Environment)
    (initial middle terminal : Expr) (left right : List Row)
    (a : Trace rules support initial left middle) (b : Trace rules support middle right terminal) :
    Trace rules support initial (left ++ right) terminal := by
  induction a with
  | identity e generated => exact b
  | next row rest terminal held tail ih => exact .next _ _ _ held (ih b)

theorem everyRuleRetained (rules : List Rule) (support : List Environment)
    (initial terminal : Expr) (rows : List Row) (trace : Trace rules support initial rows terminal) :
    ∀ row, row ∈ rows → Admitted rules support row := by
  induction trace with
  | identity e generated => intro row member; cases member
  | next row rest terminal held tail ih =>
    intro selected member
    cases member with
    | head => exact held
    | tail _ h => exact ih selected h

theorem endpointSyntax (rules : List Rule) (support : List Environment)
    (initial terminal : Expr) (rows : List Row) (trace : Trace rules support initial rows terminal) :
    Generated initial ∧ Generated terminal := by
  induction trace with
  | identity e generated => exact ⟨generated,generated⟩
  | next row rest terminal held tail ih => exact ⟨(syntaxPreserved _ _ _ held).1,ih.2⟩

-- Successful source evaluation reconstructs the exact target execution, including every event.
theorem executionCorrespondence (rules : List Rule) (support : List Environment)
    (initial terminal : Expr) (rows : List Row) (trace : Trace rules support initial rows terminal)
    (env : Environment) (input : env ∈ support) (value : NumericalError.Number)
    (evaluated : evaluate env initial = .ok value) :
    ∃ events, EvaluationTrace.Execution env terminal (.ok value) events := by
  have output := (correspondence _ _ _ _ _ trace env input value).mp evaluated
  have native := EvaluationTrace.reconstruct env terminal
  have result := EvaluationTrace.resultCorrespondence env terminal
  rw [output] at result
  rw [result] at native
  exact ⟨_,native⟩

-- The retained row has a reverse traversal even when syntax alone is not invertible.
inductive Reverse : Expr → List Row → Expr → Prop where
 | identity (e : Expr) : Reverse e [] e
 | previous (row : Row) (rest : List Row) (initial : Expr)
     (prior : Reverse (source row) rest initial) : Reverse (target row) (row :: rest) initial

theorem reverseSerial (initial middle terminal : Expr) (left right : List Row)
    (a : Reverse initial left middle) (b : Reverse middle right terminal) :
    Reverse initial (left ++ right) terminal := by
  induction a with
  | identity => exact b
  | previous row rest initial prior ih => exact .previous _ _ _ (ih b)

theorem retainedInverse (rules : List Rule) (support : List Environment)
    (initial terminal : Expr) (rows : List Row) (trace : Trace rules support initial rows terminal) :
    ∃ reversed, Reverse terminal reversed initial := by
  induction trace with
  | identity e generated => exact ⟨[],.identity e⟩
  | next row rest terminal held tail ih =>
    obtain ⟨reversed,prior⟩ := ih
    exact ⟨reversed ++ [row],reverseSerial _ _ _ _ _ prior (.previous row [] _ (.identity _))⟩

theorem erasedPredecessor (left right output : Expr) (different : left ≠ right) :
    ¬ ∃ recover : Expr → Expr, recover output = left ∧ recover output = right := by
  intro ⟨recover,first,second⟩
  exact different (first.symm.trans second)

-- Resource evidence remains the original separate resource_ledger operation.
def ruleTrace (initialIdentity : String) (rows : List Row) : List String :=
  initialIdentity :: rows.map (fun row => row.rule.identity)

theorem ruleTraceLength (initialIdentity : String) (rows : List Row) :
    (ruleTrace initialIdentity rows).length = rows.length + 1 := by
  have h : (rows.map (fun row => row.rule.identity)).length = rows.length := by
    induction rows with
    | nil => rfl
    | cons row rest ih => exact congrArg Nat.succ ih
  exact congrArg Nat.succ h

theorem resourcesRetained (initialIdentity : String) (rows : List Row) (occupied : List String)
    (ledger : ResourceRecord.Ledger)
    (recorded : ResourceRecord.resourceLedger (ruleTrace initialIdentity rows) occupied = .ok ledger) :
    ledger.timeTrace.map Prod.snd = ruleTrace initialIdentity rows ∧ ledger.spaceSupport = occupied ∧
      ledger.timeCount = rows.length + 1 ∧ ledger.spaceCount = occupied.length := by
  have h := ResourceRecord.recordReconstructs _ _ _ recorded
  exact ⟨h.1,h.2.1,h.2.2.1.trans (ruleTraceLength _ _),h.2.2.2⟩

theorem earlierStepRetained (left right : List Row) (row : Row) (held : row ∈ left) :
    row ∈ left ++ right := memAppendLeft _ _ _ held

end SFT.Computation.ProgramTransformation
