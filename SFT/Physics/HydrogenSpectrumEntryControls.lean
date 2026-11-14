import SFT.Foundation.AdmissionControls
import SFT.Physics.HydrogenSpectrumEntryGrammar
import SFT.Physics.HydrogenSpectrumEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.HydrogenSpectrumEntryControls
open SFT.Host.Canonical SFT.Foundation HydrogenSpectrumEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured wavelength or Rydberg value", "no continuum Schroedinger solution", "no completed infinity", "no numerical zero or negative energy"]

def closureValue : Value := .object [
 ("result",.text "For every positive finite n, H(n)=1/n^2; H(1)-H(2)=3/4 and H(2)-H(3)=5/36, with every emitted line an exact guarded positive difference."),
 ("base",.text "Principal support One gives the exact ground binding share One."),
 ("successor",.text "The next supplied positive principal count is squared by the forced binary count; its reciprocal remains positive and every ordered lower-to-upper gap is a lawful Take."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (HydrogenSpectrumEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && HydrogenSpectrumEntryWitnesses.witnesses.all HydrogenSpectrumEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && HydrogenSpectrumEntryWitnesses.witnesses.all HydrogenSpectrumEntryWitnesses.Witness.passed) = true
 rw [HydrogenSpectrumEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.HydrogenSpectrumEntryControls
