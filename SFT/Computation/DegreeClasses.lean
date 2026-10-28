import SFT.Computation.ReductionTrace
import SFT.Mathematics.GraphInduction
namespace SFT.Computation.DegreeClasses
open SFT.Mathematics GraphOperations DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

def Mutual (graph : GeneratedGraph) (left right : String) : Prop :=
  reachable graph left right = true ∧ reachable graph right left = true

def degreeClass (graph : GeneratedGraph) (representative : String) : List String :=
  graph.nodes.filter (fun node => reachable graph representative node && reachable graph node representative)

def Strict (graph : GeneratedGraph) (left right : String) : Prop :=
  left ∈ graph.nodes ∧ right ∈ graph.nodes ∧
    reachable graph left right = true ∧ reachable graph right left = false

def Incomparable (graph : GeneratedGraph) (left right : String) : Prop :=
  left ∈ graph.nodes ∧ right ∈ graph.nodes ∧
    reachable graph left right = false ∧ reachable graph right left = false

theorem mutualReflexive (graph : GeneratedGraph) (node : String) (held : node ∈ graph.nodes) :
    Mutual graph node node := ⟨(reachableReflexiveIff _ _).mpr held,(reachableReflexiveIff _ _).mpr held⟩

theorem mutualSymmetric (graph : GeneratedGraph) (left right : String) (both : Mutual graph left right) :
    Mutual graph right left := ⟨both.2,both.1⟩

theorem mutualTransitive (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph) (left middle right : String)
    (first : Mutual graph left middle) (second : Mutual graph middle right) : Mutual graph left right :=
  ⟨admittedReachabilityTransitive _ _ _ admitted _ _ _ first.1 second.1,
   admittedReachabilityTransitive _ _ _ admitted _ _ _ second.2 first.2⟩

theorem classMembership (graph : GeneratedGraph) (representative node : String) :
    node ∈ degreeClass graph representative ↔ node ∈ graph.nodes ∧ Mutual graph representative node := by
  constructor
  · intro member
    have h := (filterMemberIff _ _ _).mp member
    have pair := (SFT.Foundation.Count.Representation.andTrue _ _).mp h.2
    exact ⟨h.1,pair⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(SFT.Foundation.Count.Representation.andTrue _ _).mpr h.2⟩

theorem classContainsRepresentative (graph : GeneratedGraph) (node : String) (held : node ∈ graph.nodes) :
    node ∈ degreeClass graph node := (classMembership _ _ _).mpr ⟨held,mutualReflexive _ _ held⟩

theorem representativeIndependent (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph) (left right : String) (equivalent : Mutual graph left right)
    (node : String) : node ∈ degreeClass graph left ↔ node ∈ degreeClass graph right := by
  constructor
  · intro member
    have h := (classMembership _ _ _).mp member
    exact (classMembership _ _ _).mpr ⟨h.1,mutualTransitive _ _ _ admitted _ _ _
      (mutualSymmetric _ _ _ equivalent) h.2⟩
  · intro member
    have h := (classMembership _ _ _).mp member
    exact (classMembership _ _ _).mpr ⟨h.1,mutualTransitive _ _ _ admitted _ _ _ equivalent h.2⟩

theorem overlappingClassesMutual (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph) (left right shared : String)
    (first : shared ∈ degreeClass graph left) (second : shared ∈ degreeClass graph right) : Mutual graph left right :=
  mutualTransitive _ _ _ admitted _ _ _ ((classMembership _ _ _).mp first).2
    (mutualSymmetric _ _ _ ((classMembership _ _ _).mp second).2)

theorem strictExcludesMutual (graph : GeneratedGraph) (left right : String)
    (strict : Strict graph left right) : ¬ Mutual graph left right := by
  intro both
  have reverse := both.2
  rw [strict.2.2.2] at reverse
  cases reverse

theorem strictTransitive (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph) (left middle right : String)
    (first : Strict graph left middle) (second : Strict graph middle right) : Strict graph left right := by
  refine ⟨first.1,second.2.1,admittedReachabilityTransitive _ _ _ admitted _ _ _ first.2.2.1 second.2.2.1,?_⟩
  cases reverse : reachable graph right left with
  | false => rfl
  | true =>
    have impossible := admittedReachabilityTransitive _ _ _ admitted _ _ _ second.2.2.1 reverse
    rw [first.2.2.2] at impossible
    cases impossible

theorem incomparabilityWitness (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph) (left right : String)
    (separated : Incomparable graph left right) :
    ¬ PathWitness graph left right ∧ ¬ PathWitness graph right left := by
  constructor
  · intro path
    have hit := pathWitnessReachable _ _ _ path
    rw [separated.2.2.1] at hit; cases hit
  · intro path
    have hit := pathWitnessReachable _ _ _ path
    rw [separated.2.2.2] at hit; cases hit

theorem mutualRetained (nodes : List String) (edges : List Edge) (old extended : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok old)
    (nodesHeld : ∀ node, node ∈ old.nodes → node ∈ extended.nodes)
    (edgesHeld : ∀ edge, edge ∈ old.edges → edge ∈ extended.edges)
    (left right : String) (prior : Mutual old left right) : Mutual extended left right :=
  ⟨retainedReachability _ _ _ _ admitted nodesHeld edgesHeld _ _ prior.1,
   retainedReachability _ _ _ _ admitted nodesHeld edgesHeld _ _ prior.2⟩

-- Every edge in a retained reachability trace retains its actual reduction
-- maps and bidirectional correctness certificate from the preceding entry.
open ReductionTrace

theorem certifiedClosureTrace (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph)
    (domains : String → List String) (answers : String → String → String → Prop)
    (certified : ∀ edge, edge ∈ graph.edges → ∃ inputMap answerMap,
      TotalOn inputMap (domains edge.1) (domains edge.2) ∧
      PreservesAnswers (domains edge.1) inputMap answerMap (answers edge.1) (answers edge.2))
    (origin target : String) (reaches : reachable graph origin target = true) :
    ∃ prior : List String, pathIsValid graph (prior ++ [target]) = true ∧
      (prior ++ [target]).head? = some origin ∧
      ∀ edge, edge ∈ adjacentPairs (prior ++ [target]) → ∃ inputMap answerMap,
        TotalOn inputMap (domains edge.1) (domains edge.2) ∧
        PreservesAnswers (domains edge.1) inputMap answerMap (answers edge.1) (answers edge.2) := by
  obtain ⟨prior,valid,head⟩ := admittedReachabilityHasPath _ _ _ admitted _ _ reaches
  exact ⟨prior,valid,head,fun edge member => certified edge ((pathMeaning _ _).mp valid |>.2.2 edge member)⟩

theorem reachTransport (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph) (left newLeft right newRight : String)
    (leftClass : Mutual graph left newLeft) (rightClass : Mutual graph right newRight)
    (prior : reachable graph left right = true) : reachable graph newLeft newRight = true :=
  admittedReachabilityTransitive _ _ _ admitted _ _ _ leftClass.2
    (admittedReachabilityTransitive _ _ _ admitted _ _ _ prior rightClass.1)

theorem absenceTransport (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph) (left newLeft right newRight : String)
    (leftClass : Mutual graph left newLeft) (rightClass : Mutual graph right newRight)
    (prior : reachable graph left right = false) : reachable graph newLeft newRight = false := by
  cases result : reachable graph newLeft newRight with
  | false => rfl
  | true =>
    have impossible := reachTransport _ _ _ admitted _ _ _ _
      (mutualSymmetric _ _ _ leftClass) (mutualSymmetric _ _ _ rightClass) result
    rw [prior] at impossible
    cases impossible

theorem strictRepresentative (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph) (left newLeft right newRight : String)
    (leftClass : Mutual graph left newLeft) (rightClass : Mutual graph right newRight)
    (prior : Strict graph left right) : Strict graph newLeft newRight :=
  ⟨pathWitnessTarget _ _ _ (admittedReachabilityHasPath _ _ _ admitted _ _ leftClass.1),
   pathWitnessTarget _ _ _ (admittedReachabilityHasPath _ _ _ admitted _ _ rightClass.1),
   reachTransport _ _ _ admitted _ _ _ _ leftClass rightClass prior.2.2.1,
   absenceTransport _ _ _ admitted _ _ _ _ rightClass leftClass prior.2.2.2⟩

theorem incomparableRepresentative (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (admitted : makeGraph nodes edges = .ok graph) (left newLeft right newRight : String)
    (leftClass : Mutual graph left newLeft) (rightClass : Mutual graph right newRight)
    (prior : Incomparable graph left right) : Incomparable graph newLeft newRight :=
  ⟨pathWitnessTarget _ _ _ (admittedReachabilityHasPath _ _ _ admitted _ _ leftClass.1),
   pathWitnessTarget _ _ _ (admittedReachabilityHasPath _ _ _ admitted _ _ rightClass.1),
   absenceTransport _ _ _ admitted _ _ _ _ leftClass rightClass prior.2.2.1,
   absenceTransport _ _ _ admitted _ _ _ _ rightClass leftClass prior.2.2.2⟩

theorem oneDegree : degreeClass ⟨["One"],[]⟩ "One" = ["One"] := rfl

end SFT.Computation.DegreeClasses
