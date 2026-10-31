import SFT.Physics.FieldLocality
namespace SFT.Physics.FieldRadiation
open MechanicalEvents

-- field_laws.py RADIATION retains the detached carrier's source, full energy,
-- momentum, recurrence and polarization. Contact and source provenance differ.
structure Carrier (Part Support State ClockState Clock : Type) where
  sourceIdentity : String
  energy : MechanicalWorkEnergy.EnergyTransfer Part Support State ClockState Clock
  momentum : MechanicalMomentum.Momentum Part Support State ClockState
  recurrence : MechanicalDuration.Recurrence State
  polarization : MechanicalLocation.Held

structure Observation (Carrier : Type) where
  carrier : Carrier
  localSourceContact : Option String
  record : SFT.Host.Canonical.Value

variable {Part Support State ClockState Clock : Type}

def detached (carrier : Carrier Part Support State ClockState Clock)
    (records : List SFT.Host.Canonical.Value) :=
  records.map (fun record => (⟨carrier,none,record⟩ : Observation _))

theorem retainsEveryObservation (carrier : Carrier Part Support State ClockState Clock)
    (records : List SFT.Host.Canonical.Value) :
    (detached carrier records).map Observation.record = records := by
  induction records with
  | nil => rfl
  | cons r rs ih => exact congrArg (List.cons r) ih

theorem sameCompleteCarrier (carrier : Carrier Part Support State ClockState Clock)
    (records : List SFT.Host.Canonical.Value) :
    (detached carrier records).map Observation.carrier = records.map (fun _ => carrier) := by
  induction records with
  | nil => rfl
  | cons r rs ih => exact congrArg (List.cons carrier) ih

theorem noContinuedLocalContact (carrier : Carrier Part Support State ClockState Clock)
    (records : List SFT.Host.Canonical.Value) :
    (detached carrier records).map Observation.localSourceContact = records.map (fun _ => none) := by
  induction records with
  | nil => rfl
  | cons r rs ih => exact congrArg (List.cons none) ih

theorem successorTransport (carrier : Carrier Part Support State ClockState Clock)
    (records : List SFT.Host.Canonical.Value) (record : SFT.Host.Canonical.Value) :
    detached carrier (records ++ [record]) = detached carrier records ++ [⟨carrier,none,record⟩] :=
  ReferenceRealization.mapAppendOne _ _ _

theorem fullEnergyMomentumRetained (carrier : Carrier Part Support State ClockState Clock)
    (records : List SFT.Host.Canonical.Value) :
    (detached carrier records).map (fun obs => (obs.carrier.energy,obs.carrier.momentum)) =
      records.map (fun _ => (carrier.energy,carrier.momentum)) := by
  induction records with
  | nil => rfl
  | cons r rs ih => exact congrArg (List.cons (carrier.energy,carrier.momentum)) ih

theorem fullPolarizationRetained (carrier : Carrier Part Support State ClockState Clock)
    (records : List SFT.Host.Canonical.Value) :
    (detached carrier records).map (fun obs => obs.carrier.polarization) =
      records.map (fun _ => carrier.polarization) := by
  induction records with
  | nil => rfl
  | cons r rs ih => exact congrArg (List.cons carrier.polarization) ih

theorem recurrenceReturns (carrier : Carrier Part Support State ClockState Clock) :
    carrier.recurrence.last.carrier = carrier.recurrence.first.carrier :=
  carrier.recurrence.returnsToCarrier

def frequency (carrier : Carrier Part Support State ClockState Clock)
    (reference : MechanicalDuration.Recurrence Clock) : SFT.Foundation.ExactOperations.PositiveFraction :=
  SFT.Mathematics.ExactRatioRelations.ratio (count reference.path) (count carrier.recurrence.path)
    reference.hasTransition carrier.recurrence.hasTransition

theorem frequencyPositive (carrier : Carrier Part Support State ClockState Clock)
    (reference : MechanicalDuration.Recurrence Clock) : 0 < (frequency carrier reference).numerator :=
  (frequency carrier reference).positive

theorem frequencyExact (carrier : Carrier Part Support State ClockState Clock)
    (reference : MechanicalDuration.Recurrence Clock) :
    count reference.path * (frequency carrier reference).denominator =
      (frequency carrier reference).numerator * count carrier.recurrence.path :=
  SFT.Foundation.ExactOperations.normalizedValuePreserved _ _ reference.hasTransition carrier.recurrence.hasTransition

end SFT.Physics.FieldRadiation
