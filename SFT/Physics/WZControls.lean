import SFT.Foundation.AdmissionControls
import SFT.Physics.WZGrammar
import SFT.Physics.WZWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.WZControls
open SFT.Foundation.AdmissionControls (admissionIdentity)
open SFT.Host.Canonical SFT.Foundation WZGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, proof certificate, candidate table or answer artifact as a premise", "no external measurement, conventional equation or fitted parameter selecting a survivor", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no unregistered force, particle, phase, scale, channel or correction rule", "no square root of three and no unsquared irrational proof value"]

def closureValue : Value := .object [
 ("result",.text "The exact squared W-to-Z Fold relation is (M_W/M_Z)^2 = 3/4; no irrational unsquared ratio is formed."),
 ("base",.text "The half-One fibre contains one lower and one upper exact channel part."),
 ("successor",.text "The massive-to-complete squared relation retains the upper complementary part under every lawful same-dimension scale transport."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (WZWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && WZWitnesses.witnesses.all WZWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && WZWitnesses.witnesses.all WZWitnesses.Witness.passed) = true
 rw [WZWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := admissionIdentity (.array [.text "SFT-PHYS-ELECTROWEAK-WZ-RATIO-002",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.WZControls
