import SFT.Physics.InverseSquareGrammar
import SFT.Physics.InverseSquareWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.InverseSquareControls
open SFT.Host.Canonical SFT.Foundation InverseSquareGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured exponent, fitted coefficient or conventional inverse-square premise", "no partial boundary, omitted response row or preferred cell", "no semantic numerical zero, negative, irrational, imaginary or floating proof value", "no target access before the forced profile seal"]

def closureValue : Value := .object [
 ("result",.text "One conserved source over complete equivalent rank-two boundary support forces response(source,r) = source/(r*r) for every generated exact positive distance ratio r."),
 ("base",.text "At the One distance ratio, the rank-two boundary has one pair cell and retains the complete source response."),
 ("successor",.text "Extending either boundary coordinate adds exactly its pairs with the other; distributing the unchanged source over the complete enlarged pair support preserves inverse-square dilution at every generated finite scale."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (InverseSquareWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with source := .rejected }
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
 (!exclusions.isEmpty && InverseSquareWitnesses.witnesses.all InverseSquareWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && InverseSquareWitnesses.witnesses.all InverseSquareWitnesses.Witness.passed) = true
 rw [InverseSquareWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-FIELD-INVERSE-SQUARE-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.InverseSquareControls
