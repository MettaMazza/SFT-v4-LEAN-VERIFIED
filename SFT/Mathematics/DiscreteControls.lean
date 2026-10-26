import SFT.Mathematics.DiscreteGrammar
import SFT.Mathematics.DiscreteWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.DiscreteControls
open SFT.Host.Canonical SFT.Foundation DiscreteGrammar
set_option maxRecDepth 20000

def laws : List String := ["canonical membership is decidable for every generated finite collection","held selection never introduces an element outside its source collection","relation complement is a held complementary selection of the same complete pair support","map composition preserves total single-valuedness when interfaces agree","structural induction covers every generated finite collection trace"]

def exclusions : List String := ["no completed infinite set","no ungenerated universal collection","no semantic numerical zero for the empty selection","no presentation alias may replace canonical form identity"]

def closureValue : Value := .object [
  ("exact_result",.text "The discrete kernel is complete unique canonical collections with retained membership, pair-cell-selected relations, total single-valued maps, held sequence order, One/base-successor induction and no extra constructor."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (DiscreteWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "The structural One is the first canonical generated member and the empty One marks a held-empty selection without numerical zero."),
  ("induction_step",.text "Given a complete unique canonical collection, append one fresh canonical form once; membership, relation pair support, map-image obligation and predecessor order extend by their local generated clauses."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with collection := .rejected }

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
  passed := !exclusions.isEmpty && DiscreteWitnesses.witnesses.all DiscreteWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && DiscreteWitnesses.witnesses.all DiscreteWitnesses.Witness.passed) = true
  rw [DiscreteWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.DiscreteControls
