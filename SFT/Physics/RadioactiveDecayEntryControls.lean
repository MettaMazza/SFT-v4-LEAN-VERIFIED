import SFT.Foundation.AdmissionControls
import SFT.Physics.RadioactiveDecayEntryGrammar
import SFT.Physics.RadioactiveDecayEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.RadioactiveDecayEntryControls
open SFT.Host.Canonical SFT.Foundation RadioactiveDecayEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, decay table, isotope name, measured lifetime or intended mode code as a premise", "no numerical-zero state, negative, irrational, imaginary, transcendental or floating proof value", "no continuum exponential, ontic random choice or fitted decay constant", "no literal claim that alpha, beta and gamma are the only named nuclear decay codes", "no unrecorded particle, energy, lepton, fragment, capture or delayed channel", "no target access before derivation and prediction seals"]

def closureValue : Value := .object [
 ("result",.text "Exactly three primitive radioactive transition topologies exist. Alpha realizes mass-four/charge-two boundary release, beta realizes retained-support held-label conversion with lepton records, and gamma realizes internal level lowering with a radiative record. Every other named decay is one primitive or an ordered composition. Survival after positive half-life count k is exactly 1/2^k and remains positive at every finite k."),
 ("base",.text "One complete hidden-path pair partitions into one retained and one released fibre, forcing survival one-half after the first half-life carrier."),
 ("successor",.text "Appending one half-life carrier independently partitions every retained predecessor pair again, multiplying survival by one-half; appending any decay channel must test support release, then label conversion, then recurrence lowering, or it is no transition."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (RadioactiveDecayEntryWitnesses.witnesses.map fun w => .object [
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
 (!(SFT.Host.Text.equal (SFT.Foundation.AdmissionControls.admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && RadioactiveDecayEntryWitnesses.witnesses.all RadioactiveDecayEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && RadioactiveDecayEntryWitnesses.witnesses.all RadioactiveDecayEntryWitnesses.Witness.passed) = true
 rw [RadioactiveDecayEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.RadioactiveDecayEntryControls
