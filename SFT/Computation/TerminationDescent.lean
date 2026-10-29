import SFT.Computation.EvaluationTrace
import SFT.Computation.RecognitionTrace
namespace SFT.Computation.TerminationDescent
open SymbolicEvaluation EvaluationTrace
open SFT.Mathematics.DiscreteObjects

-- Counts measure generated syntax and are proof bookkeeping, not fitted values.
def nodes : Expr → Nat
 | .value _ => 1
 | .name _ => 1
 | .outside _ => 1
 | .join left right => (nodes left + nodes right) + 1

inductive Child : Expr → Expr → Prop where
 | left (a b) : Child a (.join a b)
 | right (a b) : Child b (.join a b)

theorem childDecreases (child parent : Expr) (step : Child child parent) : nodes child < nodes parent := by
  cases step with
  | left a b => exact Nat.lt_of_le_of_lt (Nat.le_add_right _ _) (Nat.lt_succ_self _)
  | right a b => exact Nat.lt_of_le_of_lt (Nat.le_add_left _ _) (Nat.lt_succ_self _)

theorem accessible (e : Expr) : Acc Child e := by
  induction e with
  | value value => exact Acc.intro _ (fun child h => by cases h)
  | name label => exact Acc.intro _ (fun child h => by cases h)
  | outside tag => exact Acc.intro _ (fun child h => by cases h)
  | join a b ia ib =>
    exact Acc.intro _ (fun child h => by cases h with
      | left => exact ia
      | right => exact ib)

theorem generatedWellFounded : WellFounded Child := ⟨accessible⟩

inductive Call (env : Environment) : Expr → Expr → Prop where
 | left (a b) (unique : distinct (env.map Prod.fst) = true) : Call env a (.join a b)
 | right (a b value) (unique : distinct (env.map Prod.fst) = true)
     (first : evaluate env a = .ok value) : Call env b (.join a b)

theorem actualCallDescent (env : Environment) (child parent : Expr) (call : Call env child parent) :
    Child child parent ∧ nodes child < nodes parent := by
  have h : Child child parent := by cases call with
    | left => exact .left _ _
    | right => exact .right _ _
  exact ⟨h,childDecreases _ _ h⟩

theorem callAccessible (env : Environment) (e : Expr) : Acc (Call env) e := by
  have source := accessible e
  induction source with
  | intro e descent ih =>
    exact Acc.intro e (fun child call => ih child (actualCallDescent _ _ _ call).1)

theorem callWellFounded (env : Environment) : WellFounded (Call env) := ⟨callAccessible env⟩

theorem noCallCycle (env : Environment) (e : Expr) : ¬ Call env e e :=
  fun call => Nat.lt_irrefl _ (actualCallDescent _ _ _ call).2

theorem terminalCoverage (env : Environment) (e : Expr) :
    ∃ result children,
      Execution env e result (frame env e children result) ∧ evaluate env e = result := by
  have proof := EvaluationTrace.reconstruct env e
  obtain ⟨children,same⟩ := endpoints _ _ _ _ proof
  refine ⟨(run env e).1,children,?_,sourceResult _ _ _ _ proof⟩
  rw [← same]
  exact proof

theorem duplicateHasNoCalls (env : Environment) (child parent : Expr)
    (duplicate : distinct (env.map Prod.fst) = false) : ¬ Call env child parent := by
  intro call
  cases call with
  | left a b unique => rw [duplicate] at unique; cases unique
  | right a b value unique first => rw [duplicate] at unique; cases unique

open StateTransition StateComposition

-- The rank is an explicit descent certificate for the original step relation.
def Ranked (system : System) (rank : String → Nat) : Prop :=
  ∀ state action target, step system state action = .ok target → rank target < rank state

theorem pathRank (system : System) (rank : String → Nat) (ranked : Ranked system rank)
    (initial terminal : String) (actions before : List String)
    (path : Path system initial actions before terminal) : rank terminal ≤ rank initial := by
  induction path with
  | identity => exact Nat.le_refl _
  | next state action target actions before terminal edge rest ih =>
    exact Nat.le_trans ih (Nat.le_of_lt (ranked _ _ _ edge))

theorem pathBound (system : System) (rank : String → Nat) (ranked : Ranked system rank)
    (initial terminal : String) (actions before : List String)
    (path : Path system initial actions before terminal) : actions.length ≤ rank initial := by
  induction path with
  | identity => exact Nat.zero_le _
  | next state action target actions before terminal edge rest ih =>
    exact Nat.le_trans (Nat.succ_le_succ ih) (Nat.succ_le_of_lt (ranked _ _ _ edge))

theorem positivePathDescent (system : System) (rank : String → Nat) (ranked : Ranked system rank)
    (initial terminal : String) (action : String) (actions before : List String)
    (path : Path system initial (action::actions) before terminal) : rank terminal < rank initial := by
  cases path with
  | next state action target actions before terminal edge rest =>
    exact Nat.lt_of_le_of_lt (pathRank _ _ ranked _ _ _ _ rest) (ranked _ _ _ edge)

theorem cycleExcludesRank (system : System) (initial : String) (action : String) (actions before : List String)
    (cycle : Path system initial (action::actions) before initial) :
    ∀ rank, ¬ Ranked system rank :=
  fun rank ranked => Nat.lt_irrefl _ (positivePathDescent _ _ ranked _ _ _ _ _ cycle)

theorem nativeBound (system : System) (rank : String → Nat) (ranked : Ranked system rank)
    (initial : String) (actions trace : List String) (executed : StateTransition.run system initial actions = .ok trace) :
    actions.length ≤ rank initial ∧ ∃ before terminal, trace = before ++ [terminal] ∧ Path system initial actions before terminal := by
  obtain ⟨held,before,terminal,exactTrace,path⟩ := nativePath _ _ _ _ executed
  exact ⟨pathBound _ _ ranked _ _ _ _ path,before,terminal,exactTrace,path⟩

theorem noLongContinuation (system : System) (rank : String → Nat) (ranked : Ranked system rank)
    (initial terminal : String) (actions before : List String) (tooLong : rank initial < actions.length) :
    ¬ Path system initial actions before terminal :=
  fun path => Nat.not_lt_of_ge (pathBound _ _ ranked _ _ _ _ path) tooLong

theorem serialBound (system : System) (rank : String → Nat) (ranked : Ranked system rank)
    (initial middle terminal : String) (first second before after : List String)
    (left : Path system initial first before middle) (right : Path system middle second after terminal) :
    (first ++ second).length ≤ rank initial ∧
      Path system initial (first ++ second) (before ++ after) terminal := by
  have joined := pathSerial _ _ _ _ _ _ _ _ left right
  exact ⟨pathBound _ _ ranked _ _ _ _ joined,joined⟩

theorem successorBound (system : System) (rank : String → Nat) (ranked : Ranked system rank)
    (initial terminal next : String) (actions before : List String)
    (path : Path system initial actions before terminal) (action : String)
    (edge : step system terminal action = .ok next) :
    (actions ++ [action]).length ≤ rank initial ∧
      Path system initial (actions ++ [action]) (before ++ [terminal]) next := by
  have extended := pathSuccessor _ _ _ _ _ _ path action edge
  exact ⟨pathBound _ _ ranked _ _ _ _ extended,extended⟩

theorem originalLoopCounterexample : ∀ rank, ¬ Ranked RecognitionTrace.loop rank := by
  intro rank ranked
  have h := ranked "held" "fold" "held" (by rfl)
  exact Nat.lt_irrefl _ h

end SFT.Computation.TerminationDescent
