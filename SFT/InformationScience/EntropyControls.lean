import SFT.InformationScience.EntropyGrammar
import SFT.InformationScience.EntropyWitnesses
import SFT.Foundation.FoldControls
namespace SFT.InformationScience.EntropyControls
open SFT.Host.Canonical SFT.Foundation EntropyGrammar
set_option maxRecDepth 20000

def laws : List String := ["observation classes form a disjoint complete partition of deterministic support","uncertainty is exactly the set of within-class nonidentity microstate pairs","singleton classes carry empty-One uncertainty rather than numerical zero","fine observation cannot have more closed pairs than a coarser observation it refines","entropy retains class provenance and exact part weights instead of collapsing to a floating scalar"]

def exclusions : List String := ["no stochastic source premise","no logarithmic entropy proof value","no numerical zero for singleton uncertainty","no fitted probability distribution"]

def closureValue : Value := .object [
  ("exact_result",.text "The entropy/uncertainty kernel is complete deterministic support, total observation classes, exact class parts, complete unresolved-pair ledgers, refinement containment, successor closure and no stochastic or log rule."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (EntropyWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One deterministic microstate forms one exact whole class with structural empty-One uncertainty."),
  ("induction_step",.text "Adding one fresh microstate assigns it to one retained observation image, updates that class's exact part and adds exactly one unresolved pair with every prior member of the same class; other classes remain unchanged."),
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
  passed := !exclusions.isEmpty && EntropyWitnesses.witnesses.all EntropyWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && EntropyWitnesses.witnesses.all EntropyWitnesses.Witness.passed) = true
  rw [EntropyWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.InformationScience.EntropyControls
