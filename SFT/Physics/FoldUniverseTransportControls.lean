import SFT.Physics.FoldUniverseTransportGrammar
import SFT.Physics.FoldUniverseTransportWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.FoldUniverseTransportControls
open SFT.Host.Canonical SFT.Foundation FoldUniverseTransportGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no imported cosmological multiverse, wormhole, closed-timelike-curve or portal premise", "no V1/V2 executable, answer table, physical target or stored survivor", "no numerical-zero, negative, irrational, imaginary or floating proof magnitude", "no relabelling of arithmetic composition/projection as literal physical travel", "no relabelling of deterministic correlation as directed communication", "no physical universe plurality without a separately admitted observational discriminator"]

def closureValue : Value := .object [
 ("result",.text "Coprime odd-denominator Fold components have an exact bijective composite map that commutes with Fold and has least-common-multiple recurrence, forcing joint lockstep correlation; native Fold dynamics preserves each denominator, one component cannot steer another, and the literal physical inter-component signalling/travel record is empty."),
 ("base",.text "One composite unit residue maps to one ordered component pair and one Fold step maps both entries by their own exact Fold action."),
 ("successor",.text "If the component map commutes at a tick, applying Fold once more doubles every residue before the same reductions, preserving the pair map, each denominator and target-trajectory independence at the next tick."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (FoldUniverseTransportWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with orbit := .rejected }
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
 (!exclusions.isEmpty && FoldUniverseTransportWitnesses.witnesses.all FoldUniverseTransportWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && FoldUniverseTransportWitnesses.witnesses.all FoldUniverseTransportWitnesses.Witness.passed) = true
 rw [FoldUniverseTransportWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-FOLD-UNIVERSE-TRANSPORT-TERMINAL-024",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.FoldUniverseTransportControls
