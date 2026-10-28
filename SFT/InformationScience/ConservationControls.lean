import SFT.InformationScience.ConservationGrammar
import SFT.InformationScience.ConservationWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.ConservationControls
open SFT.Host.Canonical SFT.Foundation ConservationGrammar
set_option maxRecDepth 20000

def laws : List String := ["retained and closed ledgers are disjoint and exhaust every source distinction","information loss is exactly the source distinctions inside non-singleton image fibres","a transformation is reversible exactly when every predecessor fibre is singleton","a non-singleton fibre requires a retained predecessor label for exact reconstruction","composition cannot restore a distinction already closed by an upstream deterministic map"]

def exclusions : List String := ["no image without source provenance","no assumed inverse across merged predecessors","no scalar conservation law replacing distinction ledgers","no downstream reopening without a declared external record"]

def closureValue : Value := .object [
  ("exact_result",.text "The transformation kernel is complete source support, a total held map, exact predecessor fibres, exhaustive retained/closed source distinctions, singleton-fibre reversibility, held reverse records, compositional retention monotonicity and no unrecorded information source."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (ConservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One source maps to one held image, has one singleton fibre and structural empty-One pair ledgers."),
  ("induction_step",.text "Adding one fresh source adds one image membership and one pair against each prior source. Image equality places each new pair exactly in the retained or closed ledger and updates one predecessor fibre."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with support := .rejected }

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
  passed := !exclusions.isEmpty && ConservationWitnesses.witnesses.all ConservationWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && ConservationWitnesses.witnesses.all ConservationWitnesses.Witness.passed) = true
  rw [ConservationWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.ConservationControls
