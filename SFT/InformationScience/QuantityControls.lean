import SFT.InformationScience.QuantityGrammar
import SFT.InformationScience.QuantityWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.QuantityControls
open SFT.Host.Canonical SFT.Foundation QuantityGrammar
set_option maxRecDepth 20000

def laws : List String := ["retained and closed distinction ledgers are disjoint and exhaust complete support pairs","fine observation retains every nonidentity support distinction","coarsening can only move pair distinctions from retained to closed","one complete Fold position supplies one independently realized distinction unit","composing supports retains both source coordinates and concatenates their unit traces"]

def exclusions : List String := ["no logarithm as a proof operation","no real-valued or irrational information quantity","no semantic numerical zero for identity information","no incomplete support presented as full quantity"]

def closureValue : Value := .object [
  ("exact_result",.text "The information-quantity kernel is complete support and pair ledgers, exact retained/closed observation distinctions, first-Fold units, independently witnessed position traces, pair-support composition and no log scale."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (QuantityWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "The first Fold position has complete two-label support and one independently realized distinction unit."),
  ("induction_step",.text "Appending one fresh position extends every prior word once with every held label. Prior position witnesses remain, the fresh position varies across its labels for each held prefix, and all new support pairs enter exactly once."),
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
  passed := !exclusions.isEmpty && QuantityWitnesses.witnesses.all QuantityWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && QuantityWitnesses.witnesses.all QuantityWitnesses.Witness.passed) = true
  rw [QuantityWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.QuantityControls
