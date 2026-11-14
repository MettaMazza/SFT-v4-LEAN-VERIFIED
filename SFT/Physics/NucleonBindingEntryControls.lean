import SFT.Foundation.AdmissionControls
import SFT.Physics.NucleonBindingEntryGrammar
import SFT.Physics.NucleonBindingEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.NucleonBindingEntryControls
open SFT.Host.Canonical SFT.Foundation NucleonBindingEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate, answer value or measured mass as a premise", "no semantic numerical zero, negative, irrational, imaginary or floating proof value", "no fitted binding percentage, constituent mass, electromagnetic correction or nucleon scale", "no claim that a scheme-dependent PDG current-quark mass ratio is identical to the structural 1/128 cell", "no target access before the derivation and prediction seals"]

def closureValue : Value := .object [
 ("result",.text "The proton word is uud and the neutron word is udd; the exact structural mass ledger is bare 1/128 and held-cycle 127/128, hence bare below 1/100 and held above 99/100; the exact down-minus-up enclosure exceeds the proton electromagnetic dressing and forces neutron mass above proton mass."),
 ("base",.text "The generator-three first-return orbit supplies one complete three-member colour singlet and depth One supplies one explicit cell with one held predecessor cell."),
 ("successor",.text "Every binary depth successor doubles complete support while retaining one explicit cell, so at forced depth seven the held predecessor is 127; replacing one up label by the already ordered down root preserves common binding and appends one strictly positive surplus."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (NucleonBindingEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && NucleonBindingEntryWitnesses.witnesses.all NucleonBindingEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && NucleonBindingEntryWitnesses.witnesses.all NucleonBindingEntryWitnesses.Witness.passed) = true
 rw [NucleonBindingEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.NucleonBindingEntryControls
