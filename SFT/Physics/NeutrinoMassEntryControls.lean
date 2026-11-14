import SFT.Foundation.AdmissionControls
import SFT.Physics.NeutrinoMassEntryGrammar
import SFT.Physics.NeutrinoMassEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.NeutrinoMassEntryControls
open SFT.Host.Canonical SFT.Foundation NeutrinoMassEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, result table, certificate or measurement as a derivation premise", "no target-selected coefficient, bracket, iteration count, correction or candidate neighbourhood", "no semantic numerical zero, negative magnitude, irrational, imaginary or floating proof value", "no solved irrational algebraic root; exact polynomials and rational enclosures only", "no external value accessible before the formal seal", "no claim that an SI/eV scale is produced without one declared post-seal dimensional anchor"]

def closureValue : Value := .object [
 ("result",.text "In solar-splitting units, mass squares are lightest 1/32, middle 33/32 and heavy 3203/96, forcing positive normal ordering; eV translation requires one post-seal solar anchor."),
 ("base",.text "The first positive cell of complete depth-five support is 1/32."),
 ("successor",.text "Adding the exact solar and atmospheric differences generates the two ordered successors."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (NeutrinoMassEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && NeutrinoMassEntryWitnesses.witnesses.all NeutrinoMassEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && NeutrinoMassEntryWitnesses.witnesses.all NeutrinoMassEntryWitnesses.Witness.passed) = true
 rw [NeutrinoMassEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NEUTRINO-POSITIVE-MASS-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.NeutrinoMassEntryControls
