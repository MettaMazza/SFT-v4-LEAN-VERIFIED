import SFT.Computation.NumericalTrace
import SFT.Mathematics.OrderMeaning
import SFT.Mathematics.DynamicsStability
namespace SFT.Computation.NumericalBoundary
open NumericalError NumericalLedger NumericalTrace StateTransition StateComposition
open SFT.Mathematics DiscreteObjects OrderOperations GeometryTopology
open SFT.InformationScience.EncodingMaps

-- Enclosure is expressed in the held generated order, with no selected metric.
def interval (carrier : List String) (relation : OrderOperations.Relation) (lower upper : String) : List String :=
  carrier.filter (fun value => has relation (lower,value) && has relation (value,upper))

theorem intervalMeaning (carrier : List String) (relation : OrderOperations.Relation) (lower upper value : String) :
    value ∈ interval carrier relation lower upper ↔
      value ∈ carrier ∧ (lower,value) ∈ relation ∧ (value,upper) ∈ relation := by
  constructor
  · intro held
    have parts := (filterMemberIff _ _ _).mp held
    have bounds := (andTrue _ _).mp parts.2
    exact ⟨parts.1,(hasIff _ _).mp bounds.1,(hasIff _ _).mp bounds.2⟩
  · intro bounds
    exact (filterMemberIff _ _ _).mpr ⟨bounds.1,(andTrue _ _).mpr
      ⟨(hasIff _ _).mpr bounds.2.1,(hasIff _ _).mpr bounds.2.2⟩⟩

theorem originalBoundsEnclose (carrier : List String) (relation : OrderOperations.Relation) (held lows highs : List String)
    (lower upper value : String) (lowResult : lowerBounds carrier relation held = .ok lows)
    (highResult : upperBounds carrier relation held = .ok highs)
    (low : lower ∈ lows) (high : upper ∈ highs) (source : value ∈ held) (generated : value ∈ carrier) :
    value ∈ interval carrier relation lower upper := by
  have lb := (lowerBoundsMembership _ _ _ _ lowResult lower).mp low
  have ub := (upperBoundsMembership _ _ _ _ highResult upper).mp high
  exact (intervalMeaning _ _ _ _ _).mpr ⟨generated,lb.2 value source,ub.2 value source⟩

theorem enclosureRejects (carrier : List String) (relation : OrderOperations.Relation) (lower upper value : String)
    (outside : value ∉ carrier ∨ (lower,value) ∉ relation ∨ (value,upper) ∉ relation) :
    value ∉ interval carrier relation lower upper := by
  intro held
  have parts := (intervalMeaning _ _ _ _ _).mp held
  cases outside with
  | inl bad => exact bad parts.1
  | inr bad => exact bad.elim (fun h => h parts.2.1) (fun h => h parts.2.2)

-- This certificate retains the source's finite transition trace and its
-- registered target boundary. It does not assert convergence of every input.
structure TerminalCertificate (table : ValueTable) (reference : List Number) (system : System)
    (initial : String) (actions states : List String) (rows : List Record)
    (carrier : List String) (relation : OrderOperations.Relation) (lower upper terminal : String) : Prop where
  systemAdmission : create system.states system.actions system.transitions = .ok system
  orderAdmission : isPartialOrder carrier relation = true
  execution : run system initial actions = .ok states
  observations : records table reference states = some rows
  terminalBoundary : ∃ before, states = before++[terminal]
  enclosure : terminal ∈ interval carrier relation lower upper

theorem lastRecord (table : ValueTable) (reference : List Number) (before : List String)
    (terminal : String) (rows : List Record)
    (retained : Records table reference (before++[terminal]) rows) :
    ∃ earlier approximation ledger, rows = earlier++[(terminal,approximation,ledger)] ∧
      lookupFirst table terminal = some approximation ∧ exactErrorLedger reference approximation = .ok ledger := by
  induction before generalizing rows with
  | nil =>
    cases retained with
    | next state states approximation ledger rest registered exact tail =>
      cases tail
      exact ⟨[],approximation,ledger,rfl,registered,exact⟩
  | cons state before ih =>
    cases retained with
    | next state states approximation ledger rest registered exact tail =>
      obtain ⟨earlier,values,errors,same,lookup,result⟩ := ih _ tail
      exact ⟨(state,approximation,ledger)::earlier,values,errors,congrArg (List.cons _) same,lookup,result⟩

theorem certifiedOutput (table : ValueTable) (reference : List Number) (system : System)
    (initial : String) (actions states : List String) (rows : List Record)
    (carrier : List String) (relation : OrderOperations.Relation) (lower upper terminal : String)
    (certificate : TerminalCertificate table reference system initial actions states rows carrier relation lower upper terminal) :
    ∃ earlier approximation ledger, rows = earlier++[(terminal,approximation,ledger)] ∧
      (terminal,approximation) ∈ table ∧ reference ≠ [] ∧ Rows 1 reference approximation ledger ∧
      (lower,terminal) ∈ relation ∧ (terminal,upper) ∈ relation := by
  obtain ⟨before,same⟩ := certificate.terminalBoundary
  have observations := NumericalTrace.reconstruct _ _ _ _ certificate.observations
  rw [same] at observations
  obtain ⟨earlier,approximation,ledger,rowEq,lookup,result⟩ := lastRecord _ _ _ _ _ observations
  have admitted := (exactAdmission _ _ _).mp result
  have bounds := (intervalMeaning _ _ _ _ _).mp certificate.enclosure
  exact ⟨earlier,approximation,ledger,rowEq,lookupRow _ _ _ lookup,admitted.1,admitted.2,bounds.2⟩

theorem certificateTrace (table : ValueTable) (reference : List Number) (system : System)
    (initial : String) (actions states : List String) (rows : List Record)
    (carrier : List String) (relation : OrderOperations.Relation) (lower upper terminal : String)
    (certificate : TerminalCertificate table reference system initial actions states rows carrier relation lower upper terminal) :
    rows.map Prod.fst = states ∧ rows.length = actions.length+1 :=
  ⟨NumericalTrace.identityTrace _ _ _ _ (NumericalTrace.reconstruct _ _ _ _ certificate.observations),
   nativeCount _ _ _ _ _ _ _ certificate.execution certificate.observations⟩

theorem registeredStability (transitions : DynamicsTraces.Transitions) (terminal : String) (perturbations : List String) :
    DynamicsStability.stableUnderRegisteredPerturbations transitions terminal perturbations = true ↔
      ∀ start, start ∈ perturbations → DynamicsStability.Reaches transitions start terminal :=
  DynamicsStability.stabilityMeaning _ _ _

theorem stableEnclosedTarget (transitions : DynamicsTraces.Transitions) (terminal : String) (perturbations : List String)
    (carrier : List String) (relation : OrderOperations.Relation) (lower upper : String)
    (stable : DynamicsStability.stableUnderRegisteredPerturbations transitions terminal perturbations = true)
    (enclosed : terminal ∈ interval carrier relation lower upper) :
    ∀ start, start ∈ perturbations → DynamicsStability.Reaches transitions start terminal ∧
      (lower,terminal) ∈ relation ∧ (terminal,upper) ∈ relation := by
  intro start held
  exact ⟨(registeredStability _ _ _).mp stable start held,((intervalMeaning _ _ _ _ _).mp enclosed).2⟩


def projectedTransitions (system : System) : DynamicsTraces.Transitions :=
  system.transitions.map (fun row => (row.1,row.2.2))

theorem reachComposition (transitions : DynamicsTraces.Transitions) (start middle terminal : String)
    (first : DynamicsStability.Reaches transitions start middle)
    (second : DynamicsStability.Reaches transitions middle terminal) : DynamicsStability.Reaches transitions start terminal := by
  induction second with
  | identity => exact first
  | step previous edge ih => exact .step ih edge

theorem pathReaches (system : System) (initial terminal : String) (actions before : List String)
    (path : Path system initial actions before terminal) : DynamicsStability.Reaches (projectedTransitions system) initial terminal := by
  induction path with
  | identity => exact .identity
  | next state action target actions before terminal edge rest ih =>
    have pair : (state,target) ∈ projectedTransitions system :=
      SFT.Foundation.Count.TraceDerivation.memMap (fun row : StateTransition.Row => (row.1,row.2.2))
        (state,action,target) system.transitions (stepSourceRow _ _ _ _ edge)
    exact reachComposition _ _ _ _ (.step .identity pair) ih

theorem completePerturbationPaths (system : System) (terminal : String) (perturbations : List String)
    (paths : ∀ start, start ∈ perturbations → ∃ actions before, Path system start actions before terminal) :
    DynamicsStability.stableUnderRegisteredPerturbations (projectedTransitions system) terminal perturbations = true := by
  apply (registeredStability _ _ _).mpr
  intro start member
  obtain ⟨actions,before,path⟩ := paths start member
  exact pathReaches _ _ _ _ _ path

theorem successorCertificate (table : ValueTable) (reference : List Number) (system : System)
    (initial terminal next : String) (actions before : List String) (rows : List Record)
    (held : initial ∈ system.states) (path : Path system initial actions before terminal)
    (retained : Records table reference (before++[terminal]) rows)
    (action : String) (edge : step system terminal action = .ok next)
    (approximation : List Number) (ledger : List NumericalError.Row)
    (registered : lookupFirst table next = some approximation)
    (exact : exactErrorLedger reference approximation = .ok ledger)
    (carrier : List String) (relation : OrderOperations.Relation) (lower upper : String)
    (enclosed : next ∈ interval carrier relation lower upper)
    (systemAdmission : create system.states system.actions system.transitions = .ok system)
    (orderAdmission : isPartialOrder carrier relation = true) :
    TerminalCertificate table reference system initial (actions++[action]) ((before++[terminal])++[next])
      (rows++[(next,approximation,ledger)]) carrier relation lower upper next := by
  have update := updateSuccessor _ _ _ _ _ _ _ _ _ held path retained _ edge _ _ registered exact
  exact ⟨systemAdmission,orderAdmission,update.1,update.2,⟨before++[terminal],rfl⟩,enclosed⟩


theorem identityCertificate (table : ValueTable) (reference : List Number) (system : System)
    (state : String) (held : state ∈ system.states) (approximation : List Number) (ledger : List NumericalError.Row)
    (registered : lookupFirst table state = some approximation)
    (exact : exactErrorLedger reference approximation = .ok ledger)
    (carrier : List String) (relation : OrderOperations.Relation) (lower upper : String)
    (enclosed : state ∈ interval carrier relation lower upper)
    (systemAdmission : create system.states system.actions system.transitions = .ok system)
    (orderAdmission : isPartialOrder carrier relation = true) :
    TerminalCertificate table reference system state [] [state] [(state,approximation,ledger)]
      carrier relation lower upper state := by
  refine ⟨systemAdmission,orderAdmission,(runAdmission _ _ _ _).mpr ⟨held,rfl⟩,?_,⟨[],rfl⟩,enclosed⟩
  exact NumericalTrace.replay _ _ _ _ (.next _ _ _ _ _ registered exact .base)

end SFT.Computation.NumericalBoundary
