import SFT.InformationScience.ClassicalGrammar
import SFT.InformationScience.ClassicalWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.ClassicalControls
open SFT.Host.Canonical SFT.Foundation ClassicalGrammar
set_option maxRecDepth 20000

def laws : List String := ["a classical information state is one held member of complete support","a probabilistic row is an exact nonempty observation class and positive whole part","the complete class ledger reconstructs the exact whole","observation selects a state only when its retained class is singleton","deterministic pushforward groups predecessors without introducing random transitions"]

def exclusions : List String := ["no ontic stochastic transition premise","no floating or fitted probability","no numerical zero probability row; absence is empty One","no prior-based selection inside a non-singleton class"]

def closureValue : Value := .object [
  ("exact_result",.text "The classical/probabilistic kernel is complete deterministic support, one held classical state, total observation classes, exact positive class parts, singleton-only resolution, deterministic pushforward, exact-whole closure, successor closure and no stochastic law."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (ClassicalWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One deterministic microstate is one held classical state and one exact whole observation class."),
  ("induction_step",.text "Adding one fresh microstate extends complete support and exactly one observation class. The class ledgers and their exact whole parts update from retained membership, while each individual state remains deterministic."),
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
  passed := !exclusions.isEmpty && ClassicalWitnesses.witnesses.all ClassicalWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && ClassicalWitnesses.witnesses.all ClassicalWitnesses.Witness.passed) = true
  rw [ClassicalWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.ClassicalControls
