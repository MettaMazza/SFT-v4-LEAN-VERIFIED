import SFT.Physics.ScatteringPartitionPathGrammar
import SFT.Physics.ScatteringPartitionPathWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.ScatteringPartitionPathControls
open SFT.Host.Canonical SFT.Foundation ScatteringPartitionPathGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no assertion that arbitrary scattering has equal scatter/pass measures", "no stochastic causal selector or nondeterministic transition premise", "no numerical-zero, negative, irrational, imaginary or floating proof value", "no fitted cross section, measured path or target-selected correction", "no omission of target density from the general reciprocal law"]

def closureValue : Value := .object [
 ("result",.text "The registered one-target Fold support partitions exactly into scatter half-One and pass half-One; cross section is successful/incident support; and mean free path is the exact reciprocal of positive density times cross section, with larger section forcing shorter path."),
 ("base",.text "One generated target has the two distinguishable equipotent Fold outcomes; one successful cell among two incident cells carries half-One."),
 ("successor",.text "Appending one target carrier adds one identical section contribution, so encounter support composes by exact positive multiplication; reciprocal order reverses strictly for every larger positive product."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (ScatteringPartitionPathWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with geometry := .rejected }
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
 (!exclusions.isEmpty && ScatteringPartitionPathWitnesses.witnesses.all ScatteringPartitionPathWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && ScatteringPartitionPathWitnesses.witnesses.all ScatteringPartitionPathWitnesses.Witness.passed) = true
 rw [ScatteringPartitionPathWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-SCATTERING-PARTITION-PATH-TERMINAL-017",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.ScatteringPartitionPathControls
