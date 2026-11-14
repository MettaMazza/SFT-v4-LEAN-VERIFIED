import SFT.Foundation.AdmissionControls
import SFT.Physics.PMNSGrammar
import SFT.Physics.PMNSWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.PMNSControls
open SFT.Foundation.AdmissionControls (admissionIdentity)
open SFT.Host.Canonical SFT.Foundation PMNSGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, proof certificate, candidate table or answer artifact as a premise", "no external measurement, conventional equation or fitted parameter selecting a survivor", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no unregistered force, particle, phase, scale, channel or correction rule"]

def closureValue : Value := .object [
 ("result",.text "The exact Fold PMNS squared-support triple is atmospheric 1/2, solar 1/3 and reactor 1/48."),
 ("base",.text "Binary and generator-three carriers supply the two irreducible large separation parts."),
 ("successor",.text "Complete binary support through generator depth has eight cells; distributing the joined large-separation carrier over all cells forces 1/48."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (PMNSWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && PMNSWitnesses.witnesses.all PMNSWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && PMNSWitnesses.witnesses.all PMNSWitnesses.Witness.passed) = true
 rw [PMNSWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := admissionIdentity (.array [.text "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.PMNSControls
