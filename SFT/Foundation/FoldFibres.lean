import SFT.Foundation.FoldPhaseFull

/-! Exact exhaustion of the two source-generated Fold preimages. -/
namespace SFT.Foundation.FoldFibres
open ExactOperations ExactPartCarrier ExactValueIdentity FractionReduction
open FoldDynamics FoldCastLaws FoldPhaseLaws FoldPhaseFull ExactCast

theorem cancelAddedBound (a b k : Nat) (h : a+k ≤ b+k) : a ≤ b := by
  induction k with
  | zero => exact h
  | succ k ih => exact ih (Nat.le_of_succ_le_succ h)

theorem lowerNormalized (n d : Nat) (hn : 0 < n) (bound : n ≤ d) :
    lowerPreimage (normalizePart n d hn bound) =
      normalizePart n (d+d) hn (Nat.le_trans bound (Nat.le_add_right _ _)) := by
  let p := normalizePart n d hn bound
  let g := Nat.gcd n d
  have hd := Nat.lt_of_lt_of_le hn bound
  have nf : n = g*p.numerator := normalizedNumeratorFactor n d hn hd
  have df : d = g*p.denominator := normalizedDenominatorFactor n d hn hd
  have doubled : d+d = g*(p.denominator+p.denominator) :=
    ((congrArg (fun x => x+d) df).trans (congrArg (fun x => g*p.denominator+x) df)).trans
      (Nat.mul_add _ _ _).symm
  exact (normalizationByFactors _ _ _ _ g _ _ _ _ nf doubled).symm

theorem firstHalfRecovered (p : ExactPartCarrier.Part)
    (half : p.numerator+p.numerator ≤ p.denominator) :
    lowerPreimage (foldPart p) = p := by
  have f := castNormalizedAdmitted (p.numerator+p.numerator) p.denominator
    (Nat.add_pos_left p.positive _) (denominatorPositive p) half
  change foldPart p = _ at f
  rw [f,lowerNormalized]
  exact (normalizationByFactors _ _ p.numerator p.denominator 2 _ _ p.positive p.throughOne
    (twoTimes _).symm (twoTimes _).symm).trans (normalizationStable p)

theorem normalizedHalf (n d : Nat) (hn : 0 < n) (bound : n ≤ d)
    (half : n+n ≤ d) :
    (normalizePart n d hn bound).numerator+(normalizePart n d hn bound).numerator ≤
      (normalizePart n d hn bound).denominator := by
  let p := normalizePart n d hn bound
  let g := Nat.gcd n d
  have hd := Nat.lt_of_lt_of_le hn bound
  have nf : n = g*p.numerator := normalizedNumeratorFactor n d hn hd
  have df : d = g*p.denominator := normalizedDenominatorFactor n d hn hd
  have scaled : g*(p.numerator+p.numerator) ≤ g*p.denominator := by
    calc
      _ = n+n := (Nat.mul_add _ _ _).trans (congrArg (fun x => x+x) nf.symm)
      _ ≤ d := half
      _ = _ := df
  exact Nat.le_of_mul_le_mul_left scaled (gcdPositive n d hd)

theorem secondHalfPhaseOnFirst (p : ExactPartCarrier.Part)
    (half : p.denominator < p.numerator+p.numerator) :
    (phaseAntipode p).numerator+(phaseAntipode p).numerator ≤ (phaseAntipode p).denominator := by
  have hd := denominatorPositive p
  have beyond : shiftDenominator p < shiftNumerator p := Nat.add_lt_add_right half p.denominator
  have upper : shiftNumerator p ≤ shiftDenominator p+p.denominator :=
    Nat.add_le_add_right (Nat.add_le_add p.throughOne p.throughOne) p.denominator
  have rbound : shiftNumerator p-shiftDenominator p ≤ p.denominator := by
    apply cancelAddedBound _ _ (shiftDenominator p)
    calc
      (shiftNumerator p-shiftDenominator p)+shiftDenominator p = shiftNumerator p :=
        subtractAdd _ _ (Nat.le_of_lt beyond)
      _ ≤ shiftDenominator p+p.denominator := upper
      _ = p.denominator+shiftDenominator p := Nat.add_comm _ _
  have retained : castNumerator (shiftNumerator p) (shiftDenominator p) =
      shiftNumerator p-shiftDenominator p := by
    rw [castRemoves _ _ (shiftDenominatorPositive p) beyond,
      castRetains _ _ (shiftDenominatorPositive p) (Nat.le_trans rbound (Nat.le_add_right _ _))]
  rw [phaseCountFormula]
  apply normalizedHalf
  rw [retained]
  exact Nat.add_le_add rbound rbound

theorem preimageExhaustion (p image : ExactPartCarrier.Part) (h : foldPart p = image) :
    p = (preimages image).1 ∨ p = (preimages image).2 := by
  by_cases half : p.numerator+p.numerator ≤ p.denominator
  · exact Or.inl ((firstHalfRecovered p half).symm.trans (congrArg lowerPreimage h))
  · have recovered := firstHalfRecovered (phaseAntipode p)
      (secondHalfPhaseOnFirst p (Nat.lt_of_not_ge half))
    have collision : foldPart (phaseAntipode p) = image := (fullPhaseCollision p).trans h
    have lower : lowerPreimage image = phaseAntipode p :=
      (congrArg lowerPreimage collision).symm.trans recovered
    exact Or.inr ((fullPhaseInvolution p).symm.trans (congrArg phaseAntipode lower.symm))

theorem exactTwoPreimages (p image : ExactPartCarrier.Part) :
    foldPart p = image ↔ p = (preimages image).1 ∨ p = (preimages image).2 := by
  constructor
  · exact preimageExhaustion p image
  · intro h
    cases h with
    | inl h => exact (congrArg foldPart h).trans (firstGeneratedPreimageValid image)
    | inr h => exact (congrArg foldPart h).trans (upperFoldsToImage image)

end SFT.Foundation.FoldFibres
