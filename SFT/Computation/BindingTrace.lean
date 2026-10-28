import SFT.Computation.StateExtension
import SFT.Computation.StateComposition
namespace SFT.Computation.BindingTrace
open StateTransition StateComposition

-- catalog.py's retained transition/relation trace, instantiated with the
-- unchanged operations.py kernel. These are trace classes, not a beta rule.
def Normal (system : System) (state : String) : Prop :=
  state ∈ system.states ∧ ∀ action target, step system state action ≠ .ok target

def Cyclic (system : System) (state : String) : Prop :=
  state ∈ system.states ∧ ∃ actions before,
    actions ≠ [] ∧ Path system state actions before state

theorem normalIdentity (system : System) (state : String) (h : Normal system state) :
    run system state [] = .ok [state] := runBase _ _ h.1

theorem normalTraceEmpty (system : System) (state terminal : String)
    (actions before : List String) (h : Normal system state)
    (trace : Path system state actions before terminal) : actions = [] := by
  cases trace with
  | identity => rfl
  | next state action target actions before terminal edge rest =>
    exact False.elim (h.2 action target edge)

theorem normalNotCyclic (system : System) (state : String)
    (h : Normal system state) : ¬ Cyclic system state := by
  intro cycle
  obtain ⟨held,actions,before,nonempty,path⟩ := cycle
  exact nonempty (normalTraceEmpty _ _ _ _ _ h path)

theorem cycleReplay (system : System) (state : String) (h : Cyclic system state) :
    ∃ actions before, actions ≠ [] ∧
      run system state actions = .ok (before ++ [state]) := by
  obtain ⟨held,actions,before,nonempty,path⟩ := h
  exact ⟨actions,before,nonempty,(runAdmission _ _ _ _).mpr
    ⟨held,(runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ path)⟩⟩

theorem cycleRepeat (system : System) (state : String) (actions before : List String)
    (held : state ∈ system.states) (path : Path system state actions before state) :
    run system state (actions ++ actions) = .ok ((before ++ before) ++ [state]) :=
  nativeComposition _ _ _ _ _ _ _ _ held path path

-- Every retained step reconstructs from an actual source transition row.
theorem pathRows (system : System) (initial terminal : String)
    (actions before : List String) (path : Path system initial actions before terminal) :
    ∀ source action, (source,action) ∈ before.zip actions →
      ∃ target, (source,action,target) ∈ system.transitions := by
  induction path with
  | identity => intro source action h; cases h
  | next state action target actions before terminal edge rest ih =>
    intro source selected h
    cases h with
    | head => exact ⟨target,stepSourceRow _ _ _ _ edge⟩
    | tail _ hm => exact ih source selected hm

theorem traceReplay (system : System) (initial terminal : String)
    (actions before : List String) (held : initial ∈ system.states)
    (path : Path system initial actions before terminal) :
    run system initial actions = .ok (before ++ [terminal]) :=
  (runAdmission _ _ _ _).mpr
    ⟨held,(runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ path)⟩

theorem successorRetainsTrace (system : System) (initial terminal next : String)
    (actions before : List String) (held : initial ∈ system.states)
    (path : Path system initial actions before terminal) (action : String)
    (edge : step system terminal action = .ok next) :
    run system initial (actions ++ [action]) = .ok ((before ++ [terminal]) ++ [next]) :=
  traceReplay _ _ _ _ _ held (pathSuccessor _ _ _ _ _ _ path action edge)

end SFT.Computation.BindingTrace
