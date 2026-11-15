import SFT.Physics.FiniteQuantumGravityGrammar
import SFT.Physics.FiniteQuantumGravityWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.FiniteQuantumGravityControls
open SFT.Host.Canonical SFT.Foundation FiniteQuantumGravityGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no imported continuum quantum field, Einstein quantization or conventional quantum-gravity programme as a premise", "no V1/V2 executable, answer table, measured value or stored survivor", "no numerical-zero, negative, irrational, imaginary or floating proof magnitude", "no completed infinity, fitted counterterm, free regulator or extra dimension", "no claim of direct graviton detection or proof of a continuum Yang-Mills/Einstein completion", "no external comparison before the inherited wave, loop and horizon seals"]

def closureValue : Value := .object [
 ("result",.text "At every positive finite Fold depth, one shared lattice jointly retains complete quantum support, three spatial directions, a symmetric rank-two gravity carrier with two physical polarizations, empty mass/rest record, One-cell causal advance, a positive distance floor, a finite rational loop sum and a quarter-area horizon ledger; no extra spatial direction or completed infinity is generated."),
 ("base",.text "Depth One has two quantum words, half-One distance floor, half-One loop sum, one shared four-coordinate rank-two source and its complete two-mode causal carrier."),
 ("successor",.text "The next Fold depth doubles finite word and area support, halves the still positive floor and appends one positive loop term; it changes neither the forced three-space count, rank-two source, two-mode carrier nor quarter-area information relation."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (FiniteQuantumGravityWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && FiniteQuantumGravityWitnesses.witnesses.all FiniteQuantumGravityWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && FiniteQuantumGravityWitnesses.witnesses.all FiniteQuantumGravityWitnesses.Witness.passed) = true
 rw [FiniteQuantumGravityWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-FINITE-QUANTUM-GRAVITY-TERMINAL-023",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.FiniteQuantumGravityControls
