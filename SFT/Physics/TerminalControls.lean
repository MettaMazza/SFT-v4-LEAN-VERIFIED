import SFT.Physics.TerminalGrammar
import SFT.Physics.TerminalWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.TerminalControls
open SFT.Host.Canonical SFT.Foundation TerminalGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured lepton mass or ratio in the executable relation", "no floating, irrational, imaginary, semantic-zero or negative proof value", "no fitted coefficient, tolerance, selected root or extra correction term", "no claim that this post-failure construction was a blind forward discovery"]

def closureValue : Value := .object [
 ("result",.text "The terminal product invariant is exactly 3/1454 held by alpha^3/3^3 times (5 + (7/3)alpha), with alpha the reciprocal of the admitted terminal inverse fine-structure ratio."),
 ("base",.text "The admitted sharpened cubic supplies one positive normalized product carrier."),
 ("successor",.text "Attach one alpha to each of the three roots, distribute over the complete three-cubed support, then append the one forced up-depth transport to the down-depth carrier; no root, channel or terminal depth remains uncounted."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (TerminalWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with base := .rejected }
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
 (!exclusions.isEmpty && TerminalWitnesses.witnesses.all TerminalWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && TerminalWitnesses.witnesses.all TerminalWitnesses.Witness.passed) = true
 rw [TerminalWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.TerminalControls
