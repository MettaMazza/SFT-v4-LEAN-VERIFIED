import SFT.Foundation.AdmissionControls
import SFT.Physics.AtomicCorrectionsEntryGrammar
import SFT.Physics.AtomicCorrectionsEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.AtomicCorrectionsEntryControls
open SFT.Host.Canonical SFT.Foundation AtomicCorrectionsEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no imported QED coefficient series", "no measured splitting", "no irrational or floating proof value", "no selected correction order"]

def closureValue : Value := .object [
 ("result",.text "Gross is the One scale, fine/gross is alpha^2, and the first complete bound-return support is alpha^4 of gross; the gross Rydberg carrier in electron-rest units is alpha^2/2."),
 ("base",.text "The gross bound-state ladder supplies the One reference scale."),
 ("successor",.text "Transport through both held directions contributes alpha squared; the first complete self-return repeats that already typed carrier once and then stops."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (AtomicCorrectionsEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && AtomicCorrectionsEntryWitnesses.witnesses.all AtomicCorrectionsEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && AtomicCorrectionsEntryWitnesses.witnesses.all AtomicCorrectionsEntryWitnesses.Witness.passed) = true
 rw [AtomicCorrectionsEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-CORRECTION-HIERARCHY-004",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.AtomicCorrectionsEntryControls
