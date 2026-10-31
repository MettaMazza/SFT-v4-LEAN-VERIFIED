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
  joint : FieldElectromagnetic.Carrier Part Support State ClockState Clock
  energyFromJoint : energy = joint.electric.work
  momentumFromJoint : momentum = MechanicalForce.after joint.electric.work.force
  recurrenceFromJoint : recurrence = joint.induction.boundary.recurrence


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


def fromJoint (sourceIdentity : String)
    (joint : FieldElectromagnetic.Carrier Part Support State ClockState Clock)
    (polarization : MechanicalLocation.Held) : Carrier Part Support State ClockState Clock :=
  ⟨sourceIdentity,joint.electric.work,MechanicalForce.after joint.electric.work.force,
    joint.induction.boundary.recurrence,polarization,joint,rfl,rfl,rfl⟩

theorem energyUsesOriginalField (carrier : Carrier Part Support State ClockState Clock) :
    carrier.energy = carrier.joint.electric.work := carrier.energyFromJoint

theorem momentumUsesOriginalField (carrier : Carrier Part Support State ClockState Clock) :
    carrier.momentum = MechanicalForce.after carrier.joint.electric.work.force := carrier.momentumFromJoint

def recurrenceWord (carrier : Carrier Part Support State ClockState Clock) :=
  FieldElectromagnetic.cycleRows (changes carrier.recurrence.path)

theorem electricProjectionComplete (carrier : Carrier Part Support State ClockState Clock) :
    FieldElectromagnetic.electricLegs (recurrenceWord carrier) = changes carrier.recurrence.path :=
  FieldElectromagnetic.everyElectricLeg _

theorem magneticProjectionComplete (carrier : Carrier Part Support State ClockState Clock) :
    FieldElectromagnetic.magneticLegs (recurrenceWord carrier) = changes carrier.recurrence.path :=
  FieldElectromagnetic.everyMagneticLeg _

theorem commonFieldPropagation (carrier : Carrier Part Support State ClockState Clock) :
    changes carrier.recurrence.path = FieldElectromagnetic.propagation carrier.joint := by
  rw [carrier.recurrenceFromJoint]
  exact (FieldInduction.completeBoundary _).symm

def repeatedWord (carrier : Carrier Part Support State ClockState Clock) : Nat → List (Row State × FieldElectromagnetic.Phase)
  | 0 => []
  | n+1 => repeatedWord carrier n ++ recurrenceWord carrier

theorem recurrenceSuccessor (carrier : Carrier Part Support State ClockState Clock) (n : Nat) :
    repeatedWord carrier (n+1) = repeatedWord carrier n ++ recurrenceWord carrier := rfl

theorem allRecurrencesCount (carrier : Carrier Part Support State ClockState Clock) (n : Nat) :
    (repeatedWord carrier n).length = n * (recurrenceWord carrier).length := by
  induction n with
  | zero => exact (Nat.zero_mul _).symm
  | succ n ih =>
    change (repeatedWord carrier n ++ recurrenceWord carrier).length = _
    rw [MechanicalAngularMotion.appendLength,ih,Nat.succ_mul,Nat.add_comm]

theorem sourceUnchangedAfterDetachment (carrier : Carrier Part Support State ClockState Clock)
    (records : List SFT.Host.Canonical.Value) :
    (detached carrier records).map (fun obs => obs.carrier.sourceIdentity) =
      records.map (fun _ => carrier.sourceIdentity) := by
  induction records with
  | nil => rfl
  | cons r rs ih => exact congrArg (List.cons carrier.sourceIdentity) ih

end SFT.Physics.FieldRadiation
