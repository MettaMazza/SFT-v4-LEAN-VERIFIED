import SFT.Physics.ThermoHeatWork
namespace SFT.Physics.ThermoFirstLaw
open SFT.Mathematics.FoldScalar
variable {Node Part Support State ClockState Clock : Type}
abbrev EnergyRow (Node Part Support State ClockState Clock : Type) :=
  MechanicalConservation.Transfer Node (MechanicalWorkEnergy.EnergyTransfer Part Support State ClockState Clock)

def effect (inside : Node → Bool) (t : EnergyRow Node Part Support State ClockState Clock) : Scalar :=
  let energy := MechanicalWorkEnergy.energyChange t.carrier
  if inside t.source then
    if inside t.destination then subtract energy energy else reverse energy
  else if inside t.destination then energy else .emptyOne

def crossing (inside : Node → Bool) (t : EnergyRow Node Part Support State ClockState Clock) : Bool :=
  inside t.source != inside t.destination

def boundaryRows (inside : Node → Bool) (rows : List (EnergyRow Node Part Support State ClockState Clock)) :=
  rows.filter (crossing inside)

def compose (inside : Node → Bool) : List (EnergyRow Node Part Support State ClockState Clock) → Scalar
  | [] => .emptyOne
  | t :: rest => add (effect inside t) (compose inside rest)

theorem internalCancels (inside : Node → Bool) (t : EnergyRow Node Part Support State ClockState Clock)
    (hs : inside t.source = true) (hd : inside t.destination = true) : effect inside t = .emptyOne := by
  unfold effect
  rw [hs,hd]
  exact subtractSelf _

theorem incomingRetainsEnergy (inside : Node → Bool) (t : EnergyRow Node Part Support State ClockState Clock)
    (hs : inside t.source = false) (hd : inside t.destination = true) :
    effect inside t = MechanicalWorkEnergy.energyChange t.carrier := by
  unfold effect; rw [hs,hd]; rfl

theorem outgoingReversesHeldOrientation (inside : Node → Bool) (t : EnergyRow Node Part Support State ClockState Clock)
    (hs : inside t.source = true) (hd : inside t.destination = false) :
    effect inside t = reverse (MechanicalWorkEnergy.energyChange t.carrier) := by
  unfold effect; rw [hs,hd]; rfl

theorem outsideHasNoInternalChange (inside : Node → Bool) (t : EnergyRow Node Part Support State ClockState Clock)
    (hs : inside t.source = false) (hd : inside t.destination = false) : effect inside t = .emptyOne := by
  unfold effect; rw [hs,hd]; rfl

theorem noncrossingEmpty (inside : Node → Bool) (t : EnergyRow Node Part Support State ClockState Clock)
    (h : crossing inside t = false) : effect inside t = .emptyOne := by
  cases hs : inside t.source <;> cases hd : inside t.destination
  · exact outsideHasNoInternalChange inside t hs hd
  · unfold crossing at h; rw [hs,hd] at h; cases h
  · unfold crossing at h; rw [hs,hd] at h; cases h
  · exact internalCancels inside t hs hd

theorem completeBoundaryAccounting (inside : Node → Bool)
    (rows : List (EnergyRow Node Part Support State ClockState Clock)) :
    compose inside rows = compose inside (boundaryRows inside rows) := by
  induction rows with
  | nil => rfl
  | cons t rest ih =>
    change add (effect inside t) (compose inside rest) =
      compose inside (match crossing inside t with | true => t :: boundaryRows inside rest | false => boundaryRows inside rest)
    cases h : crossing inside t with
    | false => rw [noncrossingEmpty inside t h,addEmptyLeft]; exact ih
    | true => change add (effect inside t) (compose inside rest) = add (effect inside t) (compose inside (boundaryRows inside rest))
              exact congrArg (add (effect inside t)) ih

theorem sameEnergyNetworkSameBalance (inside : Node → Bool)
    (a b : ThermoHeatWork.ObservedTransfers Node (MechanicalWorkEnergy.EnergyTransfer Part Support State ClockState Clock))
    (same : a.network = b.network) : compose inside a.network = compose inside b.network :=
  congrArg (compose inside) same
end SFT.Physics.ThermoFirstLaw
