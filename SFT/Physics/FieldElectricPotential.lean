import SFT.Physics.FieldElectricDistinction
namespace SFT.Physics.FieldElectricPotential
open SFT.Mathematics.FoldScalar

structure ElectricInteraction (Part Support State ClockState Clock : Type) where
  charge : FieldElectricDistinction.Charge
  work : MechanicalWorkEnergy.EnergyTransfer Part Support State ClockState Clock

-- Pinned values.py divide_scalar = multiply_scalar(left, reciprocal_scalar(right)).
-- The held charge orientation is retained by its reciprocal.
def normalizeCharge (x : Scalar) (charge : FieldElectricDistinction.Charge) : Scalar :=
  multiply x (.positive (MechanicalAcceleration.scalarOrientation charge.held)
    (SFT.Mathematics.ExactRatioRelations.reciprocal charge.amount))

theorem normalizationPositive (o : Orientation) (x : SFT.Foundation.ExactOperations.PositiveFraction)
    (charge : FieldElectricDistinction.Charge) :
    normalizeCharge (.positive o x) charge =
      .positive (productOrientation o (MechanicalAcceleration.scalarOrientation charge.held))
        (quotientMagnitude x charge.amount) := rfl

theorem reversedChargeReversesResponse (x : Scalar) (charge : FieldElectricDistinction.Charge) :
    normalizeCharge x (FieldElectricDistinction.reverse charge) = reverse (normalizeCharge x charge) := by
  cases x with
  | emptyOne => rfl
  | positive o m =>
    cases charge with
    | mk amount held => cases o <;> cases held <;> rfl

def field {Part Support State ClockState Clock : Type}
    (e : ElectricInteraction Part Support State ClockState Clock) :=
  normalizeCharge (MechanicalForce.value e.work.force) e.charge

def potentialDifference {Part Support State ClockState Clock : Type}
    (e : ElectricInteraction Part Support State ClockState Clock) :=
  normalizeCharge (MechanicalWorkEnergy.energyChange e.work) e.charge

theorem exactField {Part Support State ClockState Clock : Type}
    (e : ElectricInteraction Part Support State ClockState Clock) :
    field e = normalizeCharge (MechanicalForce.value e.work.force) e.charge := rfl

theorem exactPotential {Part Support State ClockState Clock : Type}
    (e : ElectricInteraction Part Support State ClockState Clock) :
    potentialDifference e = normalizeCharge
      (multiply (MechanicalForce.value e.work.force)
        (MechanicalWorkEnergy.displacementScalar e.work.displacement)) e.charge := rfl

theorem normalizationExact {Part Support State ClockState Clock : Type}
    (e : ElectricInteraction Part Support State ClockState Clock)
    (x : SFT.Foundation.ExactOperations.PositiveFraction) :
    (x.numerator*e.charge.amount.denominator)*(quotientMagnitude x e.charge.amount).denominator =
      (quotientMagnitude x e.charge.amount).numerator*(x.denominator*e.charge.amount.numerator) := quotientExact _ _

def endpoints {Part Support State ClockState Clock : Type}
    (e : ElectricInteraction Part Support State ClockState Clock) :=
  (e.work.displacement.first,e.work.displacement.second)

theorem changedEndpointsDistinguished {Part Support State ClockState Clock : Type}
    (a b : ElectricInteraction Part Support State ClockState Clock) (h : endpoints a ≠ endpoints b) : a ≠ b :=
  fun same => h (congrArg endpoints same)

theorem fullInteractionRetained {Part Support State ClockState Clock : Type}
    (e : ElectricInteraction Part Support State ClockState Clock) :
    (ElectricInteraction.mk e.charge e.work : ElectricInteraction Part Support State ClockState Clock) = e := rfl

theorem absentForceIsEmpty {Part Support State ClockState Clock : Type}
    (e : ElectricInteraction Part Support State ClockState Clock) (absent : MechanicalForce.value e.work.force = .emptyOne) :
    field e = .emptyOne := by unfold field; rw [absent]; rfl

theorem absentWorkIsEmpty {Part Support State ClockState Clock : Type}
    (e : ElectricInteraction Part Support State ClockState Clock) (absent : MechanicalWorkEnergy.energyChange e.work = .emptyOne) :
    potentialDifference e = .emptyOne := by unfold potentialDifference; rw [absent]; rfl

theorem changedChargeDistinguished {Part Support State ClockState Clock : Type}
    (a b : ElectricInteraction Part Support State ClockState Clock) (h : a.charge ≠ b.charge) : a ≠ b :=
  fun same => h (congrArg ElectricInteraction.charge same)

theorem changedWorkDistinguished {Part Support State ClockState Clock : Type}
    (a b : ElectricInteraction Part Support State ClockState Clock) (h : a.work ≠ b.work) : a ≠ b :=
  fun same => h (congrArg ElectricInteraction.work same)

-- A common generated reference replication multiplies both normalized
-- comparison counts. Its cancellation does not depend on their values.
theorem referenceReplicationIndependent (k n d : Nat) (hk : 0 < k) (hn : 0 < n) (hd : 0 < d) :
    SFT.Foundation.ExactOperations.normalizePositive (k*n) (k*d) (Nat.mul_pos hk hn) (Nat.mul_pos hk hd) =
      SFT.Foundation.ExactOperations.normalizePositive n d hn hd :=
  FieldGeometricDilution.commonCountScaleCancels k n d hk hn hd

end SFT.Physics.FieldElectricPotential
