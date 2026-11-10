import SFT.Physics.ThermoMicroMacro
import SFT.Physics.MechanicalWorkEnergy
namespace SFT.Physics.ThermoTemperature
open SFT.InformationScience EntropyPartition EntropyLedger
open SFT.Mathematics.FoldScalar
open SFT.Foundation.ExactOperations

-- The complete macro-observation supplied by the preceding source entry.
structure Macrostate where
  support : List String
  observation : SFT.Mathematics.ProbabilityObservations.Observation
  partition : Partition
  computed : exactPartition support observation = .ok partition
  label : String
  members : List String
  present : (label,members) ∈ partition

def multiplicity (s : Macrostate) : PositiveFraction :=
  normalizePositive s.members.length 1
    (membersPositive s.support s.observation s.partition s.computed (s.label,s.members) s.present)
    (Nat.zero_lt_succ 0)

-- values.py reciprocal_scalar and divide_scalar, with the exact source halt.
def reciprocalScalar : Scalar → Except String Scalar
  | .emptyOne => .error "division by structural empty-One is undefined"
  | .positive held value => .ok (.positive held (SFT.Mathematics.ExactRatioRelations.reciprocal value))

def divideScalar (left right : Scalar) : Except String Scalar :=
  match reciprocalScalar right with
  | .error e => .error e
  | .ok reciprocal => .ok (multiply left reciprocal)

structure Transition (Part Support State ClockState Clock : Type) where
  before : Macrostate
  after : Macrostate
  energy : MechanicalWorkEnergy.EnergyTransfer Part Support State ClockState Clock

variable {Part Support State ClockState Clock : Type}

def accessibleChange (t : Transition Part Support State ClockState Clock) : Scalar :=
  subtract (.positive .forward (multiplicity t.after)) (.positive .forward (multiplicity t.before))

def thermalCarrier (t : Transition Part Support State ClockState Clock) : Except String Scalar :=
  divideScalar (MechanicalWorkEnergy.energyChange t.energy) (accessibleChange t)

def relativeCarrier (t reference : Transition Part Support State ClockState Clock) : Except String Scalar :=
  match thermalCarrier t with
  | .error e => .error e
  | .ok value => match thermalCarrier reference with
    | .error e => .error e
    | .ok held => divideScalar value held

theorem exactMultiplicity (s : Macrostate) :
    s.members.length * (multiplicity s).denominator = (multiplicity s).numerator * 1 :=
  normalizedValuePreserved _ _ _ _

theorem denominatorEmptyRejected (value : Scalar) :
    divideScalar value .emptyOne = .error "division by structural empty-One is undefined" := rfl

theorem emptyEnergyRetained (held : Orientation) (value : PositiveFraction) :
    divideScalar .emptyOne (.positive held value) = .ok .emptyOne := rfl

theorem exactOrientedQuotient (a b : Orientation) (x y : PositiveFraction) :
    divideScalar (.positive a x) (.positive b y) =
      .ok (.positive (productOrientation a b) (quotientMagnitude x y)) := rfl

theorem exactQuotientMagnitude (x y : PositiveFraction) :
    (x.numerator*y.denominator)*(quotientMagnitude x y).denominator =
      (quotientMagnitude x y).numerator*(x.denominator*y.numerator) := quotientExact x y

theorem noMultiplicityChange (t : Transition Part Support State ClockState Clock)
    (same : multiplicity t.after = multiplicity t.before) : accessibleChange t = .emptyOne := by
  unfold accessibleChange
  rw [same]
  exact subtractSelf _

theorem unchangedMultiplicityBoundary (t : Transition Part Support State ClockState Clock)
    (same : multiplicity t.after = multiplicity t.before) :
    thermalCarrier t = .error "division by structural empty-One is undefined" := by
  unfold thermalCarrier
  rw [noMultiplicityChange t same]
  rfl

theorem exactReferenceReading (t reference : Transition Part Support State ClockState Clock)
    (value held : Scalar) (hv : thermalCarrier t = .ok value) (hr : thermalCarrier reference = .ok held) :
    relativeCarrier t reference = divideScalar value held := by
  unfold relativeCarrier
  rw [hv,hr]

theorem fullMicrostateProvenance (t : Transition Part Support State ClockState Clock) :
    (Transition.mk t.before t.after t.energy : Transition Part Support State ClockState Clock) = t := rfl

theorem retainsAllEnergyInteractions (t : Transition Part Support State ClockState Clock) :
    (MechanicalWorkEnergy.interactionCells t.energy).map Prod.fst = MechanicalEvents.changes t.energy.force.interval :=
  MechanicalWorkEnergy.retainsEveryTransferRow t.energy
end SFT.Physics.ThermoTemperature
