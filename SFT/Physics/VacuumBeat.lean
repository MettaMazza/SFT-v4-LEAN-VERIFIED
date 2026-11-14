import SFT.Physics.VacuumSpectrum
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.VacuumBeat
open SFT.Foundation ExactPartCarrier ExactOperations
open LeptonIntervals

def positiveGap (larger smaller : FoldFirstReturn.Input) : Except String Rat :=
 match larger with
 | .nonFraction => .error "a Fold gap requires exact fractions"
 | .fraction larger => match smaller with
   | .nonFraction => .error "a Fold gap requires exact fractions"
   | .fraction smaller =>
     if zero.blt smaller && smaller.blt larger && !(asFraction one).blt larger then
      .ok (subtract larger smaller)
     else .error "a Fold gap requires ordered positive parts"

structure Transfer where
 vacuumBefore : Rat
 vacuumAfter : Rat
 localWork : Rat

def asymmetricBeat : Except String Transfer := do
 let before ← VacuumSpectrum.vacuumFloor
 let generator ← FoldFirstReturn.generatorPeriod
 let retained ← fromPair 1 (.ofNat generator)
 let extracted ← positiveGap (.fraction (asFraction before)) (.fraction (asFraction retained))
 let recomposed := add (asFraction retained) extracted
 if !recomposed.blt (asFraction before) && !(asFraction before).blt recomposed then
  .ok ⟨asFraction before,asFraction retained,extracted⟩
 else .error "the asymmetric beat did not conserve its source carrier"

theorem sourceAssembly : asymmetricBeat=.ok ⟨⟨1,2,by decide,by decide⟩,
 ⟨1,3,by decide,by decide⟩,⟨1,6,by decide,by decide⟩⟩ := by
 unfold asymmetricBeat
 rw [VacuumSpectrum.forcedVacuumFloor,FoldFirstReturn.generatorPeriodThree]
 rfl

theorem sourceRecomposition :
 add (⟨1,3,by decide,by decide⟩ : Rat) ⟨1,6,by decide,by decide⟩ =
 (⟨1,2,by decide,by decide⟩ : Rat) := rfl

theorem nonFractionLargerRejected (smaller : FoldFirstReturn.Input) :
 positiveGap .nonFraction smaller=.error "a Fold gap requires exact fractions" := by
 cases smaller <;> rfl

theorem nonFractionSmallerRejected (larger : FoldFirstReturn.Input) :
 positiveGap larger .nonFraction=.error "a Fold gap requires exact fractions" := by
 cases larger <;> rfl
theorem gapOnOriginalDomain (larger smaller : Rat)
 (accepted : (zero.blt smaller && smaller.blt larger && !(asFraction one).blt larger)=true) :
 positiveGap (.fraction larger) (.fraction smaller)=.ok (subtract larger smaller) := by
 unfold positiveGap
 dsimp only
 rw [accepted]
 rfl

theorem everyReturnedTransfer (t : Transfer) (returned : asymmetricBeat=.ok t) :
 t.vacuumBefore=(⟨1,2,by decide,by decide⟩ : Rat) ∧
 t.vacuumAfter=(⟨1,3,by decide,by decide⟩ : Rat) ∧
 t.localWork=(⟨1,6,by decide,by decide⟩ : Rat) ∧
 add t.vacuumAfter t.localWork=t.vacuumBefore := by
 rw [sourceAssembly] at returned
 cases returned
 exact ⟨rfl,rfl,rfl,sourceRecomposition⟩
end SFT.Physics.VacuumBeat
