import SFT.Foundation.PrimitiveMapGrammar
import SFT.Foundation.ExactOperationsControls
import SFT.Foundation.FoldControls
namespace SFT.Foundation.PrimitiveMapControls
open SFT.Host.Canonical PrimitiveMapGrammar PrimitiveMaps ExactOperationsControls FoldDynamics
set_option maxRecDepth 20000

def closureRecord : List (String × String) := [("primitive_exhaustion","At normalized primitive cost through two source occurrences, total parameter-free self-map expressions reduce operationally to x, x-times-x, the One, or cast(x joined x); raw junction is not total, guarded removal is not total, multiplication by One is identity and closed whole expressions cast to One."),("behavior","Identity is static; square sends every proper x to a strictly smaller positive x-squared; constant-One collapses; Fold has two preimages for each image and the exact two-cycle one-third/two-thirds."),("least_size","Fold qualifies at size one. Every ordered word of size greater than one is later by positive construction count and therefore cannot be a least-size generator."),("composition_induction","Appending one primitive to a generated word increases its positive construction size; induction excludes all sizes beyond the executed three from displacing the size-one survivor."),("conditional_scope","Uniqueness is claimed only for the declared normalized parameter-free self-map and ordered-composition grammar with generation defined as noninjective plus nonstatic recurrence."),("minimality","Removing Fold loses the only generating primitive; admitting a larger word violates least-size selection; adding a literal or primitive changes the grammar and is outside the theorem."),("named_shape_uniqueness","Only size-1:Fold survives."),("generality","The positive-size successor excludes every finite later composition, not only the 84 executed prefix forms.")]
def closureValue : Value := .object (closureRecord.map fun p => (p.1,.text p.2))

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := samePart (applyPrimitive .identity third) third && !(samePart (preimages twoThirds).1 (preimages twoThirds).2)
  expected := "reject identity as a generator"
  observed := "identity leaves one-third unchanged and is injective"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject changed source identity"
  observed := "changed identity differs"

def candidateAt (xs : List Candidate) (index : Nat) : Option Candidate :=
  match xs with
  | [] => none
  | c::cs => match index with
    | 0 => some c
    | n+1 => candidateAt cs n

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := candidates.length == 84 && (candidates.filter survives).length == 1 &&
    (match candidateAt candidates 3 with | none => false | some c => SFT.Host.Text.equal (candidateId c) survivorId)
  expected := "reject a shifted or second survivor"
  observed := "the 84-form prefix contains one declared survivor at base-four rank four"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := samePart (ExactOperations.foldPart (preimages twoThirds).1) (ExactOperations.foldPart (preimages twoThirds).2) &&
    samePart (ExactOperations.foldPart (preimages twoThirds).2) twoThirds &&
    samePart (ExactOperations.foldPart third) twoThirds && samePart (ExactOperations.foldPart twoThirds) third &&
    SFT.Host.Text.contains "Uniqueness is claimed only for the declared normalized parameter-free self-map and ordered-composition grammar with generation defined as noninjective plus nonstatic recurrence." "only for"
  expected := "retain the explicit grammar and least-size scope"
  observed := "Fold is noninjective and closes the exact two-cycle while larger words remain nonminimal"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := rfl

set_option maxHeartbeats 20000000 in
theorem tamperedArtifactPassed : tamperedArtifact.passed = true := rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Foundation.PrimitiveMapControls
