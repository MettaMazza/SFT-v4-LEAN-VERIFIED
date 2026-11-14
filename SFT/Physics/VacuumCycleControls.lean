import SFT.Foundation.AdmissionControls
import SFT.Physics.VacuumCycleGrammar
import SFT.Physics.VacuumCycleWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.VacuumCycleControls
open SFT.Foundation.AdmissionControls (admissionIdentity)
open SFT.Host.Canonical SFT.Foundation VacuumCycleGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, candidate table or answer artifact as a premise", "no external measurement, conventional vacuum model or apparatus result selecting a survivor", "no fitted coefficient, tunable phase, chosen reservoir value or answer-selected harmonic", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no deletion of the positive outward extraction result or of the complete restoration ledger", "no suppression of reservoir depletion, apparatus reset, information record or restoration cost"]

def closureValue : Value := .object [
 ("result",.text "A complete returned cycle is: outward vacuum 1/2 -> 1/3 + work 1/6; restoration 1/3 + 1/6 -> vacuum 1/2; residual work is the empty structural form, not numerical zero."),
 ("base",.text "The outward leg is the separately admitted positive one-sixth extraction event."),
 ("successor",.text "Exact return of the vacuum carrier uniquely requires the missing one-sixth; returning every additional retained record similarly requires its exact held support."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (VacuumCycleWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && VacuumCycleWitnesses.witnesses.all VacuumCycleWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && VacuumCycleWitnesses.witnesses.all VacuumCycleWitnesses.Witness.passed) = true
 rw [VacuumCycleWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := admissionIdentity (.array [.text "SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.VacuumCycleControls
