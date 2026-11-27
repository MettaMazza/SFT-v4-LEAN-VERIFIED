import SFT.Chemistry.AdditionWitnessGraphs.NonadjacentSource
import SFT.Chemistry.AdditionWitnessGraphs.NonadjacentTerminal
namespace SFT.Chemistry.AdditionWitnessResults.Nonadjacent
open SFT.Chemistry SFT.Physics.CapabilityValues AdditionCarrier AdditionGraph AdditionTransform AdditionWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem h0Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h0Label : nonblank "nonadjacent-left" = true := rfl
private def h0 : HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-left",h0Family,h0Label⟩
private theorem h1Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h1Label : nonblank "nonadjacent-entering-left" = true := rfl
private def h1 : HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-entering-left",h1Family,h1Label⟩
private theorem h2Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h2Label : nonblank "nonadjacent-right" = true := rfl
private def h2 : HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-right",h2Family,h2Label⟩
private theorem h3Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h3Label : nonblank "nonadjacent-entering-right" = true := rfl
private def h3 : HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-entering-right",h3Family,h3Label⟩
private theorem h4Family : nonblank "addition-site-class" = true := rfl
private theorem h4Label : nonblank "non-adjacent-sites" = true := rfl
private def h4 : HeldLabel := ⟨"addition-site-class","non-adjacent-sites",h4Family,h4Label⟩
private theorem h5Family : nonblank "addition-site-class" = true := rfl
private theorem h5Label : nonblank "adjacent-sites" = true := rfl
private def h5 : HeldLabel := ⟨"addition-site-class","adjacent-sites",h5Family,h5Label⟩
private theorem h6Family : nonblank "registered-reaction" = true := rfl
private theorem h6Label : nonblank "nonadjacent-complete-addition" = true := rfl
private def h6 : HeldLabel := ⟨"registered-reaction","nonadjacent-complete-addition",h6Family,h6Label⟩
private theorem h7Family : nonblank "addition-held-support" = true := rfl
private theorem h7Label : nonblank "nonadjacent-layer-1" = true := rfl
private def h7 : HeldLabel := ⟨"addition-held-support","nonadjacent-layer-1",h7Family,h7Label⟩
private theorem h8Family : nonblank "addition-held-support" = true := rfl
private theorem h8Label : nonblank "nonadjacent-addend" = true := rfl
private def h8 : HeldLabel := ⟨"addition-held-support","nonadjacent-addend",h8Family,h8Label⟩
private theorem h9Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h9Label : nonblank "nonadjacent-middle" = true := rfl
private def h9 : HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-middle",h9Family,h9Label⟩
def expected : Result := ⟨h6,AdditionWitnessGraphs.NonadjacentSource.sourceSame,AdditionWitnessGraphs.NonadjacentTerminal.sourceSame,⟨2,by decide⟩,[(h0,h1),(h2,h3)],⟨2,by decide⟩,[h7],⟨1,by decide⟩,[⟨⟨1,by decide⟩,h4,.count ⟨2,by decide⟩⟩,⟨⟨2,by decide⟩,h5,.count ⟨1,by decide⟩⟩],[h8,h7]⟩
theorem result : simpleExample "nonadjacent" = .ok expected := by
 change transform h6 AdditionWitnessGraphs.NonadjacentSource.sourceSame AdditionWitnessGraphs.NonadjacentTerminal.sourceSame = .ok expected
 unfold transform
 rw [AdditionWitnessGraphs.NonadjacentSource.sourceOrderedComponents, AdditionWitnessGraphs.NonadjacentTerminal.sourceSameComponents]
 conv => lhs; whnf
 dsimp only [List.mapM, List.mapM.loop, List.range, List.range.loop, List.length]
 have occurrences0 : ((sortBy edgeBefore ((endpointKeys AdditionWitnessGraphs.NonadjacentTerminal.sourceSame).filter fun e => !(endpointKeys AdditionWitnessGraphs.NonadjacentSource.sourceSame).any (NucleophilicCarrier.sameEdge e))).flatMap fun (e : HeldLabel × HeldLabel) => [e.1,e.2]).filter (fun a => componentOf [[h0,h9,h2],[h1,h3]] a == 0) = [h0,h2] := rfl
 erw [occurrences0]
 dsimp only
 have occurrences1 : ((sortBy edgeBefore ((endpointKeys AdditionWitnessGraphs.NonadjacentTerminal.sourceSame).filter fun e => !(endpointKeys AdditionWitnessGraphs.NonadjacentSource.sourceSame).any (NucleophilicCarrier.sameEdge e))).flatMap fun (e : HeldLabel × HeldLabel) => [e.1,e.2]).filter (fun a => componentOf [[h0,h9,h2],[h1,h3]] a == 1) = [h1,h3] := rfl
 erw [occurrences1]
 dsimp only
 erw [AdditionWitnessGraphs.NonadjacentSource.distance0, AdditionWitnessGraphs.NonadjacentSource.distance1]
 rfl
#print axioms result
end SFT.Chemistry.AdditionWitnessResults.Nonadjacent
