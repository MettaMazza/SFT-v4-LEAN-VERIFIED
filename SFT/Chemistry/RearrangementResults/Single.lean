import SFT.Chemistry.RearrangementWitnesses
import SFT.Chemistry.RearrangementWitnessGraphs.SingleSource
import SFT.Chemistry.RearrangementWitnessGraphs.SingleTerminal
namespace SFT.Chemistry.RearrangementResults.Single
open SFT.Chemistry SFT.Physics.CapabilityValues AdditionCarrier Rearrangement RearrangementWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem h0Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h0Label : nonblank "rearr-b" = true := rfl
private def h0 : HeldLabel := ⟨"addition-atom-occurrence","rearr-b",h0Family,h0Label⟩
private theorem h1Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h1Label : nonblank "rearr-c" = true := rfl
private def h1 : HeldLabel := ⟨"addition-atom-occurrence","rearr-c",h1Family,h1Label⟩
private theorem h2Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h2Label : nonblank "rearr-a" = true := rfl
private def h2 : HeldLabel := ⟨"addition-atom-occurrence","rearr-a",h2Family,h2Label⟩
private theorem h3Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h3Label : nonblank "rearr-d" = true := rfl
private def h3 : HeldLabel := ⟨"addition-atom-occurrence","rearr-d",h3Family,h3Label⟩
private theorem h4Family : nonblank "addition-held-support" = true := rfl
private theorem h4Label : nonblank "rearr-moving" = true := rfl
private def h4 : HeldLabel := ⟨"addition-held-support","rearr-moving",h4Family,h4Label⟩
private theorem h5Family : nonblank "registered-reaction" = true := rfl
private theorem h5Label : nonblank "rearr-single" = true := rfl
private def h5 : HeldLabel := ⟨"registered-reaction","rearr-single",h5Family,h5Label⟩
private theorem h6Family : nonblank "rearrangement-path" = true := rfl
private theorem h6Label : nonblank "direct-held-support-relocation" = true := rfl
private def h6 : HeldLabel := ⟨"rearrangement-path","direct-held-support-relocation",h6Family,h6Label⟩
private theorem h7Family : nonblank "rearrangement-path" = true := rfl
private theorem h7Label : nonblank "opened-support-then-exact-reclosure" = true := rfl
private def h7 : HeldLabel := ⟨"rearrangement-path","opened-support-then-exact-reclosure",h7Family,h7Label⟩
def expected : Result := ⟨h5,RearrangementWitnessGraphs.SingleSource.sourceSame,RearrangementWitnessGraphs.SingleTerminal.sourceSame,[h4],⟨1,by decide⟩,[(h0,h1)],[(h2,h1)],[(h4,[(h2,h0),(h2,h1),(h2,h3),(h0,h3),(h1,h3)])],[h6,h7],true⟩
theorem result : singleMove = .ok expected := by
 change transform h5 RearrangementWitnessGraphs.SingleSource.sourceSame RearrangementWitnessGraphs.SingleTerminal.sourceSame = .ok expected
 unfold transform
 rw [RearrangementWitnessGraphs.SingleSource.sourceSameComponents,RearrangementWitnessGraphs.SingleTerminal.sourceSameComponents]
 rfl
#print axioms result
theorem transformResult : transform expected.reactionIdentity expected.source expected.terminal = .ok expected := by
 exact result
#print axioms transformResult
end SFT.Chemistry.RearrangementResults.Single
