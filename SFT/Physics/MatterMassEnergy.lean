import SFT.Physics.QuantumPhysicalNoSignalling
namespace SFT.Physics.MatterMassEnergy
open SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations

structure Conversion (Support State Clock : Type) where
  inertial : QuantumPhysicalState.Prepared
  content : PositiveFraction
  limit : WaveSpeedRelation.SpatialRepeat Support State Clock
  sourceTrace : List SFT.Host.Canonical.Value

def value {Support State Clock : Type} (c : Conversion Support State Clock) :=
  compose c.content (compose (WaveSpeedRelation.speed c.limit) (WaveSpeedRelation.speed c.limit))

def record {Support State Clock : Type} (c : Conversion Support State Clock) :=
  (c.inertial,c.sourceTrace,c.limit,c.limit)

theorem twoPropagationTransfersRetained {Support State Clock : Type} (c : Conversion Support State Clock) :
    (record c).2.2.1 = c.limit ∧ (record c).2.2.2 = c.limit := ⟨rfl,rfl⟩

theorem fullInertialSourceRetained {Support State Clock : Type} (c : Conversion Support State Clock) :
    (record c).1 = c.inertial ∧ (record c).2.1 = c.sourceTrace := ⟨rfl,rfl⟩

theorem exactMassSpeedSquare {Support State Clock : Type} (c : Conversion Support State Clock) :
    (c.content.numerator * ((WaveSpeedRelation.speed c.limit).numerator * (WaveSpeedRelation.speed c.limit).numerator)) *
      (value c).denominator = (value c).numerator *
    (c.content.denominator * ((WaveSpeedRelation.speed c.limit).denominator * (WaveSpeedRelation.speed c.limit).denominator)) :=
  composeRepresents c.content (compose (WaveSpeedRelation.speed c.limit) (WaveSpeedRelation.speed c.limit))
    _ _ _ _ rfl (composeValue _ _)

theorem positiveEnergy {Support State Clock : Type} (c : Conversion Support State Clock) :
    0 < (value c).numerator := (value c).positive

theorem forcedEnergyUnique {Support State Clock : Type} (c : Conversion Support State Clock)
    (candidate : PositiveFraction)
    (h : (c.content.numerator * ((WaveSpeedRelation.speed c.limit).numerator * (WaveSpeedRelation.speed c.limit).numerator)) *
      candidate.denominator = candidate.numerator *
    (c.content.denominator * ((WaveSpeedRelation.speed c.limit).denominator * (WaveSpeedRelation.speed c.limit).denominator))) :
    candidate = value c := by
  let n := c.content.numerator * ((WaveSpeedRelation.speed c.limit).numerator * (WaveSpeedRelation.speed c.limit).numerator)
  let d := c.content.denominator * ((WaveSpeedRelation.speed c.limit).denominator * (WaveSpeedRelation.speed c.limit).denominator)
  have hn : 0 < n := Nat.mul_pos c.content.positive
    (Nat.mul_pos (WaveSpeedRelation.speed c.limit).positive (WaveSpeedRelation.speed c.limit).positive)
  have hd : 0 < d := Nat.mul_pos (Nat.pos_of_ne_zero c.content.denominatorNonzero)
    (Nat.mul_pos (Nat.pos_of_ne_zero (WaveSpeedRelation.speed c.limit).denominatorNonzero)
      (Nat.pos_of_ne_zero (WaveSpeedRelation.speed c.limit).denominatorNonzero))
  exact (FieldGeometricDilution.positiveNormalizationRepresents n d hn hd candidate h).symm.trans
    (FieldGeometricDilution.positiveNormalizationRepresents n d hn hd (value c) (exactMassSpeedSquare c))

def conversionDimension (mass length time : DimensionComposition.Path) :=
  DimensionComposition.Path.product mass (.product (.quotient length time) (.quotient length time))

theorem regroup (m l t : Nat) : m+((l+t)+(l+t)) = ((m+l)+l)+(t+t) := by
  simp only [Nat.add_assoc]
  rw [← Nat.add_assoc t l t,Nat.add_comm t l,Nat.add_assoc]

theorem exactEnergyDimension (mass length time : DimensionComposition.Path) (kind : String) :
    DimensionComposition.counts (conversionDimension mass length time) kind =
      DimensionComposition.counts (MechanicalWorkEnergy.energyDimension mass length time) kind := by
  simp only [conversionDimension,MechanicalWorkEnergy.energyDimension,DimensionComposition.counts]
  exact Prod.ext (regroup _ _ _) (regroup _ _ _)

theorem agreesWithTransferredWorkDimension (mass length time : DimensionComposition.Path) (kind : String) :
    DimensionComposition.counts (conversionDimension mass length time) kind =
      DimensionComposition.counts (MechanicalWorkEnergy.workDimension mass length time) kind :=
  (exactEnergyDimension mass length time kind).trans (MechanicalWorkEnergy.energyDimensionClosure mass length time kind).symm
end SFT.Physics.MatterMassEnergy
