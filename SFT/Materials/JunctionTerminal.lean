import SFT.Materials.JunctionTransfer
import SFT.Mathematics.DynamicsStability
namespace SFT.Materials.JunctionTerminal
open SFT.Mathematics SFT.Mathematics.DiscreteObjects
open SFT.Foundation.ExactOperations

-- Terminal selection uses the original exhaustive state/transition domain.
-- Response readings are retained at the declared common reference.
def terminals (states : List String) (transitions : DynamicsTraces.Transitions)
 (transport response : String → PositiveFraction) :=
 states.filter (fun state => has (DynamicsTraces.fixedForms transitions) state &&
  decide ((transport state).numerator * (response state).denominator =
    (response state).numerator * (transport state).denominator))

theorem terminalExactly (states : List String) (transitions : DynamicsTraces.Transitions)
 (transport response : String → PositiveFraction) (state : String) :
 state ∈ terminals states transitions transport response ↔
 state ∈ states ∧ (state,state) ∈ transitions ∧
 JunctionTransfer.residual (transport state) (response state) = .emptyOne := by
 constructor
 · intro held
   have p := (filterMemberIff _ _ _).mp held
   have checks := (GeometryTopology.andTrue _ _).mp p.2
   exact ⟨p.1,(DynamicsTraces.fixedMembership _ _).mp ((hasIff _ _).mp checks.1),
    (JunctionTransfer.balancedExactly _ _).mpr (of_decide_eq_true checks.2)⟩
 · intro h
   exact (filterMemberIff _ _ _).mpr ⟨h.1,(GeometryTopology.andTrue _ _).mpr
    ⟨(hasIff _ _).mpr ((DynamicsTraces.fixedMembership _ _).mpr h.2.1),
    decide_eq_true ((JunctionTransfer.balancedExactly _ _).mp h.2.2)⟩⟩

theorem everyBalancedFixedStateRetained (states : List String) (transitions : DynamicsTraces.Transitions)
 (transport response : String → PositiveFraction) (state : String)
 (held : state ∈ states) (fixed : (state,state) ∈ transitions)
 (balanced : JunctionTransfer.residual (transport state) (response state) = .emptyOne) :
 state ∈ terminals states transitions transport response :=
 (terminalExactly _ _ _ _ _).mpr ⟨held,fixed,balanced⟩

theorem checkedBasinReachesBalancedTerminal (states : List String) (transitions : DynamicsTraces.Transitions)
 (transport response : String → PositiveFraction) (terminal : String)
 (selected : terminal ∈ terminals states transitions transport response)
 (perturbations : List String)
 (checked : DynamicsStability.stableUnderRegisteredPerturbations transitions terminal perturbations = true)
 (start : String) (registered : start ∈ perturbations) :
 DynamicsStability.Reaches transitions start terminal ∧
 JunctionTransfer.residual (transport terminal) (response terminal) = .emptyOne :=
 ⟨(DynamicsStability.stabilityMeaning _ _ _).mp checked start registered,
  ((terminalExactly _ _ _ _ _).mp selected).2.2⟩
end SFT.Materials.JunctionTerminal
