import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalMuonAnomalyEntryGrammar
import SFT.Physics.TerminalMuonAnomalyEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.TerminalMuonAnomalyEntryControls
open SFT.Host.Canonical SFT.Foundation TerminalMuonAnomalyEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no muon measurement in the executable relation", "no imported QED or consensus anomaly", "no fitted mass scale or coefficient", "no negative, irrational, imaginary or floating proof value", "no extra terminal term"]

def closureValue : Value := .object [
 ("result",.text "The exact muon anomaly is the terminal electron anomaly plus alpha^2 [2/17 + alpha/106 + alpha^2/853], with 17=2*3^2-1, 53=2*3^3-1 and 853=16*53+5."),
 ("base",.text "The complete terminal electron anomaly supplies the universal charged-lepton loop."),
 ("successor",.text "Append the second-generation complement, its single depth-three alpha return and its sole terminal support cell in order; every term is positive, exact and used once."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (TerminalMuonAnomalyEntryWitnesses.witnesses.map fun w => .object [
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
 (!(SFT.Host.Text.equal (SFT.Foundation.AdmissionControls.admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && TerminalMuonAnomalyEntryWitnesses.witnesses.all TerminalMuonAnomalyEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && TerminalMuonAnomalyEntryWitnesses.witnesses.all TerminalMuonAnomalyEntryWitnesses.Witness.passed) = true
 rw [TerminalMuonAnomalyEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.TerminalMuonAnomalyEntryControls
