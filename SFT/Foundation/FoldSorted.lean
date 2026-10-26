import SFT.Foundation.FoldUniformOrder

/-! Native sorted-set output for fold_dynamics.py, with exact reduced-rational
identity and order. Enumeration is retained before sorting/deduplication. -/
namespace SFT.Foundation.FoldSorted
open ExactOperations ExactPartCarrier ExactValueIdentity FractionReduction
open FoldDynamics FoldUniform FoldUniformOrder Count.TraceDerivation

theorem rotateProduct (a b c : Nat) : a*(b*c) = c*(b*a) := by
  rw [Nat.mul_comm a (b*c),mulAssoc b c a,Nat.mul_comm c a,← mulAssoc b a c,Nat.mul_comm (b*a) c]

theorem orderTrans (p q r : ExactPartCarrier.Part)
    (pq : strictlyLarger q p) (qr : strictlyLarger r q) : strictlyLarger r p := by
  apply cancelPositiveStrict q.denominator
  calc
    q.denominator*(p.numerator*r.denominator) = r.denominator*(p.numerator*q.denominator) := rotateProduct _ _ _
    _ < r.denominator*(q.numerator*p.denominator) := Nat.mul_lt_mul_of_pos_left pq (denominatorPositive r)
    _ = p.denominator*(q.numerator*r.denominator) := rotateProduct _ _ _
    _ < p.denominator*(r.numerator*q.denominator) := Nat.mul_lt_mul_of_pos_left qr (denominatorPositive p)
    _ = q.denominator*(r.numerator*p.denominator) := rotateProduct _ _ _

theorem reverseOrder (p q : ExactPartCarrier.Part)
    (different : p.numerator*q.denominator ≠ q.numerator*p.denominator)
    (notBefore : ¬ strictlyLarger q p) : strictlyLarger p q := by
  have bound := Nat.le_of_not_gt notBefore
  cases Nat.eq_or_lt_of_le bound with
  | inl same => exact False.elim (different same.symm)
  | inr less => exact less

def insertDistinct (p : ExactPartCarrier.Part) : List ExactPartCarrier.Part → List ExactPartCarrier.Part
  | [] => [p]
  | q::qs =>
    if p.numerator*q.denominator = q.numerator*p.denominator then q::qs
    else if strictlyLarger q p then p::q::qs
    else q::insertDistinct p qs

def sortedDistinct : List ExactPartCarrier.Part → List ExactPartCarrier.Part
  | [] => []
  | p::ps => insertDistinct p (sortedDistinct ps)

def foldedDistinct (ps : List ExactPartCarrier.Part) : List ExactPartCarrier.Part :=
  sortedDistinct (ps.map foldPart)

theorem insertMembership (p x : ExactPartCarrier.Part) (xs : List ExactPartCarrier.Part) :
    x ∈ insertDistinct p xs ↔ x = p ∨ x ∈ xs := by
  induction xs with
  | nil =>
    constructor
    · intro h; cases h with
      | head => exact Or.inl rfl
      | tail _ h => cases h
    · intro h; cases h with
      | inl eq => cases eq; exact .head _
      | inr h => cases h
  | cons q qs ih =>
    dsimp only [insertDistinct]
    split
    next equal =>
      have pq := reducedValueIdentity p q equal
      cases pq
      constructor
      · intro h; exact Or.inr h
      · intro h; cases h with
        | inl eq => cases eq; exact .head _
        | inr h => exact h
    next different =>
      split
      next before =>
        constructor
        · intro h; cases h with
          | head => exact Or.inl rfl
          | tail _ h => exact Or.inr h
        · intro h; cases h with
          | inl eq => cases eq; exact .head _
          | inr h => exact .tail _ h
      next after =>
        constructor
        · intro h; cases h with
          | head => exact Or.inr (.head _)
          | tail _ h =>
            cases ih.mp h with
            | inl eq => exact Or.inl eq
            | inr old => exact Or.inr (.tail _ old)
        · intro h; cases h with
          | inl eq => exact .tail _ (ih.mpr (Or.inl eq))
          | inr old => cases old with
            | head => exact .head _
            | tail _ old => exact .tail _ (ih.mpr (Or.inr old))

theorem insertionOrdered (p : ExactPartCarrier.Part) (xs : List ExactPartCarrier.Part)
    (ordered : xs.Pairwise (fun p q => strictlyLarger q p)) :
    (insertDistinct p xs).Pairwise (fun p q => strictlyLarger q p) := by
  induction xs with
  | nil => exact .cons (fun _ h => nomatch h) .nil
  | cons q qs ih =>
    cases ordered with
    | cons head tail =>
      dsimp only [insertDistinct]
      split
      next equal => exact .cons head tail
      next different =>
        split
        next before =>
          constructor
          · intro r member
            cases member with
            | head => exact before
            | tail _ member => exact orderTrans p q r before (head r member)
          · exact .cons head tail
        next after =>
          constructor
          · intro r member
            cases (insertMembership p r qs).mp member with
            | inl same => cases same; exact reverseOrder p q different after
            | inr old => exact head r old
          · exact ih tail

theorem sortedMembership (xs : List ExactPartCarrier.Part) (p : ExactPartCarrier.Part) :
    p ∈ sortedDistinct xs ↔ p ∈ xs := by
  induction xs with
  | nil => exact ⟨fun h => h,fun h => h⟩
  | cons q qs ih =>
    constructor
    · intro h
      cases (insertMembership q p (sortedDistinct qs)).mp h with
      | inl same => cases same; exact .head _
      | inr old => exact .tail _ (ih.mp old)
    · intro h
      apply (insertMembership q p (sortedDistinct qs)).mpr
      cases h with
      | head => exact Or.inl rfl
      | tail _ old => exact Or.inr (ih.mpr old)

theorem sortedOrdered (xs : List ExactPartCarrier.Part) :
    (sortedDistinct xs).Pairwise (fun p q => strictlyLarger q p) := by
  induction xs with
  | nil => exact .nil
  | cons p ps ih => exact insertionOrdered p _ ih

theorem orderedListsEqual (xs ys : List ExactPartCarrier.Part)
    (ox : xs.Pairwise (fun p q => strictlyLarger q p))
    (oy : ys.Pairwise (fun p q => strictlyLarger q p))
    (same : ∀ p, p ∈ xs ↔ p ∈ ys) : xs = ys := by
  induction xs generalizing ys with
  | nil =>
    cases ys with
    | nil => rfl
    | cons q qs => exact False.elim (by have h := (same q).mpr (.head _); cases h)
  | cons p ps ih =>
    cases ys with
    | nil => exact False.elim (by have h := (same p).mp (.head _); cases h)
    | cons q qs =>
      cases ox with
      | cons hx tx =>
        cases oy with
        | cons hy ty =>
          have heads : p = q := by
            have pin := (same p).mp (.head _)
            have qin := (same q).mpr (.head _)
            cases pin with
            | head => rfl
            | tail _ pin =>
              cases qin with
              | head => rfl
              | tail _ qin => exact False.elim (Nat.lt_asymm (hy p pin) (hx q qin))
          cases heads
          have tails : ∀ x, x ∈ ps ↔ x ∈ qs := by
            intro x
            constructor
            · intro member
              have full := (same x).mp (.tail _ member)
              cases full with
              | head => exact False.elim (Nat.lt_irrefl _ (hx p member))
              | tail _ member => exact member
            · intro member
              have full := (same x).mpr (.tail _ member)
              cases full with
              | head => exact False.elim (Nat.lt_irrefl _ (hy p member))
              | tail _ member => exact member
          exact congrArg (fun tail => p::tail) (ih qs tx ty tails)

theorem sortedNoDuplicates (xs : List ExactPartCarrier.Part) : (sortedDistinct xs).Nodup :=
  strictlyOrderedNoDuplicates _ (sortedOrdered xs)

theorem foldedUniformDivision (n : Nat) (hn : 0 < n) :
    foldedDistinct (uniformDivision (n+n) (Nat.add_pos_left hn n)) = uniformDivision n hn := by
  apply orderedListsEqual
  · exact sortedOrdered _
  · exact uniformStrictlyOrdered n hn
  · intro p
    exact (sortedMembership _ p).trans (foldedEnumerationMembership n hn p)

theorem foldedUniformLength (n : Nat) (hn : 0 < n) :
    (foldedDistinct (uniformDivision (n+n) (Nat.add_pos_left hn n))).length = n :=
  (congrArg List.length (foldedUniformDivision n hn)).trans (uniformLength n hn)

end SFT.Foundation.FoldSorted
