import SFT.Foundation.FoldUniform
import SFT.Foundation.CommonRefinement

/-! Exact positive rational comparison and order of the generated uniform
partition, as used by fold_dynamics.py sorted distinct images. -/
namespace SFT.Foundation.FoldUniformOrder
open ExactOperations ExactPartCarrier ExactValueIdentity FractionReduction
open FoldUniform FoldFibres FoldCastLaws

theorem multiplyShuffle (a b c d : Nat) : (a*b)*(c*d) = (a*c)*(b*d) := by
  rw [mulAssoc,← mulAssoc b c d,Nat.mul_comm b c,mulAssoc c b d,← mulAssoc]

theorem cancelPositiveStrict (k a b : Nat) (h : k*a < k*b) : a < b := by
  apply Nat.lt_of_not_ge
  intro reversed
  exact Nat.not_le_of_lt h (Nat.mul_le_mul_left k reversed)

theorem normalizedOrder (a d b e : Nat) (ha : 0 < a) (ad : a ≤ d)
    (hb : 0 < b) (be : b ≤ e) :
    strictlyLarger (normalizePart b e hb be) (normalizePart a d ha ad) ↔ a*e < b*d := by
  let p := normalizePart a d ha ad
  let q := normalizePart b e hb be
  let g := Nat.gcd a d
  let h := Nat.gcd b e
  have hd := Nat.lt_of_lt_of_le ha ad
  have he := Nat.lt_of_lt_of_le hb be
  have an : a = g*p.numerator := normalizedNumeratorFactor a d ha hd
  have dd : d = g*p.denominator := normalizedDenominatorFactor a d ha hd
  have bn : b = h*q.numerator := normalizedNumeratorFactor b e hb he
  have ee : e = h*q.denominator := normalizedDenominatorFactor b e hb he
  have left : a*e = (g*h)*(p.numerator*q.denominator) := by
    calc
      a*e = (g*p.numerator)*(h*q.denominator) :=
        (congrArg (fun x => x*e) an).trans (congrArg (fun x => (g*p.numerator)*x) ee)
      _ = _ := multiplyShuffle _ _ _ _
  have right : b*d = (g*h)*(q.numerator*p.denominator) := by
    calc
      b*d = (h*q.numerator)*(g*p.denominator) :=
        (congrArg (fun x => x*d) bn).trans (congrArg (fun x => (h*q.numerator)*x) dd)
      _ = (h*g)*(q.numerator*p.denominator) := multiplyShuffle _ _ _ _
      _ = _ := congrArg (fun x => x*(q.numerator*p.denominator)) (Nat.mul_comm h g)
  constructor
  · intro order
    rw [left,right]
    exact Nat.mul_lt_mul_of_pos_left order (Nat.mul_pos (gcdPositive a d hd) (gcdPositive b e he))
  · intro order
    rw [left,right] at order
    exact cancelPositiveStrict (g*h) _ _ order

theorem divisionOrder (n i j : Nat) (hi : 0 < i) (hj : 0 < j)
    (ib : i ≤ n) (jb : j ≤ n) :
    strictlyLarger (divisionPoint n j hj jb) (divisionPoint n i hi ib) ↔ i < j := by
  constructor
  · intro h
    have raw := (normalizedOrder i n j n hi ib hj jb).mp h
    rw [Nat.mul_comm i n,Nat.mul_comm j n] at raw
    exact cancelPositiveStrict n i j raw
  · intro h
    apply (normalizedOrder i n j n hi ib hj jb).mpr
    have scaled := Nat.mul_lt_mul_of_pos_left h (Nat.lt_of_lt_of_le hi ib)
    rw [Nat.mul_comm n i,Nat.mul_comm n j] at scaled
    exact scaled

theorem pairwiseSnoc {α : Type} (R : α → α → Prop) (xs : List α) (x : α)
    (ordered : xs.Pairwise R) (last : ∀ y, y ∈ xs → R y x) : (xs ++ [x]).Pairwise R := by
  induction xs with
  | nil => exact .cons (fun _ h => nomatch h) .nil
  | cons a xs ih =>
    cases ordered with
    | cons head tail =>
      constructor
      · intro y member
        cases Count.TraceDerivation.memAppendCases y xs [x] member with
        | inl old => exact head y old
        | inr newest =>
          cases newest with
          | head => exact last a (List.Mem.head _)
          | tail _ impossible => cases impossible
      · exact ih tail (fun y hy => last y (List.Mem.tail _ hy))

theorem prefixStrictlyOrdered (n k : Nat) (bound : k ≤ n) :
    (divisionPrefix n k bound).Pairwise (fun p q => strictlyLarger q p) := by
  induction k with
  | zero => exact .nil
  | succ k ih =>
    apply pairwiseSnoc
    · exact ih (Nat.le_trans (Nat.le_succ k) bound)
    · intro p member
      obtain ⟨i,hi,ib,eq⟩ := prefixOrigin n k (Nat.le_trans (Nat.le_succ k) bound) p member
      cases eq
      exact (divisionOrder n i (k+1) hi (Nat.zero_lt_succ k) _ bound).mpr (Nat.lt_succ_of_le ib)

theorem uniformStrictlyOrdered (n : Nat) (hn : 0 < n) :
    (uniformDivision n hn).Pairwise (fun p q => strictlyLarger q p) :=
  prefixStrictlyOrdered n n (Nat.le_refl n)

theorem strictlyOrderedNoDuplicates (xs : List ExactPartCarrier.Part)
    (ordered : xs.Pairwise (fun p q => strictlyLarger q p)) : xs.Nodup := by
  induction xs with
  | nil => exact .nil
  | cons p xs ih =>
    cases ordered with
    | cons head tail =>
      constructor
      · intro q member same
        cases same
        exact Nat.lt_irrefl _ (head p member)
      · exact ih tail

theorem uniformNoDuplicates (n : Nat) (hn : 0 < n) : (uniformDivision n hn).Nodup :=
  strictlyOrderedNoDuplicates _ (uniformStrictlyOrdered n hn)

theorem adjacentRawDifference (n i : Nat) : (i+1)*n-i*n = n := by
  rw [Nat.mul_comm (i+1) n,Nat.mul_succ,Nat.mul_comm n i,Nat.add_comm (i*n) n]
  exact ExactCast.addSubtract n (i*n)

theorem adjacentGap (n i : Nat) (hi : 0 < i) (bound : i+1 ≤ n) :
    takePart (divisionPoint n (i+1) (Nat.zero_lt_succ i) bound)
      (divisionPoint n i hi (Nat.le_trans (Nat.le_succ i) bound)) =
    .ok (divisionPoint n 1 (by decide) (Nat.lt_of_lt_of_le (Nat.zero_lt_succ i) bound)) := by
  let p := divisionPoint n i hi (Nat.le_trans (Nat.le_succ i) bound)
  let q := divisionPoint n (i+1) (Nat.zero_lt_succ i) bound
  let g := Nat.gcd i n
  let h := Nat.gcd (i+1) n
  have hn : 0 < n := Nat.lt_of_lt_of_le (Nat.zero_lt_succ i) bound
  have pn : i = g*p.numerator := normalizedNumeratorFactor i n hi hn
  have pd : n = g*p.denominator := normalizedDenominatorFactor i n hi hn
  have qn : i+1 = h*q.numerator := normalizedNumeratorFactor (i+1) n (Nat.zero_lt_succ i) hn
  have qd : n = h*q.denominator := normalizedDenominatorFactor (i+1) n (Nat.zero_lt_succ i) hn
  have left : (i+1)*n = (g*h)*(q.numerator*p.denominator) := by
    calc
      (i+1)*n = (h*q.numerator)*(g*p.denominator) :=
        (congrArg (fun x => x*n) qn).trans (congrArg (fun x => (h*q.numerator)*x) pd)
      _ = (h*g)*(q.numerator*p.denominator) := multiplyShuffle _ _ _ _
      _ = _ := congrArg (fun x => x*(q.numerator*p.denominator)) (Nat.mul_comm h g)
  have right : i*n = (g*h)*(p.numerator*q.denominator) := by
    calc
      i*n = (g*p.numerator)*(h*q.denominator) :=
        (congrArg (fun x => x*n) pn).trans (congrArg (fun x => (g*p.numerator)*x) qd)
      _ = _ := multiplyShuffle _ _ _ _
  have nf : n = (g*h)*takeNumerator q p := by
    calc
      n = (i+1)*n-i*n := (adjacentRawDifference n i).symm
      _ = (g*h)*(q.numerator*p.denominator)-(g*h)*(p.numerator*q.denominator) :=
        (congrArg (fun x => x-i*n) left).trans
          (congrArg (fun x => (g*h)*(q.numerator*p.denominator)-x) right)
      _ = _ := mulSubtract _ _ _
  have df : n*n = (g*h)*takeDenominator q p := by
    calc
      n*n = (h*q.denominator)*(g*p.denominator) :=
        (congrArg (fun x => x*n) qd).trans (congrArg (fun x => (h*q.denominator)*x) pd)
      _ = (h*g)*(q.denominator*p.denominator) := multiplyShuffle _ _ _ _
      _ = _ := congrArg (fun x => x*(q.denominator*p.denominator)) (Nat.mul_comm h g)
  have guard : strictlyLarger q p := (divisionOrder n i (i+1) hi (Nat.zero_lt_succ i) _ bound).mpr (Nat.lt_succ_self i)
  have nn : n ≤ n*n := by
    have scaled := Nat.mul_le_mul_left n hn
    rw [Nat.mul_one] at scaled
    exact scaled
  have normalized := normalizationByFactors n (n*n) (takeNumerator q p) (takeDenominator q p) (g*h)
    hn nn (takePositive q p guard) (Nat.le_of_lt (takeStrictlyBelowOne q p guard)) nf df
  have unit := normalizationByFactors n (n*n) 1 n n hn nn (by decide) hn
    (Nat.mul_one n).symm rfl
  exact (takeAdmitted q p guard).trans (congrArg Except.ok (normalized.symm.trans unit))

theorem prefixLength (n k : Nat) (bound : k ≤ n) : (divisionPrefix n k bound).length = k := by
  induction k with
  | zero => rfl
  | succ k ih =>
    change (divisionPrefix n k _ ++ [_]).length = k+1
    exact (CommonRefinement.appendLength _ _).trans
      (congrArg (fun x => x+1) (ih (Nat.le_trans (Nat.le_succ k) bound)))

theorem uniformLength (n : Nat) (hn : 0 < n) : (uniformDivision n hn).length = n :=
  prefixLength n n (Nat.le_refl n)

theorem singletonDivision : uniformDivision 1 (by decide) = [one] := rfl

end SFT.Foundation.FoldUniformOrder
