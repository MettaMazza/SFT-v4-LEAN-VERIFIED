import SFT.Foundation.AdmissionControls
import SFT.Physics.TwoHandGrammar
import SFT.Physics.TwoHandWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.TwoHandControls
open SFT.Host.Canonical SFT.Foundation TwoHandGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, candidate table, certificate or answer artifact as a premise", "no conventional field equation, continuum, matrix algebra or measured constant selecting a survivor", "no fitted coefficient, adjustable phase, imported normalization or target-selected value", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no target access before the complete exact result and candidate census are sealed"]

def closureValue : Value := .object [
 ("result",.text "The exact two-component square is (3/5)^2 + (4/5)^2 = 9/25 + 16/25 = One."),
 ("base",.text "The forced generator three and binary square four produce covering count five."),
 ("successor",.text "Replication retains the same exact square identity for every source-labelled copy."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (TwoHandWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && TwoHandWitnesses.witnesses.all TwoHandWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && TwoHandWitnesses.witnesses.all TwoHandWitnesses.Witness.passed) = true
 rw [TwoHandWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.TwoHandControls
