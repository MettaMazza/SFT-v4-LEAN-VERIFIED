import SFT.Physics.NuclearBinding
namespace SFT.Physics.NuclearLevels
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar

structure Level (Trace : Type) where
  joint : MatterHadrons.Joint
  completeTrace : Trace
  name : String

def equivalent {Trace : Type} (a b : Level Trace) : Prop := a.completeTrace = b.completeTrace

def census {Trace : Type} [DecidableEq Trace] (levels : List (Level Trace)) :=
  MatterSpectrum.unique (levels.map Level.completeTrace)

theorem exactCensusMembership {Trace : Type} [DecidableEq Trace] (levels : List (Level Trace)) (trace : Trace) :
    trace ∈ census levels ↔ ∃ level ∈ levels, level.completeTrace = trace := by
  constructor
  · intro h
    exact SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ ((MatterSpectrum.uniqueMembership _ _).mp h)
  · intro h; obtain ⟨level,held,same⟩ := h
    apply (MatterSpectrum.uniqueMembership _ _).mpr
    rw [← same]
    exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem censusHasNoEquivalentDuplicates {Trace : Type} [DecidableEq Trace] (levels : List (Level Trace)) :
    MatterSpectrum.distinct (census levels) := MatterSpectrum.uniqueDistinct _

theorem nameDoesNotSelectClass {Trace : Type} (level : Level Trace) (name : String) :
    equivalent {level with name := name} level := rfl

def conversion {Trace Support State Clock : Type} (level : Level Trace)
    (limit : WaveSpeedRelation.SpatialRepeat Support State Clock) : MatterMassEnergy.Conversion Support State Clock :=
  ⟨level.joint.whole.word,level.joint.whole.inertial,limit,level.joint.totalCarriers⟩

def energy {Trace Support State Clock : Type} (level : Level Trace)
    (limit : WaveSpeedRelation.SpatialRepeat Support State Clock) := MatterMassEnergy.value (conversion level limit)

def difference {Trace Support State Clock : Type} (a b : Level Trace)
    (limit : WaveSpeedRelation.SpatialRepeat Support State Clock) :=
  subtract (.positive .forward (energy a limit)) (.positive .forward (energy b limit))

theorem emittedDifference {Trace Support State Clock : Type} (a b : Level Trace)
    (limit : WaveSpeedRelation.SpatialRepeat Support State Clock)
    (lower : rightCross (energy a limit) (energy b limit) < leftCross (energy a limit) (energy b limit)) :
    difference a b limit = .positive .forward (leftRemainder (energy a limit) (energy b limit) lower) :=
  opposedLeft _ _ _ _ lower

theorem absorbedDifference {Trace Support State Clock : Type} (a b : Level Trace)
    (limit : WaveSpeedRelation.SpatialRepeat Support State Clock)
    (higher : leftCross (energy a limit) (energy b limit) < rightCross (energy a limit) (energy b limit)) :
    difference a b limit = .positive .counter (rightRemainder (energy a limit) (energy b limit) higher) :=
  opposedRight _ _ _ _ higher

theorem emissionExactlyClosesCarriers {Trace Support State Clock : Type} (a b : Level Trace)
    (limit : WaveSpeedRelation.SpatialRepeat Support State Clock)
    (lower : rightCross (energy a limit) (energy b limit) < leftCross (energy a limit) (energy b limit)) :
    rightCross (energy a limit) (energy b limit) * (leftRemainder (energy a limit) (energy b limit) lower).denominator +
      (leftRemainder (energy a limit) (energy b limit) lower).numerator * denominator (energy a limit) (energy b limit) =
    leftCross (energy a limit) (energy b limit) * (leftRemainder (energy a limit) (energy b limit) lower).denominator :=
  leftRemainderReconstructs _ _ _

theorem unchangedLevelNoTransfer {Trace Support State Clock : Type} (level : Level Trace)
    (limit : WaveSpeedRelation.SpatialRepeat Support State Clock) : difference level level limit = .emptyOne := subtractSelf _

theorem finiteRecurrenceRetained {Trace : Type} (level : Level Trace) :
    SFT.QuantumComputation.ReversibleModel.phaseAction level.joint.whole.word.state level.joint.returnTrace = .ok level.joint.whole.word.state :=
  MatterHadrons.jointRecurrenceRetained level.joint
end SFT.Physics.NuclearLevels
