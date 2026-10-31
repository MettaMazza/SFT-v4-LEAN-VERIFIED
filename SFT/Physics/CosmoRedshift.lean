import SFT.Physics.GravityHorizon
import SFT.Physics.WaveSpeedRelation
namespace SFT.Physics.CosmoRedshift
open SFT.Foundation.ExactOperations

structure Record (Emission Observation SourceClock ObserverClock Cell Carrier : Type) where
 source : QuantityCarrier.Observation Carrier
 emitted : WavePeriodFrequency.Wave Emission SourceClock
 observed : WavePeriodFrequency.Wave Observation ObserverClock
 emissionEvent : MechanicalEvents.Event Cell
 observationEvent : MechanicalEvents.Event Cell
 adjacent : MechanicalEvents.Event Cell → MechanicalEvents.Event Cell → Prop
 path : FieldLocality.Propagation adjacent emissionEvent observationEvent
 sourceLabel : String
 detectorLabel : String

variable {Emission Observation SourceClock ObserverClock Cell Carrier : Type}

def ratio (record : Record Emission Observation SourceClock ObserverClock Cell Carrier) :=
 MechanicalVelocity.quotient (WavePeriodFrequency.frequency record.emitted) (WavePeriodFrequency.frequency record.observed)

theorem exactFrequencyRatio (record : Record Emission Observation SourceClock ObserverClock Cell Carrier) :
 ((WavePeriodFrequency.frequency record.emitted).numerator * (WavePeriodFrequency.frequency record.observed).denominator) * (ratio record).denominator =
 (ratio record).numerator * ((WavePeriodFrequency.frequency record.emitted).denominator * (WavePeriodFrequency.frequency record.observed).numerator) :=
 MechanicalVelocity.quotientExact _ _

theorem positiveRatio (record : Record Emission Observation SourceClock ObserverClock Cell Carrier) :
 0 < (ratio record).numerator := (ratio record).positive

theorem forcedRatioUnique (record : Record Emission Observation SourceClock ObserverClock Cell Carrier) (candidate : PositiveFraction)
 (sameCounts : ((WavePeriodFrequency.frequency record.emitted).numerator * (WavePeriodFrequency.frequency record.observed).denominator) * candidate.denominator =
 candidate.numerator * ((WavePeriodFrequency.frequency record.emitted).denominator * (WavePeriodFrequency.frequency record.observed).numerator)) :
 candidate=ratio record := by
 let n := (WavePeriodFrequency.frequency record.emitted).numerator * (WavePeriodFrequency.frequency record.observed).denominator
 let d := (WavePeriodFrequency.frequency record.emitted).denominator * (WavePeriodFrequency.frequency record.observed).numerator
 have hn : 0<n := Nat.mul_pos (WavePeriodFrequency.frequency record.emitted).positive
  (Nat.pos_of_ne_zero (WavePeriodFrequency.frequency record.observed).denominatorNonzero)
 have hd : 0<d := Nat.mul_pos (Nat.pos_of_ne_zero (WavePeriodFrequency.frequency record.emitted).denominatorNonzero)
  (WavePeriodFrequency.frequency record.observed).positive
 exact (FieldGeometricDilution.positiveNormalizationRepresents n d hn hd candidate sameCounts).symm.trans
  (FieldGeometricDilution.positiveNormalizationRepresents n d hn hd (ratio record) (exactFrequencyRatio record))

def relabel (record : Record Emission Observation SourceClock ObserverClock Cell Carrier) (source detector : String) :=
 {record with sourceLabel:=source,detectorLabel:=detector}

theorem detectorAndSourceNamesDoNotSelectRatio (record : Record Emission Observation SourceClock ObserverClock Cell Carrier) (source detector : String) :
 ratio (relabel record source detector)=ratio record := rfl

theorem completeSourceRetained (record : Record Emission Observation SourceClock ObserverClock Cell Carrier) (source detector : String) :
 (relabel record source detector).source=record.source := rfl

theorem bothClockRecordsRetained (record : Record Emission Observation SourceClock ObserverClock Cell Carrier) (source detector : String) :
 (relabel record source detector).emitted.reference=record.emitted.reference ∧
 (relabel record source detector).observed.reference=record.observed.reference := ⟨rfl,rfl⟩

theorem completePathProvenance (record : Record Emission Observation SourceClock ObserverClock Cell Carrier) :
 (MechanicalEvents.changes (FieldLocality.trace record.path)).map (fun row => (row.sourceIdentity,row.actionRecord)) =
 MechanicalEvents.sourceRecords (FieldLocality.trace record.path) := MechanicalEvents.allSourceRecordsRetained _

theorem everyPathStepCausal (record : Record Emission Observation SourceClock ObserverClock Cell Carrier) :
 ∀ row ∈ MechanicalEvents.changes (FieldLocality.trace record.path), record.adjacent row.before row.after :=
 FieldLocality.everyTransitionAdjacent _
end SFT.Physics.CosmoRedshift
