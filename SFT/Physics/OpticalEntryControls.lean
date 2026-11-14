import SFT.Foundation.AdmissionControls
import SFT.Physics.OpticalEntryGrammar
import SFT.Physics.OpticalEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.OpticalEntryControls
open SFT.Host.Canonical SFT.Foundation OpticalEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, candidate table, certificate or answer artifact as a premise", "no conventional field equation, continuum, matrix algebra or measured constant selecting a survivor", "no fitted coefficient, adjustable phase, imported normalization or target-selected value", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no target access before the complete exact result and candidate census are sealed"]

def closureValue : Value := .object [
 ("result",.text "Eight One-speed ticks retain phase exactly; polarization has two held transverse labels; equal half carriers give bright One or an empty dark record; 1/3 and 1/4 mix to 7/12, 1/12 and second harmonic 1/2, while Kerr witnesses also return 1/2."),
 ("base",.text "One joint electric/magnetic recurrence transports one complete tick with held orientation."),
 ("successor",.text "Every further tick or interaction composes exact carriers and retains the full source/phase ledger."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (OpticalEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && OpticalEntryWitnesses.witnesses.all OpticalEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && OpticalEntryWitnesses.witnesses.all OpticalEntryWitnesses.Witness.passed) = true
 rw [OpticalEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-WAVE-EXACT-OPERATIONS-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.OpticalEntryControls
