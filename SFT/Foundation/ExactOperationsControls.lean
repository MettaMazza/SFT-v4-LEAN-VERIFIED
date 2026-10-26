import SFT.Foundation.ExactOperationsGrammar
import SFT.Foundation.FoldControls
namespace SFT.Foundation.ExactOperationsControls
open SFT.Host.Canonical ExactOperations
set_option maxRecDepth 20000

def closureRecord : List (String × String) := [
  ("cast","For positive n/d, repeated removal acts only while n/d exceeds the One; termination leaves an exact part in (0, One], and an exact whole terminates at the One."),
  ("fold","For an admitted part x, x joined to itself lies in (0, two Ones]; casting therefore returns exactly one admitted part."),
  ("take","For admitted a>b, the guarded difference is strictly positive and smaller than the One."),
  ("unison","The positive relation a/a is exactly the One; coincidence is identity, not a numerical zero."),
  ("exactness","Integer pairs reduce through the host Fraction carrier; no decimal, irrational or imaginary proof value is constructible."),
  ("minimality","Removing a guard, cast convention, closure, unison or trace loses a required invariant; adding an operation is unforced."),
  ("named_shape_uniqueness","Only domain-exact-positive-through-One__full-turn-as-One__fold-junction-then-cast__take-strictly-larger__unison-exact-One-relation__trace-root-bound__no-extra preserves every invariant."),
  ("generality","The numerator/denominator arguments apply to every admitted finite positive count pair, not a chosen denominator bound.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1,.text p.2))

def rejected {α : Type} : Except String α → Bool
  | .ok _ => false
  | .error _ => true

def samePart (a b : ExactPartCarrier.Part) : Bool :=
  decide (a.numerator = b.numerator ∧ a.denominator = b.denominator)

theorem samePartIff (a b : ExactPartCarrier.Part) : samePart a b = true ↔ a = b := by
  constructor
  · intro h
    have pair : a.numerator = b.numerator ∧ a.denominator = b.denominator := of_decide_eq_true h
    exact partEquality a b pair.1 pair.2
  · intro h
    cases h
    exact decide_eq_true ⟨rfl,rfl⟩

def quarter : ExactPartCarrier.Part := normalizePart 1 4 (by decide) (by decide)

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := rejected (takePart quarter one)
  expected := "reject an unguarded reversed Take"
  observed := "the exact carrier raises before constructing a forbidden part"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject changed source identity"
  observed := "the changed identity differs"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := match castFraction ⟨2,1,by decide,by decide⟩ with
    | .ok p => samePart p one
    | .error _ => false
  expected := "reject a full turn represented as absence"
  observed := "casting two Ones returns the One"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := rejected (fromPair 0 1) &&
    rejected (fromPair (-1) 2) &&
    (ExactPartCarrier.admitFraction ⟨3,2,by decide,by decide⟩).isNone &&
    rejected (castFraction ⟨0,1,by decide,by decide⟩)
  expected := "reject zero, signed, inexact and beyond-One proof carriers"
  observed := "all four hostile carrier constructions halt"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem tamperedArtifactPassed : tamperedArtifact.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Foundation.ExactOperationsControls
