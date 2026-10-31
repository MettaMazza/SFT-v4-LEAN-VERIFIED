import SFT.Physics.UnifiedConstantsGrammar
import SFT.Physics.UnifiedConstantsWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.UnifiedConstantsControls
open SFT.Host.Canonical SFT.Foundation UnifiedConstantsGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no renaming, replacement or reinterpretation of Grand Lock 075 or 076", "no V1/V2 proof artifact or measured constant as an executable premise", "no fitted parameter, selected coefficient, target tolerance or untyped numerical coincidence", "no numerical-zero, negative, irrational, imaginary, floating, NaN or completed-infinite proof scalar", "no omitted sector, severed root edge, blanket mutation or silently rewritten terminal value"]

def closureValue : Value := .object [
 ("result",.text "One connected rooted Fold object generates the registered cross-sector constants. Its common order is b=2, c=3, spatial rank 3, boundary rank 2, down/up cover depths 5 and 7, leading inverse alpha 34259/250, charged-lepton product 1/485, depth-five conjugate 1/95, depth-seven product 1/383, dark/baryon 27/5 with dark share 27/32, Hubble 13/12, Planck exponent 127/2, local vacuum-energy floor 1/2^20 and half-One 1/2. V3 terminal continuations retain the same object and include inverse alpha 503846395469/3676744786, charged-lepton sharpened product 3/1454 and terminal product, quark products 1/383 and 1/3071, dark/baryon 279/52, Hubble 3305/3048, the terminal squared Planck hierarchy, local vacuum amplitude/energy floors 1/2^10 and 1/2^20, and normalized cosmological magnitude 33/16."),
 ("base",.text "The One and Fold generate binary two, generator three, stable rank three, boundary rank two and their least covers before any physical target is opened."),
 ("successor",.text "Every lawful sector extension must consume an existing typed carrier or add a uniquely forced descendant, retain the complete incidence trace, and pass the same mutation and independence controls; otherwise it is not part of the object."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (UnifiedConstantsWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with root := .rejected }
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
 (!exclusions.isEmpty && UnifiedConstantsWitnesses.witnesses.all UnifiedConstantsWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 unfold boundary record
 rw [UnifiedConstantsWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-UNIFIED-CONSTANTS-OBJECT-077",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.UnifiedConstantsControls
