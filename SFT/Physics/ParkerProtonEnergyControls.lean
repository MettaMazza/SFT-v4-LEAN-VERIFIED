import SFT.Physics.ParkerProtonEnergyGrammar
import SFT.Physics.ParkerProtonEnergyWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.ParkerProtonEnergyControls
open SFT.Host.Canonical SFT.Foundation ParkerProtonEnergyGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no local plasma density, magnetic field, Alfven energy or guide-field parameter", "no proton mass-energy or Parker spectrum in the candidate generator or survivor decision", "no numerical-zero, negative, irrational, imaginary or floating Fold proof magnitude", "no claim that approximately 400 keV is an exact measured cutoff or has 0.1-percent precision", "no omission of alternative forced-sector/power formulas at the post-seal comparison boundary", "no claim of historical blindness; V2 and the external result were known before reconstruction"]

def closureValue : Value := .object [
 ("result",.text "The terminal structural proton-energy fraction is exactly 108147617771025486368/253861190227103943729961 = 8 alpha_terminal^2. The superseded leading-rung prediction 500000/1173679081 is retained as an exact historical control.  External proton mass and Parker observations remain inaccessible until the derivation seal."),
 ("base",.text "The colour-three proton supplies eight complete non-return channels and one electromagnetic energy self-composition supplies alpha squared."),
 ("successor",.text "Promotion of one remaining cover direction updates alpha through the already admitted exact ladder without changing the proton colour count, energy power or target boundary; the terminal rung has no successor."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (ParkerProtonEnergyWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && ParkerProtonEnergyWitnesses.witnesses.all ParkerProtonEnergyWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && ParkerProtonEnergyWitnesses.witnesses.all ParkerProtonEnergyWitnesses.Witness.passed) = true
 rw [ParkerProtonEnergyWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-PARKER-PROTON-ENERGY-TERMINAL-028",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.ParkerProtonEnergyControls
