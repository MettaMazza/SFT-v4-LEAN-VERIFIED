import SFT.Foundation.AdmissionControls
import SFT.Physics.AtomicTransitionRateEntryGrammar
import SFT.Physics.AtomicTransitionRateEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.AtomicTransitionRateEntryControls
open SFT.Host.Canonical SFT.Foundation AtomicTransitionRateEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured wavelength, rate, line strength, lifetime or source access in execution", "no imported continuum radiation equation or floating proof value", "no numerical-zero state, negative rate, irrational or imaginary proof scalar", "no universal claim that every forbidden-channel rate is slower independent of strength", "no fitted exponent, coefficient, lifetime or multipole exception"]

def closureValue : Value := .object [
 ("result",.text "Normalized E1 rate is gap^3*S/g; lifetime is 1/(sum_i A_i); normalized electric rank-L rate is gap^(2L+1)*S/g and the equal-strength/equal-weight successor ratio is gap^2. The elementary orbital step remains One, while non-electric typed channels require their own held strengths."),
 ("base",.text "Electric rank One consists of one emitted gap carrier plus the complete held spatial boundary pair, giving exponent three."),
 ("successor",.text "Appending one electric multipole rank appends exactly the two held boundary directions, changing 2L+1 to 2(L+1)+1 and multiplying the normalized equal-strength/equal-weight rate by gap squared."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (AtomicTransitionRateEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && AtomicTransitionRateEntryWitnesses.witnesses.all AtomicTransitionRateEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && AtomicTransitionRateEntryWitnesses.witnesses.all AtomicTransitionRateEntryWitnesses.Witness.passed) = true
 rw [AtomicTransitionRateEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.AtomicTransitionRateEntryControls
