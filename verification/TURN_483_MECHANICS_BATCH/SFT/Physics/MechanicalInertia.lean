import SFT.Physics.MechanicalVelocity
namespace SFT.Physics.MechanicalInertia
open SFT.Host.Canonical

-- mechanics_laws.py INERTIA: a changed carrier requires a retained transfer.
-- Carrier is the complete held motion carrier, never an answer-only scalar.
structure Transfer (Carrier : Type) where
  sourceIdentity : String
  actionRecord : Value
  result : Carrier

def successor {Carrier : Type} (prior : Carrier) : Option (Transfer Carrier) → Carrier
  | none => prior
  | some transfer => transfer.result

inductive Admissible {Carrier : Type} (prior : Carrier) :
    Option (Transfer Carrier) → Carrier → Prop where
  | retained : Admissible prior none prior
  | transferred (transfer : Transfer Carrier) : Admissible prior (some transfer) transfer.result

def run {Carrier : Type} (prior : Carrier) : List (Option (Transfer Carrier)) → Carrier
  | [] => prior
  | step :: rest => run (successor prior step) rest

def sources {Carrier : Type} : List (Option (Transfer Carrier)) → List (Transfer Carrier)
  | [] => []
  | none :: rest => sources rest
  | some transfer :: rest => transfer :: sources rest

theorem successorAdmissible {Carrier : Type} (prior : Carrier) (step : Option (Transfer Carrier)) :
    Admissible prior step (successor prior step) := by
  cases step with
  | none => exact .retained
  | some transfer => exact .transferred transfer

theorem continuationUnique {Carrier : Type} {prior next : Carrier}
    {step : Option (Transfer Carrier)} (h : Admissible prior step next) :
    next = successor prior step := by cases h <;> rfl

theorem closedSuccessor {Carrier : Type} (prior : Carrier) : successor prior none = prior := rfl

theorem changedRequiresSource {Carrier : Type} {prior next : Carrier}
    {step : Option (Transfer Carrier)} (h : Admissible prior step next) (changed : next ≠ prior) :
    ∃ transfer, step = some transfer ∧ next = transfer.result := by
  cases h with
  | retained => exact False.elim (changed rfl)
  | transferred transfer => exact ⟨transfer,rfl,rfl⟩

theorem closedPath {Carrier : Type} (prior : Carrier) (steps : List (Option (Transfer Carrier)))
    (closed : sources steps = []) : run prior steps = prior := by
  induction steps generalizing prior with
  | nil => rfl
  | cons step rest ih =>
    cases step with
    | none => exact ih prior closed
    | some transfer => cases closed

theorem runAppend {Carrier : Type} (prior : Carrier)
    (left right : List (Option (Transfer Carrier))) :
    run prior (left ++ right) = run (run prior left) right := by
  induction left generalizing prior with
  | nil => rfl
  | cons step rest ih => exact ih (successor prior step)

theorem sourcesAppend {Carrier : Type} (left right : List (Option (Transfer Carrier))) :
    sources (left ++ right) = sources left ++ sources right := by
  induction left with
  | nil => rfl
  | cons step rest ih =>
    cases step with
    | none => exact ih
    | some transfer => exact congrArg (List.cons transfer) ih

theorem closedVelocityPath {Support State ClockState : Type}
    (prior : MechanicalVelocity.Velocity Support State ClockState)
    (steps : List (Option (Transfer (MechanicalVelocity.Velocity Support State ClockState))))
    (closed : sources steps = []) : run prior steps = prior := closedPath prior steps closed

theorem closedPathRetainsSpeed {Support State ClockState : Type}
    (prior : MechanicalVelocity.Velocity Support State ClockState)
    (steps : List (Option (Transfer (MechanicalVelocity.Velocity Support State ClockState))))
    (closed : sources steps = []) : MechanicalVelocity.speed (run prior steps) = MechanicalVelocity.speed prior :=
  congrArg MechanicalVelocity.speed (closedPath prior steps closed)

theorem closedPathRetainsOrientation {Support State ClockState : Type}
    (prior : MechanicalVelocity.Velocity Support State ClockState)
    (steps : List (Option (Transfer (MechanicalVelocity.Velocity Support State ClockState))))
    (closed : sources steps = []) : MechanicalVelocity.orientation (run prior steps) = MechanicalVelocity.orientation prior :=
  congrArg MechanicalVelocity.orientation (closedPath prior steps closed)
end SFT.Physics.MechanicalInertia
