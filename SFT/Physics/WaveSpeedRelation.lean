import SFT.Physics.WavePropagation
namespace SFT.Physics.WaveSpeedRelation
open SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations

structure SpatialRepeat (Support State Clock : Type) where
  wave : WavePeriodFrequency.Wave State Clock
  displacement : MechanicalLocation.Displacement Support

variable {Support State Clock : Type}

def wavelength (spatial : SpatialRepeat Support State Clock) := spatial.displacement.separation

def speed (spatial : SpatialRepeat Support State Clock) :=
  SFT.Mathematics.FoldScalar.quotientMagnitude (wavelength spatial) (WavePeriodFrequency.period spatial.wave)

theorem wavelengthTimesFrequency (spatial : SpatialRepeat Support State Clock) :
    speed spatial = compose (wavelength spatial) (WavePeriodFrequency.frequency spatial.wave) := rfl

theorem wavelengthOverPeriod (spatial : SpatialRepeat Support State Clock) :
    ((wavelength spatial).numerator * (WavePeriodFrequency.period spatial.wave).denominator) *
      (speed spatial).denominator = (speed spatial).numerator *
      ((wavelength spatial).denominator * (WavePeriodFrequency.period spatial.wave).numerator) :=
  SFT.Mathematics.FoldScalar.quotientExact _ _

theorem speedPositive (spatial : SpatialRepeat Support State Clock) : 0 < (speed spatial).numerator :=
  (speed spatial).positive

def endpoints (spatial : SpatialRepeat Support State Clock) :=
  (spatial.displacement.first,spatial.displacement.second)

theorem changedEndpointsDistinguished (a b : SpatialRepeat Support State Clock)
    (h : endpoints a ≠ endpoints b) : a ≠ b := fun eq => h (congrArg endpoints eq)

theorem speedUnique (spatial : SpatialRepeat Support State Clock) (candidate : PositiveFraction)
    (h : ((wavelength spatial).numerator * (WavePeriodFrequency.period spatial.wave).denominator) *
      candidate.denominator = candidate.numerator *
      ((wavelength spatial).denominator * (WavePeriodFrequency.period spatial.wave).numerator)) :
    candidate = speed spatial := by
  let n := (wavelength spatial).numerator * (WavePeriodFrequency.period spatial.wave).denominator
  let d := (wavelength spatial).denominator * (WavePeriodFrequency.period spatial.wave).numerator
  have hn : 0 < n := Nat.mul_pos (wavelength spatial).positive
    (Nat.pos_of_ne_zero (WavePeriodFrequency.period spatial.wave).denominatorNonzero)
  have hd : 0 < d := Nat.mul_pos (Nat.pos_of_ne_zero (wavelength spatial).denominatorNonzero)
    (WavePeriodFrequency.period spatial.wave).positive
  exact (FieldGeometricDilution.positiveNormalizationRepresents n d hn hd candidate h).symm.trans
    (FieldGeometricDilution.positiveNormalizationRepresents n d hn hd (speed spatial) (wavelengthOverPeriod spatial))

theorem changedSpatialRepeatDistinguished (a b : SpatialRepeat Support State Clock)
    (h : a.displacement ≠ b.displacement) : a ≠ b := fun eq => h (congrArg SpatialRepeat.displacement eq)

theorem changedTemporalRepeatDistinguished (a b : SpatialRepeat Support State Clock)
    (h : a.wave ≠ b.wave) : a ≠ b := fun eq => h (congrArg SpatialRepeat.wave eq)
end SFT.Physics.WaveSpeedRelation
