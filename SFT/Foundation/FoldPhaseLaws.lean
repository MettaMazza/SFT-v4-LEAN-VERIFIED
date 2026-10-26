import SFT.Foundation.FoldCastLaws

/-! fold_dynamics.py phase/preimage laws on the first half-circle. -/
namespace SFT.Foundation.FoldPhaseLaws
open ExactOperations ExactPartCarrier ExactValueIdentity FractionReduction
open FoldDynamics FoldCastLaws HalfOneDerivation ExactCast

def shiftNumerator (p : ExactPartCarrier.Part) : Nat := p.numerator+p.numerator+p.denominator

def shiftDenominator (p : ExactPartCarrier.Part) : Nat := p.denominator+p.denominator

theorem shiftPositive (p : ExactPartCarrier.Part) : 0 < shiftNumerator p :=
  Nat.add_pos_left (Nat.add_pos_left p.positive _) _

theorem shiftDenominatorPositive (p : ExactPartCarrier.Part) : 0 < shiftDenominator p :=
  Nat.add_pos_left (denominatorPositive p) _

theorem shiftWithinOne (p : ExactPartCarrier.Part) (half : p.numerator+p.numerator ≤ p.denominator) :
    shiftNumerator p ≤ shiftDenominator p := Nat.add_le_add_right half p.denominator

theorem phaseOnFirstHalf (p : ExactPartCarrier.Part) (half : p.numerator+p.numerator ≤ p.denominator) :
    phaseAntipode p = normalizePart (shiftNumerator p) (shiftDenominator p)
      (shiftPositive p) (shiftWithinOne p half) := by
  have nr : p.numerator*halfOne.denominator+halfOne.numerator*p.denominator = shiftNumerator p := by
    change p.numerator*2+1*p.denominator = p.numerator+p.numerator+p.denominator
    rw [Nat.mul_succ,Nat.mul_one,Nat.one_mul]
  have dr : p.denominator*halfOne.denominator = shiftDenominator p := by
    change p.denominator*2 = p.denominator+p.denominator
    rw [Nat.mul_succ,Nat.mul_one]
  exact (congrArg ExactOperations.castPositive
    (positiveNormalizationCongr _ _ _ _ _ _ (shiftPositive p) (shiftDenominatorPositive p) nr dr)).trans
      (castNormalizedAdmitted _ _ _ _ (shiftWithinOne p half))

theorem translatedDoubleCast (p : ExactPartCarrier.Part) :
    castNumerator (shiftNumerator p+shiftNumerator p) (shiftDenominator p) =
      2*castNumerator (p.numerator+p.numerator) p.denominator := by
  change castNumerator ((p.numerator+p.numerator+p.denominator)+(p.numerator+p.numerator+p.denominator))
    (p.denominator+p.denominator) = _
  rw [additionShuffle,castAddingOne ((p.numerator+p.numerator)+(p.numerator+p.numerator))
    (p.denominator+p.denominator)
    (Nat.add_pos_left (Nat.add_pos_left p.positive p.numerator) (p.numerator+p.numerator))
    (shiftDenominatorPositive p)]
  rw [← twoTimes (p.numerator+p.numerator),← twoTimes p.denominator]
  exact castScale 2 _ _ (by decide) (denominatorPositive p)

theorem firstHalfPhaseCollision (p : ExactPartCarrier.Part)
    (half : p.numerator+p.numerator ≤ p.denominator) : foldPart (phaseAntipode p) = foldPart p := by
  have cf := translatedDoubleCast p
  have df : shiftDenominator p = 2*p.denominator := (twoTimes _).symm
  have factor := normalizationByFactors
    (castNumerator (shiftNumerator p+shiftNumerator p) (shiftDenominator p))
    (shiftDenominator p) (castNumerator (p.numerator+p.numerator) p.denominator)
    p.denominator 2
    (ExactCast.castPositive _ _ (Nat.add_pos_left (shiftPositive p) _) (shiftDenominatorPositive p))
    (castWithinOne _ _ (shiftDenominatorPositive p))
    (ExactCast.castPositive _ _ (Nat.add_pos_left p.positive _) (denominatorPositive p))
    (castWithinOne _ _ (denominatorPositive p)) cf df
  exact (congrArg foldPart (phaseOnFirstHalf p half)).trans
    ((foldNormalized _ _ (shiftPositive p) (shiftWithinOne p half)).trans
      (factor.trans (foldCountFormula p).symm))

theorem upperFoldsToImage (image : ExactPartCarrier.Part) : foldPart (preimages image).2 = image :=
  (firstHalfPhaseCollision (lowerPreimage image) (lowerOnFirstHalf image)).trans (lowerFoldsToImage image)

theorem phaseBeyondHalf (p : ExactPartCarrier.Part)
    (half : p.numerator+p.numerator ≤ p.denominator) :
    (phaseAntipode p).denominator < (phaseAntipode p).numerator+(phaseAntipode p).numerator := by
  let q := normalizePart (shiftNumerator p) (shiftDenominator p) (shiftPositive p) (shiftWithinOne p half)
  let g := Nat.gcd (shiftNumerator p) (shiftDenominator p)
  have nf : shiftNumerator p = g*q.numerator :=
    normalizedNumeratorFactor _ _ (shiftPositive p) (shiftDenominatorPositive p)
  have df : shiftDenominator p = g*q.denominator :=
    normalizedDenominatorFactor _ _ (shiftPositive p) (shiftDenominatorPositive p)
  have larger : shiftDenominator p < shiftNumerator p+shiftNumerator p := by
    change p.denominator+p.denominator <
      (p.numerator+p.numerator+p.denominator)+(p.numerator+p.numerator+p.denominator)
    rw [additionShuffle]
    exact Nat.lt_add_of_pos_left
      (Nat.add_pos_left (Nat.add_pos_left p.positive p.numerator) (p.numerator+p.numerator))
  have separated : q.denominator < q.numerator+q.numerator := by
    apply Nat.lt_of_not_ge
    intro h
    have scaled := Nat.mul_le_mul_left g h
    rw [Nat.mul_add,← nf,← df] at scaled
    exact Nat.not_le_of_gt larger scaled
  rw [phaseOnFirstHalf p half]
  exact separated

theorem generatedPreimagesDistinct (image : ExactPartCarrier.Part) :
    (preimages image).1 ≠ (preimages image).2 := by
  intro same
  have first := lowerOnFirstHalf image
  change (preimages image).1.numerator+(preimages image).1.numerator ≤ (preimages image).1.denominator at first
  rw [same] at first
  exact Nat.not_le_of_gt (phaseBeyondHalf (lowerPreimage image) (lowerOnFirstHalf image)) first

theorem bothGeneratedPreimagesValid (image : ExactPartCarrier.Part) :
    foldPart (preimages image).1 = image ∧ foldPart (preimages image).2 = image :=
  ⟨firstGeneratedPreimageValid image,upperFoldsToImage image⟩

end SFT.Foundation.FoldPhaseLaws
