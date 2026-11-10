import SFT.Physics.CollectiveInviscid
namespace SFT.Physics.CollectiveViscosity
open SFT.Mathematics.FoldScalar
open SFT.Foundation.ExactOperations
open MechanicalConservation MechanicalDuration

structure Exchange (Support State ClockState : Type) where
 boundary : CollectivePressure.BoundaryRecurrence State
 leftCell : String
 rightCell : String
 adjacent : (leftCell,rightCell) ∈ boundary.boundary
 leftVelocity : MechanicalVelocity.Velocity Support State ClockState
 rightVelocity : MechanicalVelocity.Velocity Support State ClockState
 commonClock : leftVelocity.clock = rightVelocity.clock
 momentum : Scalar
 transfer : Transfer String CollectiveInviscid.Channel
 sourceHeld : transfer.source = leftCell
 destinationHeld : transfer.destination = rightCell
 tangential : transfer.carrier = .tangential momentum

variable {Support State ClockState : Type}

def interfaceCount (e : Exchange Support State ClockState) : PositiveFraction :=
 normalizePositive e.boundary.boundary.length 1 e.boundary.boundaryPositive (Nat.zero_lt_succ 0)

def leftRecurrence (e : Exchange Support State ClockState) :=
 positiveRatio e.leftVelocity.path e.leftVelocity.clock e.leftVelocity.present

def rightRecurrence (e : Exchange Support State ClockState) :=
 positiveRatio e.rightVelocity.path e.rightVelocity.clock e.rightVelocity.present

def recurrenceDifference (e : Exchange Support State ClockState) :=
 subtract (.positive .forward (rightRecurrence e)) (.positive .forward (leftRecurrence e))

def denominator (e : Exchange Support State ClockState) :=
 multiply (.positive .forward (interfaceCount e)) (recurrenceDifference e)

def coefficient (e : Exchange Support State ClockState) :=
 ThermoTemperature.divideScalar e.momentum (denominator e)

theorem exactInterfaceCount (e : Exchange Support State ClockState) :
 e.boundary.boundary.length * (interfaceCount e).denominator = (interfaceCount e).numerator * 1 :=
 normalizedValuePreserved _ _ _ _

theorem leftRecurrenceExact (e : Exchange Support State ClockState) :
 MechanicalEvents.count e.leftVelocity.path * (leftRecurrence e).denominator =
 (leftRecurrence e).numerator * MechanicalEvents.count e.leftVelocity.clock.path :=
 exactRecurrenceRatio _ _ _

theorem rightRecurrenceExact (e : Exchange Support State ClockState) :
 MechanicalEvents.count e.rightVelocity.path * (rightRecurrence e).denominator =
 (rightRecurrence e).numerator * MechanicalEvents.count e.rightVelocity.clock.path :=
 exactRecurrenceRatio _ _ _

theorem sameRecurrenceBoundary (e : Exchange Support State ClockState)
 (same : rightRecurrence e = leftRecurrence e) :
 coefficient e = .error "division by structural empty-One is undefined" := by
 unfold coefficient denominator recurrenceDifference
 rw [same,subtractSelf]
 rfl

theorem exactResponseRatio (e : Exchange Support State ClockState) :
 coefficient e = ThermoTemperature.divideScalar e.momentum
 (multiply (.positive .forward (interfaceCount e)) (recurrenceDifference e)) := rfl

theorem presentResponse (e : Exchange Support State ClockState) (a b : Orientation)
 (x y : PositiveFraction) (momentum : e.momentum = .positive a x)
 (difference : denominator e = .positive b y) :
 coefficient e = .ok (.positive (productOrientation a b) (quotientMagnitude x y)) := by
 unfold coefficient
 rw [momentum,difference]
 rfl

theorem exactResponseMagnitude (x y : PositiveFraction) :
 (x.numerator*y.denominator)*(quotientMagnitude x y).denominator =
 (quotientMagnitude x y).numerator*(x.denominator*y.numerator) := quotientExact x y

theorem transferIsAdjacentTangential (e : Exchange Support State ClockState) :
 (e.transfer.source,e.transfer.destination) ∈ e.boundary.boundary ∧
 e.transfer.carrier = .tangential e.momentum := by
 rw [e.sourceHeld,e.destinationHeld]
 exact ⟨e.adjacent,e.tangential⟩

theorem transferCarrierPaired (e : Exchange Support State ClockState) :
 outgoingSupport [e.transfer] = incomingSupport [e.transfer] := completeConservation _

theorem coefficientUnique (e : Exchange Support State ClockState) (a b : Scalar)
 (ha : coefficient e = .ok a) (hb : coefficient e = .ok b) : a = b := Except.ok.inj (ha.symm.trans hb)
end SFT.Physics.CollectiveViscosity
