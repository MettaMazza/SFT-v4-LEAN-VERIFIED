import SFT.Materials.NucleationGrowth
import SFT.Physics.MechanicalLocation
namespace SFT.Materials.Solidification
open SFT.Physics SFT.Foundation.Count.TraceDerivation
open NucleationBoundary

-- MATERIALS_OBLIGATIONS[70]: the complete nucleation/growth path,
-- with mobile/position-retaining observations and separate transfer ledgers.
structure Record (Energy : Type) where
 candidates : List Cluster
 nucleus : Cluster
 selected : nucleus ∈ NucleationCritical.nuclei candidates
 finish : Cluster
 growth : NucleationGrowth.History nucleus finish
 mobile : List (MechanicalLocation.Displacement String)
 retainedPositions : MechanicalDuration.Recurrence (List (MechanicalLocation.Location String))
 positionSupport : retainedPositions.first.carrier.map MechanicalLocation.Location.support = finish.cells
 latent : MechanicalConservation.Network String Energy
 rejection : MechanicalConservation.Network String String
 rejectionSources : ∀ t ∈ rejection, t.source ∈ finish.cells
 rejectionDestinations : ∀ t ∈ rejection, t.destination ∉ finish.cells
 rateGradientBoundary : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

variable {Energy : Type}

theorem leastPersistentNucleus (r : Record Energy) :
 NucleationCritical.Least r.candidates r.nucleus :=
 (NucleationCritical.nucleiExactly _ _).mp r.selected

theorem allMinimalAlternativesRetained (r : Record Energy) (c : Cluster)
 (least : NucleationCritical.Least r.candidates c) : c ∈ NucleationCritical.nuclei r.candidates :=
 (NucleationCritical.nucleiExactly _ _).mpr least

theorem finalPhasePersists (r : Record Energy) : persists r.finish = true :=
 NucleationGrowth.recurrenceRetained r.growth (leastPersistentNucleus r).2.1

theorem originalPhaseHeld (r : Record Energy) : r.finish.phase = r.nucleus.phase :=
 NucleationGrowth.phaseRetained r.growth

theorem originalConditionsHeld (r : Record Energy) : r.finish.condition = r.nucleus.condition :=
 NucleationGrowth.conditionRetained r.growth

theorem exactGrowthCount (r : Record Energy) :
 r.finish.cells.length = r.nucleus.cells.length+(NucleationGrowth.transfers r.growth).length :=
 NucleationGrowth.exactGrowthCount r.growth

theorem completeIntermediateClusters (r : Record Energy) :
 (NucleationGrowth.clusters r.growth).length = (NucleationGrowth.transfers r.growth).length+1 :=
 NucleationGrowth.historyLength r.growth

theorem nucleusRetained (r : Record Energy) (cell : String) (held : cell ∈ r.nucleus.cells) : cell ∈ r.finish.cells :=
 NucleationGrowth.initialCellsRetained r.growth cell held

theorem finalPositionsHeld (r : Record Energy) :
 r.retainedPositions.last.carrier.map MechanicalLocation.Location.support = r.finish.cells :=
 (congrArg (List.map MechanicalLocation.Location.support) r.retainedPositions.returnsToCarrier).trans r.positionSupport

theorem mobileSeparationRetained (r : Record Energy) (d : MechanicalLocation.Displacement String)
 (_held : d ∈ r.mobile) : 0 < d.separation.numerator := MechanicalLocation.separationPositive d

theorem latentTransferConserved (r : Record Energy) :
 MechanicalConservation.outgoingSupport r.latent = MechanicalConservation.incomingSupport r.latent :=
 MechanicalConservation.completeConservation r.latent

theorem rejectedConstituentsConserved (r : Record Energy) :
 MechanicalConservation.outgoingSupport r.rejection = MechanicalConservation.incomingSupport r.rejection :=
 MechanicalConservation.completeConservation r.rejection

theorem rejectionCrossesBoundary (r : Record Energy) (t : MechanicalConservation.Transfer String String)
 (held : t ∈ r.rejection) : t.source ∈ r.finish.cells ∧ t.destination ∉ r.finish.cells :=
 ⟨r.rejectionSources t held,r.rejectionDestinations t held⟩

theorem completeInterfaceRecurrence (r : Record Energy) (edge : SFT.Mathematics.GraphOperations.Edge)
 (held : edge ∈ r.finish.boundary) :
 ∃ row ∈ r.finish.recurrences, row.edge = edge := everyBoundaryRow r.finish edge held

theorem interfacePhaseHeld (r : Record Energy) (row : Recurrence) (held : row ∈ r.finish.recurrences) :
 row.after.label = r.finish.phase := phasePersistsAcrossCompleteBoundary _ (finalPhasePersists r) row held

def record (r : Record Energy) :=
 (r,NucleationCritical.nuclei r.candidates,NucleationGrowth.clusters r.growth,
 NucleationGrowth.transfers r.growth,NucleationGrowth.provenance r.growth,
 r.latent,r.rejection,r.finish.boundary,r.finish.recurrences)

theorem wholeInputRetained (r : Record Energy) : (record r).1 = r := rfl

theorem everyGrowthProvenance (r : Record Energy) (t : MechanicalConservation.Transfer String String)
 (held : t ∈ NucleationGrowth.transfers r.growth) :
 (t.sourceIdentity,t.actionRecord) ∈ (NucleationGrowth.provenance r.growth).2 :=
 NucleationGrowth.everyTransferProvenanceRetained r.growth t held

theorem changedRejectionDistinguished (r s : Record Energy)
 (different : r.rejection ≠ s.rejection) : record r ≠ record s :=
 fun same => different (congrArg (fun x => x.1.rejection) same)

theorem boundaryRetained (r : Record Energy) : (record r).1.rateGradientBoundary = r.rateGradientBoundary := rfl

def records (rs : List (Record Energy)) := rs.map record

theorem base (r : Record Energy) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Energy)) (r : Record Energy) :
 records (rs++[r]) = records rs++[record r] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.Solidification
