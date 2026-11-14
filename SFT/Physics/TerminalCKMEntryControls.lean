import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalCKMEntryGrammar
import SFT.Physics.TerminalCKMEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.TerminalCKMEntryControls
open SFT.Host.Canonical SFT.Foundation TerminalCKMEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, result table, certificate or measurement as a derivation premise", "no target-selected coefficient, bracket, iteration count, correction or candidate neighbourhood", "no semantic numerical zero, negative magnitude, irrational, imaginary or floating proof value", "no solved irrational algebraic root; exact polynomials and rational enclosures only", "no external value accessible before the formal seal", "no claim that this post-adverse completion was a blind forward discovery"]

def closureValue : Value := .object [
 ("result",.text "The terminal CKM contribution is exactly alpha times [A/(A+7)] divided by three, equivalently 1/[3(A+7)], where A is the admitted terminal inverse-alpha; it appends to the leading positive s23 slope gap, while the existing s12 and six-channel s13 relations are preserved."),
 ("base",.text "The admitted leading positive root-slope gap supplies the CKM carrier before terminal transport."),
 ("successor",.text "One terminal alpha share crosses the complete colour carrier and the existing upper-depth retention exactly once; no later transport is generated in this grammar."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (TerminalCKMEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && TerminalCKMEntryWitnesses.witnesses.all TerminalCKMEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && TerminalCKMEntryWitnesses.witnesses.all TerminalCKMEntryWitnesses.Witness.passed) = true
 rw [TerminalCKMEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-MATTER-CKM-TERMINAL-004",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.TerminalCKMEntryControls
