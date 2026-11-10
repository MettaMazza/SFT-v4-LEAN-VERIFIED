import SFT.Physics.ThermoFirstLaw
namespace SFT.Physics.ThermoFirstLawBalance
open ThermoFirstLaw SFT.Mathematics.FoldScalar
variable {Node Part Support State ClockState Clock : Type}

def incoming (inside : Node → Bool) (t : EnergyRow Node Part Support State ClockState Clock) : Scalar :=
  if inside t.destination then MechanicalWorkEnergy.energyChange t.carrier else .emptyOne

def outgoing (inside : Node → Bool) (t : EnergyRow Node Part Support State ClockState Clock) : Scalar :=
  if inside t.source then MechanicalWorkEnergy.energyChange t.carrier else .emptyOne

theorem effectIsExactSourceDestinationDifference (inside : Node → Bool)
    (t : EnergyRow Node Part Support State ClockState Clock) :
    effect inside t = subtract (incoming inside t) (outgoing inside t) := by
  cases hs : inside t.source <;> cases hd : inside t.destination
  · unfold effect incoming outgoing; rw [hs,hd]; rfl
  · unfold effect incoming outgoing; rw [hs,hd]
    exact (subtractEmpty _).symm
  · unfold effect incoming outgoing; rw [hs,hd]
    exact (subtractFromEmpty _).symm
  · unfold effect incoming outgoing; rw [hs,hd]; rfl

end SFT.Physics.ThermoFirstLawBalance
