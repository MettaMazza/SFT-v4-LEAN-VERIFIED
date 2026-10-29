import SFT.Physics.GeneratorThreeDerivation
import SFT.Mathematics.DiscreteObjects
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.FoldReturnCarrier
open SFT.Foundation SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects
abbrev Key := Nat × Nat

def key (p : Part) : Key := (p.numerator,p.denominator)

theorem keyInjective (p q : Part) (same : key p = key q) : p = q :=
  partEquality p q (congrArg Prod.fst same) (congrArg Prod.snd same)

theorem normalDenominatorBound (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    (normalizePositive n d hn hd).denominator ≤ d := by
  have factor := normalizedDenominatorFactor n d hn hd
  have bound := Nat.mul_le_mul_right (normalizePositive n d hn hd).denominator
    (FractionReduction.gcdPositive n d hd)
  rw [Nat.one_mul,← factor] at bound
  exact bound

theorem foldDenominatorBound (p : Part) : (foldPart p).denominator ≤ p.denominator := by
  let doubled := normalizePositive (p.numerator+p.numerator) p.denominator
    (Nat.add_pos_left p.positive _) (denominatorPositive p)
  have first := normalDenominatorBound (p.numerator+p.numerator) p.denominator
    (Nat.add_pos_left p.positive _) (denominatorPositive p)
  have second := normalDenominatorBound
    (ExactCast.castNumerator doubled.numerator doubled.denominator) doubled.denominator
    (ExactCast.castPositive _ _ doubled.positive (Nat.pos_of_ne_zero doubled.denominatorNonzero))
    (Nat.pos_of_ne_zero doubled.denominatorNonzero)
  exact Nat.le_trans second first

-- This finite host support proves termination. Zero cells are bookkeeping
-- only: the executed states remain exact positive Parts.
def through : Nat → List Nat
 | 0 => [0]
 | n+1 => (n+1) :: through n

theorem throughMember (n x : Nat) (bound : x ≤ n) : x ∈ through n := by
  induction n with
  | zero => have same := Nat.eq_zero_of_le_zero bound; cases same; exact List.Mem.head _
  | succ n ih =>
    cases Nat.eq_or_lt_of_le bound with
    | inl same => cases same; exact List.Mem.head _
    | inr smaller => exact List.Mem.tail _ (ih (Nat.le_of_lt_succ smaller))

def carrier (denominator : Nat) : List Key :=
  (through denominator).flatMap (fun n => (through denominator).map (fun d => (n,d)))

theorem partInCarrier (denominator : Nat) (p : Part) (bound : p.denominator ≤ denominator) :
    key p ∈ carrier denominator :=
  CommonRefinement.memFlatMap _ _ _ _ (throughMember _ _ (Nat.le_trans p.throughOne bound))
    (memMap _ _ _ (throughMember _ _ bound))

def remove (gone : Key) : List Key → List Key
 | [] => []
 | head :: tail => if head = gone then remove gone tail else head :: remove gone tail

theorem removeMember (gone item : Key) (rows : List Key) :
    item ∈ remove gone rows ↔ item ∈ rows ∧ item ≠ gone := by
  induction rows with
  | nil => constructor; intro h; cases h; intro h; cases h.1
  | cons head tail ih =>
    change item ∈ (if head = gone then remove gone tail else head :: remove gone tail) ↔ _
    by_cases same : head = gone
    · rw [ite_eq_left same]
      constructor
      · intro h; have p := ih.mp h; exact ⟨List.Mem.tail _ p.1,p.2⟩
      · intro h; apply ih.mpr
        cases h.1 with
        | head => exact False.elim (h.2 same)
        | tail _ held => exact ⟨held,h.2⟩
    · rw [ite_eq_right same]
      constructor
      · intro h; cases h with
        | head => exact ⟨List.Mem.head _,same⟩
        | tail _ held => have p := ih.mp held; exact ⟨List.Mem.tail _ p.1,p.2⟩
      · intro h; cases h.1 with
        | head => exact List.Mem.head _
        | tail _ held => exact List.Mem.tail _ (ih.mpr ⟨held,h.2⟩)

theorem removeLength (gone : Key) (rows : List Key) : (remove gone rows).length ≤ rows.length := by
  induction rows with
  | nil => exact Nat.le_refl _
  | cons head tail ih =>
    change (if head = gone then remove gone tail else head :: remove gone tail).length ≤ _
    by_cases same : head = gone
    · rw [ite_eq_left same]; exact Nat.le_trans ih (Nat.le_succ _)
    · rw [ite_eq_right same]; exact Nat.succ_le_succ ih

theorem removeDecreases (gone : Key) (rows : List Key) (held : gone ∈ rows) :
    (remove gone rows).length < rows.length := by
  induction rows with
  | nil => cases held
  | cons head tail ih =>
    change (if head = gone then remove gone tail else head :: remove gone tail).length < _
    by_cases same : head = gone
    · rw [ite_eq_left same]; exact Nat.lt_succ_of_le (removeLength _ _)
    · rw [ite_eq_right same]
      cases held with
      | head => exact False.elim (same rfl)
      | tail _ h => exact Nat.succ_lt_succ (ih h)

-- Every generated rational state is either still available or already visited.
def Covered (denominator : Nat) (remaining seen : List Key) : Prop :=
  ∀ p : Part, p.denominator ≤ denominator → key p ∈ remaining ∨ key p ∈ seen

theorem initialCovered (source : Part) : Covered source.denominator (carrier source.denominator) [key source] :=
  fun p bound => Or.inl (partInCarrier _ _ bound)

theorem coveredSuccessor (denominator : Nat) (remaining seen : List Key)
    (covered : Covered denominator remaining seen) (next : Part) :
    Covered denominator (remove (key next) remaining) (key next :: seen) := by
  intro p bound
  by_cases same : key p = key next
  · exact Or.inr (same ▸ List.Mem.head _)
  · cases covered p bound with
    | inl held => exact Or.inl ((removeMember _ _ _).mpr ⟨held,same⟩)
    | inr held => exact Or.inr (List.Mem.tail _ held)

end SFT.Physics.FoldReturnCarrier
