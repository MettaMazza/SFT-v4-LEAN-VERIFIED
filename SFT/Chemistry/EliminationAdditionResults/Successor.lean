import SFT.Chemistry.Elimination
import SFT.Chemistry.EliminationWitnessGraphs.SuccessorSource
import SFT.Chemistry.EliminationWitnessGraphs.SuccessorTerminal
namespace SFT.Chemistry.EliminationAdditionResults.Successor
open SFT.Chemistry SFT.Physics.CapabilityValues AdditionCarrier AdditionGraph AdditionTransform AdditionWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem h0Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h0Label : nonblank "elim-nonadjacent-left" = true := rfl
private def h0 : HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-left",h0Family,h0Label⟩
private theorem h1Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h1Label : nonblank "elim-nonadjacent-enter-left" = true := rfl
private def h1 : HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-enter-left",h1Family,h1Label⟩
private theorem h2Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h2Label : nonblank "elim-nonadjacent-right" = true := rfl
private def h2 : HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-right",h2Family,h2Label⟩
private theorem h3Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h3Label : nonblank "elim-nonadjacent-enter-right" = true := rfl
private def h3 : HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-enter-right",h3Family,h3Label⟩
private theorem h4Family : nonblank "addition-site-class" = true := rfl
private theorem h4Label : nonblank "non-adjacent-sites" = true := rfl
private def h4 : HeldLabel := ⟨"addition-site-class","non-adjacent-sites",h4Family,h4Label⟩
private theorem h5Family : nonblank "addition-site-class" = true := rfl
private theorem h5Label : nonblank "adjacent-sites" = true := rfl
private def h5 : HeldLabel := ⟨"addition-site-class","adjacent-sites",h5Family,h5Label⟩
private theorem h6Family : nonblank "registered-reaction" = true := rfl
private theorem h6Label : nonblank "elim-nonadjacent-inverse" = true := rfl
private def h6 : HeldLabel := ⟨"registered-reaction","elim-nonadjacent-inverse",h6Family,h6Label⟩
private theorem h7Family : nonblank "addition-held-support" = true := rfl
private theorem h7Label : nonblank "elim-nonadjacent-layer-1" = true := rfl
private def h7 : HeldLabel := ⟨"addition-held-support","elim-nonadjacent-layer-1",h7Family,h7Label⟩
private theorem h8Family : nonblank "addition-held-support" = true := rfl
private theorem h8Label : nonblank "elim-nonadjacent-entering" = true := rfl
private def h8 : HeldLabel := ⟨"addition-held-support","elim-nonadjacent-entering",h8Family,h8Label⟩
private theorem h9Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h9Label : nonblank "elim-nonadjacent-middle" = true := rfl
private def h9 : HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-middle",h9Family,h9Label⟩
private theorem h10Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h10Label : nonblank "elim-successor-atom" = true := rfl
private def h10 : HeldLabel := ⟨"addition-atom-occurrence","elim-successor-atom",h10Family,h10Label⟩
def expected : Result := ⟨h6,EliminationWitnessGraphs.SuccessorSource.sourceSame,EliminationWitnessGraphs.SuccessorTerminal.sourceSame,⟨2,by decide⟩,[(h0,h1),(h2,h3)],⟨2,by decide⟩,[h7],⟨1,by decide⟩,[⟨⟨1,by decide⟩,h4,.count ⟨2,by decide⟩⟩,⟨⟨2,by decide⟩,h5,.count ⟨1,by decide⟩⟩],[h8,h7]⟩
theorem result : AdditionTransform.transform h6 EliminationWitnessGraphs.SuccessorSource.sourceSame EliminationWitnessGraphs.SuccessorTerminal.sourceSame = .ok expected := by
 change transform h6 EliminationWitnessGraphs.SuccessorSource.sourceSame EliminationWitnessGraphs.SuccessorTerminal.sourceSame = .ok expected
 unfold transform
 rw [EliminationWitnessGraphs.SuccessorSource.sourceOrderedComponents, EliminationWitnessGraphs.SuccessorTerminal.sourceSameComponents]
 conv => lhs; whnf
 dsimp only [List.mapM, List.mapM.loop, List.range, List.range.loop, List.length]
 have occurrences0 : ((sortBy edgeBefore ((endpointKeys EliminationWitnessGraphs.SuccessorTerminal.sourceSame).filter fun e => !(endpointKeys EliminationWitnessGraphs.SuccessorSource.sourceSame).any (NucleophilicCarrier.sameEdge e))).flatMap fun (e : HeldLabel × HeldLabel) => [e.1,e.2]).filter (fun a => componentOf [[h0,h9,h2,h10],[h1,h3]] a == 0) = [h0,h2] := rfl
 erw [occurrences0]
 dsimp only
 have occurrences1 : ((sortBy edgeBefore ((endpointKeys EliminationWitnessGraphs.SuccessorTerminal.sourceSame).filter fun e => !(endpointKeys EliminationWitnessGraphs.SuccessorSource.sourceSame).any (NucleophilicCarrier.sameEdge e))).flatMap fun (e : HeldLabel × HeldLabel) => [e.1,e.2]).filter (fun a => componentOf [[h0,h9,h2,h10],[h1,h3]] a == 1) = [h1,h3] := rfl
 erw [occurrences1]
 dsimp only
 erw [EliminationWitnessGraphs.SuccessorSource.distance0, EliminationWitnessGraphs.SuccessorSource.distance1]
 rfl
#print axioms result
theorem transformResult : AdditionTransform.transform expected.reactionIdentity expected.source expected.terminal = .ok expected := by
 exact result
#print axioms transformResult
end SFT.Chemistry.EliminationAdditionResults.Successor
