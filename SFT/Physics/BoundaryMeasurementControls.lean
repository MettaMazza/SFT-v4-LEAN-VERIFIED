import SFT.Physics.BoundaryMeasurementGrammar
import SFT.Physics.BoundaryMeasurementWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.BoundaryMeasurementControls
open SFT.Host.Canonical SFT.Foundation BoundaryMeasurementGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no logarithm, irrational exponent, floating fit or regression", "no semantic numerical zero or negative proof magnitude", "no physical dimension or inverse-power answer supplied before observation", "no target access before the complete method seal", "no omitted measurement, uncertainty component or compatible exponent"]

def closureValue : SFT.Host.Canonical.Value := .object [
 ("result",.text "One source-bound exact ratio experiment, complete response uncertainty, positive successor-power enumeration, all-compatible selection, monotonic closure, post-seal custody and complete trace."),
 ("base",.text "The first positive exponent predicts the registered distance ratio itself and receives one exact inside/below/above interval decision."),
 ("successor",.text "If the current power has not strictly exceeded the response upper endpoint, multiply once by the same distance ratio to obtain the next positive exponent.  If it has exceeded, every successor is strictly larger and is closed without a completed infinite census."),
 ("exclusions",.array (exclusions.map SFT.Host.Canonical.Value.text)),
 ("witnesses",.array (BoundaryMeasurementWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with source := .rejected }
def survivorIds : List String := (candidates.filter survives).map candidateId

def record (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : FoldControls.ControlRecord where
 kind := kind
 passed := passed
 expected := observation
 observed := if passed then observation else "control failed"

def falsePremise : FoldControls.ControlRecord := record .falsePremise
 (!(SFT.Host.Text.equal (candidateId falseCandidate) survivorId))
 "reject the generated form missing the first preservation"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord := record .tamperedSource
 (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && BoundaryMeasurementWitnesses.witnesses.all BoundaryMeasurementWitnesses.Witness.passed)
 "reject excluded capabilities, values or authority paths"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && BoundaryMeasurementWitnesses.witnesses.all BoundaryMeasurementWitnesses.Witness.passed) = true
 rw [BoundaryMeasurementWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-MEAS-BOUNDARY-GROWTH-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : SFT.Host.Canonical.Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.BoundaryMeasurementControls
