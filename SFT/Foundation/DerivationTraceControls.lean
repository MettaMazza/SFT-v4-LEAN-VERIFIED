import SFT.Foundation.DerivationTraceWitnesses
import SFT.Foundation.ExactOperationsControls
namespace SFT.Foundation.DerivationTraceControls
set_option maxRecDepth 20000
open SFT.Host.Canonical DerivationTrace DerivationTraceWitnesses ExactOperationsControls FoldDynamics

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := rejected (replay falsePremiseTrace)
  expected := "reject an unregistered operation"
  observed := "replay halts on an unregistered row"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject changed source identity"
  observed := "changed identity differs"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := rejected (replay tamperedTrace)
  expected := "reject a changed intermediate or output"
  observed := "the changed terminal value disagrees with its bound identity"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := (match replayThreeMove with
    | .error _ => false
    | .ok result => samePart result twoThirds) && samePart (ExactOperations.foldPart third) twoThirds
  expected := "replay the complete exact trace and agree with the independent direct route"
  observed := "both routes terminate at exact two-of-three"

theorem falsePremisePassed : falsePremise.passed = true := by
  dsimp only [falsePremise]
  rw [falsePremiseRejected]
  rfl

theorem tamperedArtifactPassed : tamperedArtifact.passed = true := by
  dsimp only [tamperedArtifact]
  rw [tamperedArtifactRejected]
  rfl

theorem boundaryPassed : boundary.passed = true := by
  dsimp only [boundary]
  rw [threeMoveReplay,thirdFoldsToTwoThirds]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Foundation.DerivationTraceControls
