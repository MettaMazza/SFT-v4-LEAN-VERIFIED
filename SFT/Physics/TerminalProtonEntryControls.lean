import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalProtonEntryGrammar
import SFT.Physics.TerminalProtonEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.TerminalProtonEntryControls
open SFT.Host.Canonical SFT.Foundation TerminalProtonEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured proton/electron value or uncertainty in the executable relation", "no fitted coefficient, selected correction neighborhood or added scale", "no semantic numerical zero, negative, irrational, imaginary or floating proof value", "no conflation of observationally informed derivation with target-readable execution"]

def closureValue : Value := .object [
 ("result",.text "Let R3 be the admitted exact algebraic proton/electron ratio and alpha the reciprocal of the admitted terminal inverse-alpha.  The unique retained successor is R4 = R3 * [1 - delta] in conventional notation, represented only as positive_take(One,delta), where delta = (53/30) alpha^2 [1 + (2/135) alpha]."),
 ("base",.text "The admitted proton/electron graph supplies one complete normalized colour-bound carrier."),
 ("successor",.text "Attach alpha once to each charged Fold end, distribute their joint support over all colour-bulk and carried-boundary cells, then transport the sole terminal return through every down-depth/volume cell; every typed carrier is consumed once and no successor remains."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (TerminalProtonEntryWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with base := .rejected }
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
 (!exclusions.isEmpty && TerminalProtonEntryWitnesses.witnesses.all TerminalProtonEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && TerminalProtonEntryWitnesses.witnesses.all TerminalProtonEntryWitnesses.Witness.passed) = true
 rw [TerminalProtonEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.TerminalProtonEntryControls
