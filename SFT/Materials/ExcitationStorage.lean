import SFT.Physics.ThermoResponse
import SFT.Materials.MaterialCarrier
namespace SFT.Materials.ExcitationStorage
open SFT.Physics SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations

structure Record (C Part Support State ClockState Clock : Type) where
 material : MaterialCarrier.Record C
 transition : ThermoTemperature.Transition Part Support State ClockState Clock
 phaseIdentity : String
 conditions : SFT.Host.Canonical.Value
 temperatureWindow : SFT.Host.Canonical.Value

variable {C Part Support State ClockState Clock : Type}

def supplied (r : Record C Part Support State ClockState Clock) :=
 MechanicalWorkEnergy.energyChange r.transition.energy

def accessible (r : Record C Part Support State ClockState Clock) :=
 ThermoTemperature.accessibleChange r.transition

def response (r : Record C Part Support State ClockState Clock) :=
 ThermoTemperature.divideScalar (supplied r) (accessible r)

theorem originalThermalRelation (r : Record C Part Support State ClockState Clock) :
 response r = ThermoTemperature.thermalCarrier r.transition := rfl

theorem accessibleFromFullSupports (r : Record C Part Support State ClockState Clock) :
 accessible r = subtract
 (.positive .forward (ThermoTemperature.multiplicity r.transition.after))
 (.positive .forward (ThermoTemperature.multiplicity r.transition.before)) := rfl

theorem beforeCountExact (r : Record C Part Support State ClockState Clock) :
 r.transition.before.members.length * (ThermoTemperature.multiplicity r.transition.before).denominator =
 (ThermoTemperature.multiplicity r.transition.before).numerator * 1 :=
 ThermoTemperature.exactMultiplicity r.transition.before

theorem afterCountExact (r : Record C Part Support State ClockState Clock) :
 r.transition.after.members.length * (ThermoTemperature.multiplicity r.transition.after).denominator =
 (ThermoTemperature.multiplicity r.transition.after).numerator * 1 :=
 ThermoTemperature.exactMultiplicity r.transition.after

theorem everyEnergyInteraction (r : Record C Part Support State ClockState Clock) :
 (MechanicalWorkEnergy.interactionCells r.transition.energy).map Prod.fst =
 MechanicalEvents.changes r.transition.energy.force.interval :=
 ThermoTemperature.retainsAllEnergyInteractions r.transition

theorem unchangedSupportBoundary (r : Record C Part Support State ClockState Clock)
 (same : ThermoTemperature.multiplicity r.transition.after = ThermoTemperature.multiplicity r.transition.before) :
 response r = .error "division by structural empty-One is undefined" :=
 ThermoTemperature.unchangedMultiplicityBoundary r.transition same

theorem actualOrientedResponse (r : Record C Part Support State ClockState Clock)
 (a b : Orientation) (x y : PositiveFraction)
 (energy : supplied r = .positive a x) (excitation : accessible r = .positive b y) :
 response r = .ok (.positive (productOrientation a b) (quotientMagnitude x y)) := by
 unfold response
 rw [energy,excitation]
 rfl

theorem exactMagnitude (x y : PositiveFraction) :
 (x.numerator*y.denominator)*(quotientMagnitude x y).denominator =
 (quotientMagnitude x y).numerator*(x.denominator*y.numerator) :=
 ThermoTemperature.exactQuotientMagnitude x y

def record (r : Record C Part Support State ClockState Clock) :=
 (r,supplied r,accessible r,response r)

theorem originalRecordRetained (r : Record C Part Support State ClockState Clock) :
 (record r).1 = r := rfl

theorem phaseConditionsWindow (r : Record C Part Support State ClockState Clock) :
 (record r).1.phaseIdentity = r.phaseIdentity ∧
 (record r).1.conditions = r.conditions ∧
 (record r).1.temperatureWindow = r.temperatureWindow := ⟨rfl,rfl,rfl⟩

def records (rs : List (Record C Part Support State ClockState Clock)) := rs.map record

theorem base (r : Record C Part Support State ClockState Clock) : records [r] = [record r] := rfl

theorem successor (rs : List (Record C Part Support State ClockState Clock))
 (r : Record C Part Support State ClockState Clock) :
 records (rs ++ [r]) = records rs ++ [record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.ExcitationStorage
