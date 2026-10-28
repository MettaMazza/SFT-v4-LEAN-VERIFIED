import SFT.Computation.MachineExecution
namespace SFT.Computation.ProcessFailure
open StateTransition StateComposition

-- Retained failure records for the original runFrom error branches. The
-- executable observation remains the unchanged Except error, not this ledger.
inductive Failure (system : System) : String → List String → List String → String → String → Prop
 | stopped (state action : String) (rest : List String) (error : String)
     (failed : step system state action = .error error) :
     Failure system state (action :: rest) [] state error
 | continued (state action target : String) (actions before : List String) (failed error : String)
     (edge : step system state action = .ok target)
     (later : Failure system target actions before failed error) :
     Failure system state (action :: actions) (state :: before) failed error

theorem failureObserved (system : System) (initial : String)
    (actions before : List String) (failed error : String)
    (record : Failure system initial actions before failed error) :
    runFrom system initial actions = .error error := by
  induction record with
  | stopped state action rest error edge => rw [runFrom,edge]
  | continued state action target actions before failed error edge later ih =>
    rw [runFrom,edge]; dsimp only; rw [ih]

theorem observedFailureRecorded (system : System) (initial : String)
    (actions : List String) (error : String)
    (observed : runFrom system initial actions = .error error) :
    ∃ before failed, Failure system initial actions before failed error := by
  induction actions generalizing initial with
  | nil => cases observed
  | cons action rest ih =>
    cases edge : step system initial action with
    | error reason =>
      rw [runFrom,edge] at observed
      cases observed
      exact ⟨[],initial,.stopped initial action rest error edge⟩
    | ok next =>
      rw [runFrom,edge] at observed
      dsimp only at observed
      cases tail : runFrom system next rest with
      | ok values => rw [tail] at observed; cases observed
      | error reason =>
        rw [tail] at observed; cases observed
        obtain ⟨before,failed,record⟩ := ih next tail
        exact ⟨initial :: before,failed,.continued initial action next rest before failed error edge record⟩

theorem failureIff (system : System) (initial : String) (actions : List String) (error : String) :
    runFrom system initial actions = .error error ↔
      ∃ before failed, Failure system initial actions before failed error :=
  ⟨observedFailureRecorded _ _ _ _,fun ⟨before,failed,record⟩ => failureObserved _ _ _ _ _ _ record⟩

theorem failureRetainsChoices (system : System) (initial : String) (actions before : List String)
    (failed error : String) (record : Failure system initial actions before failed error) :
    ∃ chosen action unexecuted,
      actions = chosen ++ action :: unexecuted ∧
      Path system initial chosen before failed ∧ step system failed action = .error error := by
  induction record with
  | stopped state action rest error edge => exact ⟨[],action,rest,rfl,.identity state,edge⟩
  | continued state action target actions before failed error edge later ih =>
    obtain ⟨chosen,failedAction,unexecuted,eq,path,boundary⟩ := ih
    exact ⟨action :: chosen,failedAction,unexecuted,congrArg (List.cons action) eq,
      .next state action target chosen before failed edge path,boundary⟩

theorem failurePrefixReplay (system : System) (initial : String) (actions before : List String)
    (failed error : String) (record : Failure system initial actions before failed error) :
    ∃ chosen action unexecuted,
      actions = chosen ++ action :: unexecuted ∧
      runFrom system initial chosen = .ok (before ++ [failed]) ∧
      step system failed action = .error error := by
  obtain ⟨chosen,action,unexecuted,eq,path,boundary⟩ := failureRetainsChoices _ _ _ _ _ _ record
  exact ⟨chosen,action,unexecuted,eq,(runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ path),boundary⟩

theorem failureNotSuccess (system : System) (initial : String) (actions before : List String)
    (failed error : String) (record : Failure system initial actions before failed error)
    (trace : List String) : runFrom system initial actions ≠ .ok trace := by
  rw [failureObserved _ _ _ _ _ _ record]
  intro impossible; cases impossible

theorem serialFailure (system : System) (initial middle failed error : String)
    (left right before after : List String) (first : Path system initial left before middle)
    (second : Failure system middle right after failed error) :
    Failure system initial (left ++ right) (before ++ after) failed error := by
  induction first with
  | identity => exact second
  | next state action target actions prior terminal edge later ih =>
    exact .continued state action target (actions ++ right) (prior ++ after) failed error edge (ih second)

theorem admittedFailureObserved (system : System) (initial : String) (actions before : List String)
    (failed error : String) (held : initial ∈ system.states)
    (record : Failure system initial actions before failed error) :
    run system initial actions = .error error := by
  unfold run
  rw [(SFT.Mathematics.DiscreteObjects.hasIff _ _).mpr held]
  exact failureObserved _ _ _ _ _ _ record

end SFT.Computation.ProcessFailure
