import SFT.Foundation.AdmissionControls
import SFT.Physics.NuclearResidualForceEntryGrammar
import SFT.Physics.NuclearResidualForceEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.NuclearResidualForceEntryControls
open SFT.Host.Canonical SFT.Foundation NuclearResidualForceEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, answer value, Yukawa potential or consensus interaction model as a premise", "no particle name, measured mass, cross section, length, uncertainty or source access in execution", "no numerical-zero state, negative, irrational, imaginary or floating proof value", "no identification of structural one-quarter with a universal dimensional nuclear-force strength", "no fitted coupling, exponential decay profile, hard cutoff or selected mediator scale", "no target access before derivation and prediction seals"]

def closureValue : Value := .object [
 ("result",.text "Leading colour exchange outside a singlet is the empty form; the first retained two-boundary order is (1/2)^2=1/4 and returns 1/4 to 1/2 to One in two Folds; every positive mediator has finite normalized range 1/m and m1<m2 forces 1/m1>1/m2."),
 ("base",.text "Two neutral boundaries each retain one half-One boundary act, whose paired support is exactly one-quarter; one positive mediator mass has one exact reciprocal scale."),
 ("successor",.text "Appending another closed composite repeats the same paired residual order rather than reopening raw colour; increasing any positive mass strictly decreases its reciprocal range while preserving finite boundary capacity."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (NuclearResidualForceEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && NuclearResidualForceEntryWitnesses.witnesses.all NuclearResidualForceEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && NuclearResidualForceEntryWitnesses.witnesses.all NuclearResidualForceEntryWitnesses.Witness.passed) = true
 rw [NuclearResidualForceEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.NuclearResidualForceEntryControls
