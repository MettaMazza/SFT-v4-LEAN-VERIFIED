import SFT.Materials.NucleationCritical
namespace SFT.Materials.NucleationGrowth
open NucleationBoundary
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

structure Step (prior next : Cluster) where
 cell : String
 fresh : cell ∉ prior.cells
 appended : next.cells=prior.cells++[cell]
 samePhase : next.phase=prior.phase
 sameCondition : next.condition=prior.condition
 compatible : persists next=true
 transfer : SFT.Physics.MechanicalConservation.Transfer String String
 arrived : transfer.destination=cell

theorem retainedPriorCells {prior next : Cluster} (step : Step prior next)
 (cell : String) (held : cell∈prior.cells) : cell∈next.cells :=
 step.appended.symm ▸ memAppendLeft cell prior.cells [step.cell] held

theorem oneCellAdded {prior next : Cluster} (step : Step prior next) : next.cells.length=prior.cells.length+1 := by
 rw [step.appended,appendLength]
 rfl

inductive History : Cluster → Cluster → Type where
 | initial (cluster : Cluster) : History cluster cluster
 | append {start prior next : Cluster} (history : History start prior) (step : Step prior next) : History start next

def clusters {start : Cluster} : {finish : Cluster} → History start finish → List Cluster
 | _, .initial _ => [start]
 | next, .append history _ => clusters history++[next]

def transfers {start finish : Cluster} : History start finish → List (SFT.Physics.MechanicalConservation.Transfer String String)
 | .initial _ => []
 | .append history step => transfers history++[step.transfer]

theorem phaseRetained {start finish : Cluster} (history : History start finish) : finish.phase=start.phase := by
 induction history with
 | initial => rfl
 | append history step ih => exact step.samePhase.trans ih

theorem conditionRetained {start finish : Cluster} (history : History start finish) : finish.condition=start.condition := by
 induction history with
 | initial => rfl
 | append history step ih => exact step.sameCondition.trans ih

theorem initialCellsRetained {start finish : Cluster} (history : History start finish) (cell : String)
 (held : cell∈start.cells) : cell∈finish.cells := by
 induction history with
 | initial => exact held
 | append history step ih => exact retainedPriorCells step cell ih

theorem recurrenceRetained {start finish : Cluster} (history : History start finish) (initial : persists start=true) :
 persists finish=true := by
 cases history with
 | initial => exact initial
 | append history step => exact step.compatible

theorem exactGrowthCount {start finish : Cluster} (history : History start finish) :
 finish.cells.length=start.cells.length+(transfers history).length := by
 induction history with
 | initial => rfl
 | append history step ih =>
   rw [oneCellAdded step,ih]
   change _ = start.cells.length+(transfers history++[step.transfer]).length
   rw [appendLength]
   rfl

theorem historyLength {start finish : Cluster} (history : History start finish) :
 (clusters history).length=(transfers history).length+1 := by
 induction history with
 | initial => rfl
 | append history step ih =>
   change (clusters history++[_]).length=(transfers history++[step.transfer]).length+1
   rw [appendLength,appendLength,ih]
   rfl

theorem previousClusterRetained {start prior next : Cluster} (history : History start prior) (step : Step prior next)
 (cluster : Cluster) (held : cluster∈clusters history) : cluster∈clusters (.append history step) :=
 memAppendLeft _ _ _ held

theorem completeGrowthTransfersPaired {start finish : Cluster} (history : History start finish) :
 SFT.Physics.MechanicalConservation.outgoingSupport (transfers history)=
 SFT.Physics.MechanicalConservation.incomingSupport (transfers history) :=
 SFT.Physics.MechanicalConservation.completeConservation _

def provenance {start finish : Cluster} (history : History start finish) :=
 ((clusters history).map Cluster.provenance,
 (transfers history).map (fun t => (t.sourceIdentity,t.actionRecord)))

theorem everyTransferProvenanceRetained {start finish : Cluster} (history : History start finish)
 (transfer : SFT.Physics.MechanicalConservation.Transfer String String) (held : transfer∈transfers history) :
 (transfer.sourceIdentity,transfer.actionRecord)∈(provenance history).2 := memMap _ _ _ held
end SFT.Materials.NucleationGrowth
