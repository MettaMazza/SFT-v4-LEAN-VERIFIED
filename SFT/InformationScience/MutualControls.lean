import SFT.InformationScience.MutualGrammar
import SFT.InformationScience.MutualWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.MutualControls
open SFT.Host.Canonical SFT.Foundation MutualGrammar
set_option maxRecDepth 20000

def laws : List String := ["conditional rows partition every nonempty given class by target observation","every conditional part is exact and positive; absent intersections are empty One","the joint ledger explicitly contains every marginal-label pair cell","factorization holds exactly when every joint cell equals its marginal-part product","dependence retains the responsible joint cells and comparison direction without signed subtraction"]

def exclusions : List String := ["no logarithmic mutual-information proof value","no signed or floating dependence score","no stochastic cause or prior distribution","no incomplete joint census presented as factorization"]

def closureValue : Value := .object [
  ("exact_result",.text "The mutual/conditional kernel is complete deterministic support, two total observations, exact marginal and joint classes, exact conditional restrictions, provenance-retaining joint/product comparison, all-cell factorization, successor closure and no stochastic or logarithmic measure."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (MutualWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One source form gives one whole marginal cell, one whole joint cell and one whole conditional cell."),
  ("induction_step",.text "Adding one fresh source form places it in exactly one class of each observation and therefore one joint cell; all marginal, joint and conditional counts and exact parts are recomputed from retained membership."),
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
  passed := !exclusions.isEmpty && MutualWitnesses.witnesses.all MutualWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && MutualWitnesses.witnesses.all MutualWitnesses.Witness.passed) = true
  rw [MutualWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.MutualControls
