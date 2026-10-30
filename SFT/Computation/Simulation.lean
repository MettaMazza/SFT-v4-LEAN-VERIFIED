import SFT.Computation.StateComposition
import SFT.Computation.StateExtension
import SFT.InformationScience.EncodingMaps
namespace SFT.Computation.Simulation
open StateTransition SFT.InformationScience.EncodingMaps

structure Model where
  system : System
  admitted : create system.states system.actions system.transitions = .ok system
  observationMap : List (String × String)
  observationUnique : SFT.Mathematics.DiscreteObjects.distinct (observationMap.map Prod.fst) = true

structure Report where
  states : List String
  observations : List String

def observe (mapping : List (String × String)) : List String → Option (List String)
  | [] => some []
  | state::rest => match lookupFirst mapping state with
    | none => none
    | some observation => match observe mapping rest with
      | none => none
      | some tail => some (observation::tail)

def simulate (model : Model) (initial : String) (schedule : List String) : Option Report :=
  match run model.system initial schedule with
  | .error _ => none
  | .ok states => match observe model.observationMap states with
    | none => none
    | some observations => some ⟨states,observations⟩

theorem observationLength (mapping : List (String × String)) (states observations : List String)
    (accepted : observe mapping states = some observations) : observations.length = states.length := by
  induction states generalizing observations with
  | nil => cases accepted; rfl
  | cons state rest ih =>
    unfold observe at accepted
    cases h : lookupFirst mapping state with
    | none => rw [h] at accepted; cases accepted
    | some value =>
      rw [h] at accepted
      cases t : observe mapping rest with
      | none => rw [t] at accepted; cases accepted
      | some tail =>
        rw [t] at accepted
        cases accepted
        exact congrArg Nat.succ (ih _ t)

theorem simulationSource (model : Model) (initial : String) (schedule : List String) (report : Report)
    (accepted : simulate model initial schedule = some report) :
    run model.system initial schedule = .ok report.states ∧
      observe model.observationMap report.states = some report.observations := by
  unfold simulate at accepted
  cases h : run model.system initial schedule with
  | error e => rw [h] at accepted; cases accepted
  | ok states =>
    rw [h] at accepted
    dsimp only at accepted
    cases o : observe model.observationMap states with
    | none => rw [o] at accepted; cases accepted
    | some observations =>
      rw [o] at accepted
      cases accepted
      exact ⟨rfl,o⟩

theorem executionCertificate (model : Model) (initial : String) (schedule : List String) (report : Report)
    (accepted : simulate model initial schedule = some report) :
    initial ∈ model.system.states ∧ Execution model.system initial schedule report.states := by
  have source := simulationSource _ _ _ _ accepted
  have admitted := (runAdmission _ _ _ _).mp source.1
  exact ⟨admitted.1,(runFromMeaning _ _ _ _).mp admitted.2⟩

theorem completeObservationCount (model : Model) (initial : String) (schedule : List String) (report : Report)
    (accepted : simulate model initial schedule = some report) :
    report.observations.length = schedule.length+1 := by
  have source := simulationSource _ _ _ _ accepted
  exact (observationLength _ _ _ source.2).trans
    (executionLength _ _ _ _ (executionCertificate _ _ _ _ accepted).2)

theorem missingObservationRejected (mapping : List (String × String)) (state : String) (rest : List String)
    (missing : lookupFirst mapping state = none) : observe mapping (state::rest) = none := by
  unfold observe
  rw [missing]

inductive ObservationRows (mapping : List (String × String)) : List String → List String → Prop where
  | base : ObservationRows mapping [] []
  | next (state observation : String) (states observations : List String)
      (held : lookupFirst mapping state = some observation)
      (tail : ObservationRows mapping states observations) :
      ObservationRows mapping (state::states) (observation::observations)

theorem observationReplay (mapping : List (String × String)) (states observations : List String)
    (rows : ObservationRows mapping states observations) : observe mapping states = some observations := by
  induction rows with
  | base => rfl
  | next state observation states observations held tail ih =>
    unfold observe
    rw [held,ih]

theorem observationReconstruction (mapping : List (String × String)) (states observations : List String)
    (accepted : observe mapping states = some observations) : ObservationRows mapping states observations := by
  induction states generalizing observations with
  | nil => cases accepted; exact .base
  | cons state rest ih =>
    unfold observe at accepted
    cases h : lookupFirst mapping state with
    | none => rw [h] at accepted; cases accepted
    | some value =>
      rw [h] at accepted
      cases t : observe mapping rest with
      | none => rw [t] at accepted; cases accepted
      | some tail =>
        rw [t] at accepted
        cases accepted
        exact .next _ _ _ _ h (ih _ t)

theorem observationComposition (mapping : List (String × String)) (first second left right : List String)
    (a : ObservationRows mapping first left) (b : ObservationRows mapping second right) :
    ObservationRows mapping (first++second) (left++right) := by
  induction a with
  | base => exact b
  | next state observation states observations held tail ih => exact .next _ _ _ _ held ih

theorem exactSimulation (model : Model) (initial : String) (schedule states observations : List String)
    (executed : run model.system initial schedule = .ok states)
    (observed : observe model.observationMap states = some observations) :
    simulate model initial schedule = some ⟨states,observations⟩ := by
  unfold simulate
  rw [executed]
  dsimp only
  rw [observed]

theorem composedSimulation (model : Model) (initial middle terminal : String)
    (left right before after preObservations postObservations : List String)
    (held : initial ∈ model.system.states)
    (first : StateComposition.Path model.system initial left before middle)
    (second : StateComposition.Path model.system middle right after terminal)
    (pre : ObservationRows model.observationMap before preObservations)
    (post : ObservationRows model.observationMap (after++[terminal]) postObservations) :
    simulate model initial (left++right) = some ⟨before++(after++[terminal]),preObservations++postObservations⟩ := by
  have execution := StateComposition.nativeComposition _ _ _ _ _ _ _ _ held first second
  rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative] at execution
  exact exactSimulation _ _ _ _ _ execution (observationReplay _ _ _ (observationComposition _ _ _ _ _ pre post))

def comparisonAccepted (registered : List (List String × List String)) (report : Report) (external : List String) : Bool :=
  SFT.Mathematics.DiscreteObjects.has registered (report.observations,external)

theorem comparisonBoundary (registered : List (List String × List String)) (report : Report) (external : List String) :
    comparisonAccepted registered report external = true ↔ (report.observations,external) ∈ registered :=
  SFT.Mathematics.DiscreteObjects.hasIff _ _

theorem successorSimulation (model : Model) (initial terminal next action observation : String)
    (schedule before observations : List String) (held : initial ∈ model.system.states)
    (path : StateComposition.Path model.system initial schedule before terminal)
    (edge : step model.system terminal action = .ok next)
    (prior : ObservationRows model.observationMap (before++[terminal]) observations)
    (observed : lookupFirst model.observationMap next = some observation) :
    simulate model initial (schedule++[action]) =
      some ⟨(before++[terminal])++[next],observations++[observation]⟩ := by
  have executed := (runAdmission _ _ _ _).mpr
    ⟨held,StateComposition.successorTrace _ _ _ _ _ _ path action edge⟩
  exact exactSimulation _ _ _ _ _ executed
    (observationReplay _ _ _ (observationComposition _ _ _ _ _ prior (.next _ _ _ _ observed .base)))

theorem observationExtension (first second : List (String × String)) (states observations : List String)
    (rows : ObservationRows first states observations)
    (retained : ∀ state value, lookupFirst first state = some value → lookupFirst second state = some value) :
    ObservationRows second states observations := by
  induction rows with
  | base => exact .base
  | next state observation states observations held tail ih => exact .next _ _ _ _ (retained _ _ held) ih

theorem simulationExtension (first second : Model) (initial : String) (schedule : List String) (report : Report)
    (statesRetained : ∀ state, state ∈ first.system.states → state ∈ second.system.states)
    (rowsRetained : ∀ row, row ∈ first.system.transitions → row ∈ second.system.transitions)
    (observationsRetained : ∀ state value, lookupFirst first.observationMap state = some value →
      lookupFirst second.observationMap state = some value)
    (accepted : simulate first initial schedule = some report) : simulate second initial schedule = some report := by
  have source := simulationSource _ _ _ _ accepted
  have executed := StateExtension.extendRun _ _ second.admitted statesRetained rowsRetained _ _ _ source.1
  have observed := observationReplay _ _ _ (observationExtension _ _ _ _
    (observationReconstruction _ _ _ source.2) observationsRetained)
  exact exactSimulation _ _ _ _ _ executed observed

theorem registeredObservation (model : Model) (state observation : String)
    (held : (state,observation) ∈ model.observationMap) :
    lookupFirst model.observationMap state = some observation :=
  lookupUnique _ _ _ model.observationUnique held

theorem simulationStates (model : Model) (initial : String) (schedule : List String) (report : Report)
    (accepted : simulate model initial schedule = some report) :
    ∀ state, state ∈ report.states → state ∈ model.system.states := by
  have execution := executionCertificate _ _ _ _ accepted
  exact executionStates _ _ _ _ model.admitted _ execution.1 _ _ execution.2

end SFT.Computation.Simulation
