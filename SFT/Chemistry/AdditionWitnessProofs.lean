import SFT.Chemistry.AdditionWitnessResults.Same
import SFT.Chemistry.AdditionWitnessResults.Adjacent
import SFT.Chemistry.AdditionWitnessResults.Nonadjacent
import SFT.Chemistry.AdditionWitnessResults.Multiple
import SFT.Chemistry.AdditionWitnessResults.Cyclo
import SFT.Chemistry.AdditionWitnessResults.Successor
namespace SFT.Chemistry.AdditionWitnessProofs
open SFT.Physics.CapabilityValues AdditionCarrier AdditionTransform AdditionWitnesses AdditionWitnessResults
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem atomFamily : nonblank "addition-atom-occurrence" = true := rfl
private theorem supportFamily : nonblank "addition-held-support" = true := rfl
private theorem anchorLabel : nonblank "nonadjacent-middle" = true := rfl
private theorem successorLabel : nonblank "complete-successor" = true := rfl
private def anchor : HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-middle",atomFamily,anchorLabel⟩
private def newAtom : HeldLabel := ⟨"addition-atom-occurrence","complete-successor",atomFamily,successorLabel⟩
private def newSupport : HeldLabel := ⟨"addition-held-support","complete-successor",supportFamily,successorLabel⟩
theorem successorPassed : extend Nonadjacent.expected anchor newAtom newSupport = .ok true := by
 unfold extend
 conv => lhs; whnf
 erw [Successor.result]
 rfl
#print axioms successorPassed
theorem noReductionRejected : transform Adjacent.expected.reactionIdentity Adjacent.expected.source Adjacent.expected.source = .error "two or more complete source carriers must become one product" := by
 change transform Adjacent.expected.reactionIdentity AdditionWitnessGraphs.AdjacentSource.sourceSame AdditionWitnessGraphs.AdjacentSource.sourceSame = _
 unfold transform
 rw [AdditionWitnessGraphs.AdjacentSource.sourceOrderedComponents,AdditionWitnessGraphs.AdjacentSource.sourceSameComponents]
 rfl
#print axioms noReductionRejected
theorem operationalWitnesses : witnesses = .ok [true,true,true,true,true,true,true,true,true] := by
 unfold witnesses
 rw [Same.result]
 try dsimp only
 rw [Adjacent.result]
 try dsimp only
 rw [Nonadjacent.result]
 try dsimp only
 rw [Multiple.result]
 try dsimp only
 rw [Cyclo.result]
 conv => lhs; whnf
 erw [successorPassed]
 rw [noReductionRejected]
 rfl
#print axioms operationalWitnesses
end SFT.Chemistry.AdditionWitnessProofs
