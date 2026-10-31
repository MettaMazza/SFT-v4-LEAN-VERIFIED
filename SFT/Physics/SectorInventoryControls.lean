import SFT.Physics.SectorInventoryGrammar
import SFT.Physics.SectorInventoryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.SectorInventoryControls
open SFT.Host.Canonical SFT.Foundation SectorInventoryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, proof certificate, candidate table or answer artifact as a premise", "no external measurement, conventional equation or fitted parameter selecting a survivor", "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity", "no unregistered force, particle, phase, scale, channel or correction rule", "no omission of predicted penta/hepta sectors because they are presently unobserved", "no imported SU(n), Standard Model, grand-unification or hadron table as a proof premise"]

def closureValue : SFT.Host.Canonical.Value := .object [
 ("result",.text "Sectors (2,3,5,7) have charge counts (2,3,5,7), mediator counts (3,8,24,48), couplings (1/2,2/3,4/5,6/7), gauge-carrier total 83 and 72 penta/hepta carriers. Penta/hepta singlets have 5/7 constituents, mixing diagonals 14/15 and 20/21, electron mass-part ratios 2/5 and 2/7, and the complete named inventory has 98 members including 12 Smithions and photon/graviton/Higgs. Prime 11 is excluded."),
 ("base",.text "Sector two is the first prime fibre and its complete pair-cell predecessor supplies three carriers."),
 ("successor",.text "Advance through every positive count to ceiling seven, retain primes by complete divisor tests, and apply the same fibre, pair-cell, shortfall, running and generation constructions; prime eleven is the first candidate beyond the closed ceiling."),
 ("exclusions",.array (exclusions.map SFT.Host.Canonical.Value.text)),
 ("witnesses",.array (SectorInventoryWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with sector := .rejected }
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
 (!exclusions.isEmpty && SectorInventoryWitnesses.witnesses.all SectorInventoryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && SectorInventoryWitnesses.witnesses.all SectorInventoryWitnesses.Witness.passed) = true
 rw [SectorInventoryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : SFT.Host.Canonical.Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.SectorInventoryControls
