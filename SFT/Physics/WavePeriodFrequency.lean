import SFT.Physics.FieldRadiation
namespace SFT.Physics.WavePeriodFrequency
open MechanicalEvents SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations
open SFT.Foundation.FractionReduction

structure Wave (State Clock : Type) where
  cycle : MechanicalAngularMotion.Cycle State
  reference : MechanicalDuration.Recurrence Clock

variable {State Clock : Type}

def period (wave : Wave State Clock) : PositiveFraction :=
  MechanicalDuration.positiveRatio wave.cycle.recurrence.path wave.reference wave.cycle.recurrence.hasTransition

def frequency (wave : Wave State Clock) : PositiveFraction := reciprocal (period wave)

theorem periodExact (wave : Wave State Clock) :
    count wave.cycle.recurrence.path * (period wave).denominator =
      (period wave).numerator * count wave.reference.path :=
  ratioValue _ _ wave.cycle.recurrence.hasTransition wave.reference.hasTransition

theorem reciprocalRepresentation (x : PositiveFraction) (n d : Nat)
    (h : n*x.denominator = x.numerator*d) :
    d*(reciprocal x).denominator = (reciprocal x).numerator*n := by
  apply cancelPositive x.numerator _ _ x.positive
  calc
    x.numerator*(d*(reciprocal x).denominator) = (x.numerator*d)*(reciprocal x).denominator := (mulAssoc _ _ _).symm
    _ = (n*x.denominator)*(reciprocal x).denominator := congrArg (fun k => k*(reciprocal x).denominator) h.symm
    _ = n*(x.denominator*(reciprocal x).denominator) := mulAssoc _ _ _
    _ = n*((reciprocal x).numerator*x.numerator) := congrArg (fun k => n*k) (reciprocalValue x)
    _ = x.numerator*((reciprocal x).numerator*n) := by
      rw [Nat.mul_comm (reciprocal x).numerator x.numerator,← mulAssoc,Nat.mul_comm n x.numerator,mulAssoc,Nat.mul_comm n (reciprocal x).numerator]

theorem frequencyExact (wave : Wave State Clock) :
    count wave.reference.path * (frequency wave).denominator =
      (frequency wave).numerator * count wave.cycle.recurrence.path :=
  reciprocalRepresentation _ _ _ (periodExact wave)

theorem frequencyIsReverseCountRatio (wave : Wave State Clock) :
    frequency wave = ratio (count wave.reference.path) (count wave.cycle.recurrence.path)
      wave.reference.hasTransition wave.cycle.recurrence.hasTransition :=
  (FieldGeometricDilution.positiveNormalizationRepresents _ _ _ _ _ (frequencyExact wave)).symm

theorem periodFrequencyOne (wave : Wave State Clock) :
    (compose (period wave) (frequency wave)).numerator = 1 ∧
    (compose (period wave) (frequency wave)).denominator = 1 := reciprocalReturnsOne _

theorem phaseReturn (wave : Wave State Clock) :
    wave.cycle.recurrence.last.carrier = wave.cycle.recurrence.first.carrier := wave.cycle.recurrence.returnsToCarrier

theorem periodPositive (wave : Wave State Clock) : 0 < (period wave).numerator := (period wave).positive

theorem frequencyPositive (wave : Wave State Clock) : 0 < (frequency wave).numerator := (frequency wave).positive

theorem completePhaseTrace (wave : Wave State Clock) (phase : MechanicalAngularMotion.Position wave.cycle) :
    changes phase.initialPath ++ changes phase.remainingPath = changes wave.cycle.recurrence.path :=
  MechanicalAngularMotion.wholeTrace phase
end SFT.Physics.WavePeriodFrequency
