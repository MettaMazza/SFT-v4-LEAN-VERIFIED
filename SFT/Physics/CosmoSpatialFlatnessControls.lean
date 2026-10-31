import SFT.Physics.CosmoSpatialFlatnessGrammar
import SFT.Physics.CosmoSpatialFlatnessWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.CosmoSpatialFlatnessControls
open SFT.Host.Canonical SFT.Foundation CosmoSpatialFlatnessGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no measured Omega_K value or standard cosmological field equation in executable forcing", "no numerical zero, negative, irrational, imaginary or floating proof value", "no curvature remainder treated as a signed proof scalar", "no selected epoch, incomplete component list or extra closure rule", "no claim that Planck parameter inference is an SFT premise"]

def closureValue : Value := .object [
 ("result",.text "Every finite complete exact positive cosmic-component partition closes to the One; the curvature remainder is the empty One form, and every positive parent-preserving refinement retains that result."),
 ("base",.text "A finite complete positive component family is admitted only when its exact assembly is the One; its unassigned remainder is therefore structurally absent."),
 ("successor",.text "Replacing any one positive part by two positive parts whose exact assembly is the parent preserves the complete sum and hence preserves the empty remainder."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (CosmoSpatialFlatnessWitnesses.witnesses.map fun w => .object [
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
 (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && CosmoSpatialFlatnessWitnesses.witnesses.all CosmoSpatialFlatnessWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && CosmoSpatialFlatnessWitnesses.witnesses.all CosmoSpatialFlatnessWitnesses.Witness.passed) = true
 rw [CosmoSpatialFlatnessWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-COSMO-SPATIAL-FLATNESS-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.CosmoSpatialFlatnessControls
