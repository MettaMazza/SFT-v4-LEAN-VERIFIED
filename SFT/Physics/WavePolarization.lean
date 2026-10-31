import SFT.Physics.WaveDiffraction
namespace SFT.Physics.WavePolarization

structure Polarized (Part Support State ClockState Clock : Type) where
  carrier : FieldRadiation.Carrier Part Support State ClockState Clock

variable {Part Support State ClockState Clock : Type}

def reverse (p : Polarized Part Support State ClockState Clock) : Polarized Part Support State ClockState Clock :=
  ⟨{p.carrier with polarization := MechanicalLocation.opposite p.carrier.polarization}⟩

theorem oppositeTwice (p : Polarized Part Support State ClockState Clock) : reverse (reverse p) = p := by
  cases p with
  | mk c => cases c with
    | mk source energy momentum recurrence held joint he hm hr => cases held <;> rfl

theorem orientationChanges (p : Polarized Part Support State ClockState Clock) :
    (reverse p).carrier.polarization ≠ p.carrier.polarization := by
  change MechanicalLocation.opposite p.carrier.polarization ≠ p.carrier.polarization
  cases p.carrier.polarization <;> intro eq <;> cases eq

theorem positiveCarrierUnchanged (p : Polarized Part Support State ClockState Clock) :
    (reverse p).carrier.energy = p.carrier.energy ∧ (reverse p).carrier.momentum = p.carrier.momentum := ⟨rfl,rfl⟩

theorem recurrenceUnchanged (p : Polarized Part Support State ClockState Clock) :
    (reverse p).carrier.recurrence = p.carrier.recurrence := rfl

theorem frequencyUnchanged (p : Polarized Part Support State ClockState Clock)
    (reference : MechanicalDuration.Recurrence Clock) :
    FieldRadiation.frequency (reverse p).carrier reference = FieldRadiation.frequency p.carrier reference := rfl

theorem transverseRoleUnchanged (p : Polarized Part Support State ClockState Clock) :
    FieldMagnetic.role (reverse p).carrier.joint.magnetic = FieldMagnetic.role p.carrier.joint.magnetic := rfl

theorem twoHeldOrientations (p : Polarized Part Support State ClockState Clock) :
    p.carrier.polarization = .first ∨ p.carrier.polarization = .second := by
  cases h : p.carrier.polarization
  · exact Or.inl rfl
  · exact Or.inr rfl
end SFT.Physics.WavePolarization
