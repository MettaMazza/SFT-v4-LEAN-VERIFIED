import SFT.Physics.GravityWave
import SFT.Mathematics.GraphPathCompleteness
namespace SFT.Physics.GravityHorizon
open SFT.Mathematics.GraphOperations

-- The graph is the complete registered outward causal-support relation.
-- Directed reachability is used; no reverse causal edge is inserted.
def exposed (graph : GeneratedGraph) (observer event : String) : Bool := reachable graph event observer

def confined (graph : GeneratedGraph) (observer event : String) : Prop := exposed graph observer event=false

theorem exactOperationalBoundary (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
 (accepted : makeGraph nodes edges=.ok graph) (observer event : String) :
 exposed graph observer event=true ↔ PathWitness graph event observer :=
 admittedReachabilityIffPath nodes edges graph accepted event observer

theorem confinedExactlyNoOutwardTrace (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
 (accepted : makeGraph nodes edges=.ok graph) (observer event : String) :
 confined graph observer event ↔ ¬ PathWitness graph event observer := by
 constructor
 · intro h path
   have reaches := pathWitnessReachable graph event observer path
   change exposed graph observer event=true at reaches
   rw [h] at reaches
   cases reaches
 · intro absent
   cases result : exposed graph observer event with
   | false => exact result
   | true => exact False.elim (absent ((exactOperationalBoundary nodes edges graph accepted observer event).mp result))

theorem everyEventClassified (graph : GeneratedGraph) (observer event : String) :
 exposed graph observer event=true ∨ confined graph observer event := by
 cases result : exposed graph observer event with
 | false => exact Or.inr result
 | true => exact Or.inl rfl

theorem boundaryClassesDisjoint (graph : GeneratedGraph) (observer event : String)
 (outward : exposed graph observer event=true) : ¬ confined graph observer event := by
 intro inside
 rw [inside] at outward
 cases outward

theorem everyOutwardContinuationRemainsConfined
 (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
 (accepted : makeGraph nodes edges=.ok graph) (observer first last : String)
 (inside : confined graph observer first) (continuation : PathWitness graph first last) :
 confined graph observer last := by
 apply (confinedExactlyNoOutwardTrace nodes edges graph accepted observer last).mpr
 intro escape
 exact (confinedExactlyNoOutwardTrace nodes edges graph accepted observer first).mp inside
  (composePathWitnesses graph first last observer continuation escape)

theorem noTransferWithoutGeneratedTrace (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
 (accepted : makeGraph nodes edges=.ok graph) (observer event : String)
 (inside : confined graph observer event) : ¬ PathWitness graph event observer :=
 (confinedExactlyNoOutwardTrace nodes edges graph accepted observer event).mp inside

theorem observerRetained (graph : GeneratedGraph) (observer : String) (member : observer ∈ graph.nodes) :
 exposed graph observer observer=true := (reachableReflexiveIff graph observer).mpr member

def completeCensus (graph : GeneratedGraph) (observer : String) := graph.nodes.map (fun event => (event,exposed graph observer event))

theorem noEventOmitted (graph : GeneratedGraph) (observer : String) :
 (completeCensus graph observer).map Prod.fst=graph.nodes := by
 have all (nodes : List String) : (nodes.map (fun event => (event,exposed graph observer event))).map Prod.fst=nodes := by
  induction nodes with
  | nil => rfl
  | cons event rest ih => exact congrArg (List.cons event) ih
 exact all graph.nodes
end SFT.Physics.GravityHorizon
