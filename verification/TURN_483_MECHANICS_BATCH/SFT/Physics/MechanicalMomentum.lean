import SFT.Physics.MechanicalInertia
import SFT.Mathematics.ExactRatioRelations
namespace SFT.Physics.MechanicalMomentum
open SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations

-- mechanics_laws.py MOMENTUM: each inertial part retains the full motion label.
def cells {Part Motion : Type} (parts : List Part) (motion : Motion) : List (Part × Motion) :=
  parts.map (fun part => (part,motion))

theorem cellsRetainEveryPart {Part Motion : Type} (parts : List Part) (motion : Motion) :
    (cells parts motion).map Prod.fst = parts := by
  induction parts with
  | nil => rfl
  | cons part rest ih => simp only [cells, List.map_cons] at *; exact congrArg (List.cons part) ih

theorem cellsCount {Part Motion : Type} (parts : List Part) (motion : Motion) :
    (cells parts motion).length = parts.length := by
  induction parts with
  | nil => rfl
  | cons part rest ih => exact congrArg Nat.succ ih

theorem cellMembership {Part Motion : Type} (parts : List Part) (motion : Motion)
    (part : Part) (label : Motion) : (part,label) ∈ cells parts motion ↔ part ∈ parts ∧ label = motion := by
  induction parts with
  | nil =>
    constructor
    · intro h; cases h
    · intro h; cases h.1
  | cons p rest ih =>
    constructor
    · intro h
      cases h with
      | head => exact ⟨.head _,rfl⟩
      | tail _ h =>
        have prior := ih.mp h
        exact ⟨.tail _ prior.1,prior.2⟩
    · intro h
      cases h.2
      cases h.1 with
      | head => exact .head _
      | tail _ h => exact .tail _ (ih.mpr ⟨h,rfl⟩)

theorem cellsAppend {Part Motion : Type} (left right : List Part) (motion : Motion) :
    cells (left ++ right) motion = cells left motion ++ cells right motion := by
  induction left with
  | nil => rfl
  | cons part rest ih => exact congrArg (List.cons (part,motion)) ih

theorem cellsRecoverParts {Part Motion : Type} {left right : List Part} {a b : Motion}
    (equal : cells left a = cells right b) : left = right := by
  have h := congrArg (List.map Prod.fst) equal
  rw [cellsRetainEveryPart,cellsRetainEveryPart] at h
  exact h

theorem cellsRecoverMotion {Part Motion : Type} (part : Part) (rest : List Part)
    {a b : Motion} (equal : cells (part :: rest) a = cells (part :: rest) b) : a = b := by
  have h := List.cons.inj equal
  exact congrArg Prod.snd h.1

structure Momentum (Part Support State ClockState : Type) where
  parts : List Part
  nonempty : parts ≠ []
  content : PositiveFraction
  velocity : MechanicalVelocity.Velocity Support State ClockState

def completeCells {Part Support State ClockState : Type}
    (p : Momentum Part Support State ClockState) := cells p.parts p.velocity

def magnitude {Part Support State ClockState : Type}
    (p : Momentum Part Support State ClockState) := compose p.content (MechanicalVelocity.speed p.velocity)

def orientation {Part Support State ClockState : Type}
    (p : Momentum Part Support State ClockState) := MechanicalVelocity.orientation p.velocity

theorem productExact {Part Support State ClockState : Type}
    (p : Momentum Part Support State ClockState) :
    (p.content.numerator * (MechanicalVelocity.speed p.velocity).numerator) * (magnitude p).denominator =
      (magnitude p).numerator * (p.content.denominator * (MechanicalVelocity.speed p.velocity).denominator) :=
  composeValue _ _

theorem magnitudePositive {Part Support State ClockState : Type}
    (p : Momentum Part Support State ClockState) : 0 < (magnitude p).numerator := (magnitude p).positive

theorem everyPartHasCompleteVelocity {Part Support State ClockState : Type}
    (p : Momentum Part Support State ClockState) (part : Part) (included : part ∈ p.parts) :
    (part,p.velocity) ∈ completeCells p := (cellMembership p.parts p.velocity part p.velocity).mpr ⟨included,rfl⟩

theorem noUnregisteredCell {Part Support State ClockState : Type}
    (p : Momentum Part Support State ClockState) (part : Part)
    (motion : MechanicalVelocity.Velocity Support State ClockState)
    (included : (part,motion) ∈ completeCells p) : part ∈ p.parts ∧ motion = p.velocity :=
  (cellMembership p.parts p.velocity part motion).mp included

end SFT.Physics.MechanicalMomentum
