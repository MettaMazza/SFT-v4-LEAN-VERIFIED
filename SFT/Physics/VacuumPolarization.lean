import SFT.Physics.VacuumSpectrum
namespace SFT.Physics.VacuumPolarization
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.HalfOneDerivation

-- vacuum_lineage_laws_v1.py: vacuum_polarization_support. The original
-- selection and Fold are performed before the ordered/end-point guards.
def support : Except String (Part × Part) := do
 let screened ← VacuumSpectrum.vacuumFloor
 let exposed := foldPart screened
 if screened.numerator * exposed.denominator < exposed.numerator * screened.denominator then
   if exposed.numerator == exposed.denominator then .ok (screened, exposed)
   else .error "vacuum exposure did not increase exact charge support"
 else .error "vacuum exposure did not increase exact charge support"

theorem selectedFloor : VacuumSpectrum.floorSurvivors = [halfOne] :=
 VacuumSpectrum.completeFloorSelection

theorem exactExposure : foldPart halfOne = one := VacuumSpectrum.floorReturns

theorem forcedSupport : support = .ok (halfOne, one) := by
 unfold support
 rw [VacuumSpectrum.forcedVacuumFloor]
 rfl

theorem direction : halfOne.numerator * one.denominator < one.numerator * halfOne.denominator := by decide

theorem screenedFields : halfOne.numerator = 1 ∧ halfOne.denominator = 2 := ⟨rfl,rfl⟩
theorem exposedFields : one.numerator = 1 ∧ one.denominator = 1 := ⟨rfl,rfl⟩

theorem anyReturnedSupport (screened exposed : Part)
 (returned : support = .ok (screened,exposed)) : screened = halfOne ∧ exposed = one := by
 rw [forcedSupport] at returned
 cases returned
 exact ⟨rfl,rfl⟩

theorem everyReturnedDirection (screened exposed : Part)
 (returned : support = .ok (screened,exposed)) :
 screened.numerator * exposed.denominator < exposed.numerator * screened.denominator := by
 obtain ⟨hs,he⟩ := anyReturnedSupport screened exposed returned
 rw [hs,he]
 exact direction
end SFT.Physics.VacuumPolarization
