import SFT.Physics.PlanckTerminalGrammar
import SFT.Physics.PlanckTerminalWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.PlanckTerminalControls
open SFT.Host.Canonical SFT.Foundation PlanckTerminalGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no external measured value, uncertainty or best-fit table as a derivation input", "no V1/V2 executable, candidate table, certificate or answer artifact as a premise", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no fitted level, coefficient, correction sign, truncation or target-selected candidate neighbourhood", "no irrational square root; authoritative mass intervals are squared only after the formal seal"]

def closureValue : Value := .object [
 ("result",.text "The terminal squared Planck/proton hierarchy is 255923934603817488008405160690199418432572494970880/1511539186407, equal to 2^127 times (1 - (2/3) alpha_terminal)."),
 ("base",.text "The lower law fixes all 127 massive positions and therefore the exact squared support 2^127."),
 ("successor",.text "The admitted charged-colour carrier transports the sole terminal electromagnetic share once; its positive complement exhausts the retained support and admits no second correction."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (PlanckTerminalWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && PlanckTerminalWitnesses.witnesses.all PlanckTerminalWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && PlanckTerminalWitnesses.witnesses.all PlanckTerminalWitnesses.Witness.passed) = true
 rw [PlanckTerminalWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-SCALE-PROTON-PLANCK-TERMINAL-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.PlanckTerminalControls
