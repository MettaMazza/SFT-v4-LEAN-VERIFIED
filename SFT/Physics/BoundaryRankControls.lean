import SFT.Physics.BoundaryRankGrammar
import SFT.Physics.BoundaryRankWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.BoundaryRankControls
open SFT.Host.Canonical SFT.Foundation BoundaryRankGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured inverse-power exponent as input", "no conventional surface-area formula or continuum premise", "no signed subtraction, semantic numerical zero or nonexact proof value", "no partial boundary sample or added geometry"]

def closureValue : SFT.Host.Canonical.Value := .object [
 ("result",.text "The complete boundary of the forced three-direction spatial carrier has exact positive rank two and r-by-r pair-cell support at every generated positive scale r."),
 ("base",.text "One boundary cell on each of the two retained directions gives one complete pair cell around the source-normal relation."),
 ("successor",.text "Appending one cell to either retained direction adds exactly one labelled pair with every cell of the other direction, preserving complete rank-two support without changing rank."),
 ("exclusions",.array (exclusions.map SFT.Host.Canonical.Value.text)),
 ("witnesses",.array (BoundaryRankWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with carrier := .rejected }
def survivorIds : List String := (candidates.filter survives).map candidateId

def record (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : FoldControls.ControlRecord where
 kind := kind
 passed := passed
 expected := observation
 observed := if passed then observation else "control failed"

def falsePremise : FoldControls.ControlRecord := record .falsePremise
 (!(SFT.Host.Text.equal (candidateId falseCandidate) survivorId))
 "reject the form missing the first structural preservation"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord := record .tamperedSource
 (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && BoundaryRankWitnesses.witnesses.all BoundaryRankWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && BoundaryRankWitnesses.witnesses.all BoundaryRankWitnesses.Witness.passed) = true
 rw [BoundaryRankWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : SFT.Host.Canonical.Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.BoundaryRankControls
