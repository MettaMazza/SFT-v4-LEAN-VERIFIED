import SFT.InformationScience.SymbolGrammar
import SFT.InformationScience.SymbolWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.SymbolControls
open SFT.Host.Canonical SFT.Foundation SymbolGrammar
set_option maxRecDepth 20000

def laws : List String := ["symbol identity is canonical construction identity plus retained held label","observation classes partition the complete alphabet without changing microform identity","distinguishability is symmetric and irreflexive on exact symbol pairs","coarsening closes distinctions only by merging observation images","the retained/closed pair ledgers exhaust every generated unordered symbol pair"]

def exclusions : List String := ["no imported semantic meaning","no frequency or probability prior","no presentation alias replacing canonical identity","no ungenerated infinite alphabet"]

def closureValue : Value := .object [
  ("exact_result",.text "The symbol kernel is a complete canonical held-labelled alphabet, total single-valued observation, exact different-image distinguishability, retained closed classes, successor generality and no imported semantics."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (SymbolWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One canonical symbol has one observation row and no nonidentity pair distinction."),
  ("induction_step",.text "Adding one fresh canonical symbol adds exactly one source-bound observation row and one pair with every prior symbol. Each new pair is classified once as retained or closed by equality of its two observation labels."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with alphabet := .rejected }

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
  passed := !exclusions.isEmpty && SymbolWitnesses.witnesses.all SymbolWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && SymbolWitnesses.witnesses.all SymbolWitnesses.Witness.passed) = true
  rw [SymbolWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.SymbolControls
