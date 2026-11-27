import SFT.Chemistry.AdditionWitnessGraphs.CycloSource
import SFT.Chemistry.AdditionWitnessGraphs.CycloTerminal
namespace SFT.Chemistry.AdditionWitnessResults.Cyclo
open SFT.Chemistry SFT.Physics.CapabilityValues AdditionCarrier AdditionGraph AdditionTransform AdditionWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem h0Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h0Label : nonblank "cyclo-a" = true := rfl
private def h0 : HeldLabel := ⟨"addition-atom-occurrence","cyclo-a",h0Family,h0Label⟩
private theorem h1Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h1Label : nonblank "cyclo-e" = true := rfl
private def h1 : HeldLabel := ⟨"addition-atom-occurrence","cyclo-e",h1Family,h1Label⟩
private theorem h2Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h2Label : nonblank "cyclo-d" = true := rfl
private def h2 : HeldLabel := ⟨"addition-atom-occurrence","cyclo-d",h2Family,h2Label⟩
private theorem h3Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h3Label : nonblank "cyclo-f" = true := rfl
private def h3 : HeldLabel := ⟨"addition-atom-occurrence","cyclo-f",h3Family,h3Label⟩
private theorem h4Family : nonblank "addition-site-class" = true := rfl
private theorem h4Label : nonblank "non-adjacent-sites" = true := rfl
private def h4 : HeldLabel := ⟨"addition-site-class","non-adjacent-sites",h4Family,h4Label⟩
private theorem h5Family : nonblank "addition-site-class" = true := rfl
private theorem h5Label : nonblank "adjacent-sites" = true := rfl
private def h5 : HeldLabel := ⟨"addition-site-class","adjacent-sites",h5Family,h5Label⟩
private theorem h6Family : nonblank "registered-reaction" = true := rfl
private theorem h6Label : nonblank "complete-cycloaddition" = true := rfl
private def h6 : HeldLabel := ⟨"registered-reaction","complete-cycloaddition",h6Family,h6Label⟩
private theorem h7Family : nonblank "addition-held-support" = true := rfl
private theorem h7Label : nonblank "cyclo-layer-ab" = true := rfl
private def h7 : HeldLabel := ⟨"addition-held-support","cyclo-layer-ab",h7Family,h7Label⟩
private theorem h8Family : nonblank "addition-held-support" = true := rfl
private theorem h8Label : nonblank "cyclo-layer-cd" = true := rfl
private def h8 : HeldLabel := ⟨"addition-held-support","cyclo-layer-cd",h8Family,h8Label⟩
private theorem h9Family : nonblank "addition-held-support" = true := rfl
private theorem h9Label : nonblank "cyclo-layer-ef" = true := rfl
private def h9 : HeldLabel := ⟨"addition-held-support","cyclo-layer-ef",h9Family,h9Label⟩
private theorem h10Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h10Label : nonblank "cyclo-b" = true := rfl
private def h10 : HeldLabel := ⟨"addition-atom-occurrence","cyclo-b",h10Family,h10Label⟩
private theorem h11Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h11Label : nonblank "cyclo-c" = true := rfl
private def h11 : HeldLabel := ⟨"addition-atom-occurrence","cyclo-c",h11Family,h11Label⟩
def expected : Result := ⟨h6,AdditionWitnessGraphs.CycloSource.sourceSame,AdditionWitnessGraphs.CycloTerminal.sourceSame,⟨2,by decide⟩,[(h0,h1),(h2,h3)],⟨2,by decide⟩,[h7,h8,h9],⟨3,by decide⟩,[⟨⟨1,by decide⟩,h4,.count ⟨3,by decide⟩⟩,⟨⟨2,by decide⟩,h5,.count ⟨1,by decide⟩⟩],[h7,h8,h9]⟩
theorem result : cycloadditionExample = .ok expected := by
 change transform h6 AdditionWitnessGraphs.CycloSource.sourceSame AdditionWitnessGraphs.CycloTerminal.sourceSame = .ok expected
 unfold transform
 rw [AdditionWitnessGraphs.CycloSource.sourceOrderedComponents, AdditionWitnessGraphs.CycloTerminal.sourceSameComponents]
 conv => lhs; whnf
 dsimp only [List.mapM, List.mapM.loop, List.range, List.range.loop, List.length]
 have occurrences0 : ((sortBy edgeBefore ((endpointKeys AdditionWitnessGraphs.CycloTerminal.sourceSame).filter fun e => !(endpointKeys AdditionWitnessGraphs.CycloSource.sourceSame).any (NucleophilicCarrier.sameEdge e))).flatMap fun (e : HeldLabel × HeldLabel) => [e.1,e.2]).filter (fun a => componentOf [[h0,h10,h11,h2],[h1,h3]] a == 0) = [h0,h2] := rfl
 erw [occurrences0]
 dsimp only
 have occurrences1 : ((sortBy edgeBefore ((endpointKeys AdditionWitnessGraphs.CycloTerminal.sourceSame).filter fun e => !(endpointKeys AdditionWitnessGraphs.CycloSource.sourceSame).any (NucleophilicCarrier.sameEdge e))).flatMap fun (e : HeldLabel × HeldLabel) => [e.1,e.2]).filter (fun a => componentOf [[h0,h10,h11,h2],[h1,h3]] a == 1) = [h1,h3] := rfl
 erw [occurrences1]
 dsimp only
 erw [AdditionWitnessGraphs.CycloSource.distance0, AdditionWitnessGraphs.CycloSource.distance1]
 rfl
#print axioms result
end SFT.Chemistry.AdditionWitnessResults.Cyclo
