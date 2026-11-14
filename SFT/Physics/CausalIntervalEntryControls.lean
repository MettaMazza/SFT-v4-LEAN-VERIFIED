import SFT.Foundation.AdmissionControls
import SFT.Physics.CausalIntervalEntryGrammar
import SFT.Physics.CausalIntervalEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.CausalIntervalEntryControls
open SFT.Host.Canonical SFT.Foundation CausalIntervalEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, answer table or conventional metric equation as a premise", "no external measurement, astronomy image or target value selecting a formal survivor", "no fitted coupling, chosen curvature, tunable horizon scale or imported normalization", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no ungenerated continuum, completed infinity, unrecorded remote adjacency or omitted source ledger"]

def closureValue : Value := .object [
 ("result",.text "Temporal One and spatial 3/5 retain interval square 16/25 and proper time 4/5; equal temporal/spatial support yields the empty massless boundary."),
 ("base",.text "One generated causal triple closes exactly."),
 ("successor",.text "Every interval appends its positive take and held causal class."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (CausalIntervalEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && CausalIntervalEntryWitnesses.witnesses.all CausalIntervalEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && CausalIntervalEntryWitnesses.witnesses.all CausalIntervalEntryWitnesses.Witness.passed) = true
 rw [CausalIntervalEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-SPACETIME-EXACT-INTERVAL-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.CausalIntervalEntryControls
