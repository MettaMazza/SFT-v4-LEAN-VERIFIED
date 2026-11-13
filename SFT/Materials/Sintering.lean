import SFT.Materials.PorousOrganization
import SFT.Materials.MaterialInterface
import SFT.Materials.DiffusionHistory
namespace SFT.Materials.Sintering
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.GraphOperations

-- MATERIALS_OBLIGATIONS[71]: actual interface transport and complete pore records.
structure Record (Content : Type) where
 transport : DiffusionHistory.Observation Content
 particles : MaterialInterface.Carrier
 sameLattice : particles.lattice = transport.lattice
 initialPores : PorousOrganization.Record
 finalPores : PorousOrganization.Record
 initialNetwork : initialPores.network = transport.lattice.cells.graph
 finalNetwork : finalPores.network = transport.lattice.cells.graph
 initialSolid : transport.start.map Prod.fst = initialPores.solid
 finalSolid : transport.finish.map Prod.fst = finalPores.solid
 interfaceMoves : ∀ move ∈ transport.first::transport.rest,
  (move.source,move.destination) ∈ MaterialInterface.boundary particles
 temperatureTimeLoad : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

variable {Content : Type}

def path (r : Record Content) := DiffusionHistory.records (r.transport.first::r.transport.rest)
def joinedPairs (r : Record Content) :=
 (r.transport.first::r.transport.rest).map (fun m => (m.source,m.destination))

theorem materialContentConserved (r : Record Content) :
 DiffusionHistory.content r.transport.start = DiffusionHistory.content r.transport.finish :=
 DiffusionHistory.observationConserves r.transport

theorem everyContentReadingConserved (r : Record Content) {Reading : Type}
 (observe : List Content → Reading) :
 observe (DiffusionHistory.content r.transport.start) = observe (DiffusionHistory.content r.transport.finish) :=
 congrArg observe (materialContentConserved r)

theorem fullTransportSupport (r : Record Content) :
 DiffusionHistory.supported r.transport.lattice r.transport.finish :=
 DiffusionHistory.observationSupported r.transport

theorem everyInterfaceDistinct (r : Record Content)
 (move : DiffusionHistory.Move r.transport.lattice Content)
 (held : move ∈ r.transport.first::r.transport.rest) :
 r.particles.material move.source ≠ r.particles.material move.destination :=
 ((MaterialInterface.boundaryExactly _ _).mp (r.interfaceMoves move held)).2

theorem everyJoiningPairGenerated (r : Record Content) (edge)
 (held : edge ∈ joinedPairs r) : edge ∈ MaterialInterface.boundary r.particles := by
 obtain ⟨move,member,equal⟩ := memMapPreimage _ _ _ held
 cases equal
 exact r.interfaceMoves move member

theorem everyJoiningPairHeld (r : Record Content) (edge)
 (held : edge ∈ joinedPairs r) :
 edge.1 ∈ r.particles.lattice.cells.graph.nodes ∧ edge.2 ∈ r.particles.lattice.cells.graph.nodes :=
 MaterialInterface.boundaryEndpointsHeld _ _ (everyJoiningPairGenerated r edge held)

theorem allTransportRecorded (r : Record Content)
 (move : DiffusionHistory.Move r.transport.lattice Content)
 (held : move ∈ r.transport.first::r.transport.rest) :
 DiffusionHistory.transitionRecord move ∈ path r :=
 DiffusionHistory.everyTransitionRecorded _ _ held

theorem exactPathCount (r : Record Content) : (path r).length = (r.transport.first::r.transport.rest).length :=
 DiffusionHistory.exactTransitionCount _

theorem finalPoreNotMaterial (r : Record Content) (cell : String)
 (pore : cell ∈ r.finalPores.poreGraph.nodes) : cell ∉ r.transport.finish.map Prod.fst := by
 rw [r.finalSolid]
 exact PorousOrganization.poreNotSolid r.finalPores cell pore

theorem completeFinalPartition (r : Record Content) (cell : String) :
 cell ∈ r.transport.lattice.cells.graph.nodes ↔
 cell ∈ r.transport.finish.map Prod.fst ∨ cell ∈ r.finalPores.poreGraph.nodes := by
 rw [r.finalSolid,← r.finalNetwork]
 exact r.finalPores.completePartition cell

theorem completeInitialPartition (r : Record Content) (cell : String) :
 cell ∈ r.transport.lattice.cells.graph.nodes ↔
 cell ∈ r.transport.start.map Prod.fst ∨ cell ∈ r.initialPores.poreGraph.nodes := by
 rw [r.initialSolid,← r.initialNetwork]
 exact r.initialPores.completePartition cell

theorem finalInterfaceExact (r : Record Content) (edge) : edge ∈ r.finalPores.interface ↔
 edge ∈ r.finalPores.network.edges ∧
 (SFT.Mathematics.DiscreteObjects.has r.finalPores.solid edge.1 !=
 SFT.Mathematics.DiscreteObjects.has r.finalPores.solid edge.2) = true :=
 PorousOrganization.interfaceExactly _ _

def record (r : Record Content) :=
 (r,path r,joinedPairs r,PorousOrganization.record r.initialPores,PorousOrganization.record r.finalPores)

theorem wholeInputRetained (r : Record Content) : (record r).1 = r := rfl

theorem poreReorganizationRetained (r s : Record Content)
 (different : r.finalPores.poreGraph ≠ s.finalPores.poreGraph) : record r ≠ record s :=
 fun equal => different (congrArg (fun x => x.1.finalPores.poreGraph) equal)

theorem processingBoundaryRetained (r : Record Content) :
 (record r).1.temperatureTimeLoad = r.temperatureTimeLoad := rfl

def records (rs : List (Record Content)) := rs.map record

theorem base (r : Record Content) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Content)) (r : Record Content) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.Sintering
