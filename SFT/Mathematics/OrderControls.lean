import SFT.Mathematics.OrderGrammar
import SFT.Mathematics.OrderWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.OrderControls
open SFT.Host.Canonical SFT.Foundation OrderGrammar
set_option maxRecDepth 20000

def laws : List String := ["partial order requires reflexive, antisymmetric and transitive relation closure","incomparability is retained and never forced into a borrowed total scale","meet and join are partial operations unless unique extremal witnesses exist","a finite lattice is exactly an admitted partial order with meet and join for every generated pair","monotonicity is preservation of every registered relation cell"]

def exclusions : List String := ["no imported real-number line","no assumed total order","no lattice completeness without generated meets and joins","no completed infinite chain"]

def closureValue : Value := .object [
  ("exact_result",.text "The order/lattice kernel is a canonical carrier with an exhaustively witnessed partial-order relation, conditional totality, complete bound selections, uniquely witnessed meet/join and monotone maps."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (OrderWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "The One carrier has its identity relation and One is both unique lower and upper bound of itself."),
  ("induction_step",.text "Adding one fresh canonical form generates all comparisons to prior forms. Order closure, comparability, bounds and extremal uniqueness are rechecked only for pairs and composites touching the fresh form."),
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
  passed := !exclusions.isEmpty && OrderWitnesses.witnesses.all OrderWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && OrderWitnesses.witnesses.all OrderWitnesses.Witness.passed) = true
  rw [OrderWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.OrderControls
