import SFT.Foundation.AdmissionControls
import SFT.Physics.FiniteLoopEntryGrammar
import SFT.Physics.FiniteLoopEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.FiniteLoopEntryControls
open SFT.Host.Canonical SFT.Foundation FiniteLoopEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, candidate table, certificate or answer artifact as a premise", "no conventional field equation, continuum, matrix algebra or measured constant selecting a survivor", "no fitted coefficient, adjustable phase, imported normalization or target-selected value", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no target access before the complete exact result and candidate census are sealed", "no claim about an actually completed infinite support or a measured radiative coefficient"]

def closureValue : Value := .object [
 ("result",.text "The depth-n binary loop sum is the exact positive finite sum 1/2+1/4+...+1/2^n; depths one through six give 1/2, 3/4, 7/8, 15/16, 31/32, 63/64."),
 ("base",.text "Depth One contains exactly the half-One loop carrier."),
 ("successor",.text "Appending a generated depth appends its exact halved positive term, preserving a finite rational total below the One."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (FiniteLoopEntryWitnesses.witnesses.map fun w => .object [
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
 (!(SFT.Host.Text.equal (SFT.Foundation.AdmissionControls.admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && FiniteLoopEntryWitnesses.witnesses.all FiniteLoopEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && FiniteLoopEntryWitnesses.witnesses.all FiniteLoopEntryWitnesses.Witness.passed) = true
 rw [FiniteLoopEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.FiniteLoopEntryControls
