import SFT.Physics.FieldInduction
namespace SFT.Physics.FieldElectromagnetic
open MechanicalEvents

-- field_laws.py ELECTROMAGNETIC_COMPOSITION: both observations belong to one
-- source/propagation carrier. Separate labels cannot create independent sources.
structure Carrier (Part Support State ClockState Clock : Type) where
  electric : FieldElectricPotential.ElectricInteraction Part Support State ClockState Clock
  magnetic : FieldMagnetic.Response Support State ClockState
  commonSource : magnetic.transport.charge = electric.charge
  induction : FieldInduction.BoundaryWork Part Support State ClockState Clock
  commonMagnetic : induction.linked.after = magnetic

variable {Part Support State ClockState Clock : Type}

def electricProjection (c : Carrier Part Support State ClockState Clock) :=
  (c.electric,FieldElectricPotential.field c.electric,FieldElectricPotential.potentialDifference c.electric)

def magneticProjection (c : Carrier Part Support State ClockState Clock) :=
  (c.magnetic,FieldMagnetic.role c.magnetic,FieldMagnetic.held c.magnetic)

def propagation (c : Carrier Part Support State ClockState Clock) :=
  FieldInduction.boundaryTrace c.induction

theorem commonSourceRetained (c : Carrier Part Support State ClockState Clock) :
    (magneticProjection c).1.transport.charge = (electricProjection c).1.charge := c.commonSource

theorem linkedMagneticRetained (c : Carrier Part Support State ClockState Clock) :
    c.induction.linked.after = (magneticProjection c).1 := c.commonMagnetic

inductive Phase where
  | electricToMagnetic | magneticToElectric

def cycleRows {State : Type} (rows : List (Row State)) : List (Row State × Phase) :=
  match rows with
  | [] => []
  | r :: rs => (r,.electricToMagnetic) :: (r,.magneticToElectric) :: cycleRows rs

def electricLegs {State : Type} : List (Row State × Phase) → List (Row State)
  | [] => []
  | (r,.electricToMagnetic) :: rs => r :: electricLegs rs
  | (_, .magneticToElectric) :: rs => electricLegs rs

def magneticLegs {State : Type} : List (Row State × Phase) → List (Row State)
  | [] => []
  | (_, .electricToMagnetic) :: rs => magneticLegs rs
  | (r,.magneticToElectric) :: rs => r :: magneticLegs rs

theorem everyElectricLeg {State : Type} (rows : List (Row State)) :
    electricLegs (cycleRows rows) = rows := by
  induction rows with
  | nil => rfl
  | cons r rs ih => exact congrArg (List.cons r) ih

theorem everyMagneticLeg {State : Type} (rows : List (Row State)) :
    magneticLegs (cycleRows rows) = rows := by
  induction rows with
  | nil => rfl
  | cons r rs ih => exact congrArg (List.cons r) ih

theorem mutualTraceClosure {State : Type} (rows : List (Row State)) :
    electricLegs (cycleRows rows) = magneticLegs (cycleRows rows) :=
  (everyElectricLeg rows).trans (everyMagneticLeg rows).symm

theorem commonPropagation (c : Carrier Part Support State ClockState Clock) :
    electricLegs (cycleRows (propagation c)) = changes c.induction.boundary.recurrence.path ∧
    magneticLegs (cycleRows (propagation c)) = changes c.induction.boundary.recurrence.path :=
  ⟨(everyElectricLeg _).trans (FieldInduction.completeBoundary _),
   (everyMagneticLeg _).trans (FieldInduction.completeBoundary _)⟩

theorem completeCycleCount {State : Type} (rows : List (Row State)) :
    (cycleRows rows).length = rows.length + rows.length := by
  induction rows with
  | nil => rfl
  | cons r rs ih =>
    change (cycleRows rs).length + 1 + 1 = (rs.length + 1) + (rs.length + 1)
    rw [ih]
    exact (congrArg (fun n => n + 1) (Nat.add_right_comm rs.length rs.length 1)).trans
      (Nat.add_assoc (rs.length + 1) rs.length 1)

theorem changedElectricDistinguished (a b : Carrier Part Support State ClockState Clock)
    (h : a.electric ≠ b.electric) : a ≠ b := fun eq => h (congrArg Carrier.electric eq)

theorem changedMagneticDistinguished (a b : Carrier Part Support State ClockState Clock)
    (h : a.magnetic ≠ b.magnetic) : a ≠ b := fun eq => h (congrArg Carrier.magnetic eq)

theorem changingMagneticReturnsSameElectricSource (c : Carrier Part Support State ClockState Clock)
    (step : Row State) :
    (FieldInduction.electricResponse c.induction step).charge = c.electric.charge := by
  change c.induction.linked.after.transport.charge = c.electric.charge
  rw [c.commonMagnetic]
  exact c.commonSource

def transportedElectric (e : FieldElectricPotential.ElectricInteraction Part Support State ClockState Clock)
    (observation : SFT.Host.Canonical.Value) : FieldMagnetic.Response Support State ClockState :=
  ⟨⟨e.charge,(MechanicalForce.after e.work.force).velocity⟩,observation⟩

theorem electricTransportRetainsCharge (e : FieldElectricPotential.ElectricInteraction Part Support State ClockState Clock)
    (observation : SFT.Host.Canonical.Value) :
    (transportedElectric e observation).transport.charge = e.charge := rfl

theorem electricTransportRetainsMotion (e : FieldElectricPotential.ElectricInteraction Part Support State ClockState Clock)
    (observation : SFT.Host.Canonical.Value) :
    (transportedElectric e observation).transport.motion = (MechanicalForce.after e.work.force).velocity := rfl

theorem electricTransportIsTransverse (e : FieldElectricPotential.ElectricInteraction Part Support State ClockState Clock)
    (observation : SFT.Host.Canonical.Value) :
    FieldMagnetic.role (transportedElectric e observation) ≠ .alongMotion :=
  FieldMagnetic.transverseExcludesLongitudinal _

end SFT.Physics.FieldElectromagnetic
