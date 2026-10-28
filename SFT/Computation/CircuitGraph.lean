import SFT.Computation.CircuitComposition
import SFT.Mathematics.GraphCycleTrace
import SFT.Mathematics.GraphPathCompleteness
namespace SFT.Computation.CircuitGraph
open CircuitComposition SFT.Mathematics.CategoryPaths SFT.Mathematics.GraphOperations

def Registered (graph : GeneratedGraph) (component : Arrow) : Prop :=
  component.source ∈ graph.nodes ∧ component.target ∈ graph.nodes ∧
    (component.source,component.target) ∈ graph.edges

theorem evaluationPath (graph : GeneratedGraph) (initial result : Arrow) (locals : List Arrow)
    (evaluation : Evaluation initial locals result) (held : initial.target ∈ graph.nodes)
    (registered : ∀ component, component ∈ locals → Registered graph component) :
    PathWitness graph initial.target result.target := by
  revert held registered
  induction evaluation with
  | identity current => intro held _; exact identityPathWitness _ _ held
  | next current component combined rest result edge later ih =>
    intro held registered
    have componentHeld := registered component (.head _)
    have interfaces := (composeResult _ _ _ edge).1
    have terminal := (composeRetains _ _ _ edge).2.1
    have wire : (current.target,component.target) ∈ graph.edges := by
      rw [interfaces]; exact componentHeld.2.2
    have one := extendPathWitness graph current.target current.target component.target
      (identityPathWitness _ _ held) wire componentHeld.2.1
    have nextHeld : combined.target ∈ graph.nodes := by rw [terminal]; exact componentHeld.2.1
    have remaining := ih nextHeld (fun component hm => registered component (.tail _ hm))
    rw [terminal] at remaining
    exact composePathWitnesses _ _ _ _ one remaining

theorem outputHeld (graph : GeneratedGraph) (initial result : Arrow) (locals : List Arrow)
    (evaluation : Evaluation initial locals result) (held : initial.target ∈ graph.nodes)
    (registered : ∀ component, component ∈ locals → Registered graph component) :
    result.target ∈ graph.nodes :=
  pathWitnessTarget _ _ _ (evaluationPath _ _ _ _ evaluation held registered)

def FeedForward (graph : GeneratedGraph) : Prop := directedCycleExists graph = false

theorem declaredCycleTrace (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph) :
    directedCycleExists graph = true ↔
      ∃ node before target, node ∈ graph.nodes ∧
        pathIsValid graph (node :: (before ++ [target])) = true ∧ target ∈ node :: before :=
  admittedCycleIffCompleteReturnPath _ _ _ admitted

theorem feedForwardExcludesReturn (graph : GeneratedGraph) (forward : FeedForward graph)
    (node : String) (before : List String) (target : String) (held : node ∈ graph.nodes)
    (path : pathIsValid graph (node :: (before ++ [target])) = true) : target ∉ node :: before := by
  intro returned
  have cycle := completeReturnPathDetected graph node before target held path returned
  rw [forward] at cycle
  cases cycle

end SFT.Computation.CircuitGraph
