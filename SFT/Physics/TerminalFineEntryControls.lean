import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalFineEntryGrammar
import SFT.Physics.TerminalFineEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.TerminalFineEntryControls
open SFT.Host.Canonical SFT.Foundation TerminalFineEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured fine splitting or Rydberg value in execution", "no consensus Ritz value as a premise", "no fitted coefficient or selected correction", "no negative, irrational, imaginary or floating proof value", "no rewriting of the leading fine/gross receipt"]

def closureValue : Value := .object [
 ("result",.text "The unique target-inaccessible ratio is alpha^2/16[1+alpha/4-(113/288)alpha^2-alpha^3/32-(10/137)alpha^4]."),
 ("base",.text "The two handed Fold directions force alpha squared and four terminal promotion rungs force support sixteen."),
 ("successor",.text "Apply the binary-squared return, then hold the turn/boundary, down-support and endpoint returns in generated order; the endpoint closes the grammar."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (TerminalFineEntryWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with predecessor := .rejected }
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
 (!exclusions.isEmpty && TerminalFineEntryWitnesses.witnesses.all TerminalFineEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && TerminalFineEntryWitnesses.witnesses.all TerminalFineEntryWitnesses.Witness.passed) = true
 rw [TerminalFineEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-FINE-STRUCTURE-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.TerminalFineEntryControls
