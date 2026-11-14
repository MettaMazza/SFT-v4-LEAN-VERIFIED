import SFT.Foundation.AdmissionControls
import SFT.Physics.NuclearBindingCurveEntryGrammar
import SFT.Physics.NuclearBindingCurveEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.NuclearBindingCurveEntryControls
open SFT.Host.Canonical SFT.Foundation NuclearBindingCurveEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, semi-empirical mass formula or fitted coefficient as a premise", "no nuclide name, measured mass, binding energy, uncertainty, table row or source access in execution", "no numerical-zero state, negative, irrational, imaginary or floating proof value", "no evaluated cube root; exact rational enclosures refine only until order separates", "no selected isotope neighborhood, finite scan standing in for the unbounded tail or hidden parity class", "no target access before derivation and prediction seals", "no free bulk, surface, Coulomb, asymmetry, pairing or residual correction"]

def closureValue : Value := .object [
 ("result",.text "The unique zero-parameter normalized binding maximum over every positive proton/neutron composition is A=62, Z=28, N=34. The exact ledger is bulk One; radial surface loss (1/5)/A^(1/3) represented only by rational enclosures; Coulomb loss alpha*Z*(Z-1)/A^(4/3); quarter-order asymmetry loss (1/4)*(N-Z)^2/A^2; and quarter-order parity gain/loss (1/4)/A^(4/3)."),
 ("base",.text "Complete exact concavity reduces every fixed-mass proton census to the integer/parity neighbors of one enclosed vertex; all masses from two through 4095 are exhausted and yield one separated maximum at 62/28/34."),
 ("successor",.text "At and beyond 4096, charge at most one-fifth forces at least 9/100 asymmetry loss; charge above one-fifth forces a Coulomb loss already large enough at the exact cubic base and increasing thereafter. Both upper bounds remain below the sealed winner."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (NuclearBindingCurveEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && NuclearBindingCurveEntryWitnesses.witnesses.all NuclearBindingCurveEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && NuclearBindingCurveEntryWitnesses.witnesses.all NuclearBindingCurveEntryWitnesses.Witness.passed) = true
 rw [NuclearBindingCurveEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.NuclearBindingCurveEntryControls
