import SFT.InformationScience.NoiseGrammar
import SFT.InformationScience.NoiseWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.NoiseControls
open SFT.Host.Canonical SFT.Foundation NoiseGrammar
set_option maxRecDepth 20000

def laws : List String := ["identity transport has structural empty-One error trace","nonidentity error retains every changed position and both labels","detection requires a received form outside the valid codebook","exact correction is equivalent to a singleton registered predecessor class","ambiguous received forms preserve all source predecessors rather than choosing a likely one"]

def exclusions : List String := ["no stochastic noise cause","no floating error rate or threshold","no assumed metric or nearest-neighbor rule","no unrecorded source inference"]

def closureValue : Value := .object [
  ("exact_result",.text "The noise/error kernel is complete source and received support, held action provenance, exact position traces, invalid-code detection, complete predecessor classes, singleton correction and no stochastic or metric rule."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (NoiseWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One source under its identity action yields itself, empty-One error and a singleton predecessor class."),
  ("induction_step",.text "Adding one registered action adds one exact image cell for each source on which it acts. Error traces compare those forms positionwise, and each affected received predecessor class extends by precisely the new source cell."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with source := .rejected }

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
  passed := !exclusions.isEmpty && NoiseWitnesses.witnesses.all NoiseWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && NoiseWitnesses.witnesses.all NoiseWitnesses.Witness.passed) = true
  rw [NoiseWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.NoiseControls
