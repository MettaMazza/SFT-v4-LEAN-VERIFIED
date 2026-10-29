import SFT.Computation.CompletenessResources
namespace SFT.Computation.ProfileResources
open BoundResources
open SFT.Foundation.ExactOperations
open SFT.Mathematics.DiscreteObjects

-- One record per declared support cell; repeated instances retain their exact
-- multiplicity, while the source support relation supplies cell provenance.
def totalCost (measure : Measure) : List Record → Nat
 | [] => 0
 | record :: rest => measured measure record.resources + totalCost measure rest

theorem measuredPositive (registry : List (String × UniversalInterpretation.Request))
    (record : Record) (valid : Verified registry record) (measure : Measure) :
    0 < measured measure record.resources := by
  have guards := (ResourceRecord.ledgerMeaning _ _ _).mp valid.2.2
  have counts := exactMeasure _ _ valid
  cases measure with
  | time =>
    rw [counts.1]
    cases h : record.observed with
    | nil => rw [h] at guards; cases guards.2.1
    | cons first rest => exact Nat.zero_lt_succ _
  | space =>
    rw [counts.2]
    cases h : record.occupied with
    | nil => rw [h] at guards; cases guards.2.2.1
    | cons first rest => exact Nat.zero_lt_succ _

theorem totalPositive (registry : List (String × UniversalInterpretation.Request))
    (head : Record) (rest : List Record) (valid : Verified registry head) (measure : Measure) :
    0 < totalCost measure (head :: rest) :=
  Nat.lt_of_lt_of_le (measuredPositive _ _ valid measure) (Nat.le_add_right _ _)

def exactAverage (registry : List (String × UniversalInterpretation.Request))
    (head : Record) (rest : List Record) (valid : Verified registry head) (measure : Measure) : PositiveFraction :=
  normalizePositive (totalCost measure (head :: rest)) (rest.length + 1)
    (totalPositive _ _ _ valid measure) (Nat.zero_lt_succ _)

theorem averageValuePreserved (registry : List (String × UniversalInterpretation.Request))
    (head : Record) (rest : List Record) (valid : Verified registry head) (measure : Measure) :
    (exactAverage registry head rest valid measure).numerator * (rest.length + 1) =
      totalCost measure (head :: rest) * (exactAverage registry head rest valid measure).denominator :=
  (normalizedValuePreserved _ _ _ _).symm

def greatestClass (measure : Measure) (records : List Record) (peak : Record) : List Record :=
  records.filter fun record => decide (measured measure record.resources = measured measure peak.resources)

theorem greatestClassMeaning (measure : Measure) (records : List Record) (peak record : Record) :
    record ∈ greatestClass measure records peak ↔ record ∈ records ∧
      measured measure record.resources = measured measure peak.resources := by
  constructor
  · intro h
    have parts := (filterMemberIff _ _ _).mp h
    exact ⟨parts.1,of_decide_eq_true parts.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem allGreatestTies (measure : Measure) (records : List Record) (peak : Record)
    (held : peak ∈ records)
    (bound : ∀ record, record ∈ records → measured measure record.resources ≤ measured measure peak.resources)
    (record : Record) : record ∈ greatestClass measure records peak ↔ record ∈ records ∧
      ∀ other, other ∈ records → measured measure other.resources ≤ measured measure record.resources := by
  constructor
  · intro h
    have parts := (greatestClassMeaning _ _ _ _).mp h
    refine ⟨parts.1,?_⟩
    intro other member
    rw [parts.2]
    exact bound other member
  · intro h
    exact (greatestClassMeaning _ _ _ _).mpr ⟨h.1,Nat.le_antisymm (bound record h.1) (h.2 peak held)⟩

theorem attainedGreatestClass (registry : List (String × UniversalInterpretation.Request))
    (measure : Measure) (head : Record) (rest : List Record)
    (verified : ∀ record, record ∈ head :: rest → Verified registry record) :
    ∃ peak, Verified registry peak ∧ peak ∈ greatestClass measure (head :: rest) peak ∧
      ∀ record, record ∈ head :: rest → measured measure record.resources ≤ measured measure peak.resources := by
  obtain ⟨peak,held,valid,bound⟩ := verifiedUpper registry measure head rest verified
  exact ⟨peak,valid,(greatestClassMeaning _ _ _ _).mpr ⟨held,rfl⟩,bound⟩

theorem totalComposition (measure : Measure) (left right : List Record) :
    totalCost measure (left ++ right) = totalCost measure left + totalCost measure right := by
  induction left with
  | nil => exact (Nat.zero_add _).symm
  | cons record rest ih =>
    change measured measure record.resources + totalCost measure (rest ++ right) = _
    rw [ih]
    exact (Nat.add_assoc _ _ _).symm

theorem totalBound (measure : Measure) (records : List Record) (bound : Nat)
    (bounded : ∀ record, record ∈ records → measured measure record.resources ≤ bound) :
    totalCost measure records ≤ records.length * bound := by
  induction records with
  | nil =>
    change 0 ≤ 0 * bound
    rw [Nat.zero_mul]
    exact Nat.le_refl _
  | cons record rest ih =>
    have step := Nat.add_le_add (bounded record (.head _)) (ih (fun other held => bounded other (.tail _ held)))
    change measured measure record.resources + totalCost measure rest ≤ (rest.length + 1) * bound
    rw [Nat.succ_mul,Nat.add_comm (rest.length * bound) bound]
    exact step

theorem successorAggregate (measure : Measure) (records : List Record) (fresh : Record) :
    totalCost measure (records ++ [fresh]) = totalCost measure records + measured measure fresh.resources := by
  exact totalComposition _ _ _

theorem singletonAggregate (measure : Measure) (record : Record) :
    totalCost measure [record] = measured measure record.resources := rfl
open SFT.InformationScience.EncodingMaps
open SFT.Mathematics.ProbabilityObservations

structure Cell where
  identity : String
  instanceName : String
  record : Record

def CompleteSupport (support : List String) (assignment : List (String × String))
    (instances : List (String × Record)) (cells : List Cell) : Prop :=
  SFT.InformationScience.ConservationLedger.validateTransformation support assignment = .ok assignment ∧
  cells.map Cell.identity = support ∧
  ∀ cell, cell ∈ cells → lookupFirst assignment cell.identity = some cell.instanceName ∧
    lookupFirst instances cell.instanceName = some cell.record

theorem distributionProvenance (support : List String) (assignment : List (String × String))
    (instances : List (String × Record)) (cells : List Cell)
    (complete : CompleteSupport support assignment instances cells)
    (cell : Cell) (held : cell ∈ cells) :
    (cell.identity,cell.instanceName) ∈ assignment ∧ (cell.instanceName,cell.record) ∈ instances :=
  ⟨lookupRow _ _ _ (complete.2.2 cell held).1,lookupRow _ _ _ (complete.2.2 cell held).2⟩

theorem completeCellCount (support : List String) (assignment : List (String × String))
    (instances : List (String × Record)) (cells : List Cell)
    (complete : CompleteSupport support assignment instances cells) :
    (cells.map Cell.record).length = support.length := by
  rw [CommunicationResources.mapLength,← complete.2.1,CommunicationResources.mapLength]

-- Positive support parts use the original exact event weighting, including
-- its original empty-One branch and canonical-support guards.
def supportPart (support held : List String) := SFT.Mathematics.ProbabilityEvents.exactWeight support held

theorem supportPartPreservesError (support held : List String) (reason : String)
    (rejected : SFT.Mathematics.ProbabilityEvents.exactEvent support held = .error reason) :
    supportPart support held = .error reason :=
  SFT.Mathematics.ProbabilityEvents.weightRetainsEventError _ _ _ rejected

theorem empiricalDistributionBoundary (preSeal mutation allRows identified : Bool)
    (accepted : SFT.Foundation.MeasurementProtocol.accepts preSeal mutation allRows identified = true) :
    preSeal = false ∧ mutation = false ∧ allRows = true ∧ identified = true :=
  (SFT.Foundation.MeasurementProtocol.acceptanceIff _ _ _ _).mp accepted
theorem completeProfileAverage (registry : List (String × UniversalInterpretation.Request))
    (support : List String) (assignment : List (String × String))
    (instances : List (String × Record)) (head : Cell) (rest : List Cell)
    (complete : CompleteSupport support assignment instances (head :: rest))
    (verified : Verified registry head.record) (measure : Measure) :
    (exactAverage registry head.record (rest.map Cell.record) verified measure).numerator * support.length =
      totalCost measure ((head :: rest).map Cell.record) *
      (exactAverage registry head.record (rest.map Cell.record) verified measure).denominator := by
  have count := completeCellCount _ _ _ _ complete
  rw [← count]
  exact averageValuePreserved _ _ _ _ _
end SFT.Computation.ProfileResources
