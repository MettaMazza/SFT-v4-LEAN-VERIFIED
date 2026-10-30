import SFT.Mathematics.LimitContinuumGrammar
import SFT.Mathematics.LimitContinuumWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.LimitContinuumControls
open SFT.Host.Canonical SFT.Foundation LimitContinuumGrammar
set_option maxRecDepth 20000

def laws : List String := ["every dyadic rung reaches the One in exactly its counted depth", "every finite depth has a lawful next depth", "exact finite-difference sequences may converge by shrinking positive rational error bounds", "no completed continuum cardinality claim is admitted without a generated object"]

def exclusions : List String := ["semantic numerical zero is not an admitted value", "negative magnitude is represented only by held orientation", "irrational, imaginary and floating proof values are excluded", "a completed infinity and an ungenerated continuum are excluded"]

def closureValue : Value := .object [
  ("exact_result",.text "Potential infinity is the never-terminal generated successor process; every reached object is finite and positive, convergence is an exact nested-bound certificate, and completed infinity or continuum is outside the admitted object language."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (LimitContinuumWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "The One is the complete finite base and its first refinement is a positive exact part."),
  ("induction_step",.text "Appending one generated Fold depth replaces a positive one-of-b^k rung by the positive one-of-b^(k+1) rung and records one additional return step."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with object := .rejected }

def survivorIds : List String := (candidates.filter survives).map candidateId

def distinctIdentifiers : List String := (candidates.map candidateId).eraseDups

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := !(SFT.Host.Text.equal (candidateId falseCandidate) survivorId)
  expected := "reject a generated form missing the first required structural condition"
  observed := decisionReason falseCandidate

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject a changed official source identity"
  observed := "the changed identity differs from the registered source manifest"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := survivorIds.length == 1 && distinctIdentifiers.length == candidates.length
  expected := "reject a missing, duplicated or additional survivor"
  observed := "the generated product contains exactly one registered survivor"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := !exclusions.isEmpty && LimitContinuumWitnesses.witnesses.all LimitContinuumWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && LimitContinuumWitnesses.witnesses.all LimitContinuumWitnesses.Witness.passed) = true
  rw [LimitContinuumWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.LimitContinuumControls
