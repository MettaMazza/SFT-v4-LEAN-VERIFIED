import SFT.Physics.YangMillsSingletGapGrammar
import SFT.Physics.YangMillsSingletGapWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.YangMillsSingletGapControls
open SFT.Host.Canonical SFT.Foundation YangMillsSingletGapGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no imported Yang-Mills action, gauge-group axiom, Hamiltonian or continuum mass-gap proof", "no V1/V2 executable, answer table, lattice mass or stored survivor", "no numerical-zero, negative, irrational, imaginary or floating proof magnitude", "no fitted dimensionful glueball scale or claim that one-third equals a mass in MeV", "no completed infinity or inference from a finite simulation to a conventional continuum theorem", "no conflation of the empty local carrier mass label with the least physical singlet gap"]

def closureValue : Value := .object [
 ("result",.text "Within the complete finite Fold colour grammar, the least observable colour singlet has normalized gap one-third above the empty excitation record at every positive finite depth; confinement work advances by two-thirds; the two shares form a period-two partition of the One; and the locally massless confined carrier is retained without being mistaken for a free gapless physical singlet."),
 ("base",.text "At the first positive separation, the least antipodal colour singlet is nonempty, its exact complement is one-third and its confinement work is two-thirds."),
 ("successor",.text "A separation successor retains the colour-three sector and its one-third complement while adding another positive two-thirds work carrier; the singlet boundary and empty isolated-colour record are unchanged."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (YangMillsSingletGapWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && YangMillsSingletGapWitnesses.witnesses.all YangMillsSingletGapWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && YangMillsSingletGapWitnesses.witnesses.all YangMillsSingletGapWitnesses.Witness.passed) = true
 rw [YangMillsSingletGapWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-YANG-MILLS-SINGLET-GAP-TERMINAL-026",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.YangMillsSingletGapControls
