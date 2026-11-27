import SFT.Chemistry.RearrangementResults.Single
import SFT.Chemistry.RearrangementResults.Multi
import SFT.Chemistry.RearrangementResults.Degenerate
import SFT.Chemistry.RearrangementResults.Successor
import SFT.Chemistry.RearrangementResults.MultiReverse
namespace SFT.Chemistry.RearrangementWitnessProofs
open SFT.Physics.CapabilityValues AdditionCarrier AdditionGraph Rearrangement RearrangementWitnesses RearrangementResults
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem atomFamily : nonblank "addition-atom-occurrence" = true := rfl
private theorem supportFamily : nonblank "addition-held-support" = true := rfl
private theorem anchorLabel : nonblank "rearr-a" = true := rfl
private theorem freshAtomLabel : nonblank "rearr-successor-atom" = true := rfl
private theorem freshSupportLabel : nonblank "rearr-successor-support" = true := rfl
private def anchor : HeldLabel := ⟨"addition-atom-occurrence","rearr-a",atomFamily,anchorLabel⟩
private def freshAtom : HeldLabel := ⟨"addition-atom-occurrence","rearr-successor-atom",atomFamily,freshAtomLabel⟩
private def freshSupport : HeldLabel := ⟨"addition-held-support","rearr-successor-support",supportFamily,freshSupportLabel⟩
theorem successorPassed : extend Single.expected anchor freshAtom freshSupport = .ok true := by
 unfold extend
 conv => lhs; whnf
 erw [Successor.transformResult]
 rfl
theorem reversePassed : reverseReconstruction Multi.expected = .ok true := by
 unfold reverseReconstruction
 erw [MultiReverse.transformResult]
 rfl
theorem unchangedRejected : transform Single.expected.reactionIdentity Single.expected.source Single.expected.source = .error "rearrangement requires at least one exact adjacency change" := by
 change transform Single.expected.reactionIdentity RearrangementWitnessGraphs.SingleSource.sourceSame RearrangementWitnessGraphs.SingleSource.sourceSame = _
 unfold transform
 rw [RearrangementWitnessGraphs.SingleSource.sourceSameComponents]
 rfl
theorem compositionRejected : (do
 let shortened ← state (← heldLabel "addition-state" "shortened")
  (Single.expected.source.atoms.take (Single.expected.source.atoms.length-1)) (Single.expected.source.bonds.take (Single.expected.source.bonds.length-1)) []
 transform Single.expected.reactionIdentity Single.expected.source shortened) = .error "rearrangement must retain every atom occurrence in exact source order" := by
 rfl
theorem operationalWitnesses : witnesses = .ok [true,true,true,true,true,true,true,true,true,true,true] := by
 unfold witnesses
 rw [Single.result,Multi.result,Degenerate.result]
 conv => lhs; whnf
 erw [successorPassed]
 erw [reversePassed]
 erw [unchangedRejected,compositionRejected]
 erw [RearrangementWitnessGraphs.SingleSource.sourceSameComponents,RearrangementWitnessGraphs.SingleTerminal.sourceSameComponents]
 rfl
#print axioms successorPassed
#print axioms reversePassed
#print axioms unchangedRejected
#print axioms compositionRejected
#print axioms operationalWitnesses
end SFT.Chemistry.RearrangementWitnessProofs
