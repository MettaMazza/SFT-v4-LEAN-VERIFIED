import SFT.Materials.DiffusionHistory
import SFT.Physics.FieldElectricPotential
namespace SFT.Materials.BoundPolarization
open SFT.Physics SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

structure Label where
 identity : String
 charge : FieldElectricDistinction.Charge
 boundSites : List String
 provenance : SFT.Host.Canonical.Value

def bound (s : DiffusionHistory.State Label) : Prop := ∀ row, row ∈ s → row.1 ∈ row.2.boundSites

theorem moveRemainsBound {l : Lattice.Record} (m : DiffusionHistory.Move l Label)
 (prior : bound (DiffusionHistory.before m)) (destination : m.destination ∈ m.label.boundSites) :
 bound (DiffusionHistory.after m) := by
 intro row held
 cases memAppendCases row m.beforeRows ((m.destination,m.label)::m.afterRows) held with
 | inl h => exact prior row (memAppendLeft _ _ _ h)
 | inr h => cases h with
   | head => exact destination
   | tail _ h => exact prior row (memAppendRight _ _ _ (.tail _ h))

inductive BoundRun (l : Lattice.Record) : DiffusionHistory.State Label → DiffusionHistory.State Label → List (DiffusionHistory.Move l Label) → Prop where
 | initial (state : DiffusionHistory.State Label) (held : bound state) : BoundRun l state state []
 | append {start finish : DiffusionHistory.State Label} {history : List (DiffusionHistory.Move l Label)}
   (prior : BoundRun l start finish history) (move : DiffusionHistory.Move l Label)
   (joined : finish = DiffusionHistory.before move) (destination : move.destination ∈ move.label.boundSites) :
   BoundRun l start (DiffusionHistory.after move) (history++[move])

theorem originalRun {l : Lattice.Record} {a b : DiffusionHistory.State Label} {h : List (DiffusionHistory.Move l Label)}
 (run : BoundRun l a b h) : DiffusionHistory.Run l a b h := by
 induction run with
 | initial held => exact .initial _
 | append prior move joined destination ih => exact .append ih move joined

theorem everyFiniteRunBound {l : Lattice.Record} {a b : DiffusionHistory.State Label} {h : List (DiffusionHistory.Move l Label)}
 (run : BoundRun l a b h) : bound b := by
 induction run with
 | initial held => exact held
 | append prior move joined destination ih => exact moveRemainsBound move (joined ▸ ih) destination

theorem everyChargeRetained {l : Lattice.Record} {a b : DiffusionHistory.State Label} {h : List (DiffusionHistory.Move l Label)}
 (run : BoundRun l a b h) : DiffusionHistory.content a = DiffusionHistory.content b :=
 DiffusionHistory.completeContentConserved (originalRun run)

structure OrientationRow where
 label : Label
 displacement : MechanicalLocation.Displacement String
 firstBound : displacement.first.support ∈ label.boundSites
 secondBound : displacement.second.support ∈ label.boundSites
 source : SFT.Host.Canonical.Value

def reorient (o : OrientationRow) : OrientationRow :=
 ⟨o.label,MechanicalLocation.reverse o.displacement,o.firstBound,o.secondBound,o.source⟩

theorem reorientationRetainsCharge (o : OrientationRow) : (reorient o).label.charge = o.label.charge := rfl

theorem reorientationChangesHeld (o : OrientationRow) :
 (reorient o).displacement.held ≠ o.displacement.held := MechanicalLocation.reverseChangesHeld o.displacement

theorem reorientationRetainsPair (o : OrientationRow) :
 (reorient o).displacement.first = o.displacement.first ∧
 (reorient o).displacement.second = o.displacement.second := ⟨rfl,rfl⟩

structure Record (Part Support State ClockState Clock : Type) where
 lattice : Lattice.Record
 initial : DiffusionHistory.State Label
 loaded : DiffusionHistory.State Label
 relaxed : DiffusionHistory.State Label
 loadingRows : List (DiffusionHistory.Move lattice Label)
 relaxationRows : List (DiffusionHistory.Move lattice Label)
 loading : BoundRun lattice initial loaded loadingRows
 relaxation : BoundRun lattice loaded relaxed relaxationRows
 interaction : FieldElectricPotential.ElectricInteraction Part Support State ClockState Clock
 probeLabel : Label
 labelHeld : probeLabel ∈ DiffusionHistory.content initial
 fieldCharge : interaction.charge = probeLabel.charge
 frequencyConditions : SFT.Host.Canonical.Value
 orientationRecords : List OrientationRow
 orientationsHeld : ∀ o, o ∈ orientationRecords → o.label ∈ DiffusionHistory.content initial

variable {Part Support State ClockState Clock : Type}

def field (r : Record Part Support State ClockState Clock) := FieldElectricPotential.field r.interaction

theorem exactAppliedField (r : Record Part Support State ClockState Clock) :
 field r = FieldElectricPotential.normalizeCharge (MechanicalForce.value r.interaction.work.force) r.probeLabel.charge := by
 unfold field FieldElectricPotential.field
 rw [r.fieldCharge]

theorem loadingConserves (r : Record Part Support State ClockState Clock) :
 DiffusionHistory.content r.initial = DiffusionHistory.content r.loaded := everyChargeRetained r.loading

theorem relaxationConserves (r : Record Part Support State ClockState Clock) :
 DiffusionHistory.content r.initial = DiffusionHistory.content r.relaxed :=
 (loadingConserves r).trans (everyChargeRetained r.relaxation)

theorem bothStatesBound (r : Record Part Support State ClockState Clock) : bound r.loaded ∧ bound r.relaxed :=
 ⟨everyFiniteRunBound r.loading,everyFiniteRunBound r.relaxation⟩

def record (r : Record Part Support State ClockState Clock) :=
 (r,field r,DiffusionHistory.records r.loadingRows,DiffusionHistory.records r.relaxationRows)

theorem completeInputRetained (r : Record Part Support State ClockState Clock) : (record r).1 = r := rfl

theorem completeLoadingCount (r : Record Part Support State ClockState Clock) :
 (record r).2.2.1.length = r.loadingRows.length := DiffusionHistory.exactTransitionCount _

theorem completeRelaxationCount (r : Record Part Support State ClockState Clock) :
 (record r).2.2.2.length = r.relaxationRows.length := DiffusionHistory.exactTransitionCount _

def records (rs : List (Record Part Support State ClockState Clock)) := rs.map record

theorem base (r : Record Part Support State ClockState Clock) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Part Support State ClockState Clock)) (r : Record Part Support State ClockState Clock) :
 records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.BoundPolarization
