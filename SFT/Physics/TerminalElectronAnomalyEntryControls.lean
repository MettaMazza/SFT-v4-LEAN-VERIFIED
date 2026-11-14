import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalElectronAnomalyEntryGrammar
import SFT.Physics.TerminalElectronAnomalyEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.TerminalElectronAnomalyEntryControls
open SFT.Host.Canonical SFT.Foundation TerminalElectronAnomalyEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no electron measurement in the executable relation", "no imported QED series or coefficient", "no signed, irrational, imaginary or floating proof value", "no selected loop truncation or extra term"]

def closureValue : Value := .object [
 ("result",.text "With alpha the admitted exact coupling and T=355/113, the electron anomaly is exactly [alpha/(2T)] times positive_take(One, alpha L), where L is the sum of positive_take(5/24,2 alpha/15) and positive_take(alpha^2/15,7 alpha^3/30)."),
 ("base",.text "The admitted positive leading anomaly supplies alpha over the binary turn carrier."),
 ("successor",.text "Close the open-bulk pair and then the terminal closed-support pair in phase order; each uses its generated carrier once, after which alpha transports the complete loop once and no typed term remains."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (TerminalElectronAnomalyEntryWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with leading := .rejected }
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
 (!(SFT.Host.Text.equal (SFT.Foundation.AdmissionControls.admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && TerminalElectronAnomalyEntryWitnesses.witnesses.all TerminalElectronAnomalyEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && TerminalElectronAnomalyEntryWitnesses.witnesses.all TerminalElectronAnomalyEntryWitnesses.Witness.passed) = true
 rw [TerminalElectronAnomalyEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.TerminalElectronAnomalyEntryControls
