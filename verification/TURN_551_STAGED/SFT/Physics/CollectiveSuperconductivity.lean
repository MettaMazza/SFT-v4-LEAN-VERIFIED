import SFT.Physics.CollectivePhaseOrder
import SFT.Physics.SuperconductivityLabelClosure
import SFT.Physics.SuperconductivityRecurrenceProofs
namespace SFT.Physics.CollectiveSuperconductivity
open SFT.Mathematics.GraphOperations
open SFT.QuantumComputation.ReversibleModel
open SuperconductivityLabelClosure

-- Each complete path retains its original transfer/observation record. The
-- two-way census binding includes every admitted path and excludes outsiders.
structure Transport where
 boundary : CollectiveBand.Boundary
 order : CollectivePhaseOrder.OrderedRegion
 sameGraph : order.cells.graph = boundary.lattice.cells.graph
 records : List (List String × MotionRecord String)
 complete : ∀ path, path ∈ CollectiveBand.support boundary ↔
   ∃ record, (path,record) ∈ records
 localTransfers : ∀ row, row ∈ records → ∀ transfer,
   transfer ∈ row.2.transfers.network →
   (transfer.source,transfer.destination) ∈ adjacentPairs row.1

def closed (t : Transport) : Prop :=
 ∀ row, row ∈ t.records → closedMotionDistinctions row.2 = []

theorem completeTransitionCensus (t : Transport) (path : List String) :
 path ∈ CollectiveBand.support t.boundary ↔
 ∃ record, (path,record) ∈ t.records := t.complete path

theorem everyRecordedPathReturns (t : Transport) (row : List String × MotionRecord String)
 (held : row ∈ t.records) :
 phaseAction t.boundary.preparation.state row.1 = .ok t.boundary.preparation.state := by
 have present : row.1 ∈ CollectiveBand.support t.boundary :=
   (t.complete row.1).mpr ⟨row.2,held⟩
 exact ((CollectiveBand.bandExactly _ _).mp present).2.2

theorem noUnregisteredPath (t : Transport) (row : List String × MotionRecord String)
 (held : row ∈ t.records) : row.1 ∈ CollectiveBand.generated t.boundary :=
 ((CollectiveBand.bandExactly _ _).mp ((t.complete _).mpr ⟨row.2,held⟩)).1

theorem everyTransferAdjacent (t : Transport) (row : List String × MotionRecord String)
 (held : row ∈ t.records) (transfer : MechanicalConservation.Transfer String (String × String))
 (member : transfer ∈ row.2.transfers.network) :
 (transfer.source,transfer.destination) ∈ t.boundary.lattice.cells.graph.edges := by
 have present := (t.complete row.1).mpr ⟨row.2,held⟩
 have valid := ((CollectiveBand.bandExactly _ _).mp present).2.1
 exact ((pathMeaning _ _).mp valid).2.2 _ (t.localTransfers row held transfer member)

theorem closureExactly (t : Transport) : closed t ↔
 ∀ row, row ∈ t.records → ∀ pair,
   pair ∈ SFT.InformationScience.EncodingLoss.sourcePairs row.2.transfers.sourceSupport →
   collectiveLabel row.2 pair.1 = collectiveLabel row.2 pair.2 →
   SFT.Mathematics.GeometryTopology.image row.2.transfers.receiver pair.1 =
     SFT.Mathematics.GeometryTopology.image row.2.transfers.receiver pair.2 →
   motionLabel row.2 pair.1 = motionLabel row.2 pair.2 := by
 constructor
 · intro h row held
   exact (emptyClosureIffMotionDistinctionsRetained row.2).mp (h row held)
 · intro h row held
   exact (emptyClosureIffMotionDistinctionsRetained row.2).mpr (h row held)

theorem closedTransportExcludesLostMotion (t : Transport) (h : closed t)
 (row : List String × MotionRecord String) (held : row ∈ t.records)
 (pair : String × String) (lost : pair ∈ closedMotionDistinctions row.2) : False := by
 rw [h row held] at lost
 cases lost

theorem completeCarrierConserved (t : Transport) (row : List String × MotionRecord String) :
 MechanicalConservation.outgoingSupport row.2.transfers.network =
 MechanicalConservation.incomingSupport row.2.transfers.network :=
 completeTransfersRemainConserved row.2

theorem finiteCoherentHistoryReturns (t : Transport) (paths : List (List String))
 (held : ∀ path, path ∈ paths → ∃ record, (path,record) ∈ t.records) :
 SuperconductivityRecurrenceProofs.runRecurrences t.boundary.preparation.state paths =
 .ok t.boundary.preparation.state :=
 SuperconductivityRecurrenceProofs.completeRecurrenceHistoryReturns t.boundary paths
 (fun path member => (t.complete path).mpr (held path member))

end SFT.Physics.CollectiveSuperconductivity
