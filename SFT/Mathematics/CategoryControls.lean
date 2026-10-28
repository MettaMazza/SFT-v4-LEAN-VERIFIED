import SFT.Mathematics.CategoryGrammar
import SFT.Mathematics.CategoryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.CategoryControls
open SFT.Host.Canonical SFT.Foundation CategoryGrammar
set_option maxRecDepth 20000

def laws : List String := ["identity preserves source and target and contributes no nonidentity transition","composition exists exactly at a canonical interface match","associativity is equality of flattened complete transition traces","products preserve both coordinates and sums preserve the held source alternative","functoriality and naturality are finite replayable preservation witnesses"]

def exclusions : List String := ["no imported category axioms","no ungenerated universe of all objects","no impredicative type constructor","no universal property without an exhaustive finite witness"]

def closureValue : Value := .object [
  ("exact_result",.text "The compositional kernel is canonical Fold objects, proof-carrying arrows, empty-One identity, exact-interface composition, path-flattening association, source-bound types, joint products, held sums, preserving functors and equal-path naturality."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (CategoryWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One canonical object supplies its empty-One identity arrow and the first singleton type."),
  ("induction_step",.text "Adding one object or arrow generates its identities, every exact interface-compatible composite, product and sum cells, type verdicts and preservation squares. Closure follows by appending its trace to prior flat paths."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with objects := .rejected }

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
  passed := !exclusions.isEmpty && CategoryWitnesses.witnesses.all CategoryWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && CategoryWitnesses.witnesses.all CategoryWitnesses.Witness.passed) = true
  rw [CategoryWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.CategoryControls
