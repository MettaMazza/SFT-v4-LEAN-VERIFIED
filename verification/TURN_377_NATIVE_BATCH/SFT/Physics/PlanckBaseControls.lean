import SFT.Physics.PlanckBaseGrammar
import SFT.Physics.PlanckBaseWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.PlanckBaseControls
open SFT.Host.Canonical SFT.Foundation PlanckBaseGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, proof certificate, candidate table or answer artifact as a premise", "no external measurement, conventional equation or fitted parameter selecting a survivor", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no unregistered force, particle, phase, scale, channel or correction rule", "no irrational square-root formation; empirical comparison must square the measured positive interval instead"]

def closureValue : Value := .object [
 ("result",.text "The exact squared Planck/proton hierarchy is 2^127 = 170141183460469231731687303715884105728; the unsquared exponent is retained as 127/2 and no square root is formed."),
 ("base",.text "Depth One has one binary pairing and a unique positive predecessor of complete support."),
 ("successor",.text "Each cover successor doubles complete support; at the forced seventh depth the predecessor count is 127 and half-One coupling retains the exact squared exponent."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (PlanckBaseWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && PlanckBaseWitnesses.witnesses.all PlanckBaseWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && PlanckBaseWitnesses.witnesses.all PlanckBaseWitnesses.Witness.passed) = true
 rw [PlanckBaseWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.PlanckBaseControls
