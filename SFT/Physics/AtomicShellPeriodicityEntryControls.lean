import SFT.Foundation.AdmissionControls
import SFT.Physics.AtomicShellPeriodicityEntryGrammar
import SFT.Physics.AtomicShellPeriodicityEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.AtomicShellPeriodicityEntryControls
open SFT.Host.Canonical SFT.Foundation AtomicShellPeriodicityEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no imported periodic table, aufbau list, electron configuration or ionization value in execution", "no conflation of shell capacities 2,8,18,32 with actual period widths 2,8,8,18,18,32,32", "no claim of strict monotonic ionization inside a period", "no numerical-zero state, negative proof scalar, irrational, imaginary or floating proof value", "no hidden observational development, free exception or rewritten predecessor receipt"]

def closureValue : Value := .object [
 ("result",.text "For every positive n, sum from orbit rank One through n of 2(1+2(r-1)) equals 2n^2. The generated closures are 2,10,18,36,54,86,118 and their successive widths are 2,8,8,18,18,32,32; ionization comparison tests endpoint-above-start and endpoint-to-next-start reset while retaining internal dips."),
 ("base",.text "Shell One contains one orientation with both exclusion-distinct Fold labels, so its complete capacity and first closure are two."),
 ("successor",.text "Adding principal successor n+1 appends the next orbit capacity 4n+2 to 2n squared, yielding 2(n+1) squared; advancing the generated cover walk holds every earlier cell and opens exactly the next cell."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (AtomicShellPeriodicityEntryWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with predecessor := .rejected }
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
 (!(SFT.Host.Text.equal (SFT.Foundation.AdmissionControls.admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && AtomicShellPeriodicityEntryWitnesses.witnesses.all AtomicShellPeriodicityEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && AtomicShellPeriodicityEntryWitnesses.witnesses.all AtomicShellPeriodicityEntryWitnesses.Witness.passed) = true
 rw [AtomicShellPeriodicityEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.AtomicShellPeriodicityEntryControls
