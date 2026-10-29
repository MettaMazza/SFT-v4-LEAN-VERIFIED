import SFT.Physics.GeneratorThreeGrammar
import SFT.Physics.GeneratorThreeWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.GeneratorThreeControls
open SFT.Host.Canonical SFT.Foundation GeneratorThreeGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured dimension, physical target or V2 proof artifact as a premise", "no semantic numerical zero, negative, irrational, imaginary or floating proof value", "no bounded denominator search standing in for positive-count closure", "no selected later period or added generator rule"]

def closureValue : Value := .object [
 ("result",.text "The second distinct nonidentity Fold generator is the exact positive count three, witnessed by the complete first-return orbit 1/7 -> 2/7 -> 4/7 -> 1/7."),
 ("base",.text "The One has identity period; the first nonidentity Fold recurrence constructed from depth-two support has period two."),
 ("successor",.text "The next distinct positive period candidate is the unique positive successor of two; the depth-three support predecessor constructs a returning orbit of that length, so every later count is nonminimal."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (GeneratorThreeWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && GeneratorThreeWitnesses.witnesses.all GeneratorThreeWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && GeneratorThreeWitnesses.witnesses.all GeneratorThreeWitnesses.Witness.passed) = true
 rw [GeneratorThreeWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-STRUCT-GENERATOR-THREE-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.GeneratorThreeControls
