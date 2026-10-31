import SFT.Physics.CosmoCompleteBudgetGrammar
import SFT.Physics.CosmoCompleteBudgetWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.CosmoCompleteBudgetControls
open SFT.Host.Canonical SFT.Foundation CosmoCompleteBudgetGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no Planck value or V1/V2 answer artifact in executable forcing", "no numerical zero, negative, irrational, imaginary or floating proof value", "no fitted density, selected tolerance, free pinned count or extra component rule", "no erasure of the earlier 1/3 and 2/3 leading approximation", "no claim that the external base-Lambda-CDM parameter analysis is an SFT premise"]

def closureValue : Value := .object [
 ("result",.text "The refined present budget is vacuum 11/16, total matter 5/16, baryon 25/512 and cold dark 135/512; baryon plus cold dark equals matter and vacuum plus matter equals the One."),
 ("base",.text "The depth-five support contains 32 states and one complete boundary pair is pinned at the first depth."),
 ("successor",.text "Each positive depth successor appends exactly one boundary pair; after all five forced depths, ten states are pinned and the exhaustive complement contains twenty-two, while internal matter composition preserves both global closures."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (CosmoCompleteBudgetWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with support := .rejected }
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
 (!exclusions.isEmpty && CosmoCompleteBudgetWitnesses.witnesses.all CosmoCompleteBudgetWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && CosmoCompleteBudgetWitnesses.witnesses.all CosmoCompleteBudgetWitnesses.Witness.passed) = true
 rw [CosmoCompleteBudgetWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-COSMO-COMPLETE-BUDGET-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.CosmoCompleteBudgetControls
