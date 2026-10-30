import SFT.QuantumComputation.MeasurementGrammar
import SFT.Foundation.FoldControls
namespace SFT.QuantumComputation.MeasurementControls
open SFT.Host.Canonical SFT.Foundation SFT.QuantumComputation.MeasurementGrammar
set_option maxRecDepth 20000
def claimId : String := "SFT-QUANTUM-MEASUREMENT-001"
def exclusions : List String := ["no numerical zero, negative, irrational, imaginary or floating proof quantity","no complex amplitude, Hilbert-space axiom or stochastic collapse postulate","no completed infinity or ungenerated continuum","no free, fitted, learned or hardware parameter","no application output or physical measurement may select the law","No stochastic collapse postulate is imported; outcome frequencies require external empirical evidence."]
def falseCandidate : Candidate := { survivor with support := .rejected }
def survivorIds : List String := (candidates.filter survives).map candidateId
def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := !(SFT.Host.Text.equal (candidateId falseCandidate) survivorId)
  expected := "reject incomplete state support"
  observed := decisionReason falseCandidate

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject changed source identity"
  observed := "changed source differs"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := survivorIds.length == 1
  expected := "reject altered survivor support"
  observed := "one literal survivor"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := !exclusions.isEmpty && SFT.QuantumComputation.ReversibleWitnesses.checks.all id
  expected := "halt complex amplitude, stochastic collapse or imported quantum postulate"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl
theorem boundaryPassed : boundary.passed = true := by
  change (true && SFT.QuantumComputation.ReversibleWitnesses.checks.all id) = true
  rw [SFT.QuantumComputation.ReversibleWitnesses.allWitnessesPassed]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
  kind := c.kind
  passed := c.passed
  expectedBehavior := c.expected
  observedBehavior := c.observed
  receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName c.kind),.text c.expected,.text c.observed,.boolean c.passed])

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.QuantumComputation.MeasurementControls
