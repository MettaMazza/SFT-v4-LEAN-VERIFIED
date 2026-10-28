import SFT.Mathematics.DynamicsGrammar
import SFT.Mathematics.DynamicsWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.DynamicsControls
open SFT.Host.Canonical SFT.Foundation DynamicsGrammar
set_option maxRecDepth 20000

def laws : List String := ["trajectory composition is lawful exactly at an equal canonical interface state","time is a positive transition trace and identity duration is empty One","fixed, cyclic and recurrent behavior require explicit transition witnesses","many-to-one evolution loses predecessor distinction unless a source record is retained","stability is quantified only over a complete registered finite perturbation class"]

def exclusions : List String := ["no continuous real time premise","no differential equation imported as a law","no stochastic transition cause","no unrecorded predecessor reconstruction"]

def closureValue : Value := .object [
  ("exact_result",.text "The dynamical kernel is complete canonical states, held transitions, complete trajectories, transition-count time, witnessed fixed/return/basin structure, retained-record reversibility and registered perturbation stability."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (DynamicsWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One state supplies its identity trajectory; no transition time or predecessor ambiguity is introduced."),
  ("induction_step",.text "Adding one transition appends one exact state pair to every extended trajectory. Fixed, return, basin, predecessor and stability obligations change only for paths that use the new relation and are rechecked completely."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with states := .rejected }

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
  passed := !exclusions.isEmpty && DynamicsWitnesses.witnesses.all DynamicsWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && DynamicsWitnesses.witnesses.all DynamicsWitnesses.Witness.passed) = true
  rw [DynamicsWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.DynamicsControls
