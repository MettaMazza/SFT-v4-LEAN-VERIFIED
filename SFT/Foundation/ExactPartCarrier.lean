import SFT.Foundation.ExactCast
import Init.Data.Rat.Basic

/-! The reduced positive Fraction domain in engine/exact.py. Rat supplies only
its reduced-pair data type here: its axiom-dependent arithmetic/normalizers
are not used. Admission below translates ExactPart.__post_init__ for a Fraction.
Normalization of arbitrary from_pair inputs remains a separate construction. -/
namespace SFT.Foundation.ExactPartCarrier

structure Part where
  numerator : Nat
  denominator : Nat
  denominatorNonzero : denominator ≠ 0
  reduced : numerator.Coprime denominator
  positive : 0 < numerator
  throughOne : numerator ≤ denominator

def asFraction (p : Part) : Rat :=
  ⟨Int.ofNat p.numerator, p.denominator, p.denominatorNonzero, p.reduced⟩

def admitFraction : Rat → Option Part
  | ⟨.ofNat n, d, hd, hr⟩ =>
    if hp : 0 < n then
      if hb : n ≤ d then some ⟨n,d,hd,hr,hp,hb⟩ else none
    else none
  | ⟨.negSucc _, _, _, _⟩ => none

theorem admittedPartRoundTrip (p : Part) : admitFraction (asFraction p) = some p := by
  cases p with
  | mk n d hd hr hp hb =>
    dsimp only [asFraction, admitFraction]
    rw [dite_eq_left hp, dite_eq_left hb]

theorem admittedFractionPreserved (r : Rat) (p : Part)
    (h : admitFraction r = some p) : asFraction p = r := by
  cases r with
  | mk' num d hd hr =>
    cases num with
    | negSucc n => cases h
    | ofNat n =>
      dsimp only [admitFraction] at h
      split at h
      next hp =>
        split at h
        next hb =>
          have same := Option.some.inj h
          subst p
          rfl
        next hb => cases h
      next hp => cases h

theorem admissionIff (r : Rat) (p : Part) :
    admitFraction r = some p ↔ asFraction p = r :=
  ⟨admittedFractionPreserved r p,
   fun h => h ▸ admittedPartRoundTrip p⟩

theorem negativeRejected (n d : Nat) (hd : d ≠ 0)
    (hr : (n+1).Coprime d) : admitFraction ⟨.negSucc n,d,hd,hr⟩ = none := rfl

theorem zeroRejected (d : Nat) (hd : d ≠ 0) (hr : Nat.Coprime 0 d) :
    admitFraction ⟨.ofNat 0,d,hd,hr⟩ = none := rfl

theorem beyondOneRejected (n d : Nat) (hd : d ≠ 0) (hr : n.Coprime d)
    (h : d < n) : admitFraction ⟨.ofNat n,d,hd,hr⟩ = none := by
  dsimp only [admitFraction]
  split
  next hp => rw [dite_eq_right (Nat.not_le_of_gt h)]
  next hp => rfl

theorem positiveReducedPairAdmitted (n d : Nat) (hd : d ≠ 0) (hr : n.Coprime d)
    (hp : 0 < n) (hb : n ≤ d) :
    admitFraction ⟨.ofNat n,d,hd,hr⟩ = some ⟨n,d,hd,hr,hp,hb⟩ := by
  dsimp only [admitFraction]
  rw [dite_eq_left hp, dite_eq_left hb]

theorem denominatorPositive (p : Part) : 0 < p.denominator :=
  Nat.lt_of_lt_of_le p.positive p.throughOne

-- Exact pre-normalization count pairs used by the source Fraction operations.
def takeNumerator (larger smaller : Part) : Nat :=
  larger.numerator * smaller.denominator - smaller.numerator * larger.denominator

def takeDenominator (larger smaller : Part) : Nat :=
  larger.denominator * smaller.denominator

@[reducible]
def strictlyLarger (larger smaller : Part) : Prop :=
  smaller.numerator * larger.denominator < larger.numerator * smaller.denominator

def guardedTakeCountPair (larger smaller : Part) : Option (Nat × Nat) :=
  if strictlyLarger larger smaller then
    some (takeNumerator larger smaller, takeDenominator larger smaller)
  else none

theorem guardedTakeAccepted (larger smaller : Part) (guard : strictlyLarger larger smaller) :
    guardedTakeCountPair larger smaller =
      some (takeNumerator larger smaller, takeDenominator larger smaller) := by
  unfold guardedTakeCountPair
  rw [ite_eq_left guard]

theorem guardedTakeRejected (larger smaller : Part) (guard : ¬ strictlyLarger larger smaller) :
    guardedTakeCountPair larger smaller = none := by
  unfold guardedTakeCountPair
  rw [ite_eq_right guard]

theorem equalTakeRejected (p : Part) : guardedTakeCountPair p p = none :=
  guardedTakeRejected p p (Nat.lt_irrefl _)

theorem reversedTakeRejected (larger smaller : Part) (guard : strictlyLarger larger smaller) :
    guardedTakeCountPair smaller larger = none :=
  guardedTakeRejected smaller larger (Nat.not_lt_of_gt guard)

theorem takePositive (larger smaller : Part) (guard : strictlyLarger larger smaller) :
    0 < takeNumerator larger smaller := ExactCast.subtractPositive _ _ guard

theorem takeDenominatorPositive (larger smaller : Part) :
    0 < takeDenominator larger smaller :=
  Nat.mul_pos (denominatorPositive larger) (denominatorPositive smaller)

theorem takeStrictlyBelowOne (larger smaller : Part) (guard : strictlyLarger larger smaller) :
    takeNumerator larger smaller < takeDenominator larger smaller := by
  have removedPositive := Nat.mul_pos smaller.positive (denominatorPositive larger)
  have originalPositive := Nat.lt_trans removedPositive guard
  have smallerResult := Nat.sub_lt originalPositive removedPositive
  have originalBound := Nat.mul_le_mul_right smaller.denominator larger.throughOne
  exact Nat.lt_of_lt_of_le smallerResult originalBound

def foldNumerator (p : Part) : Nat :=
  ExactCast.castNumerator (p.numerator+p.numerator) p.denominator

theorem foldPositive (p : Part) : 0 < foldNumerator p :=
  ExactCast.castPositive _ _ (Nat.add_pos_left p.positive _) (denominatorPositive p)

theorem foldThroughOne (p : Part) : foldNumerator p ≤ p.denominator :=
  ExactCast.castWithinOne _ _ (denominatorPositive p)

theorem completeOneFoldFixed (p : Part) (whole : p.numerator = p.denominator) :
    foldNumerator p = p.denominator := by
  unfold foldNumerator
  rw [whole, ExactCast.castAddingOne _ _ (denominatorPositive p) (denominatorPositive p)]
  exact ExactCast.fullTurnRetained _ (denominatorPositive p)

end SFT.Foundation.ExactPartCarrier
