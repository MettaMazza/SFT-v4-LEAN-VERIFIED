import SFT.Chemistry.RearrangementWitnesses
import SFT.Chemistry.RearrangementWitnessGraphs.DegenerateSource
import SFT.Chemistry.RearrangementWitnessGraphs.DegenerateTerminal
namespace SFT.Chemistry.RearrangementResults.Degenerate
open SFT.Chemistry SFT.Physics.CapabilityValues AdditionCarrier Rearrangement RearrangementWitnesses
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem h0Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h0Label : nonblank "deg-a" = true := rfl
private def h0 : HeldLabel := ⟨"addition-atom-occurrence","deg-a",h0Family,h0Label⟩
private theorem h1Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h1Label : nonblank "deg-b" = true := rfl
private def h1 : HeldLabel := ⟨"addition-atom-occurrence","deg-b",h1Family,h1Label⟩
private theorem h2Family : nonblank "addition-atom-occurrence" = true := rfl
private theorem h2Label : nonblank "deg-c" = true := rfl
private def h2 : HeldLabel := ⟨"addition-atom-occurrence","deg-c",h2Family,h2Label⟩
private theorem h3Family : nonblank "addition-held-support" = true := rfl
private theorem h3Label : nonblank "deg-first" = true := rfl
private def h3 : HeldLabel := ⟨"addition-held-support","deg-first",h3Family,h3Label⟩
private theorem h4Family : nonblank "addition-held-support" = true := rfl
private theorem h4Label : nonblank "deg-second" = true := rfl
private def h4 : HeldLabel := ⟨"addition-held-support","deg-second",h4Family,h4Label⟩
private theorem h5Family : nonblank "addition-held-support" = true := rfl
private theorem h5Label : nonblank "deg-third" = true := rfl
private def h5 : HeldLabel := ⟨"addition-held-support","deg-third",h5Family,h5Label⟩
private theorem h6Family : nonblank "registered-reaction" = true := rfl
private theorem h6Label : nonblank "rearr-degenerate" = true := rfl
private def h6 : HeldLabel := ⟨"registered-reaction","rearr-degenerate",h6Family,h6Label⟩
private theorem h7Family : nonblank "rearrangement-path" = true := rfl
private theorem h7Label : nonblank "direct-held-support-relocation" = true := rfl
private def h7 : HeldLabel := ⟨"rearrangement-path","direct-held-support-relocation",h7Family,h7Label⟩
private theorem h8Family : nonblank "rearrangement-path" = true := rfl
private theorem h8Label : nonblank "opened-support-then-exact-reclosure" = true := rfl
private def h8 : HeldLabel := ⟨"rearrangement-path","opened-support-then-exact-reclosure",h8Family,h8Label⟩
def expected : Result := ⟨h6,RearrangementWitnessGraphs.DegenerateSource.sourceSame,RearrangementWitnessGraphs.DegenerateTerminal.sourceSame,[h3,h4,h5],⟨3,by decide⟩,[(h0,h1),(h1,h2),(h0,h2)],[(h0,h2),(h0,h1),(h1,h2)],[(h3,[(h0,h2),(h1,h2)]),(h4,[(h0,h1),(h0,h2)]),(h5,[(h0,h1),(h1,h2)])],[h7,h8],true⟩
theorem result : degenerate = .ok expected := by
 change transform h6 RearrangementWitnessGraphs.DegenerateSource.sourceSame RearrangementWitnessGraphs.DegenerateTerminal.sourceSame = .ok expected
 unfold transform
 rw [RearrangementWitnessGraphs.DegenerateSource.sourceSameComponents,RearrangementWitnessGraphs.DegenerateTerminal.sourceSameComponents]
 rfl
#print axioms result
theorem transformResult : transform expected.reactionIdentity expected.source expected.terminal = .ok expected := by
 exact result
#print axioms transformResult
end SFT.Chemistry.RearrangementResults.Degenerate
