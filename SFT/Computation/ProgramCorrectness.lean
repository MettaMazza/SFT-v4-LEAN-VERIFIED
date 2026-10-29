import SFT.Computation.TerminationDescent
import SFT.Computation.ProgramEquivalence
namespace SFT.Computation.ProgramCorrectness
open SymbolicEvaluation EvaluationTrace
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects

inductive Mode where | partialMode | totalMode
structure Specification where
  mode : Mode
  precondition : Environment → Bool
  postcondition : Environment → (Result × List Event) → Bool

-- The specification and finite support are retained inputs, never inferred
-- from the observed result.
def Partial (support : List Environment) (spec : Specification) (program : Expr) : Prop :=
  ∀ env, env ∈ support → spec.precondition env = true →
    ∀ result rows, Execution env program result rows → spec.postcondition env (result,rows) = true

def Total (support : List Environment) (spec : Specification) (program : Expr) : Prop :=
  Partial support spec program ∧ ∀ env, env ∈ support → spec.precondition env = true →
    ∃ result rows, Execution env program result rows

def Correct (support : List Environment) (spec : Specification) (program : Expr) : Prop :=
  match spec.mode with
  | .partialMode => Partial support spec program
  | .totalMode => Total support spec program

def certificate (support : List Environment) (spec : Specification) (program : Expr) : Bool :=
  match support with
  | [] => true
  | env::rest => (if spec.precondition env then spec.postcondition env (run env program) else true) &&
      certificate rest spec program

theorem certificateSound (support : List Environment) (spec : Specification) (program : Expr)
    (passed : certificate support spec program = true) : Partial support spec program := by
  induction support with
  | nil => intro env present; cases present
  | cons env rest ih =>
    have parts := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp passed
    intro input present admitted result rows proof
    cases present with
    | head =>
      have h := parts.1
      rw [admitted] at h
      have same := EvaluationTrace.replay _ _ _ _ proof
      rw [same] at h
      exact h
    | tail _ member => exact ih parts.2 input member admitted result rows proof

theorem certificateComplete (support : List Environment) (spec : Specification) (program : Expr)
    (correct : Partial support spec program) : certificate support spec program = true := by
  induction support with
  | nil => rfl
  | cons env rest ih =>
    have tail := ih (fun input member => correct input (List.Mem.tail _ member))
    unfold certificate
    rw [tail]
    cases pre : spec.precondition env with
    | false => rfl
    | true =>
      have h := correct env (List.Mem.head _) pre _ _ (EvaluationTrace.reconstruct env program)
      change spec.postcondition env (run env program) = true at h
      rw [h]; rfl

theorem terminationCoverage (support : List Environment) (spec : Specification) (program : Expr)
    (correct : Partial support spec program) : Total support spec program :=
  ⟨correct,fun env _ _ => ⟨_,_,EvaluationTrace.reconstruct env program⟩⟩

theorem exactCertificate (support : List Environment) (spec : Specification) (program : Expr) :
    certificate support spec program = true ↔ Correct support spec program := by
  cases mode : spec.mode with
  | partialMode =>
    unfold Correct; rw [mode]
    exact ⟨certificateSound _ _ _,certificateComplete _ _ _⟩
  | totalMode =>
    unfold Correct; rw [mode]
    exact ⟨fun h => terminationCoverage _ _ _ (certificateSound _ _ _ h),fun h => certificateComplete _ _ _ h.1⟩

structure Row where
  input : Environment
  execution : Result × List Event
  required : Bool
  postcondition : Bool
  declaration : Mode

def record (spec : Specification) (program : Expr) (env : Environment) : Row :=
  ⟨env,run env program,spec.precondition env,spec.postcondition env (run env program),spec.mode⟩
def ledger (support : List Environment) (spec : Specification) (program : Expr) : List Row :=
  support.map (record spec program)
def isFailure (row : Row) : Bool := match row.execution.1 with
 | .error _ => true
 | .ok _ => false
def failures (rows : List Row) : List Row := rows.filter isFailure

theorem completeRecord (support : List Environment) (spec : Specification) (program : Expr)
    (row : Row) (held : row ∈ ledger support spec program) :
    row.input ∈ support ∧ Execution row.input program row.execution.1 row.execution.2 ∧
    row.required = spec.precondition row.input ∧
    row.postcondition = spec.postcondition row.input row.execution ∧ row.declaration = spec.mode := by
  obtain ⟨env,present,same⟩ := memMapPreimage (record spec program) row support held
  cases same
  exact ⟨present,EvaluationTrace.reconstruct env program,rfl,rfl,rfl⟩

theorem everyInputRetained (support : List Environment) (spec : Specification) (program : Expr)
    (env : Environment) (present : env ∈ support) : record spec program env ∈ ledger support spec program :=
  memMap _ _ _ present

theorem failureMeaning (rows : List Row) (row : Row) :
    row ∈ failures rows ↔ row ∈ rows ∧ ∃ reason, row.execution.1 = .error reason := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    refine ⟨p.1,?_⟩
    cases outcome : row.execution.1 with
    | error reason => exact ⟨reason,rfl⟩
    | ok value => unfold isFailure at p; rw [outcome] at p; cases p.2
  · intro ⟨present,reason,outcome⟩
    apply (filterMemberIff _ _ _).mpr
    refine ⟨present,?_⟩
    unfold isFailure; rw [outcome]

theorem failedCertificate (support : List Environment) (spec : Specification) (program : Expr)
    (failed : certificate support spec program = false) :
    ∃ env, env ∈ support ∧ spec.precondition env = true ∧ spec.postcondition env (run env program) = false := by
  induction support with
  | nil => cases failed
  | cons env rest ih =>
    unfold certificate at failed
    cases pre : spec.precondition env with
    | false =>
      rw [pre] at failed
      obtain ⟨input,present,admitted,rejected⟩ := ih failed
      exact ⟨input,List.Mem.tail _ present,admitted,rejected⟩
    | true =>
      rw [pre] at failed
      cases post : spec.postcondition env (run env program) with
      | false => exact ⟨env,List.Mem.head _,pre,post⟩
      | true =>
        rw [post] at failed
        obtain ⟨input,present,admitted,rejected⟩ := ih failed
        exact ⟨input,List.Mem.tail _ present,admitted,rejected⟩

theorem acceptedRows (support : List Environment) (spec : Specification) (program : Expr)
    (passed : certificate support spec program = true) (row : Row)
    (held : row ∈ ledger support spec program) (required : row.required = true) : row.postcondition = true := by
  have h := completeRecord _ _ _ _ held
  rw [h.2.2.2.1]
  exact certificateSound _ _ _ passed row.input h.1 (h.2.2.1.symm.trans required) _ _ h.2.1

theorem supportAssembly (first second : List Environment) (spec : Specification) (program : Expr)
    (left : Partial first spec program) (right : Partial second spec program) : Partial (first ++ second) spec program := by
  intro env present
  cases memAppendCases _ _ _ present with
  | inl h => exact left env h
  | inr h => exact right env h

theorem supportRestriction (first second : List Environment) (spec : Specification) (program : Expr)
    (correct : Partial (first ++ second) spec program) : Partial first spec program :=
  fun env h => correct env (memAppendLeft _ _ _ h)

theorem ledgerAssembly (first second : List Environment) (spec : Specification) (program : Expr) :
    ledger (first ++ second) spec program = ledger first spec program ++ ledger second spec program :=
  SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem earlierRowRetained (first second : List Environment) (spec : Specification) (program : Expr)
    (row : Row) (held : row ∈ ledger first spec program) : row ∈ ledger (first ++ second) spec program := by
  rw [ledgerAssembly]
  exact memAppendLeft _ _ _ held

-- Specification consequences retain the exact input and complete execution.
theorem consequence (support : List Environment) (old fresh : Specification) (program : Expr)
    (correct : Partial support old program)
    (pre : ∀ env, env ∈ support → fresh.precondition env = true → old.precondition env = true)
    (post : ∀ env result rows, Execution env program result rows → old.postcondition env (result,rows) = true →
      fresh.postcondition env (result,rows) = true) : Partial support fresh program :=
  fun env held required result rows execution =>
    post env result rows execution (correct env held (pre env held required) result rows execution)

open StateTransition StateComposition

def PathAgreement (system : System) (pre post : String → Prop) : Prop :=
  ∀ initial terminal actions before, pre initial → Path system initial actions before terminal → post terminal

theorem serialAgreement (system : System) (pre middle post : String → Prop)
    (first : PathAgreement system pre middle) (second : PathAgreement system middle post)
    (initial intermediate terminal : String) (left right before after : List String)
    (required : pre initial) (a : Path system initial left before intermediate)
    (b : Path system intermediate right after terminal) :
    post terminal ∧ Path system initial (left ++ right) (before ++ after) terminal :=
  ⟨second _ _ _ _ (first _ _ _ _ required a) b,pathSerial _ _ _ _ _ _ _ _ a b⟩

end SFT.Computation.ProgramCorrectness
