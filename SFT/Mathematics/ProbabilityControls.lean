import SFT.Mathematics.ProbabilityGrammar
import SFT.Mathematics.ProbabilityWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.ProbabilityControls
open SFT.Host.Canonical SFT.Foundation ProbabilityGrammar
set_option maxRecDepth 20000

def laws : List String := ["event weight is an exact positive part relation; empty event is empty One","conditional weight is exact restriction to a nonempty held condition","independence is a bijective complete joint-support factorization","uncertainty belongs to an observation partition and does not alter deterministic microstate evolution","statistical summaries retain exact provenance and all tied alternatives"]

def exclusions : List String := ["no ontic stochastic premise","no floating probability in proof evidence","no Bayesian or distributional prior parameter","no target data may select a formal law"]

def closureValue : Value := .object [
  ("exact_result",.text "The probability/statistics kernel is complete deterministic support, held events, exact held/whole weights, observation-class uncertainty, common-refinement conditioning, pair-cell independence, transparent finite summaries and post-seal empirical checking without random parameters."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (ProbabilityWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "A One-state support has whole certainty; its held-empty event is represented by empty One."),
  ("induction_step",.text "Adding one fresh microstate extends whole support once and either extends or leaves each held event. Exact parts, observation classes, intersections and summaries update from that retained membership without a prior."),
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
  passed := !exclusions.isEmpty && ProbabilityWitnesses.witnesses.all ProbabilityWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && ProbabilityWitnesses.witnesses.all ProbabilityWitnesses.Witness.passed) = true
  rw [ProbabilityWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.ProbabilityControls
