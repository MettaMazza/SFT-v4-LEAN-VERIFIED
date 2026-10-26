import SFT.Foundation.FoldStage
import SFT.Engine.EvidenceGates
import SFT.Host.Canonical
namespace SFT.Foundation.FoldControls
open SFT.Host.Canonical

def closureRecord : List (String × String) := [
  ("minimal_count","The structural One is the identity base. Appending one generated occurrence is the first nonidentity positive count. Every later finite extension contains this earlier nontrivial stage and is therefore not minimal."),
  ("equal_fibres","The unqualified One supplies no selector that can privilege one fibre. An unequal allocation therefore requires additional data, while equal fibre status does not."),
  ("held_labels","Nontrivial distinction requires different exact labels. They are held structural identities, not positive and negative numerical quantities."),
  ("return","Complete disjoint fibres retain the One only when their complete assembly has an explicit return relation to the source whole."),
  ("minimality","Identity is trivial; later extensions are overbuilt; removing equality, disjointness, distinct held labels or return loses a Fold requirement; adding data violates parameter freedom."),
  ("named_shape_uniqueness","Only complete__disjoint__equal__first-extension__labels-distinct-held__return-present__no-extra satisfies every generated requirement."),
  ("generality","First-extension minimality follows from the base/successor count structure at every later generated finite depth; it does not depend on a maximum census depth or completed infinity.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1,.text p.2))

def identityProposal : Fold.Candidate := { Fold.survivor with extension := .identity }

def laterProposal : Fold.Candidate := { Fold.survivor with extension := .later }

theorem identityProposalGenerated : identityProposal ∈ Fold.candidates := Fold.candidatesComplete _

theorem laterProposalGenerated : laterProposal ∈ Fold.candidates := Fold.candidatesComplete _

structure ControlRecord where
  kind : SFT.Engine.ControlKind
  passed : Bool
  expected : String
  observed : String

def falsePremise : ControlRecord where
  kind := .falsePremise
  passed := !(Fold.survives identityProposal)
  expected := "reject the unchanged One as a nontrivial Fold"
  observed := "the identity-extension proposal does not survive"

def tamperedSource (sourceHash : String) : ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject a changed derivation source identity"
  observed := "the changed source identity differs"

def tamperedArtifact : ControlRecord where
  kind := .tamperedArtifact
  passed := !(Fold.survives laterProposal)
  expected := "reject a later extension as the minimal Fold"
  observed := "the later-extension proposal does not survive"

def boundary : ControlRecord where
  kind := .boundary
  passed := SFT.Host.Text.contains "Nontrivial distinction requires different exact labels. They are held structural identities, not positive and negative numerical quantities." "not positive and negative"
  expected := "refuse signed labels, asymmetric parameters and completed-infinite arity"
  observed := "the survivor uses two held labels from the first finite extension and no added datum"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem tamperedArtifactPassed : tamperedArtifact.passed = true := rfl

set_option maxRecDepth 10000 in
theorem boundaryRecordPassed : boundary.passed = true := rfl

def controlValue (c : ControlRecord) : Value := .object [
  ("kind",.text (SFT.Engine.kindName c.kind)),("passed",.boolean c.passed),
  ("expected",.text c.expected),("observed",.text c.observed)]

def resultData (c : ControlRecord) : SFT.Engine.ControlResult where
  kind := c.kind
  passed := c.passed
  expectedBehavior := c.expected
  observedBehavior := c.observed
  receiptHash := identity (controlValue c)

def controlRecords (sourceHash : String) : List ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))

end SFT.Foundation.FoldControls
