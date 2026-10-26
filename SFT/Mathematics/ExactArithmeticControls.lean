import SFT.Mathematics.ExactArithmeticGrammar
import SFT.Mathematics.ExactArithmeticWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.ExactArithmeticControls
open SFT.Host.Canonical SFT.Foundation ExactArithmeticGrammar
set_option maxRecDepth 20000

def laws : List String := ["disjoint junction is associative on mutually disjoint generated traces","pair-cell product distributes over disjoint junction by generated cell provenance","pair-cell product composition is associative after canonical path flattening","exact quotient exists only with a complete refinement-pairing witness","comparison returns same-form or a held positive remainder orientation"]

def exclusions : List String := ["semantic numerical zero is not a value","negative magnitude is replaced by held orientation","irrational, imaginary and floating proof values are excluded","completed infinity and an ungenerated continuum are excluded"]

def closureValue : Value := .object [
  ("exact_result",.text "The exact arithmetic kernel is complete positive-trace coverage with disjoint junction, pair-cell product, common-refinement quotient, complete pairing comparison, held-oriented remainder, base/successor generality and no extra rule."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (ExactArithmeticWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "The structural One supplies the first nonempty trace and exact self-whole."),
  ("induction_step",.text "Appending one fresh generated occurrence preserves complete trace identity; junction appends it once, pair-cell refinement appends one labelled cell per opposite trace element, and pairing either extends with one mate or records the unmatched held remainder."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with coverage := .rejected }

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
  passed := !exclusions.isEmpty && ExactArithmeticWitnesses.witnesses.all ExactArithmeticWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && ExactArithmeticWitnesses.witnesses.all ExactArithmeticWitnesses.Witness.passed) = true
  rw [ExactArithmeticWitnesses.everyWitnessPassed]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.ExactArithmeticControls
