import SFT.InformationScience.ChannelGrammar
import SFT.InformationScience.ChannelWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.ChannelControls
open SFT.Host.Canonical SFT.Foundation ChannelGrammar
set_option maxRecDepth 20000

def laws : List String := ["channel output support retains every possible output of one exact input","confusability is symmetric overlap of output supports","a zero-error input code has pairwise disjoint output supports","capacity retains every greatest distinguishable selection rather than applying an undeclared tie rule","composed output paths cannot restore an input distinction already merged at an intermediate interface"]

def exclusions : List String := ["no transition probability or stochastic channel cause","no floating error threshold","no logarithmic or asymptotic capacity proof value","no ungenerated infinite code family"]

def closureValue : Value := .object [
  ("exact_result",.text "The channel kernel is complete input/output carriers and held total transport, exact overlap confusability, exhaustive zero-error codes, the complete greatest code family, relational composition and no stochastic rule."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (ChannelWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One input with one nonempty output support forms a one-member distinguishable code family."),
  ("induction_step",.text "Adding one fresh input adds its exact output support and one confusability decision with every prior input. Every prior code either extends by the fresh input when all supports are disjoint or remains unchanged."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with inputs := .rejected }

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
  passed := !exclusions.isEmpty && ChannelWitnesses.witnesses.all ChannelWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && ChannelWitnesses.witnesses.all ChannelWitnesses.Witness.passed) = true
  rw [ChannelWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.ChannelControls
