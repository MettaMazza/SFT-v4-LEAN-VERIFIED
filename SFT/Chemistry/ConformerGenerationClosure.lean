import SFT.Chemistry.ConformerUniqueness
import SFT.Chemistry.ConformerAlphabetProofs
namespace SFT.Chemistry.ConformerGenerationClosure
open SFT.Physics.CapabilityValues ConformerCarrier ConformerAssignments
open ConformerGenerationProofs ConformerUniqueness ConformerAlphabetProofs

theorem admittedProductCompleteAndUnique (alphabets : List Alphabet)
 (constructed : ∀ a, a ∈ alphabets → ∃ states reversal, alphabet states reversal = .ok a) :
 (∀ assignment, assignment ∈ productStates alphabets ↔ choices alphabets assignment) ∧
 (productStates alphabets).Pairwise (fun x y => x ≠ y) ∧
 (productStates alphabets).length=productCount alphabets := by
 refine ⟨exactGeneratedCarrier alphabets,?_,generatedCardinality alphabets⟩
 apply generatedExactlyOnce
 intro a member
 obtain ⟨states,reversal,accepted⟩ := constructed a member
 rw [acceptedStatesRetained states reversal a accepted]
 exact acceptedInputStatesDistinct states reversal a accepted
end SFT.Chemistry.ConformerGenerationClosure
