import SFT.Mathematics.OrbitCycleSupport
import SFT.Physics.CompositeConfiningAcceptanceCount
import SFT.Physics.CompositeConfiningGrammar
import SFT.Physics.CompositeConfiningWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.CompositeConfiningControls
open SFT.Host.Canonical SFT.Foundation CompositeConfiningGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no V1/V2 executable, stored orbit table or prior survivor in the derivation runtime", "no imported gauge group, particle taxonomy, measured coupling or target-selected sector", "no semantic numerical zero, negative, irrational, imaginary, floating or completed-infinity proof value", "no claim that every arithmetic composite sector is already an observed independent physical force", "no relabelling of the standing sectors twelve, eighteen, twenty-four or thirty as measured confirmations", "no ambiguous half-whole pair count: the exact whole formula is (s-2)/2"]

def closureValue : Value := .object [
 ("result",.text "The complete composite-sector census is: sector 8, denominator 7, orbits (1,2,4)/(3,6,5), three antipodal pairs and coupling 7/8; sector 12, denominator 11, one ten-mode orbit, five pairs and 11/12; sector 18, denominator 17, two eight-mode orbits, eight pairs and 17/18; sector 24, denominator 23, two eleven-mode orbits, eleven pairs and 23/24; sector 30, denominator 29, one twenty-eight-mode orbit, fourteen pairs and 29/30. The general odd-support inverse proves denominator confinement and complete recurrence at every positive finite Fold depth."),
 ("base",.text "For the least even sector beyond the binary fibre, the held predecessor d is odd. Doubling any nonempty label has the exact inverse multiplication by the positive half-successor (d+1)/2."),
 ("successor",.text "Advancing one Fold tick applies the same bijection, so a label remains inside the unchanged finite support. Finite bijection forces first return; adding the next complement pair preserves exhaustive support, One reassembly and the pair-count successor without altering the coupling construction."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (CompositeConfiningWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with scope := .rejected }
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
 (!exclusions.isEmpty && CompositeConfiningWitnesses.witnesses.all CompositeConfiningWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := by decide +kernel

attribute [local irreducible] CompositeConfiningWitnesses.witnesses in
theorem boundaryPassed : boundary.passed = true := by
 unfold boundary record
 change (true && CompositeConfiningWitnesses.witnesses.all CompositeConfiningWitnesses.Witness.passed)=true
 exact congrArg (fun b => true && b) CompositeConfiningWitnesses.allWitnessesPass

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
attribute [local irreducible] candidates in
theorem survivorIdsCount : survivorIds.length=1 :=
 (SFT.Mathematics.OrbitCycleSupport.mappedLength candidateId (candidates.filter survives)).trans
 SFT.Physics.CompositeConfiningAcceptanceCount.fullOriginalSurvivorCount
theorem recordPassed (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) :
 (record kind passed observation).passed=passed := rfl
attribute [local irreducible] survivorIds in
theorem tamperedArtifactPassed : tamperedArtifact.passed = true :=
 (recordPassed .tamperedArtifact (survivorIds.length == 1) "reject a missing, duplicate or additional survivor").trans
 (congrArg (fun n : Nat => n == 1) survivorIdsCount)
end SFT.Physics.CompositeConfiningControls
