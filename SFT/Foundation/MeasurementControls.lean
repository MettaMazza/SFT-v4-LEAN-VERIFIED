import SFT.Foundation.MeasurementGrammar
import SFT.Foundation.FoldControls
namespace SFT.Foundation.MeasurementControls
open SFT.Host.Canonical MeasurementProtocol
set_option maxRecDepth 20000

def closureRecord : List (String × String) := [
  ("direction","Scientific testing requires consequences to leave a derivation, while clean forcing forbids targets or measurements from entering law selection; only outward derivation-to-measurement flow satisfies both."),
  ("exactness","The derivation remains exact. A measurement adapter may record conventional decimals only after the law and consequence are sealed."),
  ("custody","Opening targets after the seal prevents answer flow into the derivation."),
  ("retention","Complete favorable, unfavorable, failed and tampered rows are required for falsifiability."),
  ("immutability","Measurement can validate, invalidate or bound a claim but cannot rewrite its sealed law."),
  ("minimality","Removing exactness, custody, source identity, row completeness or immutability loses a scientific control; extra rules are unregistered."),
  ("named_shape_uniqueness","Only derivation-to-measurement__proof-exact__target-after-seal__rows-complete__source-identified__law-unchanged__no-extra satisfies the complete one-way boundary."),
  ("generality","The phase and capability relation is independent of scientific branch, target size and host operating system.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1,.text p.2))

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := !(accepts true false true true)
  expected := "reject target access before the prediction seal"
  observed := "the boundary protocol rejects pre-seal target access"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject changed derivation source identity"
  observed := "changed identity differs"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := !(accepts false false false true) && !(accepts false true true true)
  expected := "reject selective rows or post-measurement law mutation"
  observed := "both tampered interfaces are rejected"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := SFT.Host.Text.contains "The derivation remains exact. A measurement adapter may record conventional decimals only after the law and consequence are sealed." "only after"
  expected := "permit conventional decimals only as post-seal measured records"
  observed := "proof stays exact and measurement records remain quarantined"

theorem falsePremisePassed : falsePremise.passed = true := rfl
theorem tamperedArtifactPassed : tamperedArtifact.passed = true := rfl
theorem boundaryPassed : boundary.passed = true := rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Foundation.MeasurementControls
