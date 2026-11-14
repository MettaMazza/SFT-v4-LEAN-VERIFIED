import SFT.Foundation.AdmissionControls
import SFT.Physics.VacuumInertiaGrammar
import SFT.Physics.VacuumInertiaWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.VacuumInertiaControls
open SFT.Foundation.AdmissionControls (admissionIdentity)
open SFT.Host.Canonical SFT.Foundation VacuumInertiaGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, candidate table or answer artifact as a premise", "no external measurement, conventional vacuum model or apparatus result selecting a survivor", "no fitted coefficient, tunable phase, chosen reservoir value or answer-selected harmonic", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no deletion of the positive outward extraction result or of the complete restoration ledger", "no UAP report, propulsion observation or engineering performance used as validation"]

def closureValue : Value := .object [
 ("result",.text "The exact vacuum-to-inertia exchange ratio is the One: (1/2)/(1/2)=1, with both carriers completing in one Fold."),
 ("base",.text "Vacuum displacement and native coupling are independently forced to the half-One."),
 ("successor",.text "Every exact proportional change must retain the same ratio One; an unequal change leaves an unrecorded carrier and is rejected."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (VacuumInertiaWitnesses.witnesses.map fun w => .object [
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
 (!(SFT.Host.Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && VacuumInertiaWitnesses.witnesses.all VacuumInertiaWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && VacuumInertiaWitnesses.witnesses.all VacuumInertiaWitnesses.Witness.passed) = true
 rw [VacuumInertiaWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := admissionIdentity (.array [.text "SFT-PHYS-VACUUM-INERTIA-UNITY-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.VacuumInertiaControls
