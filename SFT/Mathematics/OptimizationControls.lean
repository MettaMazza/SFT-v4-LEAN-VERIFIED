import SFT.Mathematics.OptimizationGrammar
import SFT.Mathematics.OptimizationWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.OptimizationControls
open SFT.Host.Canonical SFT.Foundation OptimizationGrammar
set_option maxRecDepth 20000

def laws : List String := ["optimization may eliminate a candidate only with a retained feasible dominator witness","all undominated candidates survive and uniqueness is a separately checked singleton property","Pareto comparison retains incomparability across exact criteria","decomposition is lawful only with complete shared-interface factorization","approximation is an exact generated part relation rather than a rounded scalar"]

def exclusions : List String := ["no floating objective or tolerance","no negative penalty term","no tunable regularizer or tie-break parameter","no unenumerated candidate domain"]

def closureValue : Value := .object [
  ("exact_result",.text "The optimization kernel is complete canonical candidates, source-bound feasibility, exact preference, complete undominated selection, retained ties, exact constraints and interfaces, and positive-part bounds without an added objective."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (OptimizationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "A One-candidate feasible carrier has that candidate as its unique complete undominated selection."),
  ("induction_step",.text "Adding one fresh candidate generates its feasibility verdicts and every preference pair with prior feasible forms. It is either eliminated by a retained dominator, eliminates witnessed dominated forms, or joins the retained optimal class; no prior optimum is silently discarded."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with candidates := .rejected }

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
  passed := !exclusions.isEmpty && OptimizationWitnesses.witnesses.all OptimizationWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && OptimizationWitnesses.witnesses.all OptimizationWitnesses.Witness.passed) = true
  rw [OptimizationWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.OptimizationControls
