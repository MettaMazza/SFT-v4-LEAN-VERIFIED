import SFT.InformationScience.EncodingGrammar
import SFT.InformationScience.EncodingWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.EncodingControls
open SFT.Host.Canonical SFT.Foundation EncodingGrammar
set_option maxRecDepth 20000

def laws : List String := ["every source symbol has exactly one retained codeword image","lossless exact decoding exists if and only if used codeword classes are singleton","many-to-one encoding closes exactly the distinctions inside its retained source classes","decoder-after-lossless-encoder returns the original canonical source","encoding composition preserves source provenance when every intermediate codeword is mapped"]

def exclusions : List String := ["no imported binary numeral system","no presentation-only token identity","no silent many-to-one loss","no infinite codebook as a completed object"]

def closureValue : Value := .object [
  ("exact_result",.text "The encoding kernel is complete source and generated code support with a total single-valued provenance relation, singleton-class left-inverse decoding, explicit loss classes, exact composition and no borrowed code."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (EncodingWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One source symbol maps to one generated codeword and its singleton inverse decodes exactly."),
  ("induction_step",.text "Adding one fresh source adds exactly one encoding pair. A fresh codeword preserves singleton decoding; a used codeword extends its closed source class and changes the representation status to declared lossy."),
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
  passed := !exclusions.isEmpty && EncodingWitnesses.witnesses.all EncodingWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && EncodingWitnesses.witnesses.all EncodingWitnesses.Witness.passed) = true
  rw [EncodingWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.EncodingControls
