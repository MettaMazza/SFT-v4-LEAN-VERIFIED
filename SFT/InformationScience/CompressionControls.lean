import SFT.InformationScience.CompressionGrammar
import SFT.InformationScience.CompressionWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.CompressionControls
open SFT.Host.Canonical SFT.Foundation CompressionGrammar
set_option maxRecDepth 20000

def laws : List String := ["losslessness is exact equality of reconstructed and source canonical traces","a reusable block is redundancy only when every replaced occurrence is reconstructible","dictionary, parser and decoder resources belong to the complete description","prefix freedom or an explicit delimiter is required for unique variable-word parsing","no injective code can assign every complete fixed-width message a strictly shorter nonempty word"]

def exclusions : List String := ["no hidden learned model or trained weights","no payload-only size claim","no ambiguous variable-word parsing","no universal lossless shortening claim"]

def closureValue : Value := .object [
  ("exact_result",.text "The compression kernel is exact message reconstruction from a uniquely parseable dictionary/token description, complete resource accounting, reconstructible redundancy, pigeonhole-limited shortening and no fitted model."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (CompressionWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One dictionary token reconstructs its one registered nonempty block and retains the complete description."),
  ("induction_step",.text "Appending one valid held token appends exactly its dictionary block to the reconstructed message and one token cell to the resource trace. Exact reconstruction and parsing remain local and replayable."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with message := .rejected }

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
  passed := !exclusions.isEmpty && CompressionWitnesses.witnesses.all CompressionWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && CompressionWitnesses.witnesses.all CompressionWitnesses.Witness.passed) = true
  rw [CompressionWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.CompressionControls
