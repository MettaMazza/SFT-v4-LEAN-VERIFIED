import SFT.Physics.FieldMagneticOrientation
namespace SFT.Physics.FieldMagnetic
open SFT.Mathematics.FoldScalar MechanicalEvents

-- field_laws.py MAGNETIC distinguishes a motion-path role from its transverse
-- response role. These are relational roles, not imported metric coordinates.
inductive Role where
  | alongMotion | transverse

structure Transport (Support State ClockState : Type) where
  charge : FieldElectricDistinction.Charge
  motion : MechanicalVelocity.Velocity Support State ClockState

variable {Support State ClockState : Type}

def orientation (t : Transport Support State ClockState) : Orientation :=
  FieldMagneticOrientation.responseOrientation
    (MechanicalAcceleration.scalarOrientation t.charge.held)
    (MechanicalAcceleration.scalarOrientation t.motion.displacement.held)

def reverseCharge (t : Transport Support State ClockState) :=
  {t with charge := FieldElectricDistinction.reverse t.charge}

def reverseMotion (t : Transport Support State ClockState) :=
  {t with motion := MechanicalVelocity.reverse t.motion}

structure Response (Support State ClockState : Type) where
  transport : Transport Support State ClockState
  observation : SFT.Host.Canonical.Value

def role (_ : Response Support State ClockState) : Role := .transverse

def held (r : Response Support State ClockState) := orientation r.transport

def provenance (r : Response Support State ClockState) := sourceRecords r.transport.motion.path

theorem transverseExcludesLongitudinal (r : Response Support State ClockState) :
    role r ≠ .alongMotion := by intro h; cases h

theorem scalarOpposite (h : MechanicalLocation.Held) :
    MechanicalAcceleration.scalarOrientation (MechanicalLocation.opposite h) =
    opposite (MechanicalAcceleration.scalarOrientation h) := by cases h <;> rfl

theorem chargeReversal (t : Transport Support State ClockState) :
    orientation (reverseCharge t) = opposite (orientation t) := by
  change FieldMagneticOrientation.responseOrientation
    (MechanicalAcceleration.scalarOrientation (MechanicalLocation.opposite t.charge.held))
    (MechanicalAcceleration.scalarOrientation t.motion.displacement.held) = _
  rw [scalarOpposite]
  exact FieldMagneticOrientation.reversingCharge _ _

theorem motionReversal (t : Transport Support State ClockState) :
    orientation (reverseMotion t) = opposite (orientation t) := by
  change FieldMagneticOrientation.responseOrientation
    (MechanicalAcceleration.scalarOrientation t.charge.held)
    (MechanicalAcceleration.scalarOrientation (MechanicalLocation.opposite t.motion.displacement.held)) = _
  rw [scalarOpposite]
  exact FieldMagneticOrientation.reversingMotion _ _

theorem bothReversals (t : Transport Support State ClockState) :
    orientation (reverseCharge (reverseMotion t)) = orientation t := by
  rw [chargeReversal,motionReversal,oppositeTwice]

theorem reversalsPreserveSourceMagnitude (t : Transport Support State ClockState) :
    (reverseCharge t).charge.amount = t.charge.amount ∧
    (reverseMotion t).charge.amount = t.charge.amount := ⟨rfl,rfl⟩

theorem reversalsPreservePropagation (t : Transport Support State ClockState) :
    (reverseCharge t).motion.path = t.motion.path ∧
    (reverseMotion t).motion.path = t.motion.path := ⟨rfl,rfl⟩

theorem completePropagation (r : Response Support State ClockState) :
    (changes r.transport.motion.path).map (fun x => (x.sourceIdentity,x.actionRecord)) = provenance r :=
  allSourceRecordsRetained _

theorem transportPresent (r : Response Support State ClockState) :
    0 < count r.transport.motion.path := r.transport.motion.present

theorem changedChargeDistinguished (a b : Response Support State ClockState)
    (h : a.transport.charge ≠ b.transport.charge) : a ≠ b :=
  fun eq => h (congrArg (fun r => r.transport.charge) eq)

theorem changedMotionDistinguished (a b : Response Support State ClockState)
    (h : a.transport.motion ≠ b.transport.motion) : a ≠ b :=
  fun eq => h (congrArg (fun r => r.transport.motion) eq)

-- Every accessible response retains its own full transport and observation.
def responseLedger (rows : List (Response Support State ClockState)) := rows.map (fun r => (r.transport,r.observation,role r,held r))

theorem ledgerRetainsTransports (rows : List (Response Support State ClockState)) :
    (responseLedger rows).map (fun x => x.1) = rows.map Response.transport := by
  induction rows with
  | nil => rfl
  | cons r rs ih => exact congrArg (List.cons r.transport) ih

theorem successorPreservesLedger (rows : List (Response Support State ClockState))
    (r : Response Support State ClockState) :
    responseLedger (rows ++ [r]) = responseLedger rows ++ [(r.transport,r.observation,role r,held r)] :=
  ReferenceRealization.mapAppendOne _ _ _
end SFT.Physics.FieldMagnetic
