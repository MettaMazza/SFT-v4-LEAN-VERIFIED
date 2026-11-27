import SFT.Chemistry.AdditionWitnessGraphs.MultipleSource
import SFT.Chemistry.AdditionWitnessGraphs.MultipleTerminal
namespace SFT.Chemistry.AdditionWitnessResults.Multiple
open SFT.Chemistry SFT.Physics.CapabilityValues AdditionCarrier AdditionGraph AdditionTransform AdditionWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem h0Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h0Label : nonblank "adjacent-left" = true := rfl
private def h0 : HeldLabel := ⟨"addition-atom-occurrence","adjacent-left",h0Family,h0Label⟩
private theorem h1Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h1Label : nonblank "adjacent-entering-left" = true := rfl
private def h1 : HeldLabel := ⟨"addition-atom-occurrence","adjacent-entering-left",h1Family,h1Label⟩
private theorem h2Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h2Label : nonblank "adjacent-middle" = true := rfl
private def h2 : HeldLabel := ⟨"addition-atom-occurrence","adjacent-middle",h2Family,h2Label⟩
private theorem h3Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h3Label : nonblank "adjacent-entering-right" = true := rfl
private def h3 : HeldLabel := ⟨"addition-atom-occurrence","adjacent-entering-right",h3Family,h3Label⟩
private theorem h4Family : nonblank "addition-site-class" = true := rfl
private theorem h4Label : nonblank "adjacent-sites" = true := rfl
private def h4 : HeldLabel := ⟨"addition-site-class","adjacent-sites",h4Family,h4Label⟩
private theorem h5Family : nonblank "registered-reaction" = true := rfl
private theorem h5Label : nonblank "adjacent-complete-addition" = true := rfl
private def h5 : HeldLabel := ⟨"registered-reaction","adjacent-complete-addition",h5Family,h5Label⟩
private theorem h6Family : nonblank "addition-held-support" = true := rfl
private theorem h6Label : nonblank "adjacent-layer-1" = true := rfl
private def h6 : HeldLabel := ⟨"addition-held-support","adjacent-layer-1",h6Family,h6Label⟩
private theorem h7Family : nonblank "addition-held-support" = true := rfl
private theorem h7Label : nonblank "adjacent-layer-2" = true := rfl
private def h7 : HeldLabel := ⟨"addition-held-support","adjacent-layer-2",h7Family,h7Label⟩
private theorem h8Family : nonblank "addition-held-support" = true := rfl
private theorem h8Label : nonblank "adjacent-layer-3" = true := rfl
private def h8 : HeldLabel := ⟨"addition-held-support","adjacent-layer-3",h8Family,h8Label⟩
private theorem h9Family : nonblank "addition-held-support" = true := rfl
private theorem h9Label : nonblank "adjacent-addend" = true := rfl
private def h9 : HeldLabel := ⟨"addition-held-support","adjacent-addend",h9Family,h9Label⟩
private theorem h10Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h10Label : nonblank "adjacent-right" = true := rfl
private def h10 : HeldLabel := ⟨"addition-atom-occurrence","adjacent-right",h10Family,h10Label⟩
def expected : Result := ⟨h5,AdditionWitnessGraphs.MultipleSource.sourceSame,AdditionWitnessGraphs.MultipleTerminal.sourceSame,⟨2,by decide⟩,[(h0,h1),(h2,h3)],⟨2,by decide⟩,[h6,h7,h8],⟨3,by decide⟩,[⟨⟨1,by decide⟩,h4,.count ⟨1,by decide⟩⟩,⟨⟨2,by decide⟩,h4,.count ⟨1,by decide⟩⟩],[h9,h6,h7,h8]⟩
theorem result : simpleExample "adjacent" 3 = .ok expected := by
 change transform h5 AdditionWitnessGraphs.MultipleSource.sourceSame AdditionWitnessGraphs.MultipleTerminal.sourceSame = .ok expected
 unfold transform
 rw [AdditionWitnessGraphs.MultipleSource.sourceOrderedComponents, AdditionWitnessGraphs.MultipleTerminal.sourceSameComponents]
 conv => lhs; whnf
 dsimp only [List.mapM, List.mapM.loop, List.range, List.range.loop, List.length]
 have occurrences0 : ((sortBy edgeBefore ((endpointKeys AdditionWitnessGraphs.MultipleTerminal.sourceSame).filter fun e => !(endpointKeys AdditionWitnessGraphs.MultipleSource.sourceSame).any (NucleophilicCarrier.sameEdge e))).flatMap fun (e : HeldLabel × HeldLabel) => [e.1,e.2]).filter (fun a => componentOf [[h0,h2,h10],[h1,h3]] a == 0) = [h0,h2] := rfl
 erw [occurrences0]
 dsimp only
 have occurrences1 : ((sortBy edgeBefore ((endpointKeys AdditionWitnessGraphs.MultipleTerminal.sourceSame).filter fun e => !(endpointKeys AdditionWitnessGraphs.MultipleSource.sourceSame).any (NucleophilicCarrier.sameEdge e))).flatMap fun (e : HeldLabel × HeldLabel) => [e.1,e.2]).filter (fun a => componentOf [[h0,h2,h10],[h1,h3]] a == 1) = [h1,h3] := rfl
 erw [occurrences1]
 dsimp only
 erw [AdditionWitnessGraphs.MultipleSource.distance0, AdditionWitnessGraphs.MultipleSource.distance1]
 rfl
#print axioms result
end SFT.Chemistry.AdditionWitnessResults.Multiple
