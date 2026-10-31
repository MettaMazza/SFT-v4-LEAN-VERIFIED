import SFT.Physics.MatterMixing
namespace SFT.Physics.NuclearBinding
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar

structure Composition (Support State Clock : Type) where
  bound : MatterHadrons.Joint
  separated : PositiveFraction
  releasedPositive : rightCross separated bound.whole.inertial < leftCross separated bound.whole.inertial
  limit : WaveSpeedRelation.SpatialRepeat Support State Clock
  destination : String
  sourceTrace : List SFT.Host.Canonical.Value

variable {Support State Clock : Type}

def reduction (c : Composition Support State Clock) := leftRemainder c.separated c.bound.whole.inertial c.releasedPositive

def conversion (c : Composition Support State Clock) : MatterMassEnergy.Conversion Support State Clock :=
  ⟨c.bound.whole.word,reduction c,c.limit,c.sourceTrace⟩

def releasedEnergy (c : Composition Support State Clock) := MatterMassEnergy.value (conversion c)

def releasedRecord (c : Composition Support State Clock) := (c.destination,releasedEnergy c,c.sourceTrace)

theorem exactPositiveReduction (c : Composition Support State Clock) :
    (leftCross c.separated c.bound.whole.inertial - rightCross c.separated c.bound.whole.inertial) * (reduction c).denominator =
      (reduction c).numerator * denominator c.separated c.bound.whole.inertial :=
  leftRemainderExact _ _ _

theorem completeMassBalance (c : Composition Support State Clock) :
    leftCross c.separated c.bound.whole.inertial * (reduction c).denominator =
      (reduction c).numerator * denominator c.separated c.bound.whole.inertial +
        rightCross c.separated c.bound.whole.inertial * (reduction c).denominator := by
  exact (leftRemainderReconstructs c.separated c.bound.whole.inertial c.releasedPositive).symm.trans (Nat.add_comm _ _)

theorem reductionStrictlyPositive (c : Composition Support State Clock) : 0 < (reduction c).numerator := (reduction c).positive

theorem uniqueReduction (c : Composition Support State Clock) (candidate : PositiveFraction)
    (exactValue : (leftCross c.separated c.bound.whole.inertial - rightCross c.separated c.bound.whole.inertial) * candidate.denominator =
      candidate.numerator * denominator c.separated c.bound.whole.inertial) : candidate = reduction c := by
  have hn := SFT.Foundation.ExactCast.subtractPositive _ _ c.releasedPositive
  have hd := denominatorPositive c.separated c.bound.whole.inertial
  exact (FieldGeometricDilution.positiveNormalizationRepresents _ _ hn hd candidate exactValue).symm.trans
    (FieldGeometricDilution.positiveNormalizationRepresents _ _ hn hd (reduction c) (exactPositiveReduction c))

theorem exactReleasedEnergy (c : Composition Support State Clock) :
    ((reduction c).numerator * ((WaveSpeedRelation.speed c.limit).numerator * (WaveSpeedRelation.speed c.limit).numerator)) *
      (releasedEnergy c).denominator = (releasedEnergy c).numerator *
    ((reduction c).denominator * ((WaveSpeedRelation.speed c.limit).denominator * (WaveSpeedRelation.speed c.limit).denominator)) :=
  MatterMassEnergy.exactMassSpeedSquare (conversion c)

theorem releaseDestinationAndTraceRetained (c : Composition Support State Clock) :
    (releasedRecord c).1 = c.destination ∧ (releasedRecord c).2.2 = c.sourceTrace := ⟨rfl,rfl⟩

theorem boundRecurrenceRetained (c : Composition Support State Clock) :
    SFT.QuantumComputation.ReversibleModel.phaseAction c.bound.whole.word.state c.bound.returnTrace = .ok c.bound.whole.word.state :=
  MatterHadrons.jointRecurrenceRetained c.bound
end SFT.Physics.NuclearBinding
