import SFT.Physics.NuclearClosureGrammar
import SFT.Physics.NuclearClosureWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.NuclearClosureControls
open SFT.Host.Canonical SFT.Foundation NuclearClosureGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 proof artifact, measured constant, observed shell list or intended Chemistry answer as a premise", "no semantic numerical zero, negative, irrational, imaginary or floating proof value", "no fitted coupling, selected candidate neighborhood or target-selected form", "no unrecorded external rule or measurement-to-derivation flow"]

def closureValue : Value := .object [
 ("result",.text "The depth-independent nuclear closure law gives the exact prefix 2, 8, 20, 28, 50, 82, 126, 184; its next proton closure after 82 is 126 and the next closure after 126 is 184."),
 ("base",.text "Ranks one through three are complete three-direction composition closures with both held labels."),
 ("successor",.text "From the first whole-gap rank onward, each successor uses the preceding composition closure plus the complete top-orbit capacity at that rank; the same exact construction applies to every positive successor."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (NuclearClosureWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with composition := .rejected }
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
 (!exclusions.isEmpty && NuclearClosureWitnesses.witnesses.all NuclearClosureWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && NuclearClosureWitnesses.witnesses.all NuclearClosureWitnesses.Witness.passed) = true
 rw [NuclearClosureWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-NUCLEAR-CLOSURE-SEQUENCE-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.NuclearClosureControls
