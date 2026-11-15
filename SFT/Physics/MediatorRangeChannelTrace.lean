import SFT.Physics.MediatorRangeChannel
namespace SFT.Physics.MediatorRangeChannelTrace
open MediatorRangeChannel
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Source while-loop relation on the exact common denominator.
inductive SourceTrace (mass : Nat) : Nat → List Nat → Prop where
 | stop (current : Nat) (boundary : current ≤ mass) : SourceTrace mass current [current]
 | step (current : Nat) (continues : mass < current) (tail : List Nat)
    (later : SourceTrace mass (current-mass) tail) : SourceTrace mass current (current::tail)
theorem loopMatchesSource (mass fuel current : Nat) (hm : 0<mass) (bound : current≤fuel) :
 SourceTrace mass current (forwardCountsLoop mass fuel current) := by
 induction fuel generalizing current with
 | zero => exact SourceTrace.stop current (Nat.le_trans bound (Nat.zero_le _))
 | succ fuel ih =>
  unfold forwardCountsLoop
  by_cases next : mass<current
  · rw [if_pos ⟨hm,next⟩]
    exact SourceTrace.step current next _ (ih (current-mass) (Nat.le_of_lt_succ (Nat.lt_of_lt_of_le (Nat.sub_lt (Nat.lt_trans hm next) hm) bound)))
  · rw [if_neg (fun h => next h.2)]
    exact SourceTrace.stop current (Nat.le_of_not_gt next)
theorem generatedBoundRetainsEntireTrace (mass current : Nat) (hm : 0<mass) :
 SourceTrace mass current (forwardCounts mass current) :=
 loopMatchesSource mass current current hm (Nat.le_refl _)
theorem everyRetainedCarrierPositive (mass current : Nat) (hm : 0<mass) (hc : 0<current)
 (xs : List Nat) (trace : SourceTrace mass current xs) : ∀ x, x ∈ xs → 0<x := by
 induction trace with
 | stop current boundary =>
  intro x hx
  cases hx with
  | head => exact hc
  | tail _ hx => cases hx
 | step current next tail later ih =>
  intro x hx
  cases hx with
  | head => exact hc
  | tail _ hx => exact ih (SFT.Foundation.ExactCast.subtractPositive current mass next) x hx
-- Reciprocal scale reuses the existing arbitrary-positive-mass derivation.
theorem originalEveryPositiveRange (n d : Nat) (hn : 0<n) (hd : 0<d) :
 reciprocalRangeScale (.fraction (VacuumLedgerProofs.natRatio n d hd)) =
 .ok (VacuumLedgerProofs.natRatio d n hn) := by
 unfold reciprocalRangeScale
 rw [NuclearResidualForceProofs.everyPositiveRange n d hn hd]
 rfl
end SFT.Physics.MediatorRangeChannelTrace
