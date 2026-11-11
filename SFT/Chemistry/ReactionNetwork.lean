import SFT.Chemistry.CatalyticSelectivity
import SFT.Mathematics.GraphInduction
import SFT.Mathematics.CategoryIdentity
namespace SFT.Chemistry.ReactionNetwork
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev Raw := CatalyticSelectivity.Raw
abbrev admit := CatalyticSelectivity.admit

def speciesPairs (left right : List String) : List Edge :=
 left.flatMap (fun a => right.map (fun b => (a,b)))

def reactionEdges (r : ReactionIdentity.Reaction) : List Edge :=
 speciesPairs r.trace.raw.reactants r.trace.raw.products

def edges : List ReactionIdentity.Reaction → List Edge
 | [] => []
 | r::rest => reactionEdges r++edges rest

theorem pairMembership (left right : List String) (a b : String) :
 (a,b)∈speciesPairs left right ↔ a∈left ∧ b∈right := by
 induction left with
 | nil =>
   constructor
   · intro h; cases h
   · intro h; cases h.1
 | cons first rest ih =>
   change (a,b)∈right.map (fun b => (first,b))++speciesPairs rest right ↔ _
   constructor
   · intro h
     cases memAppendCases _ _ _ h with
     | inl h =>
       obtain ⟨held,member,same⟩ := memMapPreimage (fun b => (first,b)) (a,b) right h
       cases same
       exact ⟨.head _,member⟩
     | inr h =>
       have h := ih.mp h
       exact ⟨.tail _ h.1,h.2⟩
   · intro h
     cases h.1 with
     | head => exact memAppendLeft _ _ _ (memMap (fun b => (a,b)) b right h.2)
     | tail _ held => exact memAppendRight _ _ _ (ih.mpr ⟨held,h.2⟩)

theorem edgeSource (steps : List ReactionIdentity.Reaction) (a b : String) :
 (a,b)∈edges steps ↔ ∃ r, r∈steps ∧ a∈r.trace.raw.reactants ∧ b∈r.trace.raw.products := by
 induction steps with
 | nil =>
   constructor
   · intro h; cases h
   · intro ⟨r,h,_⟩; cases h
 | cons first rest ih =>
   constructor
   · intro h
     cases memAppendCases _ _ _ h with
     | inl h => exact ⟨first,.head _,(pairMembership _ _ _ _).mp h⟩
     | inr h =>
       obtain ⟨r,held,parts⟩ := ih.mp h
       exact ⟨r,.tail _ held,parts⟩
   · intro ⟨r,held,parts⟩
     cases held with
     | head => exact memAppendLeft _ _ _ ((pairMembership _ _ _ _).mpr parts)
     | tail _ held => exact memAppendRight _ _ _ (ih.mpr ⟨r,held,parts⟩)

structure Network where
 raw : Raw
 accepted : admit raw=.ok raw
 steps : List ReactionIdentity.Reaction
 completeSupports : raw.reactions.map (fun p => (p.1.value,p.2.value))=
  steps.map (fun r => (r.trace.raw.reactants.length,r.trace.raw.products.length))
 sourceBoundary : List HeldLabel
 productBoundary : List HeldLabel
 sourceRecord : SFT.Host.Canonical.Value
 sourceBoundaryHeld : ∀ carrier∈sourceBoundary, carrier∈raw.species
 productBoundaryHeld : ∀ carrier∈productBoundary, carrier∈raw.species
 inputCoverage : ∀ r∈steps, ∀ a∈r.trace.raw.reactants, a∈raw.species.map (fun x => x.label)
 outputCoverage : ∀ r∈steps, ∀ b∈r.trace.raw.products, b∈raw.species.map (fun x => x.label)

def graph (n : Network) : GeneratedGraph := ⟨n.raw.species.map (fun x => x.label),edges n.steps⟩

theorem allIncidencesSourceBound (n : Network) (a b : String) :
 (a,b)∈(graph n).edges ↔ ∃ r, r∈n.steps ∧ a∈r.trace.raw.reactants ∧ b∈r.trace.raw.products := edgeSource _ _ _

theorem everyEdgeHasSpecies (n : Network) (edge : Edge) (held : edge∈(graph n).edges) :
 edge.1∈(graph n).nodes ∧ edge.2∈(graph n).nodes := by
 obtain ⟨r,member,input,output⟩ := (edgeSource n.steps edge.1 edge.2).mp held
 exact ⟨n.inputCoverage r member _ input,n.outputCoverage r member _ output⟩

theorem completePathsExactly (n : Network) (origin target : String) :
 reachable (graph n) origin target=true ↔ PathWitness (graph n) origin target :=
 ⟨reachableHasPath _ _ _ (everyEdgeHasSpecies n),pathWitnessReachable _ _ _⟩

theorem sharedSpeciesCompose (n : Network) (origin middle target : String)
 (first : PathWitness (graph n) origin middle) (second : PathWitness (graph n) middle target) :
 PathWitness (graph n) origin target := composePathWitnesses _ _ _ _ first second

theorem oneBalancedEdge (n : Network) (r : ReactionIdentity.Reaction) (held : r∈n.steps)
 (a b : String) (input : a∈r.trace.raw.reactants) (output : b∈r.trace.raw.products) :
 PathWitness (graph n) a b :=
 extendPathWitness _ _ _ _ (identityPathWitness _ _ (n.inputCoverage r held a input))
 ((edgeSource _ _ _).mpr ⟨r,held,input,output⟩) (n.outputCoverage r held b output)

theorem branchesRetained (n : Network) (a b c : String)
 (left : (a,b)∈(graph n).edges) (right : (a,c)∈(graph n).edges) :
 PathWitness (graph n) a b ∧ PathWitness (graph n) a c :=
 ⟨extendPathWitness _ _ _ _ (identityPathWitness _ _ (everyEdgeHasSpecies n _ left).1) left (everyEdgeHasSpecies n _ left).2,
 extendPathWitness _ _ _ _ (identityPathWitness _ _ (everyEdgeHasSpecies n _ right).1) right (everyEdgeHasSpecies n _ right).2⟩

theorem mergesRetained (n : Network) (a b c : String)
 (left : (a,c)∈(graph n).edges) (right : (b,c)∈(graph n).edges) :
 PathWitness (graph n) a c ∧ PathWitness (graph n) b c :=
 ⟨extendPathWitness _ _ _ _ (identityPathWitness _ _ (everyEdgeHasSpecies n _ left).1) left (everyEdgeHasSpecies n _ left).2,
 extendPathWitness _ _ _ _ (identityPathWitness _ _ (everyEdgeHasSpecies n _ right).1) right (everyEdgeHasSpecies n _ right).2⟩

theorem cyclesExactlyRetained (n : Network) : directedCycleExists (graph n)=true ↔
 ∃ node, node∈(graph n).nodes ∧ ∃ trace, ReturnTrace (graph n).edges node [node] trace :=
 directedCycleIffReturnTrace _

def flows (steps : List ReactionIdentity.Reaction) := ReactionIdentity.flows (steps.flatMap (fun r => r.placements))

theorem allCarriersBalanced (n : Network) (test : HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (flows n.steps)=
 SFT.Physics.MatterConservedLabels.outputCount test (flows n.steps) :=
 ReactionIdentity.noCarrierLoss _ _

def sourceTrace (n : Network) := (n.raw,n.steps,n.sourceBoundary,n.productBoundary,n.sourceRecord)

theorem edgeSuccessor (steps : List ReactionIdentity.Reaction) (fresh : ReactionIdentity.Reaction) :
 edges (steps++[fresh])=edges steps++reactionEdges fresh := by
 induction steps with
 | nil => exact (SFT.Mathematics.CategoryIdentity.appendNil _)
 | cons r rest ih =>
   change reactionEdges r++edges (rest++[fresh])=(reactionEdges r++edges rest)++reactionEdges fresh
   rw [ih,SFT.Mathematics.ExactTraceArithmetic.appendAssociative]

structure Extension where
 prior : Network
 following : Network
 fresh : ReactionIdentity.Reaction
 completeSteps : following.steps=prior.steps++[fresh]
 retainedSpecies : ∀ node∈(graph prior).nodes, node∈(graph following).nodes
 sameSourceBoundary : following.sourceBoundary=prior.sourceBoundary
 sameProductBoundary : following.productBoundary=prior.productBoundary

theorem completeNewIncidences (e : Extension) : (graph e.following).edges=(graph e.prior).edges++reactionEdges e.fresh := by
 change edges e.following.steps=edges e.prior.steps++reactionEdges e.fresh
 rw [e.completeSteps,edgeSuccessor]

theorem oldIncidencesRetained (e : Extension) (edge : Edge) (held : edge∈(graph e.prior).edges) :
 edge∈(graph e.following).edges := by
 rw [completeNewIncidences]
 exact memAppendLeft _ _ _ held

theorem allPriorPathsRetained (e : Extension) (a b : String) (path : PathWitness (graph e.prior) a b) :
 PathWitness (graph e.following) a b := retainedPathWitness _ _ e.retainedSpecies (oldIncidencesRetained e) _ _ path

theorem newPathSourceIncidences (e : Extension) (a b : String)
 (path : PathWitness (graph e.following) a b) :
 ∃ prefixNodes, pathIsValid (graph e.following) (prefixNodes++[b])=true ∧
 (prefixNodes++[b]).head?=some a ∧
 ∀ edge∈adjacentPairs (prefixNodes++[b]), edge∈(graph e.prior).edges ∨ edge∈reactionEdges e.fresh := by
 obtain ⟨prefixNodes,valid,start⟩ := path
 refine ⟨prefixNodes,valid,start,?_⟩
 intro edge held
 have h := ((pathMeaning _ _).mp valid).2.2 edge held
 rw [completeNewIncidences] at h
 exact memAppendCases _ _ _ h
theorem cycleTraceExtension (e : Extension) (node : String) (held trace : List String)
 (cycle : ReturnTrace (graph e.prior).edges node held trace) :
 ReturnTrace (graph e.following).edges node held trace := by
 induction cycle with
 | closes node held target edge returned =>
   exact .closes node held target (oldIncidencesRetained e _ edge) returned
 | advances node held next trace edge fresh tail ih =>
   exact .advances node held next trace (oldIncidencesRetained e _ edge) fresh ih

theorem oldCycleDetected (e : Extension) (cycle : directedCycleExists (graph e.prior)=true) :
 directedCycleExists (graph e.following)=true := by
 obtain ⟨node,member,trace,witness⟩ := (cyclesExactlyRetained e.prior).mp cycle
 exact (cyclesExactlyRetained e.following).mpr
  ⟨node,e.retainedSpecies node member,trace,cycleTraceExtension e node [node] trace witness⟩

theorem successorRetainsBoundaries (e : Extension) :
 e.following.sourceBoundary=e.prior.sourceBoundary ∧ e.following.productBoundary=e.prior.productBoundary :=
 ⟨e.sameSourceBoundary,e.sameProductBoundary⟩
end SFT.Chemistry.ReactionNetwork
