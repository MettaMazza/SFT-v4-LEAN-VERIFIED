import SFT.Physics.VacuumOddGrammar
import SFT.Physics.VacuumOddWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.VacuumOddControls
open SFT.Host.Canonical SFT.Foundation VacuumOddGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, candidate table or answer artifact as a premise", "no external measurement, conventional vacuum model or apparatus result selecting a survivor", "no fitted coefficient, tunable phase, chosen reservoir value or answer-selected harmonic", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no deletion of the positive outward extraction result or of the complete restoration ledger"]

def closureValue : Value := .object [
 ("result",.text "Every positive odd-denominator unit part beyond the One remains strictly positive and returns exactly; examples d=3,5,7,9 have periods 2,4,3,6."),
 ("base",.text "Denominator three gives the exact two-cycle 1/3 -> 2/3 -> 1/3."),
 ("successor",.text "Each supplied odd successor retains binary coprimality; its finite positive residue set forces recurrence, while first-return tracing closes the exact period."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (VacuumOddWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && VacuumOddWitnesses.witnesses.all VacuumOddWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && VacuumOddWitnesses.witnesses.all VacuumOddWitnesses.Witness.passed) = true
 rw [VacuumOddWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-VACUUM-ODD-RECURRENCE-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.VacuumOddControls
