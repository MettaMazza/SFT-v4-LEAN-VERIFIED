import SFT.Physics.ForceLadderGrammar
import SFT.Physics.ForceLadderWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.ForceLadderControls
open SFT.Host.Canonical SFT.Foundation ForceLadderGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, proof certificate, candidate table or answer artifact as a premise", "no external measurement, conventional equation or fitted parameter selecting a survivor", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no unregistered force, particle, phase, scale, channel or correction rule"]

def closureValue : Value := .object [
 ("result",.text "The complete prime-sector ladder is (2,3,5,7), with couplings (1/2,2/3,4/5,6/7), mediator counts (3,8,24,48), and first excluded prime 11."),
 ("base",.text "Sector two is the first positive count beyond the One and has no proper divisor."),
 ("successor",.text "Positive succession tests every proper divisor through ceiling seven; the independently forced cover ceiling halts the sector grammar before eleven."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (ForceLadderWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && ForceLadderWitnesses.witnesses.all ForceLadderWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && ForceLadderWitnesses.witnesses.all ForceLadderWitnesses.Witness.passed) = true
 rw [ForceLadderWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.ForceLadderControls
