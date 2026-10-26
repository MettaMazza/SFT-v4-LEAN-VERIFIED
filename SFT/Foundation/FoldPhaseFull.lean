import SFT.Foundation.FoldPhaseLaws

/-! fold_dynamics.py full-domain phase laws. Affine casting respects each
original complete-One removal, including the second half-circle branch. -/
namespace SFT.Foundation.FoldPhaseFull
open ExactOperations ExactPartCarrier ExactValueIdentity FractionReduction
open FoldDynamics FoldCastLaws FoldPhaseLaws HalfOneDerivation ExactCast

theorem affineRemoval (k c : Nat) (hk : 0 < k) {n d r : Nat} (trace : Removal d n r)
    (hd : 0 < d) : castNumerator (k*r+c) (k*d) = castNumerator (k*n+c) (k*d) := by
  induction trace with
  | retain n h => rfl
  | step n r h prior ih =>
    have decomposition : n = (n-d)+d := (subtractAdd n d (Nat.le_of_lt h)).symm
    have shifted : k*n+c = (k*(n-d)+c)+k*d := by
      calc
        k*n+c = k*((n-d)+d)+c := congrArg (fun x => k*x+c) decomposition
        _ = (k*(n-d)+c)+k*d := by
          rw [Nat.mul_add,Nat.add_assoc,Nat.add_comm (k*d) c,← Nat.add_assoc]
    have removed : castNumerator (k*n+c) (k*d) = castNumerator (k*(n-d)+c) (k*d) := by
      rw [shifted,castAddingOne _ _
        (Nat.add_pos_left (Nat.mul_pos hk (subtractPositive n d h)) c) (Nat.mul_pos hk hd)]
    exact ih.trans removed.symm

theorem affineCastRetained (k c n d : Nat) (hk : 0 < k) (hd : 0 < d) :
    castNumerator (k*castNumerator n d+c) (k*d) = castNumerator (k*n+c) (k*d) :=
  affineRemoval k c hk (castHasRemovalTrace n d hd) hd

theorem phaseCountFormula (p : ExactPartCarrier.Part) :
    phaseAntipode p = normalizePart (castNumerator (shiftNumerator p) (shiftDenominator p)) (shiftDenominator p)
      (ExactCast.castPositive _ _ (shiftPositive p) (shiftDenominatorPositive p))
      (castWithinOne _ _ (shiftDenominatorPositive p)) := by
  have nr : p.numerator*halfOne.denominator+halfOne.numerator*p.denominator = shiftNumerator p := by
    change p.numerator*2+1*p.denominator = p.numerator+p.numerator+p.denominator
    rw [Nat.mul_succ,Nat.mul_one,Nat.one_mul]
  have dr : p.denominator*halfOne.denominator = shiftDenominator p := by
    change p.denominator*2 = p.denominator+p.denominator
    rw [Nat.mul_succ,Nat.mul_one]
  exact (congrArg ExactOperations.castPositive
    (positiveNormalizationCongr _ _ _ _ _ _ (shiftPositive p) (shiftDenominatorPositive p) nr dr)).trans
      (normalizedCast _ _ (shiftPositive p) (shiftDenominatorPositive p))

theorem phaseNormalized (n d : Nat) (hn : 0 < n) (bound : n ≤ d) :
    phaseAntipode (normalizePart n d hn bound) =
    normalizePart (castNumerator (n+n+d) (d+d)) (d+d)
      (ExactCast.castPositive _ _ (Nat.add_pos_left (Nat.add_pos_left hn n) d)
        (Nat.add_pos_left (Nat.lt_of_lt_of_le hn bound) d))
      (castWithinOne _ _ (Nat.add_pos_left (Nat.lt_of_lt_of_le hn bound) d)) := by
  let p := normalizePart n d hn bound
  let g := Nat.gcd n d
  have hd := Nat.lt_of_lt_of_le hn bound
  have nf : n = g*p.numerator := normalizedNumeratorFactor n d hn hd
  have df : d = g*p.denominator := normalizedDenominatorFactor n d hn hd
  have sum : n+n+d = g*shiftNumerator p := by
    calc
      n+n+d = g*p.numerator+g*p.numerator+g*p.denominator :=
        (congrArg (fun x => x+n+d) nf).trans
          ((congrArg (fun x => g*p.numerator+x+d) nf).trans
            (congrArg (fun x => g*p.numerator+g*p.numerator+x) df))
      _ = _ := by change _ = g*(p.numerator+p.numerator+p.denominator); rw [Nat.mul_add,Nat.mul_add]
  have den : d+d = g*shiftDenominator p :=
    ((congrArg (fun x => x+d) df).trans (congrArg (fun x => g*p.denominator+x) df)).trans
      (Nat.mul_add g p.denominator p.denominator).symm
  have cf : castNumerator (n+n+d) (d+d) = g*castNumerator (shiftNumerator p) (shiftDenominator p) := by
    calc
      _ = castNumerator (g*shiftNumerator p) (g*shiftDenominator p) :=
        (congrArg (fun x => castNumerator x (d+d)) sum).trans
          (congrArg (fun x => castNumerator (g*shiftNumerator p) x) den)
      _ = _ := castScale g _ _ (gcdPositive n d hd) (shiftDenominatorPositive p)
  exact (phaseCountFormula p).trans (normalizationByFactors _ _ _ _ g _ _ _ _ cf den).symm


theorem doubledRemoval {n d r : Nat} (trace : Removal d n r) (hd : 0 < d) :
    castNumerator (r+r) d = castNumerator (n+n) d := by
  induction trace with
  | retain n h => rfl
  | step n r h prior ih =>
    have positive := Nat.add_pos_left (subtractPositive n d h) (n-d)
    have decomposition : n = (n-d)+d := (subtractAdd n d (Nat.le_of_lt h)).symm
    have shifted : n+n = ((n-d)+(n-d)+d)+d := by
      calc
        n+n = ((n-d)+d)+((n-d)+d) := congrArg (fun x => x+x) decomposition
        _ = _ := (additionShuffle (n-d) d).trans (Nat.add_assoc _ d d).symm
    have removed : castNumerator (n+n) d = castNumerator ((n-d)+(n-d)) d := by
      rw [shifted,castAddingOne _ _ (Nat.add_pos_left positive d) hd,
        castAddingOne _ _ positive hd]
    exact ih.trans removed.symm

theorem fullPhaseCollision (p : ExactPartCarrier.Part) :
    foldPart (phaseAntipode p) = foldPart p := by
  rw [phaseCountFormula,foldNormalized,foldCountFormula]
  apply normalizationByFactors _ _ _ _ 2
  · exact (doubledRemoval (castHasRemovalTrace (shiftNumerator p) (shiftDenominator p)
      (shiftDenominatorPositive p)) (shiftDenominatorPositive p)).trans (translatedDoubleCast p)
  · exact (twoTimes p.denominator).symm

theorem fullPhaseInvolution (p : ExactPartCarrier.Part) :
    phaseAntipode (phaseAntipode p) = p := by
  let n := shiftNumerator p
  let d := shiftDenominator p
  have hd : 0 < d := shiftDenominatorPositive p
  have retain : castNumerator (n+n+d) (d+d) = 4*p.numerator := by
    have nr : n+n+d = 4*p.numerator+4*p.denominator := by
      change ((p.numerator+p.numerator)+p.denominator)+
        ((p.numerator+p.numerator)+p.denominator)+(p.denominator+p.denominator) = _
      rw [additionShuffle]
      have four (x : Nat) : 4*x = (x+x)+(x+x) := by
        rw [Nat.mul_comm,Nat.mul_succ,Nat.mul_succ,Nat.mul_succ,Nat.mul_one]
        exact Nat.add_assoc _ _ _
      rw [four,four,Nat.add_assoc]
    have dr : d+d = 4*p.denominator := by
      change (p.denominator+p.denominator)+(p.denominator+p.denominator) = _
      rw [Nat.mul_comm,Nat.mul_succ,Nat.mul_succ,Nat.mul_succ,Nat.mul_one]
      exact (Nat.add_assoc _ _ _).symm
    rw [nr,dr,castAddingOne _ _ (Nat.mul_pos (by decide) p.positive)
      (Nat.mul_pos (by decide) (denominatorPositive p)),
      castRetains _ _ (Nat.mul_pos (by decide) (denominatorPositive p))
        (Nat.mul_le_mul_left 4 p.throughOne)]
  have raw : castNumerator (castNumerator n d+castNumerator n d+d) (d+d) = 4*p.numerator := by
    have h := affineCastRetained 2 d n d (by decide) hd
    rw [twoTimes,twoTimes,twoTimes] at h
    exact h.trans retain
  rw [phaseCountFormula p,phaseNormalized]
  exact (normalizationByFactors _ _ p.numerator p.denominator 4 _ _ p.positive p.throughOne raw
    (by change (p.denominator+p.denominator)+(p.denominator+p.denominator) = 4*p.denominator
        rw [Nat.mul_comm,Nat.mul_succ,Nat.mul_succ,Nat.mul_succ,Nat.mul_one]
        exact (Nat.add_assoc _ _ _).symm)).trans (normalizationStable p)

end SFT.Foundation.FoldPhaseFull
