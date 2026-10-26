import SFT.Foundation.FoldDynamics

/-! Count-pair casting laws used by fold_dynamics.py's arbitrary rational
preimage and phase arguments. Positive scale changes representation only. -/
namespace SFT.Foundation.FoldCastLaws
open ExactOperations ExactPartCarrier ExactValueIdentity FractionReduction ExactCast

theorem scaledRemoval (k : Nat) (hk : 0 < k) {n d r : Nat} (trace : Removal d n r) :
    Removal (k*d) (k*n) (k*r) := by
  induction trace with
  | retain n h => exact .retain _ (Nat.mul_le_mul_left k h)
  | step n r h prior ih =>
    apply Removal.step _ _ (Nat.mul_lt_mul_of_pos_left h hk)
    rw [mulSubtract]
    exact ih

theorem castScale (k n d : Nat) (hk : 0 < k) (hd : 0 < d) :
    castNumerator (k*n) (k*d) = k*castNumerator n d :=
  removalUnique (castHasRemovalTrace (k*n) (k*d) (Nat.mul_pos hk hd)) _
    (scaledRemoval k hk (castHasRemovalTrace n d hd))

theorem normalizationScale (k n d : Nat) (hk : 0 < k) (hn : 0 < n) (bound : n ≤ d) :
    normalizePart (k*n) (k*d) (Nat.mul_pos hk hn) (Nat.mul_le_mul_left k bound) =
      normalizePart n d hn bound := by
  let p := normalizePart n d hn bound
  have preserved : n*p.denominator = p.numerator*d :=
    normalizedValuePreserved n d hn (Nat.lt_of_lt_of_le hn bound)
  apply normalizedRepresents
  calc
    (k*n)*p.denominator = k*(n*p.denominator) := mulAssoc _ _ _
    _ = k*(p.numerator*d) := congrArg (fun x => k*x) preserved
    _ = p.numerator*(k*d) := by rw [← mulAssoc,Nat.mul_comm k p.numerator,mulAssoc]

theorem normalizedCast (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    ExactOperations.castPositive (normalizePositive n d hn hd) =
      normalizePart (castNumerator n d) d (ExactCast.castPositive n d hn hd) (castWithinOne n d hd) := by
  let q := normalizePositive n d hn hd
  let g := Nat.gcd n d
  have hg : 0 < g := gcdPositive n d hd
  have qd : 0 < q.denominator := Nat.pos_of_ne_zero q.denominatorNonzero
  have nf : n = g*q.numerator := normalizedNumeratorFactor n d hn hd
  have df : d = g*q.denominator := normalizedDenominatorFactor n d hn hd
  have cf : castNumerator n d = g*castNumerator q.numerator q.denominator := by
    calc
      castNumerator n d = castNumerator (g*q.numerator) (g*q.denominator) := by
        exact (congrArg (fun x => castNumerator x d) nf).trans
          (congrArg (fun x => castNumerator (g*q.numerator) x) df)
      _ = _ := castScale g q.numerator q.denominator hg qd
  let result := ExactOperations.castPositive q
  have value : castNumerator q.numerator q.denominator * result.denominator =
      result.numerator*q.denominator :=
    normalizedValuePreserved _ _ (ExactCast.castPositive _ _ q.positive qd) qd
  have represented : normalizePart (castNumerator n d) d
      (ExactCast.castPositive n d hn hd) (castWithinOne n d hd) = result := by
    apply normalizedRepresents
    calc
      castNumerator n d * result.denominator = (g*castNumerator q.numerator q.denominator)*result.denominator :=
        congrArg (fun x => x*result.denominator) cf
      _ = g*(castNumerator q.numerator q.denominator*result.denominator) := mulAssoc _ _ _
      _ = g*(result.numerator*q.denominator) := congrArg (fun x => g*x) value
      _ = result.numerator*(g*q.denominator) := by rw [← mulAssoc,Nat.mul_comm g result.numerator,mulAssoc]
      _ = result.numerator*d := congrArg (fun x => result.numerator*x) df.symm
  exact represented.symm

theorem foldCountFormula (p : ExactPartCarrier.Part) :
    foldPart p = normalizePart (castNumerator (p.numerator+p.numerator) p.denominator) p.denominator
      (ExactCast.castPositive _ _ (Nat.add_pos_left p.positive _) (denominatorPositive p))
      (castWithinOne _ _ (denominatorPositive p)) :=
  normalizedCast _ _ (Nat.add_pos_left p.positive _) (denominatorPositive p)

theorem normalizationByFactors (n d a b k : Nat)
    (hn : 0 < n) (nd : n ≤ d) (ha : 0 < a) (ab : a ≤ b)
    (nf : n = k*a) (df : d = k*b) :
    normalizePart n d hn nd = normalizePart a b ha ab := by
  let p := normalizePart a b ha ab
  have preserved : a*p.denominator = p.numerator*b :=
    normalizedValuePreserved a b ha (Nat.lt_of_lt_of_le ha ab)
  apply normalizedRepresents
  calc
    n*p.denominator = (k*a)*p.denominator := congrArg (fun x => x*p.denominator) nf
    _ = k*(a*p.denominator) := mulAssoc _ _ _
    _ = k*(p.numerator*b) := congrArg (fun x => k*x) preserved
    _ = p.numerator*(k*b) := by rw [← mulAssoc,Nat.mul_comm k p.numerator,mulAssoc]
    _ = p.numerator*d := congrArg (fun x => p.numerator*x) df.symm

theorem foldNormalized (n d : Nat) (hn : 0 < n) (bound : n ≤ d) :
    foldPart (normalizePart n d hn bound) =
    normalizePart (castNumerator (n+n) d) d
      (ExactCast.castPositive _ _ (Nat.add_pos_left hn _) (Nat.lt_of_lt_of_le hn bound))
      (castWithinOne _ _ (Nat.lt_of_lt_of_le hn bound)) := by
  let p := normalizePart n d hn bound
  let g := Nat.gcd n d
  have hd := Nat.lt_of_lt_of_le hn bound
  have nf : n = g*p.numerator := normalizedNumeratorFactor n d hn hd
  have df : d = g*p.denominator := normalizedDenominatorFactor n d hn hd
  have sum : n+n = g*(p.numerator+p.numerator) := by
    exact ((congrArg (fun x => x+n) nf).trans (congrArg (fun x => g*p.numerator+x) nf)).trans
      (Nat.mul_add g p.numerator p.numerator).symm
  have cf : castNumerator (n+n) d = g*castNumerator (p.numerator+p.numerator) p.denominator := by
    calc
      _ = castNumerator (g*(p.numerator+p.numerator)) (g*p.denominator) :=
        (congrArg (fun x => castNumerator x d) sum).trans
          (congrArg (fun x => castNumerator (g*(p.numerator+p.numerator)) x) df)
      _ = _ := castScale g _ _ (gcdPositive n d hd) (denominatorPositive p)
  exact (foldCountFormula p).trans
    (normalizationByFactors _ _ _ _ g _ _ _ _ cf df).symm

theorem positiveNormalizationCongr (n d a b : Nat) (hn : 0 < n) (hd : 0 < d)
    (ha : 0 < a) (hb : 0 < b) (ne : n = a) (de : d = b) :
    normalizePositive n d hn hd = normalizePositive a b ha hb := by
  cases ne
  cases de
  rfl

theorem twoTimes (n : Nat) : 2*n = n+n := by
  rw [Nat.mul_comm,Nat.mul_succ,Nat.mul_one]

theorem additionShuffle (x y : Nat) : (x+y)+(x+y) = (x+x)+(y+y) := by
  rw [Nat.add_assoc x y (x+y),← Nat.add_assoc y x y,Nat.add_comm y x,
    Nat.add_assoc x y y,← Nat.add_assoc x x (y+y)]

end SFT.Foundation.FoldCastLaws
