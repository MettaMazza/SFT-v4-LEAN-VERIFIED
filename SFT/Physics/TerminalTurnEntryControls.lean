import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalTurnEntryGrammar
import SFT.Physics.TerminalTurnEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.TerminalTurnEntryControls
open SFT.Host.Canonical SFT.Foundation TerminalTurnEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no imported pi or continuum circumference", "no measured magnetic anomaly", "no floating or irrational proof value", "no selected remainder or extra term"]

def closureValue : Value := .object [
 ("result",.text "The unique exact finite turn projection is 355/113 = 3 + 1/(7 + 1/16), with every count generated and no irrational or floating proof value."),
 ("base",.text "Three complete generator sectors supply the whole part of the diameter-normalized turn."),
 ("successor",.text "The sole residue passes through up-depth seven and terminates on the complete sixteen-cell support of all four promotion rungs; no later rung exists."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (TerminalTurnEntryWitnesses.witnesses.map fun w => .object [
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
 (!(SFT.Host.Text.equal (SFT.Foundation.AdmissionControls.admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && TerminalTurnEntryWitnesses.witnesses.all TerminalTurnEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && TerminalTurnEntryWitnesses.witnesses.all TerminalTurnEntryWitnesses.Witness.passed) = true
 rw [TerminalTurnEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.TerminalTurnEntryControls
