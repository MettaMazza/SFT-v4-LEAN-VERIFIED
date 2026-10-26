import SFT.Foundation.FractionReduction
import SFT.Foundation.ExactPartCarrier

/-! Native reduced Fraction construction and exact_operations.py primitives.
Self-junction is reduced before complete-One casting, as in Fraction addition. -/
namespace SFT.Foundation.ExactOperations
open FractionReduction ExactPartCarrier

structure PositiveFraction where
  numerator : Nat
  denominator : Nat
  denominatorNonzero : denominator ≠ 0
  reduced : numerator.Coprime denominator
  positive : 0 < numerator

def normalizePositive (n d : Nat) (hn : 0 < n) (hd : 0 < d) : PositiveFraction :=
  let g := Nat.gcd n d
  let hg := gcdPositive n d hd
  let dg := quotientPositive d g hd hg (gcdDivides n d).2
  ⟨n/g,d/g,Nat.ne_of_gt dg,reducedCoprime n d hd,
    quotientPositive n g hn hg (gcdDivides n d).1⟩

theorem normalizedNumeratorFactor (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    n = Nat.gcd n d * (normalizePositive n d hn hd).numerator :=
  quotientFactor n _ (gcdPositive n d hd) (gcdDivides n d).1

theorem normalizedDenominatorFactor (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    d = Nat.gcd n d * (normalizePositive n d hn hd).denominator :=
  quotientFactor d _ (gcdPositive n d hd) (gcdDivides n d).2

theorem normalizedValuePreserved (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    n*(normalizePositive n d hn hd).denominator =
      (normalizePositive n d hn hd).numerator*d := by
  let p := normalizePositive n d hn hd
  have nf := normalizedNumeratorFactor n d hn hd
  have df := normalizedDenominatorFactor n d hn hd
  calc
    n*p.denominator = (Nat.gcd n d*p.numerator)*p.denominator := congrArg (fun x => x*p.denominator) nf
    _ = p.numerator*(Nat.gcd n d*p.denominator) := by rw [Nat.mul_comm (Nat.gcd n d) p.numerator,mulAssoc]
    _ = p.numerator*d := congrArg (fun x => p.numerator*x) df.symm

theorem normalizedThroughOne (n d : Nat) (hn : 0 < n) (hd : 0 < d) (bound : n ≤ d) :
    (normalizePositive n d hn hd).numerator ≤ (normalizePositive n d hn hd).denominator := by
  have comparison :
      Nat.gcd n d*(normalizePositive n d hn hd).numerator ≤
      Nat.gcd n d*(normalizePositive n d hn hd).denominator :=
    calc
      _ = n := (normalizedNumeratorFactor n d hn hd).symm
      _ ≤ d := bound
      _ = _ := normalizedDenominatorFactor n d hn hd
  exact Nat.le_of_mul_le_mul_left comparison (gcdPositive n d hd)

def normalizePart (n d : Nat) (hn : 0 < n) (bound : n ≤ d) : Part :=
  let hd := Nat.lt_of_lt_of_le hn bound
  let p := normalizePositive n d hn hd
  ⟨p.numerator,p.denominator,p.denominatorNonzero,p.reduced,p.positive,
    normalizedThroughOne n d hn hd bound⟩

theorem partEquality (p q : Part) (hn : p.numerator = q.numerator)
    (hd : p.denominator = q.denominator) : p = q := by
  cases p
  cases q
  cases hn
  cases hd
  rfl

theorem divisionOne (n : Nat) : n/1 = n := by
  have h := divisionMultiple 1 n (by decide)
  rw [Nat.one_mul] at h
  exact h

theorem normalizationStable (p : Part) : normalizePart p.numerator p.denominator p.positive p.throughOne = p := by
  apply partEquality
  · change p.numerator / Nat.gcd p.numerator p.denominator = p.numerator
    rw [p.reduced,divisionOne]
  · change p.denominator / Nat.gcd p.numerator p.denominator = p.denominator
    rw [p.reduced,divisionOne]

def fromPair (numerator denominator : Int) : Except String Part :=
  match numerator with
  | .negSucc _ => .error "an SFT part cannot contain zero or a negative value"
  | .ofNat n =>
    match denominator with
    | .negSucc _ => .error "an SFT part cannot contain zero or a negative value"
    | .ofNat d =>
      if hn : 0 < n then
        if _hd : 0 < d then
          if bound : n ≤ d then .ok (normalizePart n d hn bound)
          else .error "an SFT part cannot exceed the One"
        else .error "an SFT part cannot contain zero or a negative value"
      else .error "an SFT part cannot contain zero or a negative value"

theorem fromPairAdmitted (n d : Nat) (hn : 0 < n) (hd : 0 < d) (bound : n ≤ d) :
    fromPair (.ofNat n) (.ofNat d) = .ok (normalizePart n d hn bound) := by
  dsimp only [fromPair]
  rw [dite_eq_left hn,dite_eq_left hd,dite_eq_left bound]

def castPositive (p : PositiveFraction) : Part :=
  normalizePart (ExactCast.castNumerator p.numerator p.denominator) p.denominator
    (ExactCast.castPositive _ _ p.positive (Nat.pos_of_ne_zero p.denominatorNonzero))
    (ExactCast.castWithinOne _ _ (Nat.pos_of_ne_zero p.denominatorNonzero))

def foldPart (p : Part) : Part :=
  castPositive (normalizePositive (p.numerator+p.numerator) p.denominator
    (Nat.add_pos_left p.positive _) (denominatorPositive p))

def takePart (larger smaller : Part) : Except String Part :=
  if guard : strictlyLarger larger smaller then
    .ok (normalizePart (takeNumerator larger smaller) (takeDenominator larger smaller)
      (takePositive larger smaller guard) (Nat.le_of_lt (takeStrictlyBelowOne larger smaller guard)))
  else .error "Take requires the first exact part to be strictly larger"

theorem takeRejected (larger smaller : Part) (guard : ¬ strictlyLarger larger smaller) :
    takePart larger smaller = .error "Take requires the first exact part to be strictly larger" := by
  unfold takePart
  rw [dite_eq_right guard]

theorem takeAdmitted (larger smaller : Part) (guard : strictlyLarger larger smaller) :
    takePart larger smaller = .ok (normalizePart (takeNumerator larger smaller) (takeDenominator larger smaller)
      (takePositive larger smaller guard) (Nat.le_of_lt (takeStrictlyBelowOne larger smaller guard))) := by
  unfold takePart
  rw [dite_eq_left guard]

theorem foldResultPositive (p : Part) : 0 < (foldPart p).numerator := (foldPart p).positive

theorem foldResultThroughOne (p : Part) : (foldPart p).numerator ≤ (foldPart p).denominator :=
  (foldPart p).throughOne

theorem foldResultReduced (p : Part) : (foldPart p).numerator.Coprime (foldPart p).denominator :=
  (foldPart p).reduced

theorem normalizationOneIff (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    ((normalizePositive n d hn hd).numerator = 1 ∧
     (normalizePositive n d hn hd).denominator = 1) ↔ n = d := by
  constructor
  · intro h
    have nf := normalizedNumeratorFactor n d hn hd
    have df := normalizedDenominatorFactor n d hn hd
    rw [h.1,Nat.mul_one] at nf
    rw [h.2,Nat.mul_one] at df
    exact nf.trans df.symm
  · intro h
    subst d
    change n / Nat.gcd n n = 1 ∧ n / Nat.gcd n n = 1
    rw [gcdSelf,divisionSelf n hn]
    exact ⟨rfl,rfl⟩

def unison (left right : Part) : Bool :=
  let q := normalizePositive (left.numerator*right.denominator) (left.denominator*right.numerator)
    (Nat.mul_pos left.positive (denominatorPositive right))
    (Nat.mul_pos (denominatorPositive left) right.positive)
  decide (q.numerator = 1 ∧ q.denominator = 1)

theorem unisonIff (left right : Part) : unison left right = true ↔
    left.numerator*right.denominator = left.denominator*right.numerator := by
  constructor
  · intro h
    exact (normalizationOneIff _ _ _ _).mp (of_decide_eq_true h)
  · intro h
    exact decide_eq_true ((normalizationOneIff _ _ _ _).mpr h)

theorem unisonSelf (p : Part) : unison p p = true :=
  (unisonIff p p).mpr (Nat.mul_comm _ _)

def one : Part := normalizePart 1 1 (by decide) (Nat.le_refl 1)

theorem oneFoldFixed : foldPart one = one := by
  apply partEquality <;> rfl

theorem completeOneFoldFixed (p : Part) (whole : p.numerator = p.denominator) : foldPart p = p := by
  have reduced := p.reduced
  change Nat.gcd p.numerator p.denominator = 1 at reduced
  rw [← whole,gcdSelf] at reduced
  have identity : p = one := partEquality p one reduced (whole.symm.trans reduced)
  cases identity
  exact oneFoldFixed

theorem fromPairNegativeNumerator (n : Nat) (d : Int) :
    fromPair (.negSucc n) d = .error "an SFT part cannot contain zero or a negative value" := rfl

theorem fromPairNegativeDenominator (n : Int) (d : Nat) :
    fromPair n (.negSucc d) = .error "an SFT part cannot contain zero or a negative value" := by
  cases n <;> rfl

theorem fromPairZeroNumerator (d : Int) :
    fromPair (.ofNat 0) d = .error "an SFT part cannot contain zero or a negative value" := by
  cases d <;> rfl

theorem fromPairBeyondOne (n d : Nat) (hn : 0 < n) (hd : 0 < d) (h : d < n) :
    fromPair (.ofNat n) (.ofNat d) = .error "an SFT part cannot exceed the One" := by
  dsimp only [fromPair]
  rw [dite_eq_left hn,dite_eq_left hd,dite_eq_right (Nat.not_le_of_gt h)]

end SFT.Foundation.ExactOperations
