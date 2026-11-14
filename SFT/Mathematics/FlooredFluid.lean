import SFT.Mathematics.FiniteRefinement
import SFT.Mathematics.ExactRatioRelations
namespace SFT.Mathematics.FlooredFluid
open SFT.Foundation.ExactOperations SFT.Foundation.ExactPartCarrier
open SFT.Foundation.FractionReduction

-- FLOORED_FLUID: binary Fold count is the existing generated rung construction.
def floor (depth : Nat) : Part := FiniteRefinement.rung depth
def bound (depth : Nat) : Nat := 2^depth

theorem floorValue (depth : Nat) :
 (floor depth).denominator=(floor depth).numerator*bound depth := by
 unfold floor bound
 rw [FiniteRefinement.dyadicRepresentation]
 have h := normalizedValuePreserved 1 (2^depth) (by decide) (Nat.pow_pos (by decide))
 rw [Nat.one_mul] at h
 exact h

theorem floorPositive (depth : Nat) : 0<(floor depth).numerator := (floor depth).positive

theorem boundSuccessor (depth : Nat) : bound (depth+1)=bound depth*2 := Nat.pow_succ _ _

theorem baseBound : bound 1=2 := rfl

theorem depthFiveBound : bound 5=32 := rfl

-- Each generated edge retains its endpoints, exact positive spacing and
-- original One-bounded positive velocity separation.
structure Edge (depth : Nat) where
 source : Nat
 destination : Nat
 spacing : PositiveFraction
 gap : Part
 minimum : spacing.denominator ≤ spacing.numerator*bound depth

def gradient {depth : Nat} (e : Edge depth) : PositiveFraction :=
 normalizePositive (e.gap.numerator*e.spacing.denominator)
  (e.gap.denominator*e.spacing.numerator)
  (Nat.mul_pos e.gap.positive (Nat.pos_of_ne_zero e.spacing.denominatorNonzero))
  (Nat.mul_pos (Nat.lt_of_lt_of_le e.gap.positive e.gap.throughOne) e.spacing.positive)

theorem gradientValue {depth : Nat} (e : Edge depth) :
 (e.gap.numerator*e.spacing.denominator)*(gradient e).denominator=
 (gradient e).numerator*(e.gap.denominator*e.spacing.numerator) :=
 normalizedValuePreserved _ _ _ _

theorem gradientBound {depth : Nat} (e : Edge depth) :
 (gradient e).numerator ≤ bound depth*(gradient e).denominator := by
 have raw : e.gap.numerator*e.spacing.denominator ≤
   bound depth*(e.gap.denominator*e.spacing.numerator) := by
   calc
     e.gap.numerator*e.spacing.denominator ≤ e.gap.denominator*e.spacing.denominator :=
       Nat.mul_le_mul_right _ e.gap.throughOne
     _ ≤ e.gap.denominator*(e.spacing.numerator*bound depth) := Nat.mul_le_mul_left _ e.minimum
     _ = bound depth*(e.gap.denominator*e.spacing.numerator) := by
       rw [← mulAssoc,Nat.mul_comm _ (bound depth)]
 have product := Nat.mul_le_mul_right (gradient e).denominator raw
 rw [gradientValue] at product
 have ordered : (gradient e).numerator*(e.gap.denominator*e.spacing.numerator) ≤
  (bound depth*(gradient e).denominator)*(e.gap.denominator*e.spacing.numerator) := by
   have h : bound depth*(e.gap.denominator*e.spacing.numerator)*(gradient e).denominator =
     (bound depth*(gradient e).denominator)*(e.gap.denominator*e.spacing.numerator) := by
     rw [mulAssoc,Nat.mul_comm (e.gap.denominator*e.spacing.numerator),← mulAssoc]
   rw [h] at product
   exact product
 exact Nat.le_of_mul_le_mul_right ordered (Nat.mul_pos
   (Nat.lt_of_lt_of_le e.gap.positive e.gap.throughOne) e.spacing.positive)

def minimumEdge (depth : Nat) (source destination : Nat) : Edge depth where
 source := source
 destination := destination
 spacing := normalizePositive 1 (bound depth) (by decide) (Nat.pow_pos (by decide))
 gap := one
 minimum := by
   have h := normalizedValuePreserved 1 (bound depth) (by decide) (Nat.pow_pos (by decide))
   rw [Nat.one_mul] at h
   exact Nat.le_of_eq h

theorem boundAttained (depth source destination : Nat) :
 (gradient (minimumEdge depth source destination)).numerator=
 bound depth*(gradient (minimumEdge depth source destination)).denominator := by
 let spacing := normalizePositive 1 (bound depth) (by decide) (Nat.pow_pos (by decide))
 let g := gradient (minimumEdge depth source destination)
 have h := gradientValue (minimumEdge depth source destination)
 change (1*spacing.denominator)*g.denominator=g.numerator*(1*spacing.numerator) at h
 rw [Nat.one_mul,Nat.one_mul] at h
 have f := normalizedValuePreserved 1 (bound depth) (by decide) (Nat.pow_pos (by decide))
 rw [Nat.one_mul] at f
 change spacing.denominator=spacing.numerator*bound depth at f
 rw [f] at h
 apply ExactRatioRelations.cancelPositive spacing.numerator _ _ spacing.positive
 calc
   spacing.numerator*g.numerator = g.numerator*spacing.numerator := Nat.mul_comm _ _
   _ = (spacing.numerator*bound depth)*g.denominator := h.symm
   _ = spacing.numerator*(bound depth*g.denominator) := mulAssoc _ _ _

theorem everyEdgeBounded {depth : Nat} (edges : List (Edge depth)) :
 ∀ e, e ∈ edges → (gradient e).numerator ≤ bound depth*(gradient e).denominator :=
 fun e _ => gradientBound e

-- Source and destination identities are retained in each transport record.
structure Transfer where
 source : Nat
 destination : Nat
 amount : PositiveFraction

def transportLedger (ts : List Transfer) : List (Nat × Nat × PositiveFraction) :=
 ts.map (fun t => (t.source,t.destination,t.amount))

theorem ledgerRetainsTransfer (ts : List Transfer) (t : Transfer) (member : t ∈ ts) :
 (t.source,t.destination,t.amount) ∈ transportLedger ts :=
 SFT.Foundation.Count.TraceDerivation.memMap _ _ _ member

end SFT.Mathematics.FlooredFluid
