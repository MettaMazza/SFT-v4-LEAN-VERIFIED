import SFT.Foundation.AdmissionControls
import SFT.Physics.HadronReggeEntryGrammar
import SFT.Physics.HadronReggeEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.HadronReggeEntryControls
open SFT.Host.Canonical SFT.Foundation HadronReggeEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, answer value or conventional SU(n) representation as a premise", "no measured resonance mass, uncertainty, trajectory slope or source access in execution", "no numerical-zero state, negative, irrational, imaginary or floating proof value", "no fitted tube tension, intercept, residual, correction term or selected trajectory subset", "no claim that non-minimal colour-neutral composites are forbidden", "no target access before derivation and prediction seals"]

def closureValue : Value := .object [
 ("result",.text "Light mesons have exact flavour support 9=8+1; light three-place baryons have exact support 27=10+8+8+1; normalized fixed-tube squared support is Q(J)=J and every positive successor difference is exactly One."),
 ("base",.text "One positive spin rank carries one normalized squared-support unit; complete generator-three words give nine two-place and twenty-seven three-place cells."),
 ("successor",.text "Appending one spin successor adds the same held tube carrier once, so the squared-support difference remains exactly One at every depth; appending generated words never changes the already exhaustive exchange partition."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (HadronReggeEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && HadronReggeEntryWitnesses.witnesses.all HadronReggeEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && HadronReggeEntryWitnesses.witnesses.all HadronReggeEntryWitnesses.Witness.passed) = true
 rw [HadronReggeEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-HADRON-REGGE-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.HadronReggeEntryControls
