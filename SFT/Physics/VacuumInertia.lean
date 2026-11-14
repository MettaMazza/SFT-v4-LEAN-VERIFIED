import SFT.Physics.VacuumSpectrum
import SFT.Physics.ElectroweakMixing
namespace SFT.Physics.VacuumInertia
open SFT.Foundation ExactPartCarrier ExactOperations HalfOneDerivation

-- vacuum_lineage_laws_v1.py:vacuum_inertia_exchange, in original call order.
def exchange : Except String PositiveFraction := do
 let coupling ← ElectroweakMixing.halfOne
 let displacement ← VacuumSpectrum.vacuumFloor
 let ratio := normalizePositive (displacement.numerator*coupling.denominator)
  (displacement.denominator*coupling.numerator)
  (Nat.mul_pos displacement.positive (denominatorPositive coupling))
  (Nat.mul_pos (denominatorPositive displacement) coupling.positive)
 if ratio.numerator==ratio.denominator then .ok ratio
 else .error "vacuum and inertia carriers did not close at the One"

theorem sourceAssembly : exchange=.ok (normalizePositive 1 1 (by decide) (by decide)) := by
 unfold exchange
 rw [ElectroweakMixing.nativeHalf,VacuumSpectrum.forcedVacuumFloor]
 rfl

theorem bothGeneratedCarriers : ElectroweakMixing.halfOne=.ok halfOne ∧
 VacuumSpectrum.vacuumFloor=.ok halfOne :=
 ⟨ElectroweakMixing.nativeHalf,VacuumSpectrum.forcedVacuumFloor⟩

theorem jointReturn : foldPart halfOne=one := VacuumSpectrum.floorReturns
-- Original induction_step: a changed pair preserves unity exactly when its
-- two rational carriers remain equal; the comparison is exact cross multiplication.
theorem changedCarrierClosure (displacement coupling : PositiveFraction) :
 let ratio := normalizePositive (displacement.numerator*coupling.denominator)
  (displacement.denominator*coupling.numerator)
  (Nat.mul_pos displacement.positive (Nat.pos_of_ne_zero coupling.denominatorNonzero))
  (Nat.mul_pos (Nat.pos_of_ne_zero displacement.denominatorNonzero) coupling.positive)
 (ratio.numerator=1 ∧ ratio.denominator=1) ↔
 displacement.numerator*coupling.denominator=displacement.denominator*coupling.numerator :=
 normalizationOneIff _ _ _ _

end SFT.Physics.VacuumInertia
