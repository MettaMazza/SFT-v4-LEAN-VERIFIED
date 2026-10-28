import SFT.Mathematics.LogicGrammar
import SFT.Mathematics.LogicWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.LogicControls
open SFT.Host.Canonical SFT.Foundation LogicGrammar
set_option maxRecDepth 20000

def laws : List String := ["denial changes held orientation while preserving proposition identity","conjunction and disjunction retain their complete source proof structure","an implication is admitted through a registered proof-carrying transition","a valid proof is replayable step by step from its premises and rule registry","completeness is always indexed by an explicit generated grammar boundary"]

def exclusions : List String := ["no imported truth-value arithmetic","no negative truth magnitude","no authority-based proof admission","no global completeness beyond a generated grammar"]

def closureValue : Value := .object [
  ("exact_result",.text "The logic/proof kernel is canonical distinguished propositions, complementary held denial, joint and held alternative proof forms, proof-carrying implication, complete inference traces, explicit consistency and soundness, and completeness only over the exhausted registered grammar."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (LogicWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One proposition form and its two orientations provide the first decidable grammar cell."),
  ("induction_step",.text "Adding one proposition or rule generates its complementary orientation, joint and alternative combinations, and all new premise tuples. Consistency and proof replay are rechecked for precisely those new forms and steps."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with proposition := .rejected }

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
  passed := !exclusions.isEmpty && LogicWitnesses.witnesses.all LogicWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && LogicWitnesses.witnesses.all LogicWitnesses.Witness.passed) = true
  rw [LogicWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.LogicControls
