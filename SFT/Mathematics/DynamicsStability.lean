import SFT.Mathematics.DynamicsReturns
import SFT.Mathematics.GraphPathCompleteness
namespace SFT.Mathematics.DynamicsStability
open DiscreteObjects AlgebraOperations GraphOperations SFT.Foundation.Count.TraceDerivation

-- This is the same ordered queue loop as the source, without reachable's carrier-sensitive identity wrapper.
def perturbationReaches (transitions : DynamicsTraces.Transitions) (start terminal : String) : Bool :=
  searchLoop transitions terminal (initialSearch transitions start)

def stableUnderRegisteredPerturbations (transitions : DynamicsTraces.Transitions)
    (terminal : String) (perturbations : List String) : Bool :=
  perturbations.all (fun start => perturbationReaches transitions start terminal)

inductive Reaches (transitions : DynamicsTraces.Transitions) (start : String) : String → Prop where
  | identity : Reaches transitions start start
  | step {left right : String} : Reaches transitions start left → (left,right) ∈ transitions → Reaches transitions start right

theorem searchHasDerivation (transitions : DynamicsTraces.Transitions) (start terminal : String)
    (success : perturbationReaches transitions start terminal = true) : Reaches transitions start terminal := by
  apply searchPreservesProperty transitions terminal (Reaches transitions start) ?_ (initialSearch transitions start) ?_ success
  · intro left right pair prior
    exact Reaches.step prior pair
  · intro node member
    cases member with
    | head => exact Reaches.identity
    | tail _ h => cases h

theorem derivationInClosedSet (transitions : DynamicsTraces.Transitions) (start terminal : String)
    (closedNodes : List String) (initial : start ∈ closedNodes)
    (closed : ∀ left right, left ∈ closedNodes → (left,right) ∈ transitions → right ∈ closedNodes)
    (derivation : Reaches transitions start terminal) : terminal ∈ closedNodes := by
  induction derivation with
  | identity => exact initial
  | step prior pair ih => exact closed _ _ ih pair

theorem derivationReaches (transitions : DynamicsTraces.Transitions) (start terminal : String)
    (derivation : Reaches transitions start terminal) : perturbationReaches transitions start terminal = true := by
  cases result : searchLoop transitions terminal (initialSearch transitions start) with
  | true => exact result
  | false =>
    obtain ⟨exhausted,_,frontier,absent,closed⟩ := searchFailureCertificate transitions terminal
      (initialSearch transitions start) (fun h => by cases h) (fun _ _ h => by cases h) result
    exact False.elim (absent (derivationInClosedSet transitions start terminal exhausted
      (frontier start (List.Mem.head [])) closed derivation))

theorem perturbationReachabilityIff (transitions : DynamicsTraces.Transitions) (start terminal : String) :
    perturbationReaches transitions start terminal = true ↔ Reaches transitions start terminal :=
  ⟨searchHasDerivation transitions start terminal,derivationReaches transitions start terminal⟩

theorem stabilityMeaning (transitions : DynamicsTraces.Transitions) (terminal : String) (perturbations : List String) :
    stableUnderRegisteredPerturbations transitions terminal perturbations = true ↔
      ∀ start, start ∈ perturbations → Reaches transitions start terminal := by
  constructor
  · intro h start member
    exact searchHasDerivation transitions start terminal (allTrueAtMember _ _ h start member)
  · intro h
    exact (allTrueIffMembers _ _).mpr (fun start member => derivationReaches transitions start terminal (h start member))

theorem noPerturbationsStable (transitions : DynamicsTraces.Transitions) (terminal : String) :
    stableUnderRegisteredPerturbations transitions terminal [] = true := rfl

theorem terminalIdentity (transitions : DynamicsTraces.Transitions) (terminal : String) :
    perturbationReaches transitions terminal terminal = true :=
  derivationReaches transitions terminal terminal Reaches.identity

theorem failedPerturbationRejects (transitions : DynamicsTraces.Transitions) (terminal : String)
    (perturbations : List String) (start : String) (member : start ∈ perturbations)
    (impossible : ¬ Reaches transitions start terminal) :
    stableUnderRegisteredPerturbations transitions terminal perturbations = false := by
  cases result : stableUnderRegisteredPerturbations transitions terminal perturbations with
  | false => rfl
  | true => exact False.elim (impossible ((stabilityMeaning _ _ _).mp result start member))

end SFT.Mathematics.DynamicsStability
