import SFT.Foundation.AdmissionControls
import SFT.Physics.AtomicTransitionEntryGrammar
import SFT.Physics.AtomicTransitionEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.AtomicTransitionEntryControls
open SFT.Host.Canonical SFT.Foundation AtomicTransitionEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured line intensity", "no imported angular-momentum algebra", "no unrecorded multi-unit elementary jump", "no signed field proof value"]

def closureValue : Value := .object [
 ("result",.text "An elementary admitted transition changes one orbital support unit, retains its carrier, has two magnetic orientations and six complete cubic electric orientations."),
 ("base",.text "A single atomic Fold act carries exactly one generated transition unit."),
 ("successor",.text "Composition appends another individually traceable one-unit act; it cannot convert one act into an unrecorded multi-unit elementary transition."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (AtomicTransitionEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && AtomicTransitionEntryWitnesses.witnesses.all AtomicTransitionEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && AtomicTransitionEntryWitnesses.witnesses.all AtomicTransitionEntryWitnesses.Witness.passed) = true
 rw [AtomicTransitionEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-TRANSITION-SELECTION-004",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.AtomicTransitionEntryControls
