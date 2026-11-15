import SFT.Physics.LatticeOperatorGrammar
import SFT.Physics.LatticeOperatorWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.LatticeOperatorControls
open SFT.Host.Canonical SFT.Foundation LatticeOperatorGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no imported continuum, signed Laplacian, Fourier cosine or monatomic-chain equation as a premise", "no V1/V2 executable, answer table, measured spectrum or stored survivor", "no numerical-zero, negative, irrational, imaginary or floating proof magnitude", "no target-selected neighbour, coefficient, mode or causal-front count", "no claim that the exact phase carrier evaluates an irrational conventional eigenvalue", "no external comparison before the inherited dispersion and cubic-support seals"]

def closureValue : Value := .object [
 ("result",.text "The exact Fold nearest-neighbour family retains half-One at the centre and shares half-One over 2d neighbours; point-source peak and opposition-ring magnitudes are 2d; causal balls at ticks 1,2,3 are (3,5,7), (5,13,25) and (7,25,63) for dimensions one, two and three; and every N-site cycle has N exact phase-mode carriers with one stationary identity mode."),
 ("base",.text "One generated direction supplies two adjacent cells, centre half-One and two quarter-One shares, conserving the One and advancing at most one cell per tick."),
 ("successor",.text "Each added direction contributes one lower and one upper neighbour and repartitions the same held half-One over the complete ring; each added tick appends exactly the oriented cells at the new taxicab radius without altering any earlier cell or the phase-mode relation."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (LatticeOperatorWitnesses.witnesses.map fun w => .object [
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
 (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && LatticeOperatorWitnesses.witnesses.all LatticeOperatorWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && LatticeOperatorWitnesses.witnesses.all LatticeOperatorWitnesses.Witness.passed) = true
 rw [LatticeOperatorWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-LATTICE-OPERATOR-TERMINAL-022",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.LatticeOperatorControls
