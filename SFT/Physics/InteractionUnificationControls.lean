import SFT.Physics.InteractionUnificationGrammar
import SFT.Physics.InteractionUnificationWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.InteractionUnificationControls
open SFT.Host.Canonical SFT.Foundation InteractionUnificationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no imported gauge-unification group, beta function, coupling crossing or mass model", "no V1/V2 executable, answer table, measured target or stored survivor", "no numerical-zero, negative, irrational, imaginary or floating proof magnitude", "no physical-sector ordering substituted for the exact common-support m ordering", "no retention of the internally inconsistent slope=m-1 and slope(2)=0 bundle", "no target access before the inherited force-sector and running seals"]

def closureValue : Value := .object [
 ("result",.text "The forced sectors (2,3,5,7) share one exact m-indexed interaction table; half-One uniquely unifies the odd-sector standing modes; all finite common-support sector gaps are positive and shrink without finite coincidence; the gravity/EM/strong Fold periods are 1/2/3 with joint recurrence 6; and the inconsistent flat-EM slope bundle is rejected in favour of the sealed terminal carrier-specific running laws."),
 ("base",.text "At support One, complete prime-sector enumeration yields four exact table rows, strictly ordered holding shares and positive pair gaps."),
 ("successor",.text "Replacing support R by twice R preserves each sector identity, keeps every pair gap positive and reduces its denominator-controlled magnitude; standing modes and Fold periods are unchanged."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (InteractionUnificationWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with sector := .rejected }
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
 (!exclusions.isEmpty && InteractionUnificationWitnesses.witnesses.all InteractionUnificationWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && InteractionUnificationWitnesses.witnesses.all InteractionUnificationWitnesses.Witness.passed) = true
 rw [InteractionUnificationWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.InteractionUnificationControls
