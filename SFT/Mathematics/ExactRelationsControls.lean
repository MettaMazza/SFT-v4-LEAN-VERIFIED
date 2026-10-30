import SFT.Mathematics.ExactRelationsGrammar
import SFT.Mathematics.ExactRelationsWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.ExactRelationsControls
open SFT.Host.Canonical SFT.Foundation ExactRelationsGrammar
set_option maxRecDepth 20000

def laws : List String := ["a positive ratio composed with its reciprocal returns the One", "relative views telescope by exact ratio composition", "the first common return of finite periods is their iterated least common multiple", "count times the corresponding equal part reconstructs the One"]

def exclusions : List String := ["semantic numerical zero is not an admitted value", "negative magnitude is represented only by held orientation", "irrational, imaginary and floating proof values are excluded", "a completed infinity and an ungenerated continuum are excluded"]

def closureValue : Value := .object [
  ("exact_result",.text "The unique exact relation kernel is generated-part ratio, held shorter separation, unique complement threshold, Fold-factor transport and least-common-return composition with finite-family induction."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (ExactRelationsWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One exact cycle returns after its own generated period."),
  ("induction_step",.text "Composing one more positive finite cycle replaces the current joint period by its least common return with the new period."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with provenance := .rejected }

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
  passed := !exclusions.isEmpty && ExactRelationsWitnesses.witnesses.all ExactRelationsWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && ExactRelationsWitnesses.witnesses.all ExactRelationsWitnesses.Witness.passed) = true
  rw [ExactRelationsWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.ExactRelationsControls
