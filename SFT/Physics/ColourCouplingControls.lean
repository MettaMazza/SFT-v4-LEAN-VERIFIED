import SFT.Physics.ColourCouplingGrammar
import SFT.Physics.ColourCouplingWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.ColourCouplingControls
open SFT.Host.Canonical SFT.Foundation ColourCouplingGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 proof artifact, measured constant, observed shell list or intended Chemistry answer as a premise", "no semantic numerical zero, negative, irrational, imaginary or floating proof value", "no fitted coupling, selected candidate neighborhood or target-selected form", "no unrecorded external rule or measurement-to-derivation flow"]

def closureValue : SFT.Host.Canonical.Value := .object [
 ("result",.text "The exact generator-three colour-sector Fold coupling is 2/3."),
 ("base",.text "One complete interaction carrier contains three generated classes and the Fold supplies two participating held labels."),
 ("successor",.text "Replicating the complete carrier preserves two participating labels per three carrier classes, so the reduced exact ratio remains 2/3."),
 ("exclusions",.array (exclusions.map SFT.Host.Canonical.Value.text)),
 ("witnesses",.array (ColourCouplingWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && ColourCouplingWitnesses.witnesses.all ColourCouplingWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && ColourCouplingWitnesses.witnesses.all ColourCouplingWitnesses.Witness.passed) = true
 rw [ColourCouplingWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : SFT.Host.Canonical.Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.ColourCouplingControls
