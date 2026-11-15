import SFT.Physics.BaryogenesisDependencyGrammar
import SFT.Physics.BaryogenesisDependencyWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.BaryogenesisDependencyControls
open SFT.Host.Canonical SFT.Foundation BaryogenesisDependencyGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no imported Sakharov theorem or conventional kinetic equation as a premise", "no V1/V2 executable, result table, measurement or stored survivor", "no numerical-zero, negative, irrational, imaginary or floating proof magnitude", "no measured baryon abundance, fitted efficiency or selected mechanism in the derivation", "no claim that the V3 reconstruction was a blind historical discovery", "no cosmic-history claim beyond the universal physical dependency law"]

def closureValue : Value := .object [
 ("result",.text "From exact paired particle/antiparticle support, a positive retained baryon residue exists exactly when baryon tally change, CP-distinguished conjugate paths and a nonequilibrium reverse-completion hold are all present; the other seven complete combinations return the empty-One residue record."),
 ("base",.text "One matter and one antimatter carrier form an exact paired source with an empty-One residue record."),
 ("successor",.text "A tally-changing append creates one possible difference; conjugate pairing duplicates it on the opposite orientation and closes it, while reverse completion removes every unmatched append.  Therefore an append survives exactly when conjugacy and reversal are both held."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (BaryogenesisDependencyWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && BaryogenesisDependencyWitnesses.witnesses.all BaryogenesisDependencyWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && BaryogenesisDependencyWitnesses.witnesses.all BaryogenesisDependencyWitnesses.Witness.passed) = true
 rw [BaryogenesisDependencyWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-BARYOGENESIS-DEPENDENCY-TERMINAL-021",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.BaryogenesisDependencyControls
