import SFT.Physics.AlphaGrammar
import SFT.Physics.AlphaWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.AlphaControls
open SFT.Host.Canonical SFT.Foundation AlphaGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 proof artifact, measured constant, observed shell list or intended Chemistry answer as a premise", "no semantic numerical zero, negative, irrational, imaginary or floating proof value", "no fitted coupling, selected candidate neighborhood or target-selected form", "no unrecorded external rule or measurement-to-derivation flow"]

def closureValue : Value := .object [
 ("result",.text "The terminal inverse fine-structure Fold ratio is exactly 503846395469/3676744786; its leading rung is exactly 34259/250."),
 ("base",.text "The least binary covers of the generator volume and its successor volume establish down/up depths and the first complete cover."),
 ("successor",.text "Promote one remaining interchangeable spatial direction per rung; the positive remaining-direction count strictly decreases until all three are promoted, when no successor exists."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (AlphaWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with cover := .rejected }
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
 (!exclusions.isEmpty && AlphaWitnesses.witnesses.all AlphaWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && AlphaWitnesses.witnesses.all AlphaWitnesses.Witness.passed) = true
 rw [AlphaWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.AlphaControls
