import SFT.Mathematics.DynamicsStability
namespace SFT.Computation.ComputationalDynamics
open SFT.Mathematics.DynamicsTraces SFT.Mathematics.DynamicsReturns
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.GraphOperations

structure Model where
  states : List String
  updates : Transitions
  admitted : validDynamics states updates = true

structure Orbit where
  trajectory : List String
  time : Time
  returnTrace : Option (List String)

def admitOrbit (model : Model) (trajectory : List String) : Option Orbit :=
  if trajectory.all (has model.states) && trajectoryValid model.updates trajectory then
    match transitionTime trajectory with
    | .error _ => none
    | .ok time => some ⟨trajectory,time,firstReturn trajectory⟩
  else none

theorem orbitSource (model : Model) (trajectory : List String) (orbit : Orbit)
    (accepted : admitOrbit model trajectory = some orbit) :
    orbit.trajectory = trajectory ∧ trajectoryValid model.updates trajectory = true ∧
      transitionTime trajectory = .ok orbit.time ∧ orbit.returnTrace = firstReturn trajectory ∧
      ∀ state, state ∈ trajectory → state ∈ model.states := by
  unfold admitOrbit at accepted
  split at accepted
  · rename_i h
    have held := (andTrue _ _).mp h
    cases t : transitionTime trajectory with
    | error e => rw [t] at accepted; cases accepted
    | ok time =>
      rw [t] at accepted
      cases accepted
      exact ⟨rfl,held.2,rfl,rfl,fun state member =>
        (hasIff _ _).mp ((allTrueIffMembers _ _).mp held.1 state member)⟩
  · cases accepted

theorem orbitReconstruction (model : Model) (trajectory : List String)
    (held : ∀ state, state ∈ trajectory → state ∈ model.states)
    (valid : trajectoryValid model.updates trajectory = true)
    (time : Time) (clock : transitionTime trajectory = .ok time) :
    admitOrbit model trajectory = some ⟨trajectory,time,firstReturn trajectory⟩ := by
  unfold admitOrbit
  have h := (andTrue _ _).mpr ⟨(allTrueIffMembers _ _).mpr
    (fun state member => (hasIff _ _).mpr (held state member)),valid⟩
  rw [ite_eq_left h,clock]

theorem identityOrbit (model : Model) (state : String) (held : state ∈ model.states) :
    admitOrbit model [state] = some ⟨[state],.inl ["empty-One"],none⟩ := by
  apply orbitReconstruction model [state] ?_ (identityTrajectory _ _) _ rfl
  intro x member
  cases member with
  | head => exact held
  | tail _ h => cases h

theorem noReturnExactlyDistinct (model : Model) (trajectory : List String) (orbit : Orbit)
    (accepted : admitOrbit model trajectory = some orbit) :
    orbit.returnTrace = none ↔ distinct trajectory = true := by
  rw [(orbitSource model trajectory orbit accepted).2.2.2.1]
  exact firstReturnNoneIff trajectory

theorem returnedOrbit (model : Model) (trajectory : List String) (orbit : Orbit)
    (accepted : admitOrbit model trajectory = some orbit)
    (cycle : List String) (returned : orbit.returnTrace = some cycle) :
    trajectoryValid model.updates cycle = true ∧
      ∃ before middle terminal after,
        trajectory = (before ++ terminal :: middle) ++ terminal :: after ∧
        cycle = (terminal :: middle) ++ [terminal] ∧
        distinct (before ++ terminal :: middle) = true ∧ ¬ terminal ∈ before := by
  have source := orbitSource model trajectory orbit accepted
  have found := source.2.2.2.1.symm.trans returned
  exact ⟨returnedTrajectoryValid model.updates trajectory cycle source.2.1 found,
    firstReturnEarliest trajectory cycle found⟩

theorem fixedTerminal (model : Model) (state : String) :
    state ∈ fixedForms model.updates ↔ (state,state) ∈ model.updates :=
  fixedMembership model.updates state

theorem preservedLedger (updates : Transitions) (ledger : List String)
    (closed : ∀ left right, left ∈ ledger → (left,right) ∈ updates → right ∈ ledger)
    (initial : String) (rest : List String) (held : initial ∈ ledger)
    (valid : trajectoryValid updates (initial :: rest) = true) :
    ∀ state, state ∈ initial :: rest → state ∈ ledger := by
  induction rest generalizing initial with
  | nil =>
    intro state member
    cases member with
    | head => exact held
    | tail _ h => cases h
  | cons next tail ih =>
    have facts := (trajectoryMeaning _ _).mp valid
    have edge : (initial,next) ∈ updates := facts.2 _ (List.Mem.head _)
    have tailValid : trajectoryValid updates (next :: tail) = true :=
      (trajectoryMeaning _ _).mpr ⟨rfl,fun pair member => facts.2 pair (List.Mem.tail _ member)⟩
    intro state member
    cases member with
    | head => exact held
    | tail _ h => exact ih next (closed initial next held edge) tailValid state h

theorem orbitInvariant (model : Model) (initial : String) (rest : List String) (orbit : Orbit)
    (accepted : admitOrbit model (initial :: rest) = some orbit)
    (ledger : List String) (held : initial ∈ ledger)
    (closed : ∀ left right, left ∈ ledger → (left,right) ∈ model.updates → right ∈ ledger) :
    ∀ state, state ∈ orbit.trajectory → state ∈ ledger := by
  have source := orbitSource model (initial :: rest) orbit accepted
  rw [source.1]
  exact preservedLedger model.updates ledger closed initial rest held source.2.1

theorem perturbationCertificate (model : Model) (terminal : String) (support : List String) :
    SFT.Mathematics.DynamicsStability.stableUnderRegisteredPerturbations model.updates terminal support = true ↔
      ∀ initial, initial ∈ support →
        SFT.Mathematics.DynamicsStability.Reaches model.updates initial terminal :=
  SFT.Mathematics.DynamicsStability.stabilityMeaning model.updates terminal support

theorem composeOrbits (model : Model) (before after : List String) (middle : String)
    (left right : Orbit)
    (leftAccepted : admitOrbit model (before ++ [middle]) = some left)
    (rightAccepted : admitOrbit model (middle :: after) = some right) :
    ∃ joined, admitOrbit model (before ++ middle :: after) = some joined := by
  have l := orbitSource model _ left leftAccepted
  have r := orbitSource model _ right rightAccepted
  have valid := (trajectoryComposition model.updates before after middle).mpr ⟨l.2.1,r.2.1⟩
  have held : ∀ state, state ∈ before ++ middle :: after → state ∈ model.states := by
    intro state member
    cases SFT.Foundation.Count.TraceDerivation.memAppendCases _ _ _ member with
    | inl h => exact l.2.2.2.2 state (SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ h)
    | inr h => exact r.2.2.2.2 state h
  cases trajectory : before ++ middle :: after with
  | nil =>
    rw [trajectory] at valid
    cases valid
  | cons head tail =>
    rw [trajectory] at held valid
    cases tail with
    | nil => exact ⟨⟨[head],.inl ["empty-One"],firstReturn [head]⟩,
        orbitReconstruction model [head] held valid _ rfl⟩
    | cons next rest => exact ⟨⟨head :: next :: rest,.inr (adjacentPairs (head :: next :: rest)),
        firstReturn (head :: next :: rest)⟩,
        orbitReconstruction model (head :: next :: rest) held valid _ rfl⟩

theorem successorOrbit (model : Model) (before : List String) (terminal next : String)
    (orbit : Orbit) (accepted : admitOrbit model (before ++ [terminal]) = some orbit)
    (edge : (terminal,next) ∈ model.updates) :
    ∃ extended, admitOrbit model (before ++ [terminal,next]) = some extended := by
  have endpoints := ((dynamicsMeaning _ _).mp model.admitted).2.2.2 _ edge
  have held : ∀ state, state ∈ [terminal,next] → state ∈ model.states := by
    intro state member
    cases member with
    | head => exact endpoints.1
    | tail _ tailMember =>
      cases tailMember with
      | head => exact endpoints.2
      | tail _ impossible => cases impossible
  have valid : trajectoryValid model.updates [terminal,next] = true :=
    (trajectoryMeaning _ _).mpr ⟨rfl,by
      intro pair member
      cases member with
      | head => exact edge
      | tail _ impossible => cases impossible⟩
  exact composeOrbits model before [next] terminal orbit
    ⟨[terminal,next],.inr [(terminal,next)],firstReturn [terminal,next]⟩ accepted
    (orbitReconstruction model [terminal,next] held valid _ rfl)

theorem successorTime (before : List String) (terminal next : String) :
    adjacentPairs (before ++ [terminal,next]) =
      adjacentPairs (before ++ [terminal]) ++ [(terminal,next)] :=
  adjacentPairsComposition before terminal [next]

theorem retainedOrbit (original extended : Model)
    (statesRetained : ∀ state, state ∈ original.states → state ∈ extended.states)
    (updatesRetained : ∀ pair, pair ∈ original.updates → pair ∈ extended.updates)
    (trajectory : List String) (orbit : Orbit)
    (accepted : admitOrbit original trajectory = some orbit) :
    admitOrbit extended trajectory = some orbit := by
  have source := orbitSource original trajectory orbit accepted
  have old := (trajectoryMeaning _ _).mp source.2.1
  have valid := (trajectoryMeaning extended.updates trajectory).mpr
    ⟨old.1,fun pair member => updatesRetained pair (old.2 pair member)⟩
  have result := orbitReconstruction extended trajectory
    (fun state member => statesRetained state (source.2.2.2.2 state member))
    valid orbit.time source.2.2.1
  cases orbit with
  | mk trace clock returned =>
    dsimp only at source result
    cases source.1
    cases source.2.2.2.1
    exact result

theorem predecessorDistinctions (model : Model) (target source : String) :
    source ∈ predecessorRecords model.updates target ↔ (source,target) ∈ model.updates :=
  predecessorMembership model.updates target source

end SFT.Computation.ComputationalDynamics
