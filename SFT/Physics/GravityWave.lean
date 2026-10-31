import SFT.Physics.GravityFieldSource
import SFT.Physics.BoundarySupport
import SFT.Physics.WavePropagation
namespace SFT.Physics.GravityWave
open MechanicalEvents

structure Carrier (Part Support State Clock : Type)
 (adjacent : Event (GravityFieldSource.Energy Support State Clock) → Event (GravityFieldSource.Energy Support State Clock) → Prop) where
 sourceChange : GravityFieldSource.Change Support State Clock adjacent
 recurrence : MechanicalDuration.Recurrence (GravityFieldSource.Change Support State Clock adjacent)
 sourceAtStart : recurrence.first.carrier=sourceChange
 boundary : SpacetimeLimitSpeed.Elementary (GravityFieldSource.Energy Support State Clock) Clock Support adjacent
 boundarySource : boundary.relation.source=sourceChange.first
 normal : BoundarySupport.HeldNormal
 threeDirections : (BoundarySupport.spatialCarrier normal).length=3
 polarization : String
 transverse : polarization ∈ BoundarySupport.boundaryDirections normal
 momentum : MechanicalMomentum.Momentum Part Support State Clock
 sourceContent : momentum.content=sourceChange.first.carrier.content

variable {Part Support State Clock : Type}
variable {adjacent : Event (GravityFieldSource.Energy Support State Clock) → Event (GravityFieldSource.Energy Support State Clock) → Prop}

def energy (wave : Carrier Part Support State Clock adjacent) := GravityFieldSource.sourceEnergy wave.sourceChange
def speed (wave : Carrier Part Support State Clock adjacent) := SpacetimeLimitSpeed.boundaryRatio wave.boundary

theorem completeSourceRecurs (wave : Carrier Part Support State Clock adjacent) :
 wave.recurrence.last.carrier=wave.sourceChange := wave.recurrence.returnsToCarrier.trans wave.sourceAtStart

theorem everyNonnormalDirectionRetained (wave : Carrier Part Support State Clock adjacent) (direction : String) :
 direction ∈ BoundarySupport.boundaryDirections wave.normal ↔
 direction ∈ BoundarySupport.spatialCarrier wave.normal ∧ direction ≠ wave.normal.normal :=
 BoundarySupport.allNonnormalRetained wave.normal direction

theorem transverseRankTwo (wave : Carrier Part Support State Clock adjacent) :
 (BoundarySupport.boundaryDirections wave.normal).length=2 :=
 BoundarySupport.retainedRankTwo wave.normal wave.threeDirections

theorem polarizationNotLongitudinal (wave : Carrier Part Support State Clock adjacent) :
 wave.polarization ≠ wave.normal.normal := (everyNonnormalDirectionRetained wave wave.polarization).mp wave.transverse |>.2

theorem elementaryPropagation (wave : Carrier Part Support State Clock adjacent) :
 MechanicalEvents.count (FieldLocality.trace (SpacetimeEvent.completePath wave.boundary.relation))=1 :=
 SpacetimeLimitSpeed.oneElementaryRecurrence wave.boundary

theorem exactLimitingRatio (wave : Carrier Part Support State Clock adjacent) :
 (wave.boundary.relation.spatial.separation.numerator * (SpacetimeLimitSpeed.duration wave.boundary).denominator) * (speed wave).denominator =
 (speed wave).numerator * (wave.boundary.relation.spatial.separation.denominator * (SpacetimeLimitSpeed.duration wave.boundary).numerator) :=
 SpacetimeLimitSpeed.boundaryRatioExact wave.boundary

theorem positiveEnergy (wave : Carrier Part Support State Clock adjacent) :
 0 < (energy wave).numerator := GravityFieldSource.everyChangeHasPositiveSource wave.sourceChange

def detached (wave : Carrier Part Support State Clock adjacent) (records : List SFT.Host.Canonical.Value) :=
 records.map (fun record => (⟨wave,none,record⟩ : FieldRadiation.Observation _))

theorem completeDetachedRecords (wave : Carrier Part Support State Clock adjacent) (records : List SFT.Host.Canonical.Value) :
 (detached wave records).map FieldRadiation.Observation.record=records := by
 induction records with
 | nil => rfl
 | cons record rest ih => exact congrArg (List.cons record) ih

theorem completeEnergyMomentumPolarization (wave : Carrier Part Support State Clock adjacent) (records : List SFT.Host.Canonical.Value) :
 (detached wave records).map (fun obs => (energy obs.carrier,obs.carrier.momentum,obs.carrier.polarization)) =
 records.map (fun _ => (energy wave,wave.momentum,wave.polarization)) := by
 induction records with
 | nil => rfl
 | cons record rest ih => exact congrArg (List.cons (energy wave,wave.momentum,wave.polarization)) ih

theorem noContinuingContact (wave : Carrier Part Support State Clock adjacent) (records : List SFT.Host.Canonical.Value) :
 (detached wave records).map FieldRadiation.Observation.localSourceContact=records.map (fun _ => none) := by
 induction records with
 | nil => rfl
 | cons record rest ih => exact congrArg (List.cons none) ih

theorem causalSourcePath (wave : Carrier Part Support State Clock adjacent) :
 ∀ row ∈ MechanicalEvents.changes (FieldLocality.trace wave.sourceChange.propagation), adjacent row.before row.after :=
 GravityFieldSource.everyPropagationStepAdjacent wave.sourceChange

theorem completePathProvenance (wave : Carrier Part Support State Clock adjacent) :
 (MechanicalEvents.changes (FieldLocality.trace wave.sourceChange.propagation)).map (fun row => (row.sourceIdentity,row.actionRecord)) =
 MechanicalEvents.sourceRecords (FieldLocality.trace wave.sourceChange.propagation) :=
 GravityFieldSource.everySourceRecordRetained wave.sourceChange
end SFT.Physics.GravityWave
