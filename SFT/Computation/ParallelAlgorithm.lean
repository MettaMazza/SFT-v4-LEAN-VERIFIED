import SFT.Computation.ScheduledAlgorithm
import SFT.Computation.DynamicProgrammingTrace
namespace SFT.Computation.ParallelAlgorithm
open DynamicProgrammingTrace ParallelResources
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics GraphOperations

-- All members of a ready layer read the same prior retained result table.
def layerRun (rules : List Rule) (before : Table) : List Task → Option Table
 | [] => some []
 | (key,deps) :: rest => match inputs before deps with
   | none => none
   | some values => match result rules key values with
     | none => none
     | some value => match layerRun rules before rest with
       | none => none
       | some rows => some ((key,value) :: rows)

inductive LayerExecution (rules : List Rule) (before : Table) : List Task → Table → Prop where
 | base : LayerExecution rules before [] []
 | next (key deps values value rest rows)
     (reads : Reads before deps values) (recurrence : result rules key values = some value)
     (tail : LayerExecution rules before rest rows) :
     LayerExecution rules before ((key,deps) :: rest) ((key,value) :: rows)

theorem layerReplay (rules : List Rule) (before rows : Table) (tasks : List Task)
    (trace : LayerExecution rules before tasks rows) : layerRun rules before tasks = some rows := by
  induction trace with
  | base => rfl
  | next key deps values value rest rows reads recurrence tail ih =>
    unfold layerRun; rw [readsReconstruct _ _ _ reads]; dsimp only; rw [recurrence]; dsimp only; rw [ih]

theorem layerDerivation (rules : List Rule) (before rows : Table) (tasks : List Task)
    (run : layerRun rules before tasks = some rows) : LayerExecution rules before tasks rows := by
  induction tasks generalizing rows with
  | nil => cases run; exact .base
  | cons task rest ih =>
    cases task with
    | mk key deps =>
      unfold layerRun at run
      cases h : inputs before deps with
      | none => rw [h] at run; contradiction
      | some values =>
        rw [h] at run; dsimp only at run
        cases selected : result rules key values with
        | none => rw [selected] at run; contradiction
        | some value =>
          rw [selected] at run; dsimp only at run
          cases later : layerRun rules before rest with
          | none => rw [later] at run; contradiction
          | some tail => rw [later] at run; cases run; exact .next _ _ _ _ _ _ (inputsReads _ _ _ h) selected (ih _ later)

theorem layerIdentities (rules : List Rule) (before rows : Table) (tasks : List Task)
    (trace : LayerExecution rules before tasks rows) : rows.map Prod.fst = tasks.map Prod.fst := by
  induction trace with
  | base => rfl
  | next key deps values value rest rows reads recurrence tail ih => exact congrArg (List.cons key) ih

theorem layerCount (rules : List Rule) (before rows : Table) (tasks : List Task)
    (trace : LayerExecution rules before tasks rows) : rows.length = tasks.length := by
  induction trace with
  | base => rfl
  | next key deps values value rest rows reads recurrence tail ih => exact congrArg Nat.succ ih

theorem localInvariants (rules : List Rule) (graph tasks : List Task) (before rows : Table)
    (property : String → String → Prop)
    (localRule : ∀ key deps values value, (key,deps) ∈ graph →
      (key,values,value) ∈ rules → deps.length = values.length →
      (∀ dep answer, (dep,answer) ∈ deps.zip values → property dep answer) → property key value)
    (covered : ∀ task, task ∈ tasks → task ∈ graph)
    (initial : Validated property before) (trace : LayerExecution rules before tasks rows) :
    Validated property rows := by
  induction trace with
  | base => intro key value impossible; cases impossible
  | next key deps values value rest rows reads recurrence tail ih =>
    have proved := localRule key deps values value (covered _ (.head _))
      (selectedRow _ _ _ _ recurrence) (readCount _ _ _ reads).symm
      (fun dep answer held => initial dep answer (readProvenance _ _ _ reads dep answer held))
    intro name answer held
    cases held with
    | head => exact proved
    | tail _ member => exact ih (fun task held => covered task (.tail _ held)) name answer member

theorem reconstructedLayer (rules : List Rule) (graph tasks : List Task) (before rows : Table)
    (covered : ∀ task, task ∈ tasks → task ∈ graph)
    (initial : Validated (Derivation graph rules) before)
    (trace : LayerExecution rules before tasks rows) : Validated (Derivation graph rules) rows :=
  localInvariants _ _ _ _ _ _ (fun key deps values value decomposition row count children =>
    .step key value deps values decomposition row count children) covered initial trace

theorem appendValidated (property : String → String → Prop) (before rows : Table)
    (one : Validated property before) (two : Validated property rows) : Validated property (before ++ rows) := by
  intro key value held
  cases memAppendCases _ _ _ held with
  | inl old => exact one _ _ old
  | inr added => exact two _ _ added

def executeLayers (rules : List Rule) (before : Table) : List (List Task) → Option Table
 | [] => some before
 | layer :: rest => match layerRun rules before layer with
   | none => none
   | some rows => executeLayers rules (before ++ rows) rest

inductive Execution (rules : List Rule) : Table → List (List Task) → Table → Prop where
 | base (before) : Execution rules before [] before
 | next (before layer rows rest terminal)
     (localTrace : LayerExecution rules before layer rows)
     (tail : Execution rules (before ++ rows) rest terminal) :
     Execution rules before (layer :: rest) terminal

theorem executionReplay (rules : List Rule) (before terminal : Table) (layers : List (List Task))
    (trace : Execution rules before layers terminal) : executeLayers rules before layers = some terminal := by
  induction trace with
  | base => rfl
  | next before layer rows rest terminal localTrace tail ih =>
    unfold executeLayers; rw [layerReplay _ _ _ _ localTrace]; exact ih

theorem executionDerivation (rules : List Rule) (before terminal : Table) (layers : List (List Task))
    (run : executeLayers rules before layers = some terminal) : Execution rules before layers terminal := by
  induction layers generalizing before with
  | nil => cases run; exact .base _
  | cons layer rest ih =>
    unfold executeLayers at run
    cases h : layerRun rules before layer with
    | none => rw [h] at run; contradiction
    | some rows => rw [h] at run; exact .next _ _ _ _ _ (layerDerivation _ _ _ _ h) (ih _ run)

theorem completeReconstruction (rules : List Rule) (graph : List Task) (before terminal : Table)
    (layers : List (List Task))
    (covered : ∀ layer, layer ∈ layers → ∀ task, task ∈ layer → task ∈ graph)
    (initial : Validated (Derivation graph rules) before)
    (trace : Execution rules before layers terminal) : Validated (Derivation graph rules) terminal := by
  induction trace with
  | base => exact initial
  | next before layer rows rest terminal localTrace tail ih =>
    exact ih (fun layer held => covered layer (.tail _ held))
      (appendValidated _ _ _ initial (reconstructedLayer _ _ _ _ _ (covered _ (.head _)) initial localTrace))

theorem synchronizedDependencies (graph : GeneratedGraph) (before : Table) (tasks : List Task)
    (ready : tasks.map Prod.fst ∈ readyChoices graph (before.map Prod.fst))
    (sourceRows : ∀ task, task ∈ tasks → ∀ dep, dep ∈ task.2 → (dep,task.1) ∈ graph.edges) :
    ∀ task, task ∈ tasks → ∀ dep, dep ∈ task.2 → dep ∈ before.map Prod.fst := by
  intro task held dep member
  have r := generatedLayerReady _ _ _ ready task.1 (memMap Prod.fst _ _ held)
  exact r.2.2 dep (sourceRows task held dep member)

theorem independentLayer (graph : GeneratedGraph) (before : Table) (tasks : List Task)
    (ready : tasks.map Prod.fst ∈ readyChoices graph (before.map Prod.fst))
    (first second : Task) (one : first ∈ tasks) (two : second ∈ tasks) : ¬ (first.1,second.1) ∈ graph.edges :=
  generatedLayerIndependent _ _ _ ready _ _ (memMap Prod.fst _ _ one) (memMap Prod.fst _ _ two)

theorem synchronizationLedger (graph : GeneratedGraph) (before : Table) (tasks : List Task)
    (ready : tasks.map Prod.fst ∈ readyChoices graph (before.map Prod.fst)) (edge : String × String)
    (held : edge ∈ synchronizationRows graph (tasks.map Prod.fst)) : edge.1 ∈ before.map Prod.fst :=
  generatedSynchronization _ _ _ ready _ held

theorem composition (rules : List Rule) (before middle terminal : Table) (first second : List (List Task))
    (left : Execution rules before first middle) (right : Execution rules middle second terminal) :
    Execution rules before (first ++ second) terminal := by
  induction left with
  | base => exact right
  | next before layer rows rest middle localTrace tail ih => exact .next _ _ _ _ _ localTrace (ih right)

theorem successor (rules : List Rule) (before middle rows : Table) (layers : List (List Task)) (layer : List Task)
    (prior : Execution rules before layers middle) (next : LayerExecution rules middle layer rows) :
    Execution rules before (layers ++ [layer]) (middle ++ rows) :=
  composition _ _ _ _ _ _ prior (.next _ _ _ _ _ next (.base _))
inductive ScheduledExecution (graph : GeneratedGraph) (rules : List Rule) : Table → List (List Task) → Table → Prop where
 | base (before) : ScheduledExecution graph rules before [] before
 | next (before layer rows rest terminal)
     (ready : layer.map Prod.fst ∈ readyChoices graph (before.map Prod.fst))
     (localTrace : LayerExecution rules before layer rows)
     (tail : ScheduledExecution graph rules (before ++ rows) rest terminal) :
     ScheduledExecution graph rules before (layer :: rest) terminal

theorem scheduledExecution (graph : GeneratedGraph) (rules : List Rule) (before terminal : Table)
    (layers : List (List Task)) (trace : ScheduledExecution graph rules before layers terminal) :
    Execution rules before layers terminal := by
  induction trace with
  | base => exact .base _
  | next before layer rows rest terminal ready localTrace tail ih => exact .next _ _ _ _ _ localTrace ih

theorem scheduledIdentities (graph : GeneratedGraph) (rules : List Rule) (before terminal : Table)
    (layers : List (List Task)) (trace : ScheduledExecution graph rules before layers terminal) :
    LayerSchedule graph (before.map Prod.fst) (layers.map (List.map Prod.fst)) (terminal.map Prod.fst) := by
  induction trace with
  | base => exact .identity _
  | next before layer rows rest terminal ready localTrace tail ih =>
    rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,layerIdentities _ _ _ _ localTrace] at ih
    exact .next _ _ _ _ ready ih

theorem combinedWork (graph : GeneratedGraph) (rules : List Rule) (before terminal : Table)
    (layers : List (List Task)) (trace : ScheduledExecution graph rules before layers terminal) :
    terminal.map Prod.fst = before.map Prod.fst ++ workTrace (layers.map (List.map Prod.fst)) :=
  workReconstruction _ _ _ _ (scheduledIdentities _ _ _ _ _ trace)

theorem workCoverage (graph : GeneratedGraph) (rules : List Rule) (terminal : Table)
    (layers : List (List Task)) (trace : ScheduledExecution graph rules [] layers terminal)
    (complete : ∀ task, task ∈ terminal.map Prod.fst ↔ task ∈ graph.nodes) :
    ∀ task, task ∈ workTrace (layers.map (List.map Prod.fst)) ↔ task ∈ graph.nodes :=
  completeWork _ _ _ (scheduledIdentities _ _ _ _ _ trace) complete

end SFT.Computation.ParallelAlgorithm
