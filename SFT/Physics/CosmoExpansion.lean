import SFT.Physics.CosmoRedshift
namespace SFT.Physics.CosmoExpansion
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction SFT.Mathematics.ExactRatioRelations

structure Sample (Emission Observation SourceClock ObserverClock Cell Carrier Support : Type) where
 record : CosmoRedshift.Record Emission Observation SourceClock ObserverClock Cell Carrier
 separationSupport : List Support
 present : 0 < separationSupport.length

variable {Emission Observation SourceClock ObserverClock Cell Carrier Support : Type}
local notation "ObservationSample" => Sample Emission Observation SourceClock ObserverClock Cell Carrier Support

def relativeSupport (sample : ObservationSample) := ratio sample.separationSupport.length
 (MechanicalEvents.count sample.record.observed.reference.path) sample.present sample.record.observed.reference.hasTransition

theorem exactSupportPerClock (sample : ObservationSample) :
 sample.separationSupport.length * (relativeSupport sample).denominator =
 (relativeSupport sample).numerator * MechanicalEvents.count sample.record.observed.reference.path := ratioValue _ _ _ _

structure Change (Emission Observation SourceClock ObserverClock Cell Carrier Support : Type) where
 before : Sample Emission Observation SourceClock ObserverClock Cell Carrier Support
 after : Sample Emission Observation SourceClock ObserverClock Cell Carrier Support
 sameSourceIdentity : before.record.sourceLabel=after.record.sourceLabel

local notation "SourceChange" => Change Emission Observation SourceClock ObserverClock Cell Carrier Support

def orientation (change : SourceChange) : Ordering :=
 compare ((relativeSupport change.after).numerator * (relativeSupport change.before).denominator)
         ((relativeSupport change.before).numerator * (relativeSupport change.after).denominator)

def coherent (direction : Ordering) : List SourceChange → Prop
 | [] => True
 | row::rest => orientation row=direction ∧ coherent direction rest

theorem everySourceHasCommonOrientation (direction : Ordering) (rows : List SourceChange)
 (common : coherent direction rows) (row : SourceChange) (member : row ∈ rows) : orientation row=direction := by
 induction rows with
 | nil => cases member
 | cons first rest ih =>
  cases member with
  | head => exact common.1
  | tail _ member => exact ih common.2 member

theorem successorPreservesExactlyCommonOrientation (direction : Ordering) (row : SourceChange) (rows : List SourceChange) :
 coherent direction (row::rows) ↔ orientation row=direction ∧ coherent direction rows := Iff.rfl

theorem incompatibleSourceExcludesCoherence (direction : Ordering) (rows : List SourceChange)
 (row : SourceChange) (member : row ∈ rows) (different : orientation row ≠ direction) : ¬ coherent direction rows :=
 fun common => different (everySourceHasCommonOrientation direction rows common row member)

theorem commonFiniteRefinementPreservesRatio (n d k : Nat) (hn : 0<n) (hd : 0<d) (hk : 0<k) :
 ratio (k*n) (k*d) (Nat.mul_pos hk hn) (Nat.mul_pos hk hd)=ratio n d hn hd := by
 apply FieldGeometricDilution.positiveNormalizationRepresents
 calc
  (k*n)*(ratio n d hn hd).denominator = k*(n*(ratio n d hn hd).denominator) := mulAssoc _ _ _
  _ = k*((ratio n d hn hd).numerator*d) := congrArg (fun x => k*x) (ratioValue n d hn hd)
  _ = (ratio n d hn hd).numerator*(k*d) := by rw [← mulAssoc, Nat.mul_comm k, mulAssoc]

def completeObservations (rows : List SourceChange) := rows.map (fun row => (row.before.record,row.after.record))

theorem eachSourceIdentityPreserved (row : SourceChange) : row.before.record.sourceLabel=row.after.record.sourceLabel := row.sameSourceIdentity

theorem bothCausalTracesRetained (row : SourceChange) :
 (completeObservations [row]).head? = some (row.before.record,row.after.record) := rfl
structure Census (Emission Observation SourceClock ObserverClock Cell Carrier Support : Type) where
 rows : List (Change Emission Observation SourceClock ObserverClock Cell Carrier Support)
 multiple : 2 ≤ rows.length
 distinctSources : (rows.map (fun row => row.before.record.sourceLabel)).Nodup
 direction : Ordering
 common : coherent direction rows

theorem everyRegisteredSourceAgrees (census : Census Emission Observation SourceClock ObserverClock Cell Carrier Support)
 (row : SourceChange) (member : row ∈ census.rows) : orientation row=census.direction :=
 everySourceHasCommonOrientation _ _ census.common row member

end SFT.Physics.CosmoExpansion
