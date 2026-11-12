import SFT.Materials.Lattice
import SFT.Physics.ThermoPhaseEquilibrium
import SFT.Mathematics.GraphPathSoundness
namespace SFT.Materials.NucleationBoundary
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Physics
open SFT.Foundation.Count.TraceDerivation

-- Each row is a retained recurrence across an actual cluster-boundary edge.
structure Recurrence where
 edge : Edge
 before : ThermoTemperature.Macrostate
 after : ThermoTemperature.Macrostate
 transfer : MechanicalConservation.Transfer String String
 sourceAtEdge : transfer.source=edge.1
 destinationAtEdge : transfer.destination=edge.2

def retained (row : Recurrence) : Bool :=
 decide (ThermoEquilibrium.classView row.before=ThermoEquilibrium.classView row.after)

theorem retainedExactly (row : Recurrence) : retained row=true ↔
 row.before.label=row.after.label ∧ row.before.members=row.after.members := by
 constructor
 · intro passed
   have same := of_decide_eq_true passed
   exact ⟨congrArg Prod.fst same,congrArg Prod.snd same⟩
 · intro same
   apply decide_eq_true
   exact Prod.ext same.1 same.2

structure Cluster where
 lattice : Lattice.Record
 cells : List String
 boundary : List Edge
 completeBoundary : crossingCut lattice.cells.graph cells = .ok boundary
 recurrences : List Recurrence
 completeRecurrences : recurrences.map Recurrence.edge=boundary
 phase : String
 phaseBound : ∀ row, row ∈ recurrences → row.before.label=phase
 condition : String
 provenance : SFT.Host.Canonical.Value

def persists (cluster : Cluster) : Bool := cluster.recurrences.all retained

theorem persistsExactly (cluster : Cluster) : persists cluster=true ↔
 ∀ row, row ∈ cluster.recurrences →
 row.before.label=row.after.label ∧ row.before.members=row.after.members := by
 constructor
 · intro passed row member
   exact (retainedExactly row).mp ((allTrueIffMembers _ _).mp passed row member)
 · intro all
   exact (allTrueIffMembers _ _).mpr (fun row member => (retainedExactly row).mpr (all row member))

theorem everyBoundaryRow (cluster : Cluster) (edge : Edge) (held : edge ∈ cluster.boundary) :
 ∃ row, row ∈ cluster.recurrences ∧ row.edge=edge := by
 rw [← cluster.completeRecurrences] at held
 exact memMapPreimage Recurrence.edge edge cluster.recurrences held

theorem exactBoundary (cluster : Cluster) (edge : Edge) : edge ∈ cluster.boundary ↔
 edge ∈ cluster.lattice.cells.graph.edges ∧ (has cluster.cells edge.1 != has cluster.cells edge.2)=true :=
 cutMembership _ _ _ cluster.completeBoundary edge

theorem changedBoundaryRowRejected (cluster : Cluster) (row : Recurrence)
 (held : row ∈ cluster.recurrences)
 (changed : row.before.label≠row.after.label ∨ row.before.members≠row.after.members) :
 persists cluster≠true := by
 intro passed
 have fixed := (persistsExactly cluster).mp passed row held
 cases changed with
 | inl h => exact h fixed.1
 | inr h => exact h fixed.2

theorem phasePersistsAcrossCompleteBoundary (cluster : Cluster) (passed : persists cluster=true)
 (row : Recurrence) (held : row ∈ cluster.recurrences) : row.after.label=cluster.phase :=
 ((persistsExactly cluster).mp passed row held).1.symm.trans (cluster.phaseBound row held)

def transfers (cluster : Cluster) := cluster.recurrences.map Recurrence.transfer

theorem completeTransferBalance (cluster : Cluster) :
 MechanicalConservation.outgoingSupport (transfers cluster)=MechanicalConservation.incomingSupport (transfers cluster) :=
 MechanicalConservation.completeConservation _

theorem everyTransferBound (cluster : Cluster) (row : Recurrence) (held : row ∈ cluster.recurrences) :
 (row.transfer.source,row.transfer.destination) ∈ cluster.boundary := by
 rw [row.sourceAtEdge,row.destinationAtEdge]
 rw [← cluster.completeRecurrences]
 exact memMap Recurrence.edge row cluster.recurrences held
end SFT.Materials.NucleationBoundary
