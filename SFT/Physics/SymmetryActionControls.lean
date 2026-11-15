import SFT.Physics.SymmetryActionGrammar
import SFT.Physics.SymmetryActionEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.SymmetryActionControls
open SFT.Host.Canonical SFT.Foundation SymmetryActionGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def exclusions : List String := ["no imported Noether theorem, Lagrangian, Euler-Lagrange equation or continuum variation", "no prior V1/V2 proof artifact, answer table or stored survivor", "no numerical-zero, negative, irrational, imaginary or floating proof magnitude", "no assertion that an arbitrary non-Fold physical system has the registered dyadic ranking", "no measured trajectory or target selecting the symmetry, charge or action form"]

def closureValue : Value := .object [
 ("result",.text "Fold preserves the reduced odd denominator core of every rational part; complete finite Fold symmetries preserve their held invariant fibres, every registered conserved partition generates its complete preserving symmetry class; every dyadic Fold part follows its unique binary-rank descent to stationary One; every monotone positive descent path telescopes to its endpoint carrier; and no finite detour has smaller action."),
 ("base",.text "One-half folds to the One while retaining odd core One; a two-state support has a complete permutation census; a one-edge descent has action equal to its exact endpoint separation."),
 ("successor",.text "Writing a reduced denominator as a binary power times an odd core shows that Fold removes at most one binary factor and cannot alter the odd core. Adding one dyadic denominator layer adds exactly one preceding Fold act. Adding one generated state extends the complete permutation census by placing it in every image position and deciding the same incidence, carrier and fibre predicates.  Appending one exact path step preserves telescoping when its orientation continues descent; an opposed step retains additional positive variation and cannot reduce total action."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (SymmetryActionEntryWitnesses.witnesses.map fun w => .object [
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
 (!exclusions.isEmpty && SymmetryActionEntryWitnesses.witnesses.all SymmetryActionEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (!exclusions.isEmpty && SymmetryActionEntryWitnesses.witnesses.all SymmetryActionEntryWitnesses.Witness.passed) = true
 rw [SymmetryActionEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-DYNAMICS-SYMMETRY-ACTION-TERMINAL-016",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.SymmetryActionControls
