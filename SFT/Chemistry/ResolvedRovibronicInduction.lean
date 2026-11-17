import SFT.Chemistry.ResolvedRovibronic
import SFT.Chemistry.MolecularRovibronicRecurrences
namespace SFT.Chemistry.ResolvedRovibronicInduction
open ResolvedRovibronic
open AnalyticalAccuracy (PositiveRatio)
-- rovibronic_joint_batch_v1: a positive coordinate extension keeps every
-- other state factor; appending the resulting row keeps preceding states.
def vibration (s : State) (next : PositiveRatio) : State :=
 {s with vibrationalCoordinate := .positive next}
def rotation (s : State) (next : PositiveRatio) : State :=
 {s with rotationalCoordinate := .positive next}
def appendRow (history : List State) (next : State) : List State := history ++ [next]

theorem vibrationRetainsOtherFactors (s : State) (next : PositiveRatio) :
 (vibration s next).carrier = s.carrier ∧
 (vibration s next).isotopeSupport = s.isotopeSupport ∧
 (vibration s next).electronicState = s.electronicState ∧
 (vibration s next).spinMultiplicity = s.spinMultiplicity ∧
 (vibration s next).rotationalCoordinate = s.rotationalCoordinate ∧
 (vibration s next).transitionRecord = s.transitionRecord ∧
 (vibration s next).sourceRecord = s.sourceRecord :=
 ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
theorem rotationRetainsOtherFactors (s : State) (next : PositiveRatio) :
 (rotation s next).carrier = s.carrier ∧
 (rotation s next).isotopeSupport = s.isotopeSupport ∧
 (rotation s next).electronicState = s.electronicState ∧
 (rotation s next).spinMultiplicity = s.spinMultiplicity ∧
 (rotation s next).vibrationalCoordinate = s.vibrationalCoordinate ∧
 (rotation s next).transitionRecord = s.transitionRecord ∧
 (rotation s next).sourceRecord = s.sourceRecord :=
 ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
theorem retainsAllPriorRows (history : List State) (next : State) :
 (appendRow history next).take history.length = history := by
 induction history with
 | nil => rfl
 | cons first rest ih => exact congrArg (List.cons first) ih
-- The positive recurrence values are the already verified original dependency:
-- MolecularRovibronicState.vibrationalValue and rotationalValue. The resolved
-- source takes its coordinates as supplied exact observations; it does not
-- replace those measured inscriptions by a new fitted recurrence law.
end SFT.Chemistry.ResolvedRovibronicInduction
