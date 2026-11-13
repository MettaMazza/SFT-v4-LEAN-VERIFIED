import SFT.Materials.BoundPolarization
import SFT.Physics.CollectivePhaseOrder
import SFT.Mathematics.DynamicsStability
namespace SFT.Materials.Ferroelectric
open SFT.Physics SFT.Mathematics SFT.Foundation.Count.TraceDerivation

-- Original FUNC-FERROELECTRIC: complete polar recurrence classes and the
-- registered finite perturbation witnesses; no fitted hysteresis magnitude.
structure PolarClass where
 region : CollectivePhaseOrder.OrderedRegion
 held : MechanicalLocation.Held
 polarization : String → BoundPolarization.OrientationRow
 oriented : ∀ cell, cell ∈ region.macrostate.members → (polarization cell).displacement.held = held
 recurrence : MechanicalDuration.Recurrence (List (String × BoundPolarization.OrientationRow))
 recurrenceStarts : recurrence.first.carrier = region.macrostate.members.map (fun cell => (cell,polarization cell))
 transitions : DynamicsTraces.Transitions
 perturbations : List String
 returnPaths : ∀ start, start ∈ perturbations → DynamicsStability.Reaches transitions start region.macrostate.label

def polarizationRows (c : PolarClass) := c.region.macrostate.members.map (fun cell => (cell,c.polarization cell))

def stable (c : PolarClass) := DynamicsStability.stableUnderRegisteredPerturbations c.transitions c.region.macrostate.label c.perturbations

theorem stabilityComputed (c : PolarClass) : stable c = true :=
 (DynamicsStability.stabilityMeaning _ _ _).mpr c.returnPaths

theorem completeRecurrenceReturns (c : PolarClass) : c.recurrence.last.carrier = polarizationRows c :=
 c.recurrence.returnsToCarrier.trans c.recurrenceStarts

theorem everyOrientationHeld (c : PolarClass) (cell : String) (member : cell ∈ c.region.macrostate.members) :
 (c.polarization cell).displacement.held = c.held := c.oriented cell member

theorem completePolarizationSupport (c : PolarClass) :
 (polarizationRows c).map Prod.fst = c.region.macrostate.members := by
 unfold polarizationRows
 generalize c.region.macrostate.members = cells
 induction cells with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons h) ih

theorem connectedPolarRegion (c : PolarClass) (a b : String)
 (ha : a ∈ c.region.macrostate.members) (hb : b ∈ c.region.macrostate.members) :
 GraphOperations.PathWitness (CollectivePhaseOrder.inducedGraph c.region.cells c.region.macrostate.members) a b :=
 CollectivePhaseOrder.exactConnectedSupport _ _ _ ha hb

structure Switching (P S T CS C : Type) where
 first : MechanicalEvents.Event PolarClass
 last : MechanicalEvents.Event PolarClass
 path : MechanicalEvents.Path first last
 opposed : last.carrier.held = MechanicalLocation.opposite first.carrier.held
 fields : List (FieldElectricPotential.ElectricInteraction P S T CS C)
 fieldDriven : ∀ step, step ∈ MechanicalEvents.changes path →
  ∃ field ∈ fields, ∃ action ∈ MechanicalEvents.changes field.work.force.interval,
   action.sourceIdentity = step.sourceIdentity ∧ action.actionRecord = step.actionRecord
 hysteresisConditions : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

variable {P S T CS C : Type}

theorem opposedClassesDistinct (s : Switching P S T CS C) : s.first.carrier.held ≠ s.last.carrier.held := by
 rw [s.opposed]
 cases s.first.carrier.held <;> intro h <;> cases h

theorem bothClassesStable (s : Switching P S T CS C) : stable s.first.carrier = true ∧ stable s.last.carrier = true :=
 ⟨stabilityComputed _,stabilityComputed _⟩

theorem bothClassesRecur (s : Switching P S T CS C) :
 s.first.carrier.recurrence.last.carrier = polarizationRows s.first.carrier ∧
 s.last.carrier.recurrence.last.carrier = polarizationRows s.last.carrier :=
 ⟨completeRecurrenceReturns _,completeRecurrenceReturns _⟩

theorem switchingHasTransition (s : Switching P S T CS C) : 0 < MechanicalEvents.count s.path := by
 have positive : ∀ {a b : MechanicalEvents.Event PolarClass} (path : MechanicalEvents.Path a b),
   a.carrier.held ≠ b.carrier.held → 0 < MechanicalEvents.count path := by
  intro a b path
  cases path with
  | one => intro distinct; exact False.elim (distinct rfl)
  | append prior step =>
   intro _
   rw [MechanicalEvents.successorAddsOne]
   exact Nat.zero_lt_succ _
 exact positive s.path (opposedClassesDistinct s)

theorem completeSwitchingEvents (s : Switching P S T CS C) :
 (MechanicalEvents.events s.path).length = MechanicalEvents.count s.path + 1 := MechanicalEvents.completeEventCount _

theorem allSwitchingSources (s : Switching P S T CS C) :
 (MechanicalEvents.changes s.path).map (fun r => (r.sourceIdentity,r.actionRecord)) = MechanicalEvents.sourceRecords s.path :=
 MechanicalEvents.allSourceRecordsRetained _

theorem everyStepHasActualField (s : Switching P S T CS C)
 (step : MechanicalEvents.Row PolarClass) (member : step ∈ MechanicalEvents.changes s.path) :
 ∃ field ∈ s.fields, ∃ action ∈ MechanicalEvents.changes field.work.force.interval,
 action.sourceIdentity = step.sourceIdentity ∧ action.actionRecord = step.actionRecord := s.fieldDriven step member

def fieldValues (s : Switching P S T CS C) := s.fields.map FieldElectricPotential.field

theorem completeFieldCount (s : Switching P S T CS C) : (fieldValues s).length = s.fields.length :=
 SFT.Foundation.CommonRefinement.mapLength _ _

theorem eachFieldExact (field : FieldElectricPotential.ElectricInteraction P S T CS C) :
 FieldElectricPotential.field field = FieldElectricPotential.normalizeCharge (MechanicalForce.value field.work.force) field.charge := rfl

def record (s : Switching P S T CS C) :=
 (s,polarizationRows s.first.carrier,polarizationRows s.last.carrier,
 MechanicalEvents.events s.path,MechanicalEvents.changes s.path,fieldValues s)

theorem completeInputRetained (s : Switching P S T CS C) : (record s).1 = s := rfl

def records (ss : List (Switching P S T CS C)) := ss.map record

theorem base (s : Switching P S T CS C) : records [s] = [record s] := rfl

theorem successor (ss : List (Switching P S T CS C)) (s : Switching P S T CS C) :
 records (ss++[s]) = records ss++[record s] := by
 induction ss with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.Ferroelectric
