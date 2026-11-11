import SFT.Physics.AlphaRatio
namespace SFT.Physics.AtomicBoundary
open SFT.Foundation SFT.Foundation.ExactOperations
open FoldFirstReturn BoundaryGrowth

-- Original greatest_whole_not_exceeding guards, in their source order.
def greatestWhole : Input → Except String Nat
 | .nonFraction => .error "ValueError: greatest-whole construction requires a positive ratio at least One"
 | .fraction value => match admitPositive value with
   | none => .error "ValueError: greatest-whole construction requires a positive ratio at least One"
   | some p =>
     if p.numerator < p.denominator then
       .error "ValueError: greatest-whole construction requires a positive ratio at least One"
     else
       let q := p.numerator / p.denominator
       if q < 1 then .error "ValueError: greatest whole must remain positive"
       else if q*p.denominator ≤ p.numerator ∧ p.numerator < (q+1)*p.denominator then .ok q
       else .error "ValueError: greatest-whole boundary failed to close"

theorem quotientLower (n d : Nat) (positive : 0<d) : (n/d)*d≤n := by
 have h := FractionReduction.remainderQuotient n d positive
 rw [Nat.mul_comm d] at h
 exact Nat.le_trans (Nat.le_add_left (n/d*d) (n%d)) (Nat.le_of_eq h)

theorem quotientUpper (n d : Nat) (positive : 0<d) : n<(n/d+1)*d := by
 have h := FractionReduction.remainderQuotient n d positive
 have bound := Nat.add_lt_add_right (Nat.mod_lt n positive) (d*(n/d))
 rw [h] at bound
 rw [Nat.mul_comm (n/d+1), Nat.mul_add, Nat.mul_one, Nat.add_comm]
 exact bound

theorem quotientPositive (n d : Nat) (positive : 0<d) (above : d≤n) : 0<n/d := by
 rw [FractionReduction.divisionRemoves n d positive above]
 exact Nat.zero_lt_succ _

theorem greatestWholeAdmitted (p : PositiveFraction) (above : p.denominator≤p.numerator) :
 greatestWhole (.fraction (asFraction p))=.ok (p.numerator/p.denominator) := by
 unfold greatestWhole
 dsimp only
 rw [positiveRoundTrip]
 dsimp only
 rw [ite_eq_right (Nat.not_lt_of_ge above)]
 have pd := Nat.pos_of_ne_zero p.denominatorNonzero
 rw [ite_eq_right (Nat.not_lt_of_ge (quotientPositive _ _ pd above))]
 rw [ite_eq_left ⟨quotientLower _ _ pd,quotientUpper _ _ pd⟩]

theorem greatestWholeBoundary (p : PositiveFraction) (below : p.numerator<p.denominator) :
 greatestWhole (.fraction (asFraction p))=
 .error "ValueError: greatest-whole construction requires a positive ratio at least One" := by
 unfold greatestWhole
 dsimp only
 rw [positiveRoundTrip]
 dsimp only
 rw [ite_eq_left below]

theorem everyLaterExcluded (n d k : Nat) (positive : 0<d) (later : n/d<k) : n<k*d :=
 Nat.lt_of_lt_of_le (quotientUpper n d positive) (Nat.mul_le_mul_right d later)

theorem greatestUnique (n d k : Nat) (positive : 0<d)
 (lower : k*d≤n) (upper : n<(k+1)*d) : k=n/d := by
 cases Nat.lt_trichotomy k (n/d) with
 | inl earlier =>
   have impossible := Nat.lt_of_lt_of_le upper (Nat.mul_le_mul_right d earlier)
   exact False.elim (Nat.not_lt_of_ge (quotientLower n d positive) impossible)
 | inr rest => cases rest with
   | inl same => exact same
   | inr later => exact False.elim (Nat.not_lt_of_ge lower (everyLaterExcluded n d k positive later))

def atomicEndpoint : Except String Nat := do
 let ratio ← AlphaRatio.inverseFineStructure none
 greatestWhole (.fraction (asFraction ratio))

theorem endpoint137 : atomicEndpoint=.ok 137 := rfl
theorem exactLower : 137*3676744786≤503846395469 := by decide
theorem exactUpper : 503846395469<138*3676744786 := by decide
theorem allLaterCoordinatesExcluded (k : Nat) (later : 137<k) :
 503846395469<k*3676744786 :=
 everyLaterExcluded 503846395469 3676744786 k (by decide) later

end SFT.Physics.AtomicBoundary
