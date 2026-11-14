import SFT.Foundation.AdmissionControls
import SFT.Physics.StaticFoldClockEntryGrammar
import SFT.Physics.StaticFoldClockEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.StaticFoldClockEntryControls
open SFT.Host.Canonical SFT.Foundation StaticFoldClockEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, answer table or conventional metric equation as a premise", "no external measurement, astronomy image or target value selecting a formal survivor", "no fitted coupling, chosen curvature, tunable horizon scale or imported normalization", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no ungenerated continuum, completed infinity, unrecorded remote adjacency or omitted source ledger"]

def closureValue : Value := .object [
 ("result",.text "At well 1/8, Fold(7/8)=3/4=One-Fold(1/8); at well 7/16, metric square 9/16 has clock rate 3/4; the horizon yields an empty clock record."),
 ("base",.text "One weak well retains one positive clock square."),
 ("successor",.text "Each generated well repeats the exact covariance until the boundary becomes the empty record."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (StaticFoldClockEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && StaticFoldClockEntryWitnesses.witnesses.all StaticFoldClockEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && StaticFoldClockEntryWitnesses.witnesses.all StaticFoldClockEntryWitnesses.Witness.passed) = true
 rw [StaticFoldClockEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-GRAVITY-STATIC-CLOCK-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.StaticFoldClockEntryControls
