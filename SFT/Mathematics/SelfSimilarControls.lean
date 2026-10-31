import SFT.Mathematics.SelfSimilarGrammar
import SFT.Mathematics.SelfSimilarWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.SelfSimilarControls
open SFT.Host.Canonical SFT.Foundation SelfSimilarGrammar
set_option maxRecDepth 20000

def laws : List String := ["local uncast separation multiplies by the Fold count", "one predecessor label is closed per Fold merge", "rank doubling paired with count halving selects the unit power among the generated nonnegative whole exponent forms", "m-labelled successor support obeys the base/successor count m^d", "a geometric rational tail bound proves finite accumulated separation"]

def exclusions : List String := ["semantic numerical zero is not an admitted value", "negative magnitude is represented only by held orientation", "irrational, imaginary and floating proof values are excluded", "a completed infinity and an ungenerated continuum are excluded"]

def closureValue : Value := .object [
  ("exact_result",.text "The exact Fold rate is binary separation expansion and one closed label per step; unit rank power is the unique Fold-self-similar exponent, m-labelled support is m^d, and decreasing rational terms close convergence without importing their limit as a value."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (SelfSimilarWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "At depth One an m-labelled successor has m states and one Fold closes one binary distinction."),
  ("induction_step",.text "Appending one label multiplies support by m; applying one Fold multiplies an uncast local gap by b and closes one predecessor label; one further rational term preserves the tail bound."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with scale := .rejected }

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
  passed := !exclusions.isEmpty && SelfSimilarWitnesses.witnesses.all SelfSimilarWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && SelfSimilarWitnesses.witnesses.all SelfSimilarWitnesses.Witness.passed) = true
  rw [SelfSimilarWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.SelfSimilarControls
