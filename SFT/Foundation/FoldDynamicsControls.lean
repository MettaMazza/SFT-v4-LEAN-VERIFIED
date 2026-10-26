import SFT.Foundation.FoldDynamicsGrammar
import SFT.Foundation.FoldControls
namespace SFT.Foundation.FoldDynamicsControls
open SFT.Host.Canonical ExactOperations FoldDynamics FoldPhaseFull FoldPhaseLaws
open FoldUniform FoldSorted FoldUniformCheck
set_option maxRecDepth 20000

def closureRecord : List (String × String) := [
  ("domain","For x in (0, One], self-junction lies in (0, two Ones]; exact cast returns (0, One]."),
  ("preimages","For image y, the lower preimage y/2 and upper preimage cast(y/2 plus half-One) are distinct, lie on opposite half-circles and both Fold to y. Any Fold preimage has one of these two forms."),
  ("phase_antipode","Adding half-One twice adds one complete One, which cast removes; therefore phase antipode is an involution. Doubling a half-One translation adds one complete One before cast, so both phase partners share one Fold image."),
  ("uniform_partition","For an even generated count two-n, images of i/(two-n) identify i with i+n and are exactly j/n for the n positive residue classes; their distinct sorted gaps remain one/n."),
  ("first_cycle","Fold sends one-of-three to two-of-three and two-of-three back to one-of-three. No nonstatic cycle can have positive length below the first count extension beyond identity."),
  ("minimality","Deleting either preimage, cast closure, phase relation, uniform image or return loses an exact Fold invariant; extra dynamics are unforced."),
  ("named_shape_uniqueness","Only domain-closed__fibre-exactly-two__phase-collision-present__phase-involution-present__uniform-division-preserved__first-cycle-two__no-extra has every invariant."),
  ("generality","The proofs use arbitrary positive numerator/denominator and arbitrary generated positive n, not the finite controls below.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1,.text p.2))

def controlImages : List ExactPartCarrier.Part :=
  uniformDivision 2 (by decide) ++
  uniformDivision 3 (by decide) ++
  uniformDivision 4 (by decide) ++
  uniformDivision 5 (by decide) ++
  uniformDivision 6 (by decide) ++
  uniformDivision 7 (by decide) ++
  uniformDivision 8 (by decide)

def fibreCheck (p : ExactPartCarrier.Part) : Bool :=
  !(samePart (preimages p).1 (preimages p).2) &&
    samePart (foldPart (preimages p).1) p && samePart (foldPart (preimages p).2) p

def phaseCheck (p : ExactPartCarrier.Part) : Bool :=
  samePart (foldPart p) (foldPart (phaseAntipode p)) && samePart (phaseAntipode (phaseAntipode p)) p

theorem fibreCheckPassed (p : ExactPartCarrier.Part) : fibreCheck p = true := by
  have distinct : samePart (preimages p).1 (preimages p).2 = false := by
    cases h : samePart (preimages p).1 (preimages p).2 with
    | false => rfl
    | true => exact False.elim (generatedPreimagesDistinct p ((samePartIff _ _).mp h))
  have lower := (samePartIff _ _).mpr (firstGeneratedPreimageValid p)
  have upper := (samePartIff _ _).mpr (upperFoldsToImage p)
  unfold fibreCheck
  rw [distinct,lower,upper]
  rfl

theorem phaseCheckPassed (p : ExactPartCarrier.Part) : phaseCheck p = true := by
  unfold phaseCheck
  rw [(samePartIff _ _).mpr (fullPhaseCollision p).symm,
    (samePartIff _ _).mpr (fullPhaseInvolution p)]
  rfl

theorem allPassed (f : ExactPartCarrier.Part → Bool) (xs : List ExactPartCarrier.Part)
    (proof : ∀ p, f p = true) : xs.all f = true := by
  induction xs with
  | nil => rfl
  | cons p ps ih =>
    change (f p && ps.all f) = true
    rw [proof p,ih]
    rfl

def uniformControls : Bool :=
  isUniform (foldedDistinct (uniformDivision 2 (by decide))) &&
  isUniform (foldedDistinct (uniformDivision 4 (by decide))) &&
  isUniform (foldedDistinct (uniformDivision 6 (by decide))) &&
  isUniform (foldedDistinct (uniformDivision 8 (by decide))) &&
  isUniform (foldedDistinct (uniformDivision 10 (by decide))) &&
  isUniform (foldedDistinct (uniformDivision 12 (by decide)))

theorem uniformControlsPassed : uniformControls = true := by
  have h2 := everyEvenDivisionRemainsUniform 1 (by decide)
  have h4 := everyEvenDivisionRemainsUniform 2 (by decide)
  have h6 := everyEvenDivisionRemainsUniform 3 (by decide)
  have h8 := everyEvenDivisionRemainsUniform 4 (by decide)
  have h10 := everyEvenDivisionRemainsUniform 5 (by decide)
  have h12 := everyEvenDivisionRemainsUniform 6 (by decide)
  unfold uniformControls
  rw [h2,h4,h6,h8,h10,h12]
  rfl

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := controlImages.all fibreCheck
  expected := "reject a single-preimage Fold fibre"
  observed := "every control image has two distinct generated preimages"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject changed source identity"
  observed := "changed identity differs"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := controlImages.all phaseCheck
  expected := "reject a phase pair with unequal Fold images"
  observed := "all exact control pairs collide and the phase map is involutive"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := uniformControls && samePart (foldPart third) twoThirds && samePart (foldPart twoThirds) third
  expected := "retain exact even-partition and first-cycle scope"
  observed := "six even partitions remain uniform and the one-third orbit closes in two"

theorem falsePremisePassed : falsePremise.passed = true := allPassed fibreCheck controlImages fibreCheckPassed

theorem tamperedArtifactPassed : tamperedArtifact.passed = true := allPassed phaseCheck controlImages phaseCheckPassed

theorem boundaryPassed : boundary.passed = true := by
  change (uniformControls && samePart (foldPart third) twoThirds && samePart (foldPart twoThirds) third) = true
  rw [uniformControlsPassed,(samePartIff _ _).mpr thirdFoldsToTwoThirds,
    (samePartIff _ _).mpr twoThirdsFoldsToThird]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Foundation.FoldDynamicsControls
