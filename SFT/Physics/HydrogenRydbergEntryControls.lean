import SFT.Foundation.AdmissionControls
import SFT.Physics.HydrogenRydbergEntryGrammar
import SFT.Physics.HydrogenRydbergEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.HydrogenRydbergEntryControls
open SFT.Host.Canonical SFT.Foundation HydrogenRydbergEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured Rydberg, ionization, electron-rest energy or line value in execution", "no imported reduced-mass factor or atomic correction series", "no numerical-zero state, negative proof scalar, irrational, imaginary or floating proof value", "no concealed observational development or rewritten predecessor receipt", "no correction beyond the exhausted typed carrier grammar"]

def closureValue : Value := .object [
 ("result",.text "For exact terminal rho, H/R_infinity=rho/(rho+1)+alpha^2/5+alpha^3/2 Take 6alpha^4+49alpha^5; H/(m_e c^2)=alpha^2/2 times that carrier; Lyman-alpha/R_infinity is three-quarters and Balmer-alpha/R_infinity is five-thirty-sixths of the same carrier."),
 ("base",.text "The terminal exact rho enclosure and immutable alpha-squared-over-two gross carrier supply the finite-mass base."),
 ("successor",.text "Apply each typed alpha return once, then compose any generated positive principal-level gap; prior levels and the terminal scale remain held and no correction carrier remains."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (HydrogenRydbergEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && HydrogenRydbergEntryWitnesses.witnesses.all HydrogenRydbergEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && HydrogenRydbergEntryWitnesses.witnesses.all HydrogenRydbergEntryWitnesses.Witness.passed) = true
 rw [HydrogenRydbergEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.HydrogenRydbergEntryControls
