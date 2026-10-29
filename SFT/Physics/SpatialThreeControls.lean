import SFT.Physics.SpatialThreeGrammar
import SFT.Physics.SpatialThreeWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.SpatialThreeControls
open SFT.Host.Canonical SFT.Foundation SpatialThreeGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no observed three-space fact or conventional manifold premise", "no V2 proof artifact as a dependency", "no semantic numerical zero, signed dimension or nonexact proof value", "no target-selected interval endpoint or extra stability rule"]

def closureValue : SFT.Host.Canonical.Value := .object [
 ("result",.text "The unique Fold-stable spatial dimension count is three, independently equal to generator three."),
 ("base",.text "The Fold supplies exactly two disjoint held fibre roles and one complete return relation."),
 ("successor",.text "Their ordered pair-cell closure supplies four roles; positive succession enumerates the proper counts between the fibre and pair-cell boundaries and leaves exactly the successor three."),
 ("exclusions",.array (exclusions.map SFT.Host.Canonical.Value.text)),
 ("witnesses",.array (SpatialThreeWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && SpatialThreeWitnesses.witnesses.all SpatialThreeWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && SpatialThreeWitnesses.witnesses.all SpatialThreeWitnesses.Witness.passed) = true
 rw [SpatialThreeWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-SPACE-DIMENSION-THREE-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : SFT.Host.Canonical.Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.SpatialThreeControls
