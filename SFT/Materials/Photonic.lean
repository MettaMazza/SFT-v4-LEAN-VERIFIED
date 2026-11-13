import SFT.Physics.CollectiveBand
import SFT.Physics.FieldElectromagnetic
import SFT.Physics.WavePropagation
namespace SFT.Materials.Photonic
open SFT.Physics SFT.Mathematics.GraphOperations

-- Original FUNC-PHOTONIC: retain the complete electromagnetic cell carrier,
-- generated geometry/recurrence boundary and actual propagation records.
structure Record (P S T CS C WS WC : Type) where
 boundary : CollectiveBand.Boundary
 cells : String → FieldElectromagnetic.Carrier P S T CS C
 transport : WavePropagation.Transport WS WC String (FieldElectromagnetic.Carrier P S T CS C)
 sourceCell : String
 sourceHeld : sourceCell ∈ boundary.lattice.cells.graph.nodes
 sourceCarrier : transport.source.carrier = cells sourceCell
 adjacency : ∀ a b, transport.adjacent a b ↔ (a.carrier,b.carrier) ∈ boundary.lattice.cells.graph.edges
 arrivalWithinBoundary : ∀ a, a ∈ transport.arrivals →
   (MechanicalEvents.events (FieldLocality.trace a.propagation)).map (fun e => e.carrier) ∈ CollectiveBand.support boundary
 spectralConditions : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

variable {P S T CS C WS WC : Type}

def cellRecords (r : Record P S T CS C WS WC) :=
 r.boundary.lattice.cells.graph.nodes.map (fun cell => (cell,r.boundary.lattice.word cell,r.cells cell))

def propagationSupport (r : Record P S T CS C WS WC) := CollectiveBand.support r.boundary

def classRows (r : Record P S T CS C WS WC) (label : String) := CollectiveBand.classRows r.boundary label

theorem completeCellSupport (r : Record P S T CS C WS WC) :
 (cellRecords r).map Prod.fst = r.boundary.lattice.cells.graph.nodes := by
 unfold cellRecords
 generalize r.boundary.lattice.cells.graph.nodes = nodes
 induction nodes with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons h) ih

theorem generatedGeometryExactly (r : Record P S T CS C WS WC) (trace : List String) :
 trace ∈ CollectiveBand.generated r.boundary ↔
 0 < trace.length ∧ trace.length ≤ r.boundary.depth ∧
 ∀ cell, cell ∈ trace → cell ∈ r.boundary.lattice.cells.graph.nodes :=
 CollectiveBand.generatedExactly _ _

theorem allowedPropagationExactly (r : Record P S T CS C WS WC) (trace : List String) :
 trace ∈ propagationSupport r ↔ trace ∈ CollectiveBand.generated r.boundary ∧
 pathIsValid r.boundary.lattice.cells.graph trace = true ∧
 SFT.QuantumComputation.ReversibleModel.phaseAction r.boundary.preparation.state trace = .ok r.boundary.preparation.state :=
 CollectiveBand.bandExactly _ _

theorem completeClassExactly (r : Record P S T CS C WS WC) (label : String) (trace : List String) :
 trace ∈ classRows r label ↔ trace ∈ propagationSupport r ∧ r.boundary.observedClass trace = label :=
 CollectiveBand.classExactly _ _ _

theorem gapExactly (r : Record P S T CS C WS WC) (label : String) :
 classRows r label = [] ↔ ∀ trace, trace ∈ CollectiveBand.generated r.boundary →
 pathIsValid r.boundary.lattice.cells.graph trace = true →
 SFT.QuantumComputation.ReversibleModel.phaseAction r.boundary.preparation.state trace = .ok r.boundary.preparation.state →
 r.boundary.observedClass trace ≠ label := CollectiveBand.gapExactly _ _

theorem noCompatibleGeometryOmitted (r : Record P S T CS C WS WC) (trace : List String)
 (length : 0 < trace.length ∧ trace.length ≤ r.boundary.depth)
 (cells : ∀ cell, cell ∈ trace → cell ∈ r.boundary.lattice.cells.graph.nodes)
 (path : pathIsValid r.boundary.lattice.cells.graph trace = true)
 (phase : SFT.QuantumComputation.ReversibleModel.phaseAction r.boundary.preparation.state trace = .ok r.boundary.preparation.state) :
 trace ∈ propagationSupport r := CollectiveBand.everyCompatiblePathIncluded _ _ length cells path phase

theorem completeRecurrenceIncluded (r : Record P S T CS C WS WC) (trace : List String)
 (generated : trace ∈ CollectiveBand.generated r.boundary)
 (path : pathIsValid r.boundary.lattice.cells.graph trace = true)
 (period : trace.length = r.boundary.preparation.state.phaseCycle.length) :
 trace ∈ propagationSupport r := CollectiveBand.fullPhaseCycleIncluded _ _ generated path period

theorem electricMagneticCommonSource (r : Record P S T CS C WS WC) (cell : String) :
 (FieldElectromagnetic.magneticProjection (r.cells cell)).1.transport.charge =
 (FieldElectromagnetic.electricProjection (r.cells cell)).1.charge :=
 FieldElectromagnetic.commonSourceRetained _

theorem actualTransportSource (r : Record P S T CS C WS WC) :
 r.transport.source.carrier = r.cells r.sourceCell := r.sourceCarrier

theorem observedArrivalAllowed (r : Record P S T CS C WS WC)
 (a : FieldLocality.Arrival r.transport.adjacent r.transport.start) (held : a ∈ r.transport.arrivals) :
 (MechanicalEvents.events (FieldLocality.trace a.propagation)).map (fun e => e.carrier) ∈ propagationSupport r :=
 r.arrivalWithinBoundary a held

theorem everyObservedStepIsGeometric (r : Record P S T CS C WS WC)
 (a : FieldLocality.Arrival r.transport.adjacent r.transport.start)
 (row : MechanicalEvents.Row String) (held : row ∈ MechanicalEvents.changes (FieldLocality.trace a.propagation)) :
 (row.before.carrier,row.after.carrier) ∈ r.boundary.lattice.cells.graph.edges :=
 (r.adjacency _ _).mp (WavePropagation.actualAdjacentPath r.transport a row held)

theorem observedArrivalExcludedByGap (r : Record P S T CS C WS WC) (label : String)
 (gap : classRows r label = []) (a : FieldLocality.Arrival r.transport.adjacent r.transport.start)
 (held : a ∈ r.transport.arrivals) :
 r.boundary.observedClass ((MechanicalEvents.events (FieldLocality.trace a.propagation)).map (fun e => e.carrier)) ≠ label := by
 intro same
 have member := (completeClassExactly r label _).mpr ⟨observedArrivalAllowed r a held,same⟩
 rw [gap] at member
 cases member

theorem frequencyAtEveryCell (r : Record P S T CS C WS WC) :
 (WavePropagation.records r.transport).map (fun row => WavePeriodFrequency.frequency row.2.1) =
 r.transport.arrivals.map (fun _ => WavePeriodFrequency.frequency r.transport.wave) :=
 WavePropagation.frequencyAtEveryCell _

structure Output (P S T CS C WS WC : Type) where
 input : Record P S T CS C WS WC
 cells : List (String × List String × FieldElectromagnetic.Carrier P S T CS C)
 support : List (List String)
 propagation : List (QuantityCarrier.Observation (FieldElectromagnetic.Carrier P S T CS C) ×
   WavePeriodFrequency.Wave WS WC × MechanicalEvents.Event String × MechanicalAngularMotion.Position input.transport.wave.cycle)

def record (r : Record P S T CS C WS WC) : Output P S T CS C WS WC :=
 ⟨r,cellRecords r,propagationSupport r,WavePropagation.records r.transport⟩

theorem completeInputRetained (r : Record P S T CS C WS WC) : (record r).input = r := rfl

def records (rs : List (Record P S T CS C WS WC)) := rs.map record

theorem base (r : Record P S T CS C WS WC) : records [r] = [record r] := rfl

theorem successor (rs : List (Record P S T CS C WS WC)) (r : Record P S T CS C WS WC) :
 records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.Photonic
