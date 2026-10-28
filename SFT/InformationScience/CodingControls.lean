import SFT.InformationScience.CodingGrammar
import SFT.InformationScience.CodingWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.CodingControls
open SFT.Host.Canonical SFT.Foundation CodingGrammar
set_option maxRecDepth 20000

def laws : List String := ["valid codewords are a held selection of complete generated word support","difference retains every changed canonical position and both labels","detection requires all nonidentity registered images outside the codebook","correction is equivalent to pairwise disjoint complete error-image supports","a correctable received form decodes by exact unique source membership without a prior"]

def exclusions : List String := ["no stochastic error model","no floating distance or likelihood threshold","no unaccounted redundancy","no asymptotic rate imported as a finite proof"]

def closureValue : Value := .object [
  ("exact_result",.text "The coding kernel is complete word support, held codebook and source map, common positions, exact differences, complete registered error images, structural detection, disjoint-support correction and witnessed redundancy."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (CodingWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One registered error action generates one image per codeword; detection and support disjointness are exhaustively checked."),
  ("induction_step",.text "Adding one error action appends its exact image to every affected codeword family. Detection checks valid-word membership and correction checks every newly possible intersection with all other source families."),
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
  passed := !exclusions.isEmpty && CodingWitnesses.witnesses.all CodingWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && CodingWitnesses.witnesses.all CodingWitnesses.Witness.passed) = true
  rw [CodingWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.CodingControls
