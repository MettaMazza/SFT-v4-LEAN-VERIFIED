import SFT.Computation.StateTransition
namespace SFT.Computation.StateComposition
open StateTransition
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.DiscreteObjects

-- A retained execution with its terminal interface made explicit.
inductive Path (system : System) : String → List String → List String → String → Prop
 | identity (state) : Path system state [] [] state
 | next (state action target actions before terminal)
     (edge : step system state action = .ok target)
     (rest : Path system target actions before terminal) :
     Path system state (action::actions) (state::before) terminal

theorem pathExecution (system : System) (initial terminal : String) (actions before : List String)
    (h : Path system initial actions before terminal) :
    Execution system initial actions (before ++ [terminal]) := by
  induction h with
  | identity => exact .base _
  | next _ _ _ _ _ _ edge _ ih => exact .next _ _ _ _ _ edge ih

theorem executionPath (system : System) (initial : String) (actions trace : List String)
    (h : Execution system initial actions trace) :
    ∃ before terminal, trace = before ++ [terminal] ∧ Path system initial actions before terminal := by
  induction h with
  | base state => exact ⟨[],state,rfl,.identity state⟩
  | next state action target actions trace edge rest ih =>
    obtain ⟨before,terminal,eq,hp⟩ := ih
    exact ⟨state::before,terminal,congrArg (List.cons state) eq,.next _ _ _ _ _ _ edge hp⟩

theorem pathSerial (system : System) (initial middle terminal : String)
    (left right before after : List String)
    (first : Path system initial left before middle)
    (second : Path system middle right after terminal) :
    Path system initial (left ++ right) (before ++ after) terminal := by
  induction first with
  | identity => exact second
  | next state action target actions pre endState edge rest ih =>
    exact .next _ _ _ _ _ _ edge (ih second)

theorem nativeSerial (system : System) (initial middle terminal : String)
    (left right before after : List String)
    (first : Path system initial left before middle)
    (second : Path system middle right after terminal) :
    runFrom system initial (left ++ right) = .ok ((before ++ after) ++ [terminal]) :=
  (runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ (pathSerial _ _ _ _ _ _ _ _ first second))

theorem nativePath (system : System) (initial : String) (actions trace : List String)
    (h : run system initial actions = .ok trace) :
    initial ∈ system.states ∧ ∃ before terminal, trace = before ++ [terminal] ∧ Path system initial actions before terminal := by
  have p := (runAdmission _ _ _ _).mp h
  exact ⟨p.1,executionPath _ _ _ _ ((runFromMeaning _ _ _ _).mp p.2)⟩

theorem nativeComposition (system : System) (initial middle terminal : String)
    (left right before after : List String) (held : initial ∈ system.states)
    (first : Path system initial left before middle)
    (second : Path system middle right after terminal) :
    run system initial (left ++ right) = .ok ((before ++ after) ++ [terminal]) :=
  (runAdmission _ _ _ _).mpr ⟨held,nativeSerial _ _ _ _ _ _ _ _ first second⟩

theorem pathSuccessor (system : System) (initial terminal next : String) (actions before : List String)
    (h : Path system initial actions before terminal) (action : String)
    (edge : step system terminal action = .ok next) :
    Path system initial (actions ++ [action]) (before ++ [terminal]) next :=
  pathSerial _ _ _ _ _ _ _ _ h (.next _ _ _ _ _ _ edge (.identity next))

theorem successorTrace (system : System) (initial terminal next : String) (actions before : List String)
    (h : Path system initial actions before terminal) (action : String)
    (edge : step system terminal action = .ok next) :
    runFrom system initial (actions ++ [action]) = .ok ((before ++ [terminal]) ++ [next]) :=
  (runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ (pathSuccessor _ _ _ _ _ _ h action edge))

theorem pathTraceLength (system : System) (initial terminal : String) (actions before : List String)
    (h : Path system initial actions before terminal) : before.length = actions.length := by
  induction h with
  | identity => rfl
  | next _ _ _ _ _ _ _ _ ih => exact congrArg Nat.succ ih

end SFT.Computation.StateComposition
