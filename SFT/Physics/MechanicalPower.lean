import SFT.Physics.MechanicalWorkEnergy
namespace SFT.Physics.MechanicalPower
open SFT.Mathematics.FoldScalar SFT.Physics.MechanicalEvents

-- The energy transfer and its generated interaction interval remain one record.
abbrev Power := MechanicalWorkEnergy.EnergyTransfer

def duration {Part Support State ClockState Clock : Type}
    (p : Power Part Support State ClockState Clock) := MechanicalForce.duration p.force

def value {Part Support State ClockState Clock : Type}
    (p : Power Part Support State ClockState Clock) :=
  dividePositive (MechanicalWorkEnergy.energyChange p) (duration p)

theorem exactEnergyRate {Part Support State ClockState Clock : Type}
    (p : Power Part Support State ClockState Clock) :
    value p = dividePositive (MechanicalWorkEnergy.energyChange p)
      (MechanicalDuration.positiveRatio p.force.interval p.force.clock p.force.present) := rfl

theorem durationExact {Part Support State ClockState Clock : Type}
    (p : Power Part Support State ClockState Clock) :
    count p.force.interval * (duration p).denominator =
      (duration p).numerator * count p.force.clock.path := MechanicalForce.durationExact p.force

theorem positiveEnergyRate {Part Support State ClockState Clock : Type}
    (p : Power Part Support State ClockState Clock) (o : Orientation)
    (e : SFT.Foundation.ExactOperations.PositiveFraction)
    (energy : MechanicalWorkEnergy.energyChange p = .positive o e) :
    value p = .positive o (quotientMagnitude e (duration p)) := by
  unfold value
  rw [energy]
  rfl

theorem positiveRateExact {Part Support State ClockState Clock : Type}
    (p : Power Part Support State ClockState Clock)
    (e : SFT.Foundation.ExactOperations.PositiveFraction) :
    (e.numerator*(duration p).denominator)*(quotientMagnitude e (duration p)).denominator =
      (quotientMagnitude e (duration p)).numerator*(e.denominator*(duration p).numerator) :=
  quotientExact _ _

theorem absentEnergyIsEmpty {Part Support State ClockState Clock : Type}
    (p : Power Part Support State ClockState Clock)
    (empty : MechanicalWorkEnergy.energyChange p = .emptyOne) : value p = .emptyOne := by
  unfold value
  rw [empty]
  rfl

theorem retainsCompleteTransfer {Part Support State ClockState Clock : Type}
    (p : Power Part Support State ClockState Clock) :
    (MechanicalWorkEnergy.Work.mk p.force p.displacement : Power Part Support State ClockState Clock) = p := rfl

end SFT.Physics.MechanicalPower
