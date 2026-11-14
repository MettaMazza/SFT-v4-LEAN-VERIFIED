import SFT.QuantumComputation.UnboundedFaults
import SFT.QuantumComputation.ReversibleInterpretation
namespace SFT.QuantumComputation.UnboundedComposition
open UnboundedFaults ReversibleModel ReversibleInterpretation

theorem recoveryRetainsExactWord (source recovered : List String) (t : Nat)
 (generated : ∀ label,label∈source → label="held" ∨ label="returned")
 (result : recoverWord source t (2*t+1)=.ok recovered) : recovered=source :=
 (Except.ok.inj ((everySourceWordRecovers source t generated).symm.trans result)).symm

theorem recoveryPreservesCircuit (source recovered : List String) (t : Nat)
 (generated : ∀ label,label∈source → label="held" ∨ label="returned")
 (result : recoverWord source t (2*t+1)=.ok recovered)
 (before after : List (Word × String)) (phase : String) (cycle : List String) (gates : List Gate) :
 evaluate ⟨before++(recovered,phase)::after,cycle⟩ gates =
 evaluate ⟨before++(source,phase)::after,cycle⟩ gates := by
 rw [recoveryRetainsExactWord source recovered t generated result]
end SFT.QuantumComputation.UnboundedComposition
