import SFT.Computation.StateComposition
namespace SFT.Computation.StateExtension
open StateTransition StateComposition
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

theorem matchesKey (row : Row) (state action : String)
    (h : (decide (row.1 = state) && decide (row.2.1 = action)) = true) :
    (row.1,row.2.1) = (state,action) := by
  have p := (SFT.Foundation.Count.Representation.andTrue _ _).mp h
  have a : row.1 = state := of_decide_eq_true p.1
  have b : row.2.1 = action := of_decide_eq_true p.2
  rw [a,b]

theorem validAvoidsSeen (states actions : List String) (seen : List (String × String)) (rows : List Row)
    (valid : RowsValid states actions seen rows) (state action : String) (prior : (state,action) ∈ seen) :
    targets rows state action = [] := by
  induction valid with
  | nil => rfl
  | cons seen row rows bound fresh rest ih =>
    have negative : (decide (row.1 = state) && decide (row.2.1 = action)) ≠ true := by
      intro matchRow
      have key := matchesKey row state action matchRow
      rw [key] at fresh
      have yes := (hasIff _ _).mpr prior
      rw [fresh] at yes
      cases yes
    unfold targets
    rw [List.filter_cons_of_neg (p := fun r : Row => decide (r.1 = state) && decide (r.2.1 = action)) negative]
    exact ih (List.Mem.tail _ prior)

theorem validTargetSingleton (states actions : List String) (seen : List (String × String)) (rows : List Row)
    (valid : RowsValid states actions seen rows) (state action target : String)
    (member : (state,action,target) ∈ rows) : targets rows state action = [target] := by
  induction valid with
  | nil => cases member
  | cons seen row rows bound fresh rest ih =>
    cases member with
    | head =>
      have empty := validAvoidsSeen _ _ _ _ rest state action (List.Mem.head _)
      unfold targets
      rw [List.filter_cons_of_pos (by exact (SFT.Foundation.Count.Representation.andTrue _ _).mpr ⟨decide_eq_true rfl,decide_eq_true rfl⟩)]
      change target :: targets rows state action = [target]
      rw [empty]
    | tail _ hm =>
      have negative : (decide (row.1 = state) && decide (row.2.1 = action)) ≠ true := by
        intro matchRow
        have key := matchesKey row state action matchRow
        have prior : (state,action) ∈ (row.1,row.2.1)::seen := by rw [key]; exact List.Mem.head _
        have empty := validAvoidsSeen _ _ _ _ rest state action prior
        have inside := (targetMembership _ _ _ _).mpr hm
        rw [empty] at inside; cases inside
      unfold targets
      rw [List.filter_cons_of_neg (p := fun r : Row => decide (r.1 = state) && decide (r.2.1 = action)) negative]
      exact ih hm

theorem admittedStepIff (states actions : List String) (rows : List Row) (system : System)
    (admitted : create states actions rows = .ok system) (state action target : String) :
    step system state action = .ok target ↔ (state,action,target) ∈ rows := by
  have p := (createMeaning _ _ _ _).mp admitted
  constructor
  · intro h
    have member := stepSourceRow _ _ _ _ h
    rw [p.2.2.2.2.2] at member
    exact member
  · intro member
    apply (stepMeaning _ _ _ _).mpr
    rw [p.2.2.2.2.2]
    exact validTargetSingleton _ _ _ _ p.2.2.2.2.1 _ _ _ member

theorem extendStep (old extended : System)
    (admitted : create extended.states extended.actions extended.transitions = .ok extended)
    (retained : ∀ row, row ∈ old.transitions → row ∈ extended.transitions)
    (state action target : String) (h : step old state action = .ok target) :
    step extended state action = .ok target :=
  (admittedStepIff _ _ _ _ admitted _ _ _).mpr (retained _ (stepSourceRow _ _ _ _ h))

theorem extendExecution (old extended : System)
    (admitted : create extended.states extended.actions extended.transitions = .ok extended)
    (retained : ∀ row, row ∈ old.transitions → row ∈ extended.transitions)
    (initial : String) (actions trace : List String) (h : Execution old initial actions trace) :
    Execution extended initial actions trace := by
  induction h with
  | base => exact .base _
  | next _ _ _ _ _ edge _ ih => exact .next _ _ _ _ _ (extendStep _ _ admitted retained _ _ _ edge) ih

theorem extendRun (old extended : System)
    (admitted : create extended.states extended.actions extended.transitions = .ok extended)
    (statesRetained : ∀ state, state ∈ old.states → state ∈ extended.states)
    (rowsRetained : ∀ row, row ∈ old.transitions → row ∈ extended.transitions)
    (initial : String) (actions trace : List String) (h : run old initial actions = .ok trace) :
    run extended initial actions = .ok trace := by
  have p := (runAdmission _ _ _ _).mp h
  exact (runAdmission _ _ _ _).mpr ⟨statesRetained _ p.1,(runFromMeaning _ _ _ _).mpr
    (extendExecution _ _ admitted rowsRetained _ _ _ ((runFromMeaning _ _ _ _).mp p.2))⟩



theorem appendPreservesRun (old : System) (newStates newActions : List String) (newRows : List Row)
    (admitted : create (old.states ++ newStates) (old.actions ++ newActions) (old.transitions ++ newRows) =
      .ok ⟨old.states ++ newStates,old.actions ++ newActions,old.transitions ++ newRows⟩)
    (initial : String) (actions trace : List String) (h : run old initial actions = .ok trace) :
    run ⟨old.states ++ newStates,old.actions ++ newActions,old.transitions ++ newRows⟩ initial actions = .ok trace :=
  extendRun _ _ admitted
    (fun state held => memAppendLeft state old.states newStates held)
    (fun row held => memAppendLeft row old.transitions newRows held) initial actions trace h

theorem commonAssemblyPreservesRuns (left right assembly : System)
    (admitted : create assembly.states assembly.actions assembly.transitions = .ok assembly)
    (leftStates : ∀ state, state ∈ left.states → state ∈ assembly.states)
    (rightStates : ∀ state, state ∈ right.states → state ∈ assembly.states)
    (leftRows : ∀ row, row ∈ left.transitions → row ∈ assembly.transitions)
    (rightRows : ∀ row, row ∈ right.transitions → row ∈ assembly.transitions)
    (leftInitial rightInitial : String) (leftActions rightActions leftTrace rightTrace : List String)
    (leftRun : run left leftInitial leftActions = .ok leftTrace)
    (rightRun : run right rightInitial rightActions = .ok rightTrace) :
    run assembly leftInitial leftActions = .ok leftTrace ∧ run assembly rightInitial rightActions = .ok rightTrace :=
  ⟨extendRun _ _ admitted leftStates leftRows _ _ _ leftRun,
   extendRun _ _ admitted rightStates rightRows _ _ _ rightRun⟩

end SFT.Computation.StateExtension
