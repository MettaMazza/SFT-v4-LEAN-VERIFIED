import SFT.Foundation.PartSelection

/-! Numerator-level translation of exact_operations.py::cast_positive and its
closure argument for every positive n/d. Each loop subtracts one denominator;
the denominator stays fixed. This precedes the Fraction carrier translation. -/
namespace SFT.Foundation.ExactCast

inductive Removal (denominator : Nat) : Nat → Nat → Prop where
  | retain (n : Nat) : n ≤ denominator → Removal denominator n n
  | step (n retained : Nat) : denominator < n →
      Removal denominator (n - denominator) retained → Removal denominator n retained

-- n bounds the number of removals because the denominator is positive.
-- Fuel is derived from the input numerator, never a scientific parameter.
def removeOnes : Nat → Nat → Nat → Nat
  | 0, n, _ => n
  | fuel+1, n, d => if d < n then removeOnes fuel (n-d) d else n

def castNumerator (n d : Nat) : Nat := removeOnes n n d

theorem removalTrace (fuel n d : Nat) (hd : 0 < d) (bound : n ≤ fuel) :
    Removal d n (removeOnes fuel n d) := by
  induction fuel generalizing n with
  | zero =>
    have hz : n = 0 := Nat.eq_zero_of_le_zero bound
    subst n
    exact .retain 0 (Nat.zero_le d)
  | succ fuel ih =>
    if h : d < n then
      rw [removeOnes, ite_eq_left h]
      have smaller : n-d < n := Nat.sub_lt (Nat.lt_trans hd h) hd
      have nextBound : n-d ≤ fuel := Nat.le_of_lt_succ (Nat.lt_of_lt_of_le smaller bound)
      exact .step n _ h (ih (n-d) nextBound)
    else
      rw [removeOnes, ite_eq_right h]
      exact .retain n (Nat.le_of_not_gt h)

theorem castHasRemovalTrace (n d : Nat) (hd : 0 < d) :
    Removal d n (castNumerator n d) := removalTrace n n d hd (Nat.le_refl n)

theorem subtractPositive (n d : Nat) (h : d < n) : 0 < n-d := by
  induction d generalizing n with
  | zero => exact h
  | succ d ih =>
    cases n with
    | zero => exact False.elim (Nat.not_lt_zero _ h)
    | succ n =>
      rw [Nat.succ_sub_succ_eq_sub]
      exact ih n (Nat.lt_of_succ_lt_succ h)

theorem removalPreservesPositive {d n retained : Nat} (trace : Removal d n retained)
    (hn : 0 < n) : 0 < retained := by
  induction trace with
  | retain _ _ => exact hn
  | step n retained h _ ih => exact ih (subtractPositive n _ h)

theorem removalWithinOne {d n retained : Nat} (trace : Removal d n retained) :
    retained ≤ d := by
  induction trace with
  | retain _ h => exact h
  | step _ _ _ _ ih => exact ih

theorem removalUnique {d n a : Nat} (left : Removal d n a) :
    ∀ b, Removal d n b → a = b := by
  induction left with
  | retain n h =>
    intro b right
    cases right with
    | retain => rfl
    | step _ _ hlt _ => exact False.elim ((Nat.not_lt_of_ge h) hlt)
  | step n a h trace ih =>
    intro b right
    cases right with
    | retain _ hle => exact False.elim ((Nat.not_lt_of_ge hle) h)
    | step _ _ _ other => exact ih b other

theorem castPositive (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    0 < castNumerator n d :=
  removalPreservesPositive (castHasRemovalTrace n d hd) hn

theorem castWithinOne (n d : Nat) (hd : 0 < d) :
    castNumerator n d ≤ d := removalWithinOne (castHasRemovalTrace n d hd)

theorem castRetains (n d : Nat) (hd : 0 < d) (h : n ≤ d) :
    castNumerator n d = n :=
  removalUnique (castHasRemovalTrace n d hd) n (.retain n h)

theorem castRemoves (n d : Nat) (hd : 0 < d) (h : d < n) :
    castNumerator n d = castNumerator (n-d) d :=
  removalUnique (castHasRemovalTrace n d hd) _
    (.step n _ h (castHasRemovalTrace (n-d) d hd))

theorem fullTurnRetained (d : Nat) (hd : 0 < d) :
    castNumerator d d = d := castRetains d d hd (Nat.le_refl d)

theorem addSubtract (n d : Nat) : n+d-d = n := by
  induction d with
  | zero => rfl
  | succ d ih =>
    rw [Nat.add_succ, Nat.succ_sub_succ_eq_sub]
    exact ih

theorem castAddingOne (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    castNumerator (n+d) d = castNumerator n d := by
  have h : d < n+d := Nat.lt_add_of_pos_left hn
  rw [castRemoves (n+d) d hd h, addSubtract]

theorem completeTurnsRetainOne (k d : Nat) (hd : 0 < d) :
    castNumerator ((k+1)*d) d = d := by
  induction k with
  | zero =>
    rw [Nat.one_mul]
    exact fullTurnRetained d hd
  | succ k ih =>
    rw [Nat.succ_mul]
    rw [castAddingOne ((k+1)*d) d (Nat.mul_pos (Nat.zero_lt_succ k) hd) hd]
    exact ih

end SFT.Foundation.ExactCast
