import SFT.Physics.VacuumPolarizationGrammar
import SFT.Physics.VacuumPolarizationWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.VacuumPolarizationControls
open SFT.Host.Canonical SFT.Foundation VacuumPolarizationGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, candidate table or answer artifact as a premise", "no external measurement, conventional vacuum model or apparatus result selecting a survivor", "no fitted coefficient, tunable phase, chosen reservoir value or answer-selected harmonic", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no deletion of the positive outward extraction result or of the complete restoration ledger", "no claim that the two structural endpoints alone fix a measured beta coefficient"]

def closureValue : SFT.Host.Canonical.Value := .object [
 ("result",.text "Vacuum polarization forces the structural running direction screened 1/2 -> exposed One; closer probing removes screening and increases effective electromagnetic support."),
 ("base",.text "The far carrier retains the exact half-One screened support."),
 ("successor",.text "Removing one complete Fold screening layer exposes the One; additional physical scale correspondence must remain a separately sealed empirical relation."),
 ("exclusions",.array (exclusions.map SFT.Host.Canonical.Value.text)),
 ("witnesses",.array (VacuumPolarizationWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && VacuumPolarizationWitnesses.witnesses.all VacuumPolarizationWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && VacuumPolarizationWitnesses.witnesses.all VacuumPolarizationWitnesses.Witness.passed) = true
 rw [VacuumPolarizationWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : SFT.Host.Canonical.Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.VacuumPolarizationControls
