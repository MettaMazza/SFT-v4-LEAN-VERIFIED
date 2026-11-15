import SFT.Physics.AccumulatedSeparationGrammar
import SFT.Physics.AccumulatedSeparationWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.AccumulatedSeparationControls
open SFT.Host.Canonical SFT.Foundation AccumulatedSeparationGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, stored partial-sum table or prior survivor in execution", "no imported coupling equation, infinite-series formula, logarithm or continuum limit", "no numerical-zero, negative, irrational, imaginary or floating proof value", "no measured coupling, target value, fitted coefficient or selected stopping depth", "no completed infinity and no claim of an attained terminal sum"]

def closureValue : Value := .object [
 ("result",.text "Every positive finite partial sum of the binary/generator-three Fold coupling gaps lies in the exact bracket [1/12, 11/60); after the second level every successor gap is below half its predecessor, and every positive rational tolerance has a generated finite tail witness."),
 ("base",.text "At the One support the gap is 1/12.  At the binary successor support it is 1/20; both lie below the forced envelope 11/60."),
 ("successor",.text "For support R at least two, doubling R makes the next paired denominator strictly greater than twice the current paired denominator.  Appending the next gap therefore preserves the finite geometric envelope, and continued binary succession constructs a finite witness below every positive rational tolerance."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (AccumulatedSeparationWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with predecessor := .rejected }
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
 (!exclusions.isEmpty && AccumulatedSeparationWitnesses.witnesses.all AccumulatedSeparationWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && AccumulatedSeparationWitnesses.witnesses.all AccumulatedSeparationWitnesses.Witness.passed) = true
 rw [AccumulatedSeparationWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-COUPLING-ACCUMULATED-SEPARATION-TERMINAL-015",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.AccumulatedSeparationControls
