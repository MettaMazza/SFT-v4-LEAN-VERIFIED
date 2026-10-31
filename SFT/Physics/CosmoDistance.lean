import SFT.Physics.CosmoLensing
namespace SFT.Physics.CosmoDistance

variable {Emission Observation SourceClock ObserverClock Cell Carrier : Type}
local notation "ObservationRecord" => CosmoRedshift.Record Emission Observation SourceClock ObserverClock Cell Carrier

def supportAndClocks (record : ObservationRecord) :=
 (record.source,record.emissionEvent,record.observationEvent,
 MechanicalEvents.changes (FieldLocality.trace record.path),record.emitted,record.observed)

def equivalent (left right : ObservationRecord) : Prop := supportAndClocks left=supportAndClocks right

theorem supportEquivalenceReflexive (record : ObservationRecord) : equivalent record record := rfl

theorem supportEquivalenceSymmetric (left right : ObservationRecord) (same : equivalent left right) : equivalent right left := same.symm

theorem supportEquivalenceTransitive (first middle last : ObservationRecord)
 (a : equivalent first middle) (b : equivalent middle last) : equivalent first last := a.trans b

def exactClass (representative : ObservationRecord) : ObservationRecord → Prop := equivalent representative

theorem classMembershipExactly (representative record : ObservationRecord) :
 exactClass representative record ↔ supportAndClocks representative=supportAndClocks record := Iff.rfl

inductive ProjectionKind where
 | luminosity | propagation | simultaneousSeparation

structure Projection (Emission Observation SourceClock ObserverClock Cell Carrier : Type) where
 kind : ProjectionKind
 record : CosmoRedshift.Record Emission Observation SourceClock ObserverClock Cell Carrier

local notation "DistanceProjection" => Projection Emission Observation SourceClock ObserverClock Cell Carrier

def sameProjection (left right : DistanceProjection) : Prop := left.kind=right.kind ∧ equivalent left.record right.record

theorem differentNotionsRemainDistinct (left right : DistanceProjection) (different : left.kind ≠ right.kind) : ¬ sameProjection left right :=
 fun same => different same.1

theorem namingDoesNotAlterSupportClass (record : ObservationRecord) (source detector : String) :
 equivalent record (CosmoRedshift.relabel record source detector) := rfl

theorem everyCausalStepRetained (record : ObservationRecord) :
 (supportAndClocks record).2.2.2.1=MechanicalEvents.changes (FieldLocality.trace record.path) := rfl

theorem bothRecurrenceCarriersRetained (record : ObservationRecord) :
 (supportAndClocks record).2.2.2.2=(record.emitted,record.observed) := rfl

end SFT.Physics.CosmoDistance
