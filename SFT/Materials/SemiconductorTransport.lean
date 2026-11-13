import SFT.Materials.CarrierDuality
import SFT.Materials.CarrierAccess

namespace SFT.Materials.SemiconductorTransport
open SFT.Mathematics.DiscreteObjects SFT.Physics

-- V3 SEMI-TRANSPORT: a generated constituent transition retains its actual
-- support, occupation change and declared field/gradient/scattering records.
-- These are observation inputs, not a fitted mobility or constitutive law.
structure Motion where
 support : Collection
 before : Collection
 after : Collection
 accessible : Collection
 source : Form
 target : Form
 sourceHeld : source ∈ support
 targetHeld : target ∈ support
 sourceBefore : source ∈ before
 targetBefore : target ∉ before
 sourceAfter : source ∉ after
 targetAfter : target ∈ after
 targetAccessible : target ∈ accessible
 charge : FieldElectricDistinction.Charge
 fieldConditions : SFT.Host.Canonical.Value
 gradientConditions : SFT.Host.Canonical.Value
 scatteringProvenance : SFT.Host.Canonical.Value
 observationBoundary : SFT.Host.Canonical.Value

def occupiedRows (history : List Motion) : List (Form × Form) :=
 history.map (fun motion => (motion.source,motion.target))

def absenceRows (history : List Motion) : List (Form × Form) :=
 history.map (fun motion => (motion.target,motion.source))

def transitionCount (history : List Motion) : Nat := history.length

theorem actualAbsenceTransport (motion : Motion) :
 motion.source ∉ CarrierDuality.holes motion.support motion.before ∧
 motion.target ∈ CarrierDuality.holes motion.support motion.before ∧
 motion.source ∈ CarrierDuality.holes motion.support motion.after ∧
 motion.target ∉ CarrierDuality.holes motion.support motion.after :=
 CarrierDuality.occupiedTransportIsOppositeAbsence motion.before motion.after
  motion.source motion.target motion.sourceBefore motion.targetBefore
  motion.sourceAfter motion.targetAfter motion.support motion.sourceHeld motion.targetHeld

theorem everyOccupiedRow (history : List Motion) (row : Form × Form) :
 row ∈ occupiedRows history ↔
 ∃ motion, motion ∈ history ∧ (motion.source,motion.target) = row := by
 constructor
 · intro held
   obtain ⟨motion,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage
    (fun m : Motion => (m.source,m.target)) row history held
   exact ⟨motion,member,same⟩
 · intro ⟨motion,member,same⟩
   rw [← same]
   exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _ member

theorem countedOnce (history : List Motion) :
 (occupiedRows history).length = transitionCount history ∧
 (absenceRows history).length = transitionCount history :=
 ⟨SFT.Foundation.CommonRefinement.mapLength _ _,
  SFT.Foundation.CommonRefinement.mapLength _ _⟩

theorem absenceExactlyOpposed (history : List Motion) :
 absenceRows history = (occupiedRows history).map (fun row => (row.2,row.1)) := by
 induction history with
 | nil => rfl
 | cons motion rest ih => exact congrArg (List.cons (motion.target,motion.source)) ih

theorem accessibleDestination (motion : Motion) : motion.target ∈ motion.accessible :=
 motion.targetAccessible

-- Preserve the original complete rows, including conditions and provenance,
-- rather than retaining only the two projected carrier descriptions.
def extend (history : List Motion) (next : Motion) : List Motion := history ++ [next]

theorem baseCount (motion : Motion) : transitionCount [motion] = 1 := rfl

theorem successorCount (history : List Motion) (next : Motion) :
 transitionCount (extend history next) = transitionCount history + 1 := by
 induction history with
 | nil => rfl
 | cons first rest ih => exact congrArg Nat.succ ih

theorem earlierRecordRetained (history : List Motion) (next motion : Motion)
 (held : motion ∈ history) : motion ∈ extend history next :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem successorRecordRetained (history : List Motion) (next : Motion) :
 next ∈ extend history next :=
 SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (List.Mem.head _)

theorem occupiedSuccessor (history : List Motion) (next : Motion) :
 occupiedRows (extend history next) = occupiedRows history ++ [(next.source,next.target)] := by
 induction history with
 | nil => rfl
 | cons first rest ih => exact congrArg (List.cons (first.source,first.target)) ih

theorem absenceSuccessor (history : List Motion) (next : Motion) :
 absenceRows (extend history next) = absenceRows history ++ [(next.target,next.source)] := by
 induction history with
 | nil => rfl
 | cons first rest ih => exact congrArg (List.cons (first.target,first.source)) ih

end SFT.Materials.SemiconductorTransport
