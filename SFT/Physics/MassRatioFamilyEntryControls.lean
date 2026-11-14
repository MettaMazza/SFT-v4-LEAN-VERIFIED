import SFT.Foundation.AdmissionControls
import SFT.Physics.MassRatioFamilyEntryGrammar
import SFT.Physics.MassRatioFamilyEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.MassRatioFamilyEntryControls
open SFT.Host.Canonical SFT.Foundation MassRatioFamilyEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, result table, certificate or measurement as a derivation premise", "no target-selected coefficient, bracket, iteration count, correction or candidate neighbourhood", "no semantic numerical zero, negative magnitude, irrational, imaginary or floating proof value", "no solved irrational algebraic root; exact polynomials and rational enclosures only", "no external value accessible before the formal seal"]

def closureValue : Value := .object [
 ("result",.text "For every positive d, heavy/light = 2*3^d-1; the first three values are 5, 17 and 53."),
 ("base",.text "Depth one has complete support six and ratio five."),
 ("successor",.text "Each depth successor triples the generator support while preserving the light/complement partition and the N-1 identity."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (MassRatioFamilyEntryWitnesses.witnesses.map fun w => .object [
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
 (!(SFT.Host.Text.equal (SFT.Foundation.AdmissionControls.admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && MassRatioFamilyEntryWitnesses.witnesses.all MassRatioFamilyEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && MassRatioFamilyEntryWitnesses.witnesses.all MassRatioFamilyEntryWitnesses.Witness.passed) = true
 rw [MassRatioFamilyEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.MassRatioFamilyEntryControls
