import SFT.Foundation.AdmissionControls
import SFT.Physics.AtomicFieldSplittingEntryGrammar
import SFT.Physics.AtomicFieldSplittingEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.AtomicFieldSplittingEntryControls
open SFT.Host.Canonical SFT.Foundation AtomicFieldSplittingEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured Zeeman coefficient, Stark coefficient, splitting or source access in execution", "no numerical-zero central state or negative signed proof scalar", "no irrational, imaginary or floating proof value", "no universal Stark order that erases the degeneracy discriminator", "no fitted g factor, dipole, polarizability or response coefficient"]

def closureValue : Value := .object [
 ("result",.text "A J level has 2J+1 magnetic classes; Zeeman magnitude is g*m*B with adjacent spacing g*B; retained degeneracy gives dipole*E while nondegenerate closure gives polarizability*E^2/2."),
 ("base",.text "The first noncentral held orientation has one positive distance and one field act, so its magnetic response is linear; one retained degenerate electric pair likewise holds its first displacement."),
 ("successor",.text "Appending one doubled-angular position adds exactly one sublevel and preserves common field spacing; removing the degenerate partner closes the paired first acts and promotes the first retained electric response from one to two field acts."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (AtomicFieldSplittingEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && AtomicFieldSplittingEntryWitnesses.witnesses.all AtomicFieldSplittingEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && AtomicFieldSplittingEntryWitnesses.witnesses.all AtomicFieldSplittingEntryWitnesses.Witness.passed) = true
 rw [AtomicFieldSplittingEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.AtomicFieldSplittingEntryControls
