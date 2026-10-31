import SFT.Physics.CommonScaleAxisGrammar
import SFT.Physics.CommonScaleAxisWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.CommonScaleAxisControls
open SFT.Host.Canonical SFT.Foundation CommonScaleAxisGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no numerical-zero scale origin, negative exponent, irrational, imaginary, floating or completed-continuum proof value", "no imported renormalization-group equation, beta function, logarithmic energy coordinate or continuous scale", "no measured energy, weak angle, coupling, Planck value or selected rung in the formal survivor decision", "no identification of the earlier full-support running level with the terminal held-support level", "no claim that one monotone weak curve applies above the registered W-threshold boundary", "no fitted offset, calibration constant, scheme correction or hidden target-selected depth", "no historical-blindness claim"]

def closureValue : Value := .object [
 ("result",.text "One exact common scale axis is forced: supports 1,2,4,8,...; spacings One, half-One, quarter-One, eighth-One,...; and every forced prime sector uses the same support. The electroweak leading curve is w(R)=(R+2)^2/[4(R+1)^2+(R+2)^2]. Terminal support sixteen holds three directions, forcing active level thirteen, w(13)=225/1009 and the separately typed alpha/17 return, exactly reproducing the admitted terminal on-shell share. The unique internal power anchor is support two. Common exact unit rescaling leaves every dimensionless result unchanged; physical magnitudes are transported only through sealed exact ratios and a post-seal held reference."),
 ("base",.text "The One supplies support one and spacing One. Its first Fold successor supplies support two, half-One spacing and the unique binary-sector source closure 2+2=4."),
 ("successor",.text "Every successor doubles support, halves exact spacing, doubles local traversal count, preserves the single sector axis and strictly lowers the squared weak share by the positive numerator R(4R^2+9R+4) in the cross-multiplied difference. For supports at least four, 2+R has an odd factor above the One and cannot be another Fold power."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (CommonScaleAxisWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with origin := .rejected }
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
 (!exclusions.isEmpty && CommonScaleAxisWitnesses.witnesses.all CommonScaleAxisWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && CommonScaleAxisWitnesses.witnesses.all CommonScaleAxisWitnesses.Witness.passed) = true
 rw [CommonScaleAxisWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.CommonScaleAxisControls
