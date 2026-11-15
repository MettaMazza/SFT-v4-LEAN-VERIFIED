import SFT.Physics.CompositeConfiningReturn
import SFT.Physics.CompositeConfiningOrbits
import SFT.Mathematics.GeometryTopology
namespace SFT.Physics.CompositeConfiningDerivation
open SFT.Physics.CompositeConfining SFT.Physics.GeneratorOperations
open SFT.Mathematics.OrbitTilingCount
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- Bind the source support guard to the exact generated positive-label list. -/
theorem originalStandingLabels (sector : CountInput) (d : Nat)
 (held : heldDenominator sector=.ok d) : standingModeLabels sector=.ok (positiveRanks d) := by
 unfold standingModeLabels
 rw [held]
 rfl
/-- The guarded original operation implements the proved double-and-cast action. -/
theorem originalFoldOperation (sector label : CountInput) (d k : Nat)
 (held : heldDenominator sector=.ok d) (value : labelInteger label=Int.ofNat k)
 (positive : 0<d) (odd : d%2=1) (kp : 0<k) (kb : k<d) :
 foldModeLabel label sector=.ok ((k+k)%d) := by
 have member := (positiveRankMember d k positive).mpr ⟨kp,kb⟩
 have present : (positiveRanks d).any (fun n => Int.ofNat n=labelInteger label)=true := by
  apply (SFT.Mathematics.GeometryTopology.anyTrueIff _ _).mpr
  exact ⟨k,member,decide_eq_true value.symm⟩
 have confined := originalFoldConfined d k positive odd kp kb
 unfold foldModeLabel
 rw [held,originalStandingLabels sector d held]
 change (if (!((positiveRanks d).any (fun n => Int.ofNat n=labelInteger label))) = true then
   Except.error "Fold mode label lies outside the complete standing support"
  else if ((labelInteger label).toNat+(labelInteger label).toNat)%d<1 then
   Except.error "odd predecessor support cannot Fold a nonempty mode to an empty label"
  else Except.ok (((labelInteger label).toNat+(labelInteger label).toNat)%d)) = Except.ok ((k+k)%d)
 rw [present]
 change (if ((labelInteger label).toNat+(labelInteger label).toNat)%d<1 then Except.error "odd predecessor support cannot Fold a nonempty mode to an empty label" else Except.ok (((labelInteger label).toNat+(labelInteger label).toNat)%d))=Except.ok ((k+k)%d)
 rw [value]
 change (if (k+k)%d<1 then Except.error "odd predecessor support cannot Fold a nonempty mode to an empty label" else Except.ok ((k+k)%d))=Except.ok ((k+k)%d)
 rw [ite_eq_right (Nat.not_lt_of_ge confined.1)]
end SFT.Physics.CompositeConfiningDerivation
