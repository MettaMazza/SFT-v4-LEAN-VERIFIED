import SFT.Materials.PointDefect
import SFT.Materials.DiffusionHistory
import SFT.Physics.MatterScattering
import SFT.Physics.NuclearReactions
namespace SFT.Materials.RadiationDamage
open SFT.Physics SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[75]: bind the actual probe interaction to its
-- local change and retain the complete subsequent migration/recovery path.
structure Record (P S T CS C : Type) where
 lattice : Lattice.Record
 channel : MatterScattering.Channel
 energy : MechanicalWorkEnergy.EnergyTransfer P S T CS C
 defect : PointDefect.Record lattice
 sourceBinding : defect.sourceIdentity = channel.sourceIdentity
 interactionBinding : ∃ q ∈ MechanicalEvents.changes energy.force.interval,
  q.sourceIdentity = defect.sourceIdentity ∧ q.actionRecord = defect.actionRecord
 first : MechanicalEvents.Event (String → List String)
 last : MechanicalEvents.Event (String → List String)
 recovery : MechanicalEvents.Path first last
 initialDefect : ∀ site, first.carrier site = PointDefect.actualWord defect site
 migration : List (DiffusionHistory.Observation (List String))
 transmutations : List (NuclearReactions.Reaction P S T CS C)
 doseRateSpectrum : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

variable {P S T CS C : Type}

theorem actualDefectGenerated (r : Record P S T CS C) :
 r.defect.source ∈ r.lattice.cells.graph.nodes := r.defect.generated

theorem localChangeExactly (r : Record P S T CS C) (site : String) :
 PointDefect.changedAt r.defect site ↔ site = r.defect.source :=
 PointDefect.differenceExactlyAtSource _ _

theorem initialPathContainsDefect (r : Record P S T CS C) :
 r.first.carrier r.defect.source ≠ r.lattice.word r.defect.source := by
 rw [r.initialDefect]
 exact PointDefect.changedAtSource _

theorem otherInitialSitesHeld (r : Record P S T CS C) (site : String) (other : site ≠ r.defect.source) :
 r.first.carrier site = r.lattice.word site :=
 (r.initialDefect site).trans (PointDefect.otherSiteUnchanged _ site other)

theorem actualProbeAction (r : Record P S T CS C) :
 ∃ q ∈ MechanicalEvents.changes r.energy.force.interval,
 q.sourceIdentity = r.channel.sourceIdentity ∧ q.actionRecord = r.defect.actionRecord := by
 obtain ⟨q,held,source,action⟩ := r.interactionBinding
 exact ⟨q,held,source.trans r.sourceBinding,action⟩

theorem completeEnergyInteractions (r : Record P S T CS C) :
 (MechanicalWorkEnergy.interactionCells r.energy).map Prod.fst =
 MechanicalEvents.changes r.energy.force.interval := MechanicalWorkEnergy.retainsEveryTransferRow _

theorem actualEnergyComposition (r : Record P S T CS C) :
 MechanicalWorkEnergy.value r.energy =
 SFT.Mathematics.FoldScalar.multiply (MechanicalForce.value r.energy.force)
 (MechanicalWorkEnergy.displacementScalar r.energy.displacement) := rfl

theorem completeRecoveryStateCount (r : Record P S T CS C) :
 (MechanicalEvents.events r.recovery).length = MechanicalEvents.count r.recovery+1 :=
 MechanicalEvents.completeEventCount _

theorem completeRecoveryProvenance (r : Record P S T CS C) :
 (MechanicalEvents.changes r.recovery).map (fun q => (q.sourceIdentity,q.actionRecord)) =
 MechanicalEvents.sourceRecords r.recovery := MechanicalEvents.allSourceRecordsRetained _

def recoveredAt (r : Record P S T CS C) (site : String) : Prop := r.last.carrier site = r.lattice.word site

theorem recoveryTestExact (r : Record P S T CS C) (site : String) :
 recoveredAt r site ↔ r.last.carrier site = r.lattice.word site := Iff.rfl

theorem retainedDepartureNotRecovered (r : Record P S T CS C) (site : String)
 (changed : r.last.carrier site ≠ r.lattice.word site) : ¬ recoveredAt r site := changed

theorem everyMigrationConserves (r : Record P S T CS C)
 (m : DiffusionHistory.Observation (List String)) (_held : m ∈ r.migration) :
 DiffusionHistory.content m.start = DiffusionHistory.content m.finish := DiffusionHistory.observationConserves _

theorem everyMigrationSupported (r : Record P S T CS C)
 (m : DiffusionHistory.Observation (List String)) (_held : m ∈ r.migration) :
 DiffusionHistory.supported m.lattice m.finish := DiffusionHistory.observationSupported _

theorem everyTransmutationConserves (r : Record P S T CS C)
 (n : NuclearReactions.Reaction P S T CS C) (_held : n ∈ r.transmutations) :
 (NuclearReactions.sourceLedger n).map Prod.snd = (NuclearReactions.targetLedger n).map Prod.snd :=
 NuclearReactions.completeCarrierClosure _

structure TransmutationRecord (P S T CS C : Type) where
 reaction : NuclearReactions.Reaction P S T CS C
 source : List (NuclearReactions.Endpoint (reaction.moreInputs.length+1) × NuclearReactions.Carrier P S T CS C × SFT.Host.Canonical.Value)
 target : List (NuclearReactions.Endpoint (reaction.moreOutputs.length+1) × NuclearReactions.Carrier P S T CS C × SFT.Host.Canonical.Value)

def transmutationRecord (n : NuclearReactions.Reaction P S T CS C) : TransmutationRecord P S T CS C :=
 ⟨n,NuclearReactions.sourceLedger n,NuclearReactions.targetLedger n⟩

def record (r : Record P S T CS C) :=
 (r,MechanicalWorkEnergy.interactionCells r.energy,
 PointDefect.observation r.defect "dose-rate-spectrum-bounded",
 MechanicalEvents.events r.recovery,MechanicalEvents.changes r.recovery,
 r.migration.map DiffusionHistory.observationRecord,
 r.transmutations.map transmutationRecord)

theorem wholeInputRetained (r : Record P S T CS C) : (record r).1 = r := rfl

theorem everyMigrationRecorded (r : Record P S T CS C)
 (m : DiffusionHistory.Observation (List String)) (held : m ∈ r.migration) :
 DiffusionHistory.observationRecord m ∈ r.migration.map DiffusionHistory.observationRecord := memMap _ _ _ held

theorem spectrumBoundaryHeld (r : Record P S T CS C) : (record r).1.doseRateSpectrum = r.doseRateSpectrum := rfl

def records (rs : List (Record P S T CS C)) := rs.map record

theorem base (r : Record P S T CS C) : records [r] = [record r] := rfl

theorem successor (rs : List (Record P S T CS C)) (r : Record P S T CS C) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.RadiationDamage
