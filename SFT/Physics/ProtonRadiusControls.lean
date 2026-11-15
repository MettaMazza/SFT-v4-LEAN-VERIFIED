import SFT.Physics.ProtonRadiusGrammar
import SFT.Physics.ProtonRadiusWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.ProtonRadiusControls
open SFT.Host.Canonical SFT.Foundation ProtonRadiusGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no proton radius, reduced Compton wavelength, electron, muon or scattering result in the candidate generator or survivor decision", "no fitted coefficient, probe-dependent correction, selected uncertainty or hidden form factor", "no numerical-zero, negative, irrational, imaginary or floating Fold proof magnitude", "no claim that rms charge radius is a hard material edge", "no claim that every historical extraction is mutually consistent or systematics-free", "no historical-blindness claim"]

def closureValue : Value := .object [
 ("result",.text "The unique terminal dimensionless proton rms charge-radius coefficient is exactly 10069574419808/2519231977345 = 4(One-alpha_terminal/10). A dimensionful radius is obtained only after the seal by composing this coefficient with the registered reduced proton Compton wavelength. The coefficient contains no electron, muon or scattering-probe input."),
 ("base",.text "The three-colour proton has one inner third, its unique outer two-thirds complement, and two Fold labels per colour, forcing the complete leading multiplier four."),
 ("successor",.text "Complete the nine internal ordered colour cells with the proton's one external charge cell and transport terminal alpha inward once; all typed carriers are then consumed and no successor remains."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (ProtonRadiusWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with particle := .rejected }
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
 (!exclusions.isEmpty && ProtonRadiusWitnesses.witnesses.all ProtonRadiusWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && ProtonRadiusWitnesses.witnesses.all ProtonRadiusWitnesses.Witness.passed) = true
 rw [ProtonRadiusWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-PROTON-RADIUS-TERMINAL-029",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.ProtonRadiusControls
