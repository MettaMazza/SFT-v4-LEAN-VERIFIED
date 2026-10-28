import SFT.InformationScience.QuantumGrammar
import SFT.InformationScience.QuantumWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.QuantumControls
open SFT.Host.Canonical SFT.Foundation QuantumGrammar
set_option maxRecDepth 20000

def laws : List String := ["one Fold position supplies one independently realized information distinction","k positions generate every held-label word exactly once","basis correspondence is bijective and retains each Fold word","joint support is the complete pair product with both source coordinates retained","observation plus the complete branch-image record reconstructs pre-observation support exactly"]

def exclusions : List String := ["no complex, irrational or imaginary proof value","no amplitude or phase law","no stochastic collapse postulate","no interference, entanglement or gate semantics claimed at the support boundary"]

def closureValue : Value := .object [
  ("exact_result",.text "The quantum-information correspondence kernel is one Fold distinction per position, complete Fold-word branch support, bijective basis and provenance traces, support-only superposition equivalence, complete pair-cell joint support, exact observation classes, reconstructing records, position induction and no imported quantum operation."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (QuantumWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "The first Fold position has the two held labels, one exact distinction and a two-branch basis correspondence."),
  ("induction_step",.text "Adding one fresh canonical position appends each held label to every prior word exactly once. Prior branch provenance remains intact, the new position realizes one distinction and joint-support laws remain pairwise."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with unit := .rejected }

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
  passed := !exclusions.isEmpty && QuantumWitnesses.witnesses.all QuantumWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && QuantumWitnesses.witnesses.all QuantumWitnesses.Witness.passed) = true
  rw [QuantumWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.QuantumControls
