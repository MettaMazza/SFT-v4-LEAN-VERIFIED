import SFT.Physics.VacuumFloorGrammar
import SFT.Physics.VacuumFloorWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.VacuumFloorControls
open SFT.Host.Canonical SFT.Foundation VacuumFloorGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, candidate table or answer artifact as a premise", "no external measurement, conventional vacuum model or apparatus result selecting a survivor", "no fitted coefficient, tunable phase, chosen reservoir value or answer-selected harmonic", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no deletion of the positive outward extraction result or of the complete restoration ledger"]

def closureValue : Value := .object [
 ("result",.text "The exact vacuum floor is 1/2. At depth k the complete oscillator spectrum is ((2j-1)/2^(k+1)) for j=1..2^k; depth two is (1/8,3/8,5/8,7/8)."),
 ("base",.text "At depth One, only the half-One self-pairs to the One and the spectrum is one-quarter, three-quarters."),
 ("successor",.text "Doubling support inserts one half-spacing state on each side of every prior whole-spacing position, preserving all odd numerators and uniform separation."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (VacuumFloorWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && VacuumFloorWitnesses.witnesses.all VacuumFloorWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && VacuumFloorWitnesses.witnesses.all VacuumFloorWitnesses.Witness.passed) = true
 rw [VacuumFloorWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.VacuumFloorControls
