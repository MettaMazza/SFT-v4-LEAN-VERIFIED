import SFT.Physics.MechanicalLocation
import SFT.Physics.DimensionComposition
namespace SFT.Physics.MechanicalVelocity
open SFT.Foundation.ExactOperations SFT.Physics.MechanicalEvents
open SFT.Physics.MechanicalDuration SFT.Physics.MechanicalLocation

def quotient (distance duration : PositiveFraction) : PositiveFraction :=
  normalizePositive (distance.numerator * duration.denominator)
    (distance.denominator * duration.numerator)
    (Nat.mul_pos distance.positive (Nat.pos_of_ne_zero duration.denominatorNonzero))
    (Nat.mul_pos (Nat.pos_of_ne_zero distance.denominatorNonzero) duration.positive)

structure Velocity (Support State ClockState : Type) where
  displacement : Displacement Support
  first : Event State
  last : Event State
  path : Path first last
  clock : Recurrence ClockState
  present : 0 < count path

def speed {Support State ClockState : Type} (v : Velocity Support State ClockState) :=
  quotient v.displacement.separation (positiveRatio v.path v.clock v.present)

def orientation {Support State ClockState : Type} (v : Velocity Support State ClockState) :=
  v.displacement.held

def reverse {Support State ClockState : Type} (v : Velocity Support State ClockState) :
    Velocity Support State ClockState :=
  {v with displacement := MechanicalLocation.reverse v.displacement}

def dimension (distance duration : SFT.Physics.DimensionComposition.Path) :=
  SFT.Physics.DimensionComposition.Path.quotient distance duration

theorem quotientExact (distance duration : PositiveFraction) :
    (distance.numerator * duration.denominator) * (quotient distance duration).denominator =
    (quotient distance duration).numerator * (distance.denominator * duration.numerator) :=
  normalizedValuePreserved _ _ _ _

theorem speedPositive {Support State ClockState : Type} (v : Velocity Support State ClockState) :
    0 < (speed v).numerator := (speed v).positive

theorem speedExact {Support State ClockState : Type} (v : Velocity Support State ClockState) :
    (v.displacement.separation.numerator * (positiveRatio v.path v.clock v.present).denominator) *
      (speed v).denominator =
    (speed v).numerator * (v.displacement.separation.denominator *
      (positiveRatio v.path v.clock v.present).numerator) :=
  quotientExact _ _

theorem retainsOrientation {Support State ClockState : Type} (v : Velocity Support State ClockState) :
    orientation v = v.displacement.held := rfl

theorem reversalPreservesSpeed {Support State ClockState : Type} (v : Velocity Support State ClockState) :
    speed (reverse v) = speed v := rfl

theorem reversalChangesOrientation {Support State ClockState : Type} (v : Velocity Support State ClockState) :
    orientation (reverse v) = opposite (orientation v) := rfl

theorem reversalRetainsDurationTrace {Support State ClockState : Type} (v : Velocity Support State ClockState) :
    (reverse v).path = v.path := rfl

theorem reversalRetainsReference {Support State ClockState : Type} (v : Velocity Support State ClockState) :
    (reverse v).clock = v.clock := rfl

theorem reversalTwice {Support State ClockState : Type} (v : Velocity Support State ClockState) :
    reverse (reverse v) = v := by
  cases v with
  | mk d first last path clock present =>
    change Velocity.mk (MechanicalLocation.reverse (MechanicalLocation.reverse d)) _ _ _ _ _ = _
    rw [MechanicalLocation.reverseTwice]
    rfl

theorem dimensionCounts (distance duration : SFT.Physics.DimensionComposition.Path) (kind : String) :
    SFT.Physics.DimensionComposition.counts (dimension distance duration) kind =
    ((SFT.Physics.DimensionComposition.counts distance kind).1 +
      (SFT.Physics.DimensionComposition.counts duration kind).2,
     (SFT.Physics.DimensionComposition.counts distance kind).2 +
      (SFT.Physics.DimensionComposition.counts duration kind).1) := rfl

theorem dimensionRetainsBothDescriptions
    (a b c d : SFT.Physics.DimensionComposition.Path)
    (equal : dimension a b = dimension c d) : a = c ∧ b = d := by
  cases equal
  exact ⟨rfl,rfl⟩
end SFT.Physics.MechanicalVelocity
