import SFT.Physics.HubbleGrammar
import SFT.Physics.HubbleWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.HubbleControls
open SFT.Host.Canonical SFT.Foundation HubbleGrammar
set_option maxRecDepth 100000

def exclusions : List String := ["no V1/V2 answer artifact or Hubble measurement in executable forcing", "no numerical zero, negative, irrational, imaginary or floating proof value", "no fitted density, selected tolerance, calibration scale, depth, sign or extra term", "no claim that either external measurement route is itself an SFT premise", "no claim that the observational reconstruction was an unobserved blind discovery"]

def closureValue : Value := .object [
 ("result",.text "The exact matter/vacuum shares are 1/3 and 2/3; the leading correction and late/early ratio are 1/12 and 13/12; the unique registered depth-seven recurrence refinement is 3305/3048."),
 ("base",.text "One formed class plus both Fold-fibre open classes exhaust the generator-three carrier, and complete depth-three support distributes its open share over eight words."),
 ("successor",.text "The independently fixed depth-seven unit part returns only after seven Folds; retaining exactly its first positive recurrence part inside the open share yields the sole first-recursive registered form."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (HubbleWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && HubbleWitnesses.witnesses.all HubbleWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && HubbleWitnesses.witnesses.all HubbleWitnesses.Witness.passed) = true
 rw [HubbleWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.HubbleControls
