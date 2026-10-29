import SFT.Computation.ApproximateError
import SFT.Computation.ApproximateDistinctions
import SFT.Computation.ResourceRecord
namespace SFT.Computation.ApproximateTrace
open ApproximateBound ApproximateError NumericalTrace StateTransition StateComposition
open SFT.Mathematics OptimizationSelection ProbabilityObservations GeometryTopology
open SFT.InformationScience ConservationLedger

structure Certificate where
  candidates : List String
  verdicts : Verdicts
  feasible : List String
  feasibility : feasibleCarrier candidates verdicts = .ok feasible
  preferred : Preference
  preferenceAdmission : preferenceValid feasible preferred = true
  objectives : ObjectiveRows
  objectiveCoverage : ∀ candidate, candidate ∈ feasible → ∃ cells, (candidate,cells) ∈ objectives
  objectiveDomain : ∀ row, row ∈ objectives → row.1 ∈ feasible
  bound : BoundRecord objectives
  optimumHeld : bound.optimum ∈ OptimizationSelection.retained feasible preferred
  exactObservation : Observation
  objectiveIdentity : ∀ row, row ∈ objectives → image exactObservation row.1 = some (toString row.2)
  exactAdmission : validateTransformation feasible exactObservation = .ok exactObservation
  approximateObservation : Observation
  approximateAdmission : validateTransformation feasible approximateObservation = .ok approximateObservation
  system : System
  systemAdmission : create system.states system.actions system.transitions = .ok system
  initial : String
  initialHeld : initial ∈ system.states
  actions : List String
  before : List String
  terminal : String
  path : Path system initial actions before terminal
  values : ValueTable
  priorRecords : List NumericalTrace.Record
  prior : Records values [.positive (referenceValue objectives bound)] before priorRecords
  outputRow : SFT.InformationScience.EncodingMaps.lookupFirst values terminal = some [.positive (candidateValue objectives bound)]
  occupied : List String
  resources : ResourceRecord.Ledger
  resourceAdmission : ResourceRecord.resourceLedger (before++[terminal]) occupied = .ok resources

def resultRecords (c : Certificate) : List NumericalTrace.Record :=
  c.priorRecords ++ [(c.terminal,[.positive (candidateValue c.objectives c.bound)],[errorRow c.objectives c.bound])]

theorem candidateFeasible (c : Certificate) : c.bound.candidate ∈ c.feasible :=
  c.objectiveDomain _ c.bound.candidateRow

theorem optimumUneliminated (c : Certificate) :
    c.bound.optimum ∈ c.feasible ∧ ∀ better, ¬ (better,c.bound.optimum) ∈ c.preferred :=
  (retainedMembership _ _ _).mp c.optimumHeld

theorem originalObjective (c : Certificate) :
    image c.exactObservation c.bound.candidate = some (toString c.bound.candidateCells) ∧
    image c.exactObservation c.bound.optimum = some (toString c.bound.optimumCells) :=
  ⟨c.objectiveIdentity _ c.bound.candidateRow,c.objectiveIdentity _ c.bound.optimumRow⟩

theorem completeRecords (c : Certificate) :
    Records c.values [.positive (referenceValue c.objectives c.bound)] (c.before++[c.terminal]) (resultRecords c) :=
  appendTerminal _ _ _ _ _ _ c.prior c.outputRow

theorem actualExecution (c : Certificate) :
    run c.system c.initial c.actions = .ok (c.before++[c.terminal]) :=
  (runAdmission _ _ _ _).mpr ⟨c.initialHeld,(runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ c.path)⟩

theorem observedExecution (c : Certificate) :
    records c.values [.positive (referenceValue c.objectives c.bound)] (c.before++[c.terminal]) = some (resultRecords c) :=
  replay _ _ _ _ (completeRecords c)

theorem allStateIdentities (c : Certificate) :
    (resultRecords c).map Prod.fst = c.before++[c.terminal] :=
  identityTrace _ _ _ _ (completeRecords c)

theorem fullResourceTrace (c : Certificate) :
    c.resources.timeTrace.map Prod.snd = c.before++[c.terminal] ∧
    c.resources.spaceSupport = c.occupied ∧
    c.resources.timeCount = c.actions.length+1 ∧
    c.resources.spaceCount = c.occupied.length := by
  have r := ResourceRecord.recordReconstructs _ _ _ c.resourceAdmission
  exact ⟨r.1,r.2.1,ResourceRecord.executionObservationCount _ _ _ _ _ _ (actualExecution c) c.resourceAdmission,r.2.2.2⟩

theorem observationCount (c : Certificate) : (resultRecords c).length = c.actions.length+1 :=
  nativeCount _ _ _ _ _ _ _ (actualExecution c) (observedExecution c)

theorem sourceCompleteDistinctions (c : Certificate) (pair : Pair)
    (source : pair ∈ ConservationLedger.retained c.feasible c.exactObservation) :
    pair ∈ ApproximateDistinctions.lost c.feasible c.exactObservation c.approximateObservation ∨
    pair ∈ ApproximateDistinctions.kept c.feasible c.exactObservation c.approximateObservation :=
  ApproximateDistinctions.completeLedger _ _ _ _ source

-- Identity, serial continuation and successor retain the same error reference
-- and include the exact next bound observation; every occupied cell is retained.
theorem identityObservation (rows : ObjectiveRows) (bound : BoundRecord rows) (table : ValueTable)
    (system : System) (state : String) (held : state ∈ system.states)
    (registered : SFT.InformationScience.EncodingMaps.lookupFirst table state = some [.positive (candidateValue rows bound)]) :
    run system state [] = .ok [state] ∧
    records table [.positive (referenceValue rows bound)] [state] =
      some [(state,[.positive (candidateValue rows bound)],[errorRow rows bound])] := by
  constructor
  · exact (runAdmission _ _ _ _).mpr ⟨held,rfl⟩
  · exact terminalObservation _ _ _ _ registered

theorem serialRecords (c : Certificate) (more : List String) (extra : List NumericalTrace.Record)
    (continuation : Records c.values [.positive (referenceValue c.objectives c.bound)] more extra) :
    Records c.values [.positive (referenceValue c.objectives c.bound)]
      ((c.before++[c.terminal])++more) (resultRecords c++extra) :=
  composition _ _ _ _ _ _ (completeRecords c) continuation

theorem successorObservation (c : Certificate) (next action : String)
    (edge : step c.system c.terminal action = .ok next)
    (registered : SFT.InformationScience.EncodingMaps.lookupFirst c.values next =
      some [.positive (candidateValue c.objectives c.bound)]) :
    run c.system c.initial (c.actions++[action]) = .ok ((c.before++[c.terminal])++[next]) ∧
    records c.values [.positive (referenceValue c.objectives c.bound)] ((c.before++[c.terminal])++[next]) =
      some (resultRecords c++[(next,[.positive (candidateValue c.objectives c.bound)],[errorRow c.objectives c.bound])]) :=
  updateSuccessor _ _ _ _ _ _ _ _ _ c.initialHeld c.path (completeRecords c) action edge _ _ registered (exactError _ _)

theorem successorChangedCandidate (c : Certificate) (newRows : ObjectiveRows) (nextBound : BoundRecord newRows)
    (sameReference : referenceValue newRows nextBound = referenceValue c.objectives c.bound)
    (next action : String) (edge : step c.system c.terminal action = .ok next)
    (registered : SFT.InformationScience.EncodingMaps.lookupFirst c.values next =
      some [.positive (candidateValue newRows nextBound)]) :
    run c.system c.initial (c.actions++[action]) = .ok ((c.before++[c.terminal])++[next]) ∧
    records c.values [.positive (referenceValue c.objectives c.bound)] ((c.before++[c.terminal])++[next]) =
      some (resultRecords c++[(next,[.positive (candidateValue newRows nextBound)],[errorRow newRows nextBound])]) := by
  have error := exactError newRows nextBound
  rw [sameReference] at error
  exact updateSuccessor _ _ _ _ _ _ _ _ _ c.initialHeld c.path (completeRecords c) action edge _ _ registered error

end SFT.Computation.ApproximateTrace
