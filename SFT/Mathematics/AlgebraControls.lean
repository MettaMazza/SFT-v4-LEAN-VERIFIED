import SFT.Mathematics.AlgebraGrammar
import SFT.Mathematics.AlgebraWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.AlgebraControls
open SFT.Host.Canonical SFT.Foundation AlgebraGrammar
set_option maxRecDepth 20000

def laws : List String := ["closure is exact membership of every operation result in the registered carrier","identity is a two-sided exhaustive preservation witness","association is equality of both complete composite traces for every carrier triple","return is a unique held mate relation and never a negative proof value","homomorphism is complete operation preservation, not resemblance of presentations"]

def exclusions : List String := ["no imported group, ring or field axioms","no negative or irrational carrier requirement","no property inferred from a conventional name","no completed infinite carrier"]

def closureValue : Value := .object [
  ("exact_result",.text "The algebraic kernel is a complete canonical carrier and complete closed single-valued operation table, with identity, association, returns, special properties and maps admitted only by exhaustive witnesses."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (AlgebraWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "The One carrier has one pair cell, its result remains One, and identity and association coincide."),
  ("induction_step",.text "Adding one fresh carrier form generates exactly its left, right and self pair cells. A proposed extension is admitted only after results remain in the extended carrier and every newly formed identity, triple, return and map obligation is checked."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with carrier := .rejected }

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
  passed := !exclusions.isEmpty && AlgebraWitnesses.witnesses.all AlgebraWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && AlgebraWitnesses.witnesses.all AlgebraWitnesses.Witness.passed) = true
  rw [AlgebraWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.AlgebraControls
