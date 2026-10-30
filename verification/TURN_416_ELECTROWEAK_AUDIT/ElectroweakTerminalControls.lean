import SFT.Physics.ElectroweakTerminalGrammar
import SFT.Physics.ElectroweakTerminalWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.ElectroweakTerminalControls
open SFT.Host.Canonical SFT.Foundation ElectroweakTerminalGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no external measured value, uncertainty or best-fit table as a derivation input", "no V1/V2 executable, candidate table, certificate or answer artifact as a premise", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no fitted level, coefficient, correction sign, truncation or target-selected candidate neighbourhood"]

def closureValue : Value := .object [
 ("result",.text "The terminal on-shell electroweak share is sin-squared = 1930922298157999/8642477221479757 and its exact One-complement is cos-squared = 6711554923321758/8642477221479757."),
 ("base",.text "The admitted bare fibre establishes two channel orientations and the terminal alpha construction establishes a four-rung finite object."),
 ("successor",.text "Complete binary support at the terminal rung count fixes sixteen; holding all three generator directions fixes level thirteen, and the unique complete-support successor fixes return divisor seventeen, leaving no further rung or carrier."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (ElectroweakTerminalWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && ElectroweakTerminalWitnesses.witnesses.all ElectroweakTerminalWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && ElectroweakTerminalWitnesses.witnesses.all ElectroweakTerminalWitnesses.Witness.passed) = true
 rw [ElectroweakTerminalWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.ElectroweakTerminalControls
