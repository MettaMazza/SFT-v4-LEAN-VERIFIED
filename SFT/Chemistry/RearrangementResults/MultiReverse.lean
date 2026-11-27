import SFT.Chemistry.RearrangementWitnesses
import SFT.Chemistry.RearrangementWitnessGraphs.MultiTerminal
import SFT.Chemistry.RearrangementWitnessGraphs.MultiSource
namespace SFT.Chemistry.RearrangementResults.MultiReverse
open SFT.Chemistry SFT.Physics.CapabilityValues AdditionCarrier Rearrangement RearrangementWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem h0Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h0Label : nonblank "multi-a" = true := rfl
private def h0 : HeldLabel := ⟨"addition-atom-occurrence","multi-a",h0Family,h0Label⟩
private theorem h1Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h1Label : nonblank "multi-c" = true := rfl
private def h1 : HeldLabel := ⟨"addition-atom-occurrence","multi-c",h1Family,h1Label⟩
private theorem h2Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h2Label : nonblank "multi-b" = true := rfl
private def h2 : HeldLabel := ⟨"addition-atom-occurrence","multi-b",h2Family,h2Label⟩
private theorem h3Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h3Label : nonblank "multi-d" = true := rfl
private def h3 : HeldLabel := ⟨"addition-atom-occurrence","multi-d",h3Family,h3Label⟩
private theorem h4Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h4Label : nonblank "multi-e" = true := rfl
private def h4 : HeldLabel := ⟨"addition-atom-occurrence","multi-e",h4Family,h4Label⟩
private theorem h5Family : nonblank "addition-held-support" = true := rfl
private theorem h5Label : nonblank "multi-first" = true := rfl
private def h5 : HeldLabel := ⟨"addition-held-support","multi-first",h5Family,h5Label⟩
private theorem h6Family : nonblank "addition-held-support" = true := rfl
private theorem h6Label : nonblank "multi-second" = true := rfl
private def h6 : HeldLabel := ⟨"addition-held-support","multi-second",h6Family,h6Label⟩
private theorem h7Family : nonblank "addition-held-support" = true := rfl
private theorem h7Label : nonblank "multi-third" = true := rfl
private def h7 : HeldLabel := ⟨"addition-held-support","multi-third",h7Family,h7Label⟩
private theorem h8Family : nonblank "registered-reaction" = true := rfl
private theorem h8Label : nonblank "rearr-multi" = true := rfl
private def h8 : HeldLabel := ⟨"registered-reaction","rearr-multi",h8Family,h8Label⟩
private theorem h9Family : nonblank "rearrangement-path" = true := rfl
private theorem h9Label : nonblank "direct-held-support-relocation" = true := rfl
private def h9 : HeldLabel := ⟨"rearrangement-path","direct-held-support-relocation",h9Family,h9Label⟩
private theorem h10Family : nonblank "rearrangement-path" = true := rfl
private theorem h10Label : nonblank "opened-support-then-exact-reclosure" = true := rfl
private def h10 : HeldLabel := ⟨"rearrangement-path","opened-support-then-exact-reclosure",h10Family,h10Label⟩
def expected : Result := ⟨h8,RearrangementWitnessGraphs.MultiTerminal.sourceSame,RearrangementWitnessGraphs.MultiSource.sourceSame,[h5,h6,h7],⟨3,by decide⟩,[(h0,h1),(h2,h3),(h1,h4)],[(h2,h1),(h1,h3),(h3,h4)],[(h5,[(h0,h2),(h0,h3),(h0,h4),(h2,h1),(h2,h3),(h2,h4),(h1,h3),(h1,h4),(h3,h4)]),(h6,[(h0,h2),(h0,h1),(h0,h3),(h0,h4),(h2,h1),(h2,h4),(h1,h3),(h1,h4),(h3,h4)]),(h7,[(h0,h2),(h0,h1),(h0,h3),(h0,h4),(h2,h1),(h2,h3),(h2,h4),(h1,h3),(h3,h4)])],[h9,h10],true⟩
theorem result : transform h8 RearrangementWitnessGraphs.MultiTerminal.sourceSame RearrangementWitnessGraphs.MultiSource.sourceSame = .ok expected := by
 change transform h8 RearrangementWitnessGraphs.MultiTerminal.sourceSame RearrangementWitnessGraphs.MultiSource.sourceSame = .ok expected
 unfold transform
 rw [RearrangementWitnessGraphs.MultiTerminal.sourceSameComponents,RearrangementWitnessGraphs.MultiSource.sourceSameComponents]
 rfl
#print axioms result
theorem transformResult : transform expected.reactionIdentity expected.source expected.terminal = .ok expected := by
 exact result
#print axioms transformResult
end SFT.Chemistry.RearrangementResults.MultiReverse
