import SFT.Physics.VacuumInertia
namespace SFT.Physics.VacuumInertiaWitnesses
open SFT.Foundation ExactOperations HalfOneDerivation
structure Witness where
 name : String
 statement : String
 passed : Bool
def exchangeCheck : Bool := match VacuumInertia.exchange with
 | .ok q => q.numerator==1 && q.denominator==1
 | .error _ => false
def jointReturnCheck : Bool := match ElectroweakMixing.halfOne with
 | .error _ => false
 | .ok coupling => match VacuumSpectrum.vacuumFloor with
   | .error _ => false
   | .ok displacement =>
    let a := foldPart coupling
    let b := foldPart displacement
    a.numerator==a.denominator && b.numerator==b.denominator
def witnesses : List Witness := [⟨"exchange","The exact vacuum/inertia exchange closes at the One.",exchangeCheck⟩,⟨"joint-return","Both carriers complete in the same single Fold.",jointReturnCheck⟩]
theorem exchangeCheckPassed : exchangeCheck=true := by
 unfold exchangeCheck
 rw [VacuumInertia.sourceAssembly]
 rfl
theorem jointReturnCheckPassed : jointReturnCheck=true := by
 unfold jointReturnCheck
 rw [ElectroweakMixing.nativeHalf,VacuumSpectrum.forcedVacuumFloor]
 rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (exchangeCheck && jointReturnCheck && true)=true
 rw [exchangeCheckPassed,jointReturnCheckPassed]
 rfl
end SFT.Physics.VacuumInertiaWitnesses
