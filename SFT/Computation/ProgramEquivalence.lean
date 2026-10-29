import SFT.Computation.MeaningCorrespondence
import SFT.InformationScience.ConservationLedger
namespace SFT.Computation.ProgramEquivalence
open SymbolicEvaluation EvaluationTrace
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects

-- The observation is a frozen input interface; it does not select the law.
abbrev Observation := Result × List Event → String
structure Row where
  input : Environment
  left : Result × List Event
  right : Result × List Event
  leftObservation : String
  rightObservation : String

def record (observe : Observation) (left right : Expr) (env : Environment) : Row :=
  ⟨env,run env left,run env right,observe (run env left),observe (run env right)⟩
def ledger (support : List Environment) (observe : Observation) (left right : Expr) : List Row :=
  support.map (record observe left right)
def retained (rows : List Row) : List Row := rows.filter (fun row => decide (row.leftObservation ≠ row.rightObservation))
def closed (rows : List Row) : List Row := rows.filter (fun row => decide (row.leftObservation = row.rightObservation))

def Equivalent (support : List Environment) (observe : Observation) (left right : Expr) : Prop :=
  ∀ env, env ∈ support → observe (run env left) = observe (run env right)

def certificate (support : List Environment) (observe : Observation) (left right : Expr) : Bool :=
  match support with
  | [] => true
  | env :: rest => decide (observe (run env left) = observe (run env right)) && certificate rest observe left right

theorem certificateSound (support : List Environment) (observe : Observation) (left right : Expr)
    (passed : certificate support observe left right = true) : Equivalent support observe left right := by
  induction support with
  | nil => intro env present; cases present
  | cons env rest ih =>
    have p := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp passed
    intro input present
    cases present with
    | head => exact of_decide_eq_true p.1
    | tail _ h => exact ih p.2 input h

theorem certificateComplete (support : List Environment) (observe : Observation) (left right : Expr)
    (same : Equivalent support observe left right) : certificate support observe left right = true := by
  induction support with
  | nil => rfl
  | cons env rest ih =>
    have h := decide_eq_true (same env (List.Mem.head _))
    have t := ih (fun input present => same input (List.Mem.tail _ present))
    change (decide (observe (run env left) = observe (run env right)) && certificate rest observe left right) = true
    rw [h,t]; rfl

theorem exactCertificate (support : List Environment) (observe : Observation) (left right : Expr) :
    certificate support observe left right = true ↔ Equivalent support observe left right :=
  ⟨certificateSound _ _ _ _,certificateComplete _ _ _ _⟩

theorem inputRecord (support : List Environment) (observe : Observation) (left right : Expr)
    (env : Environment) (present : env ∈ support) : record observe left right env ∈ ledger support observe left right :=
  memMap _ _ _ present

theorem recordInput (support : List Environment) (observe : Observation) (left right : Expr)
    (row : Row) (present : row ∈ ledger support observe left right) :
    ∃ env, env ∈ support ∧ record observe left right env = row :=
  memMapPreimage _ _ _ present

theorem completeExecutions (support : List Environment) (observe : Observation) (left right : Expr)
    (row : Row) (present : row ∈ ledger support observe left right) :
    Execution row.input left row.left.1 row.left.2 ∧ Execution row.input right row.right.1 row.right.2 ∧
    row.leftObservation = observe row.left ∧ row.rightObservation = observe row.right := by
  obtain ⟨env,held,same⟩ := recordInput _ _ _ _ _ present
  cases same
  exact ⟨EvaluationTrace.reconstruct env left,EvaluationTrace.reconstruct env right,rfl,rfl⟩

theorem closedMeaning (rows : List Row) (row : Row) :
    row ∈ closed rows ↔ row ∈ rows ∧ row.leftObservation = row.rightObservation := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem retainedMeaning (rows : List Row) (row : Row) :
    row ∈ retained rows ↔ row ∈ rows ∧ row.leftObservation ≠ row.rightObservation := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem completeDistinctions (rows : List Row) (row : Row) (present : row ∈ rows) :
    row ∈ closed rows ∨ row ∈ retained rows := by
  by_cases same : row.leftObservation = row.rightObservation
  · exact Or.inl ((closedMeaning _ _).mpr ⟨present,same⟩)
  · exact Or.inr ((retainedMeaning _ _).mpr ⟨present,same⟩)

theorem disjointDistinctions (rows : List Row) (row : Row)
    (same : row ∈ closed rows) (different : row ∈ retained rows) : False :=
  ((retainedMeaning _ _).mp different).2 (((closedMeaning _ _).mp same).2)

theorem equivalenceClosesEveryRow (support : List Environment) (observe : Observation) (left right : Expr)
    (same : Equivalent support observe left right) (row : Row)
    (present : row ∈ ledger support observe left right) : row ∈ closed (ledger support observe left right) := by
  obtain ⟨env,held,identity⟩ := recordInput _ _ _ _ _ present
  apply (closedMeaning _ _).mpr
  refine ⟨present,?_⟩
  cases identity
  exact same env held

theorem distinguishingInput (support : List Environment) (observe : Observation) (left right : Expr)
    (failed : certificate support observe left right = false) :
    ∃ env, env ∈ support ∧ observe (run env left) ≠ observe (run env right) := by
  induction support with
  | nil => cases failed
  | cons env rest ih =>
    by_cases same : observe (run env left) = observe (run env right)
    · change (decide (observe (run env left) = observe (run env right)) && certificate rest observe left right) = false at failed
      rw [decide_eq_true same] at failed
      obtain ⟨input,held,different⟩ := ih failed
      exact ⟨input,List.Mem.tail _ held,different⟩
    · exact ⟨env,List.Mem.head _,same⟩

theorem retainedRefutes (support : List Environment) (observe : Observation) (left right : Expr)
    (row : Row) (different : row ∈ retained (ledger support observe left right)) :
    ¬ Equivalent support observe left right := by
  intro same
  have h := (retainedMeaning _ _).mp different
  exact disjointDistinctions _ _ (equivalenceClosesEveryRow _ _ _ _ same row h.1) different

theorem identity (support : List Environment) (observe : Observation) (e : Expr) : Equivalent support observe e e :=
  fun _ _ => rfl

theorem symmetry (support : List Environment) (observe : Observation) (left right : Expr)
    (same : Equivalent support observe left right) : Equivalent support observe right left :=
  fun env present => (same env present).symm

theorem composition (support : List Environment) (observe : Observation) (a b c : Expr)
    (first : Equivalent support observe a b) (second : Equivalent support observe b c) : Equivalent support observe a c :=
  fun env present => (first env present).trans (second env present)

theorem supportAssembly (first second : List Environment) (observe : Observation) (left right : Expr)
    (a : Equivalent first observe left right) (b : Equivalent second observe left right) :
    Equivalent (first ++ second) observe left right := by
  intro env present
  cases memAppendCases _ _ _ present with
  | inl h => exact a env h
  | inr h => exact b env h

theorem supportRestriction (first second : List Environment) (observe : Observation) (left right : Expr)
    (same : Equivalent (first ++ second) observe left right) : Equivalent first observe left right :=
  fun env h => same env (memAppendLeft _ _ _ h)

theorem ledgerAssembly (first second : List Environment) (observe : Observation) (left right : Expr) :
    ledger (first ++ second) observe left right = ledger first observe left right ++ ledger second observe left right :=
  SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem earlierRowRetained (first second : List Environment) (observe : Observation) (left right : Expr)
    (row : Row) (held : row ∈ ledger first observe left right) : row ∈ ledger (first ++ second) observe left right := by
  rw [ledgerAssembly]
  exact memAppendLeft _ _ _ held

-- This implication uses the declared observation post-map; an arbitrary new
-- observer is not inferred to preserve equivalence.
theorem observationPostmap (support : List Environment) (observe : Observation) (post : String → String)
    (left right : Expr) (same : Equivalent support observe left right) :
    Equivalent support (fun execution => post (observe execution)) left right :=
  fun env present => congrArg post (same env present)

end SFT.Computation.ProgramEquivalence
