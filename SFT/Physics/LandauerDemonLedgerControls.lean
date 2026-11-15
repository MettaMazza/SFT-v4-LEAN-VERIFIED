import SFT.Physics.LandauerDemonLedgerGrammar
import SFT.Physics.LandauerDemonLedgerWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.LandauerDemonLedgerControls
open SFT.Host.Canonical SFT.Foundation LandauerDemonLedgerGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no conventional Landauer formula, logarithm or experimental target as a derivation premise", "no claim that native half-One is numerically identical to a dimensional energy ratio", "no numerical-zero, negative, irrational, imaginary or floating proof value", "no stochastic demon decision, free reset or omitted environment record", "no V1/V2 executable, answer table or stored survivor"]

def closureValue : Value := .object [
 ("result",.text "Resetting the complete quarter-One/three-quarter-One Fold fibre to half-One closes exactly one binary distinction with native throw half-One; reversal requires one predecessor label; and a closed Maxwell-demon cycle exports exactly that one label to its environment."),
 ("base",.text "One two-preimage reset closes one distinction, and one retained label restores the exact predecessor."),
 ("successor",.text "Appending one independent reset appends one two-label fibre, one closed distinction and one required environment reverse label; the complete ledger therefore extends without an unrecorded gain."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (LandauerDemonLedgerWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with support := .rejected }
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
 (!exclusions.isEmpty && LandauerDemonLedgerWitnesses.witnesses.all LandauerDemonLedgerWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && LandauerDemonLedgerWitnesses.witnesses.all LandauerDemonLedgerWitnesses.Witness.passed) = true
 rw [LandauerDemonLedgerWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-THERMO-LANDAUER-DEMON-TERMINAL-018",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.LandauerDemonLedgerControls
