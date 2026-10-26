import SFT.Foundation.ExactValueIdentity
import SFT.Foundation.HalfOneDerivation

/-! fold_dynamics.py: exact phase translation, generated preimages and the
first recurrent orbit. Arbitrary-image proofs use reduced Fraction identity. -/
namespace SFT.Foundation.FoldDynamics
open ExactOperations ExactPartCarrier ExactValueIdentity FractionReduction HalfOneDerivation

def sumParts (p q : ExactPartCarrier.Part) : PositiveFraction :=
  normalizePositive (p.numerator*q.denominator+q.numerator*p.denominator)
    (p.denominator*q.denominator)
    (Nat.add_pos_left (Nat.mul_pos p.positive (denominatorPositive q)) _)
    (Nat.mul_pos (denominatorPositive p) (denominatorPositive q))

def phaseAntipode (p : ExactPartCarrier.Part) : ExactPartCarrier.Part := castPositive (sumParts p halfOne)

def lowerPreimage (image : ExactPartCarrier.Part) : ExactPartCarrier.Part :=
  normalizePart image.numerator (image.denominator+image.denominator) image.positive
    (Nat.le_trans image.throughOne (Nat.le_add_right _ _))

def preimages (image : ExactPartCarrier.Part) : ExactPartCarrier.Part × ExactPartCarrier.Part :=
  let lower := lowerPreimage image
  (lower,phaseAntipode lower)

theorem lowerDenominatorIsTwice (d : Nat) : d+d = d*2 := by
  rw [Nat.mul_succ,Nat.mul_one]

theorem lowerJunctionValue (image : ExactPartCarrier.Part) :
    ((lowerPreimage image).numerator+(lowerPreimage image).numerator)*image.denominator =
      image.numerator*(lowerPreimage image).denominator := by
  have preserved := normalizedValuePreserved image.numerator
    (image.denominator+image.denominator) image.positive
    (Nat.add_pos_left (denominatorPositive image) _)
  change image.numerator*(lowerPreimage image).denominator =
    (lowerPreimage image).numerator*(image.denominator+image.denominator) at preserved
  have double : ((lowerPreimage image).numerator+(lowerPreimage image).numerator)*image.denominator =
      (lowerPreimage image).numerator*(image.denominator+image.denominator) := by
    rw [Nat.mul_comm _ image.denominator,Nat.mul_add,Nat.mul_comm image.denominator _,Nat.mul_add]
  exact double.trans preserved.symm

theorem lowerOnFirstHalf (image : ExactPartCarrier.Part) :
    (lowerPreimage image).numerator+(lowerPreimage image).numerator ≤ (lowerPreimage image).denominator := by
  have bound : image.denominator*((lowerPreimage image).numerator+(lowerPreimage image).numerator) ≤
      image.denominator*(lowerPreimage image).denominator := by
    calc
      _ = ((lowerPreimage image).numerator+(lowerPreimage image).numerator)*image.denominator := Nat.mul_comm _ _
      _ = image.numerator*(lowerPreimage image).denominator := lowerJunctionValue image
      _ ≤ _ := Nat.mul_le_mul_right _ image.throughOne
  exact Nat.le_of_mul_le_mul_left bound (denominatorPositive image)

theorem lowerFoldsToImage (image : ExactPartCarrier.Part) : foldPart (lowerPreimage image) = image :=
  (castNormalizedAdmitted _ _ _ _ (lowerOnFirstHalf image)).trans
    (normalizedRepresents _ _ _ (lowerOnFirstHalf image) image (lowerJunctionValue image))

theorem firstGeneratedPreimageValid (image : ExactPartCarrier.Part) : foldPart (preimages image).1 = image :=
  lowerFoldsToImage image

def third : ExactPartCarrier.Part := normalizePart 1 3 (by decide) (by decide)
def twoThirds : ExactPartCarrier.Part := normalizePart 2 3 (by decide) (by decide)

theorem thirdFoldsToTwoThirds : foldPart third = twoThirds := by
  apply partEquality <;> rfl

theorem twoThirdsFoldsToThird : foldPart twoThirds = third := by
  apply partEquality <;> rfl

theorem thirdAndTwoThirdsDistinct : third ≠ twoThirds := by
  intro h
  have hn := congrArg ExactPartCarrier.Part.numerator h
  change (1 : Nat) = 2 at hn
  exact (by decide : (1 : Nat) ≠ 2) hn

def iterate : Nat → ExactPartCarrier.Part → ExactPartCarrier.Part
  | 0,p => p
  | n+1,p => iterate n (foldPart p)

theorem firstTwoCycle : iterate 2 third = third := by
  change foldPart (foldPart third) = third
  rw [thirdFoldsToTwoThirds,twoThirdsFoldsToThird]

theorem noSmallerPositiveReturn (n : Nat) (positive : 0 < n) (below : n < 2) :
    iterate n third ≠ third := by
  have count : n = 1 := Nat.le_antisymm (Nat.le_of_lt_succ below) positive
  subst n
  change foldPart third ≠ third
  rw [thirdFoldsToTwoThirds]
  exact fun h => thirdAndTwoThirdsDistinct h.symm

end SFT.Foundation.FoldDynamics
