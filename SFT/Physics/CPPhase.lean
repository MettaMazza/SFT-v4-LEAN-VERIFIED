import SFT.Physics.ElectroweakMixing
import SFT.Mathematics.RiemannMirror
namespace SFT.Physics.CPPhase
open SFT.Foundation ExactPartCarrier ExactOperations HalfOneDerivation FoldUniformCheck

def phasePosition : Except String Part := do
 let value ← ElectroweakMixing.halfOne
 if !(samePart (foldPart value) one) then .error "the maximal phase carrier did not self-antipode"
 else match complement value with
 | .error _ => .error "the maximal phase carrier did not self-antipode"
 | .ok other => if samePart other value then .ok value else .error "the maximal phase carrier did not self-antipode"

theorem sourceAssembly : phasePosition=.ok halfOne := by
 unfold phasePosition;rw [ElectroweakMixing.nativeHalf];rfl

theorem exactReading : halfOne.numerator=1 ∧ halfOne.denominator=2 := ⟨rfl,rfl⟩
theorem returnsToOne : foldPart halfOne=one := halfFoldsToOne
theorem selfAntipodal : complement halfOne=.ok halfOne := complementHalf
theorem uniqueSelfAntipodal (p : Part) (fixed : complement p=.ok p) : p=halfOne :=
 SFT.Mathematics.RiemannMirror.uniqueFixedAxis p fixed
theorem everyOtherPartExcluded (p : Part) (different : p≠halfOne) : complement p≠.ok p :=
 SFT.Mathematics.RiemannMirror.nonHalfCannotBeFixed p different
end SFT.Physics.CPPhase
