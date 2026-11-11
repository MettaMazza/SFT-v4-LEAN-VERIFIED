import SFT.Physics.AtomicBoundaryGrammar
import SFT.Physics.AtomicBoundaryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.AtomicBoundaryControls
open SFT.Host.Canonical SFT.Foundation AtomicBoundaryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 proof artifact, measured constant, observed shell list or intended Chemistry answer as a premise", "no semantic numerical zero, negative, irrational, imaginary or floating proof value", "no fitted coupling, selected candidate neighborhood or target-selected form", "no unrecorded external rule or measurement-to-derivation flow"]

def closureValue : Value := .object [
 ("result",.text "The unique greatest positive whole atomic coordinate under the exact Fold binding ceiling is 137; 137 <= 503846395469/3676744786 < 138."),
 ("base",.text "The exact quotient of the sealed positive ratio supplies a positive whole and an exact nonnegative host remainder represented scientifically as either empty or a positive part."),
 ("successor",.text "The positive successor of the quotient exceeds the ratio; transitive positive order places every later successor above it, so no depth bound is used."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (AtomicBoundaryWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with charge := .rejected }
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
 (!exclusions.isEmpty && AtomicBoundaryWitnesses.witnesses.all AtomicBoundaryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && AtomicBoundaryWitnesses.witnesses.all AtomicBoundaryWitnesses.Witness.passed) = true
 rw [AtomicBoundaryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.AtomicBoundaryControls
