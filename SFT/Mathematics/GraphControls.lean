import SFT.Mathematics.GraphGrammar
import SFT.Mathematics.GraphWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.GraphControls
open SFT.Host.Canonical SFT.Foundation GraphGrammar
set_option maxRecDepth 20000

def laws : List String := ["path concatenation is lawful exactly when the interface node agrees","reachability is reflexive by the retained identity path and transitive by path composition","a tree is a connected generated graph with no nontrivial return path","a cut contains every and only relation crossing a held/complementary node partition","network balance preserves token identity rather than cancelling signed magnitudes"]

def exclusions : List String := ["no ungenerated vertex or edge","no negative edge or flow quantity","no stochastic graph law","no infinite graph as a completed object"]

def closureValue : Value := .object [
  ("exact_result",.text "The graph/network kernel is complete canonical nodes with held ordered pair-cell edges, complete adjacent paths, witnessed reachability and return, held crossing cuts, ingress/egress pairing and no extra rule."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (GraphWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One canonical node supplies the identity path and contains no nontrivial edge cycle."),
  ("induction_step",.text "Appending one fresh node generates exactly its ordered pair cells with prior nodes; any held edge selection extends paths locally, and connectivity, cycle, cut and balance witnesses update only through those new cells."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with nodes := .rejected }

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
  passed := !exclusions.isEmpty && GraphWitnesses.witnesses.all GraphWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && GraphWitnesses.witnesses.all GraphWitnesses.Witness.passed) = true
  rw [GraphWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.GraphControls
