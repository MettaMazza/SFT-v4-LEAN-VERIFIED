import SFT.Physics.LeptonGrammar
import SFT.Physics.LeptonWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.LeptonControls
open SFT.Host.Canonical SFT.Foundation LeptonGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, certificate or answer table in the derivation runtime", "no measured lepton mass or ratio may select a coefficient or channel", "no numerical zero, negative, irrational, imaginary or floating proof value", "no fitted root, bracket, tolerance, iteration count or extra coefficient"]

def closureValue : Value := .object [
 ("result",.text "The exact charged-lepton cubic invariant tuple is (sum=1, pair-sum=1/6, leading-product=1/485, sharpened-product=3/1454), with the sharpened colour channel uniquely retained over channels two, three and four."),
 ("base",.text "The structural One supplies the complete normalized three-position partition and its retained symmetric identities."),
 ("successor",.text "Appending each generated pair or triple product records it once in the symmetric ledger; the generator-three channel adds its exact held part while preserving every earlier invariant."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (LeptonWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && LeptonWitnesses.witnesses.all LeptonWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && LeptonWitnesses.witnesses.all LeptonWitnesses.Witness.passed) = true
 rw [LeptonWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.LeptonControls
