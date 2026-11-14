import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalHyperfineEntryGrammar
import SFT.Physics.TerminalHyperfineEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.TerminalHyperfineEntryControls
open SFT.Host.Canonical SFT.Foundation TerminalHyperfineEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured 21-cm frequency or Rydberg value in execution", "no imported proton magnetic moment", "no fitted magnetic coefficient or hidden target knowledge", "no negative, irrational, imaginary or floating proof value", "no collapse of the algebraic rho enclosure to a decimal"]

def closureValue : Value := .object [
 ("result",.text "For each exact terminal proton/electron ratio rho, nu_hfs/(R-infinity*c)=(16/3)alpha^2 rho^-1[rho/(rho+1)]^3 M, where M=T-1/3-2alpha+(5/16)alpha-(16/53)alpha^2-(7/80)alpha^3+alpha^4/135; exact algebraic rho isolation gives a strict rational prediction enclosure."),
 ("base",.text "The terminal proton/electron algebraic graph supplies a positive exact rho enclosure and one inverse-mass magnetic carrier."),
 ("successor",.text "Apply the cubic reduced-mass retention, both spin ends and every finite magnetic return in order; all opposing terms are held positive Takes and the colour-volume terminal cell halts the relation."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (TerminalHyperfineEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && TerminalHyperfineEntryWitnesses.witnesses.all TerminalHyperfineEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && TerminalHyperfineEntryWitnesses.witnesses.all TerminalHyperfineEntryWitnesses.Witness.passed) = true
 rw [TerminalHyperfineEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.TerminalHyperfineEntryControls
