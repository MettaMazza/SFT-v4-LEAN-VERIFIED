import SFT.Physics.VacuumDensityGrammar
import SFT.Physics.VacuumDensityWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.VacuumDensityControls
open SFT.Host.Canonical SFT.Foundation VacuumDensityGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, stored exponent survivor, dark-energy measurement or conventional field equation in forcing", "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof scalar", "no fitted cosmological density, Hubble value, gravitational value or second vacuum scale", "no direct identification of the local One/2^20 cell floor with Omega_v, Lambda or a dimensionful density", "no reuse of the withdrawn measurement-influenced 2 alpha^4/H^3 proposal", "no claim that a continuum zero-point mode sum is an SFT derivational object"]

def closureValue : Value := .object [
 ("result",.text "The unique complete local vacuum boundary-energy floor is One/2^20=(One/2^10)^2. At every finite radiative depth k, the complete 2^k half-spacing modes sum to 2^(k-1) and have common-scale mean 1/2. The terminal cosmic vacuum fraction is separately 11/16. The normalized cosmological magnitude is Lambda(c/H)^2=33/16, and dimensional transport is Lambda=(33/16)H^2/c^2 after held external scale references are supplied. Equating the local floor, a raw mode total, the global fraction or a dimensional cosmological density is rejected as a type error."),
 ("base",.text "At the first binary support, both held labels are required and a complete energy record pairs its local amplitude twice; no empty numerical state is introduced."),
 ("successor",.text "Each additional cover depth appends both held labels once; energy self-composition doubles the accumulated label depth. Each radiative successor doubles the mode count and total while retaining mean 1/2. Exact rate/speed rescaling preserves the normalized cosmological ratio at every finite scale."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (VacuumDensityWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with volume := .rejected }
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
 (!exclusions.isEmpty && VacuumDensityWitnesses.witnesses.all VacuumDensityWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && VacuumDensityWitnesses.witnesses.all VacuumDensityWitnesses.Witness.passed) = true
 rw [VacuumDensityWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.VacuumDensityControls
