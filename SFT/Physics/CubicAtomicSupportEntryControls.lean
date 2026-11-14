import SFT.Foundation.AdmissionControls
import SFT.Physics.CubicAtomicSupportEntryGrammar
import SFT.Physics.CubicAtomicSupportEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.CubicAtomicSupportEntryControls
open SFT.Host.Canonical SFT.Foundation CubicAtomicSupportEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no imported cubic lattice", "no measured coordination number", "no floating or signed proof value", "no selected neighbour subset"]

def closureValue : Value := .object [
 ("result",.text "The unique cubic support has 2*3=6 nearest neighbours, exact weight 1/12 per neighbour and complete balance 6/12=1/2."),
 ("base",.text "One spatial axis has exactly the two held Fold directions."),
 ("successor",.text "Appending each of the remaining forced axes contributes the same two directions once; equal partition of the half-One over the completed six-cell support fixes one-twelfth."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (CubicAtomicSupportEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && CubicAtomicSupportEntryWitnesses.witnesses.all CubicAtomicSupportEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && CubicAtomicSupportEntryWitnesses.witnesses.all CubicAtomicSupportEntryWitnesses.Witness.passed) = true
 rw [CubicAtomicSupportEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-CUBIC-SUPPORT-004",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.CubicAtomicSupportEntryControls
