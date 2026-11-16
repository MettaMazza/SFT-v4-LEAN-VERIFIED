import SFT.Physics.ThermalHistoryTransport
namespace SFT.Physics.ThermalHistoryThresholds
open ThermalHistory
set_option maxHeartbeats 100000000
-- Both proofs concern the actual insertion/sort operations, preserving every
-- supplied threshold occurrence before the source's distinctness guard.
theorem originalInsertionRetains (value : Rat) (xs : List Rat) :
 (insertDescending value xs).Perm (value::xs) := by
 induction xs with
 | nil => exact List.Perm.refl _
 | cons x xs ih =>
  unfold insertDescending
  split
  · exact List.Perm.refl _
  · exact List.Perm.trans (List.Perm.cons x ih) (List.Perm.swap value x xs)
theorem originalSortRetains (xs : List Rat) : (sortDescending xs).Perm xs := by
 induction xs with
 | nil => exact List.Perm.refl _
 | cons x xs ih =>
  exact List.Perm.trans (originalInsertionRetains x (sortDescending xs)) (List.Perm.cons x ih)
end SFT.Physics.ThermalHistoryThresholds
