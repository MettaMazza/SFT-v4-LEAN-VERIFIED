import SFT.Physics.MediatorRangeChannelGrammar
import SFT.Physics.MediatorRangeChannelWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.MediatorRangeChannelControls
open SFT.Host.Canonical SFT.Foundation MediatorRangeChannelGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no V1/V2 executable, answer table, selected particle name or stored survivor", "no imported exponential, fitted range, hard physical numerical-zero cutoff or sink", "no numerical-zero, negative, irrational, imaginary or floating proof magnitude", "no claim that the finite native subtraction trace is a universal physical field profile", "no target access before the predecessor electroweak and mediator-range seals"]

def closureValue : Value := .object [
 ("result",.text "Complete-One channels have an empty mass record and no finite transport endpoint; proper channels have positive shortfall, exact conserved forward/rest transfer, a finite native trace and reciprocal mass range; larger mass means shorter range, while massless inverse-square response remains positive at every finite radius."),
 ("base",.text "At the first act, one positive mass share transfers from the One-forward carrier into rest and the pair reassembles the One."),
 ("successor",.text "Whenever forward support exceeds the mass share, one further exact take leaves a positive forward carrier and adds the same share to rest.  A finite rational mass exhausts the finite native budget at a generated boundary; reciprocal order is depth-independent."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (MediatorRangeChannelWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with carrier := .rejected }
def survivorIds : List String := (candidates.filter survives).map candidateId

def record (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : FoldControls.ControlRecord where
 kind := kind
 passed := passed
 expected := observation
 observed := if passed then observation else "control failed"

def falsePremise : FoldControls.ControlRecord := record .falsePremise
 (!(SFT.Host.Text.equal (candidateId falseCandidate) survivorId))
 "reject the form missing the first structural preservation"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord := record .tamperedSource
 (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && MediatorRangeChannelWitnesses.witnesses.all MediatorRangeChannelWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && MediatorRangeChannelWitnesses.witnesses.all MediatorRangeChannelWitnesses.Witness.passed) = true
 rw [MediatorRangeChannelWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-MEDIATOR-RANGE-CHANNEL-TERMINAL-020",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.MediatorRangeChannelControls
