import SFT.Foundation.HalfOneGrammar
import SFT.Foundation.ExactOperationsControls
namespace SFT.Foundation.HalfOneControls
open SFT.Host.Canonical ExactOperations HalfOneDerivation
set_option maxRecDepth 20000

def closureRecord : List (String × String) := [
  ("forced_coordinate","The first Fold has exactly two equal fibres. Any one held fibre therefore has coordinate one-of-two; label exchange changes the held identity but not the exact part coordinate."),
  ("uniqueness","If an exact positive part x joins with itself to the One, its selected count must equal its unselected count in the two-fibre refinement; both are the singleton equivalence class."),
  ("complement","The other singleton fibre is the complement of the held singleton and has the same one-of-two coordinate, so half-One is self-complementary in exact part value."),
  ("fold","Self-junction of the singleton equivalence class completes both fibres; casting that complete turn is the One."),
  ("fixed_one","Self-junction of the One makes two complete Ones and cast removes one complete One, retaining the One."),
  ("terminology","Complement sends x to the remainder within the One. Phase antipode translates x by half-One and casts. They are separately named operations; at half-One the phase antipode is the One, while the complement has half-One value."),
  ("minimality","Whole selection is not a proper ground; any unequal or additional selection violates the minimal equal two-fibre Fold."),
  ("named_shape_uniqueness","Only selection-singleton-equivalence-class__self-junction-One__self-complement-equivalent__fold-image-One__One-fixed__phase-antipode-distinguished__no-extra preserves every first-Fold invariant."),
  ("generality","The equivalence argument uses the complete first-Fold partition, not a sampled rational search.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1,.text p.2))

def wholeCandidate : HalfOneGrammar.Candidate := { HalfOneGrammar.survivor with selection := .whole }

theorem wholeCandidateGenerated : wholeCandidate ∈ HalfOneGrammar.candidates :=
  HalfOneGrammar.candidatesComplete wholeCandidate

def selfJunctionIsOne (p : ExactPartCarrier.Part) : Bool :=
  decide ((selfJunction p).numerator = 1 ∧ (selfJunction p).denominator = 1)

theorem selfJunctionIsOneIff (p : ExactPartCarrier.Part) : selfJunctionIsOne p = true ↔ p = halfOne := by
  constructor
  · intro h
    exact (selfJunctionOneIff p).mp (of_decide_eq_true h)
  · intro h
    exact decide_eq_true ((selfJunctionOneIff p).mpr h)

def third : ExactPartCarrier.Part := normalizePart 1 3 (by decide) (by decide)

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := !(HalfOneGrammar.survives wholeCandidate)
  expected := "reject the One as the proper half-One ground"
  observed := "the whole-selection candidate does not survive"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject changed source identity"
  observed := "changed identity differs"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := selfJunctionIsOne halfOne && !(selfJunctionIsOne third)
  expected := "reject a changed half-One coordinate"
  observed := "only one-of-two self-junctions exactly to the One"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := (match complement halfOne with
    | .ok p => ExactOperationsControls.samePart p halfOne
    | .error _ => false) && ExactOperationsControls.samePart (foldPart halfOne) one
  expected := "keep complement and phase antipode distinct"
  observed := "half-One complements to half-One but its half-turn translation casts to the One"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem tamperedArtifactPassed : tamperedArtifact.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Foundation.HalfOneControls
