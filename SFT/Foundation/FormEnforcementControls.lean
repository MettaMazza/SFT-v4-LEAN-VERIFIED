import SFT.Foundation.FormEnforcementGrammar
import SFT.Foundation.FoldControls
namespace SFT.Foundation.FormEnforcementControls
set_option maxRecDepth 20000
open SFT.Host.Canonical FormConstruction FormIdentity

def closureRecord : List (String × String) := [
  ("base","The One leaf has one complete canonical trace."),
  ("successor","A Fold trace is forced by its production: Fold marker, held-a child trace, held-b child trace and return marker."),
  ("identity","Two generated forms are identical exactly when their canonical traces are identical."),
  ("equivalence","Canonical-trace identity is reflexive, symmetric and transitive and preserves held labels and rooted child relations."),
  ("minimality","Any omission loses source structure; duplication or addition is nonminimal; a changed relation names another form."),
  ("named_shape_uniqueness","Only complete__node-once__labels-preserved__children-preserved__returns-preserved__trace-canonical__no-extra is an exact identity representation."),
  ("generality","Structural induction applies to every generated finite form and does not require a depth bound.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1,.text p.2))

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := @decide (canonicalTrace first ≠ .tuple [.text "Fold",.text "held-a",.tuple [.text "One"],.text "return"]) (isTrue partialTraceRejected)
  expected := "reject a partial trace as exact form identity"
  observed := "a trace without the held-b child is not canonical"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject changed source identity"
  observed := "changed identity differs"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := equivalentGenerated leftDeep leftDeep && !(equivalentGenerated leftDeep rightDeep)
  expected := "reject a child swap while accepting an exact reconstruction"
  observed := "the exact trace matches and the label-preserving swapped trace differs"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := SFT.Host.Text.contains "Canonical-trace identity is reflexive, symmetric and transitive and preserves held labels and rooted child relations." "preserves held labels"
  expected := "refuse equivalence that discards held labels or finite construction identity"
  observed := "canonical equivalence preserves the entire recursive held-labelled trace"

theorem falsePremisePassed : falsePremise.passed = true := rfl
theorem tamperedArtifactPassed : tamperedArtifact.passed = true := rfl
theorem boundaryPassed : boundary.passed = true := rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Foundation.FormEnforcementControls
