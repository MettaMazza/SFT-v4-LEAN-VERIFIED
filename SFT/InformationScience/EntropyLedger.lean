import SFT.InformationScience.EntropyRefinement
namespace SFT.InformationScience.EntropyLedger
open EntropyPartition
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.ProbabilityObservations
open SFT.Foundation.ExactOperations SFT.Foundation.Count.TraceDerivation

structure Record where
  observation : String
  exactSupportPart : PositiveFraction
  microstates : List String
  unresolvedDistinctions : Uncertainty

theorem supportPositive (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) : 0 < support.length := by
  have ne := ((validityMeaning _ _).mp (partitionResult _ _ _ h).1).1
  cases support with
  | nil => cases ne
  | cons _ _ => exact Nat.zero_lt_succ _

theorem membersPositive (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) (row : String × List String)
    (hr : row ∈ partition) : 0 < row.2.length := by
  obtain ⟨state,hs⟩ := partitionNonemptyClass _ _ _ h row.1 row.2 hr
  cases row with
  | mk label members =>
    cases members with
    | nil => cases hs
    | cons _ _ => exact Nat.zero_lt_succ _

def makeRecord (support : List String) (positive : 0 < support.length) (row : String × List String)
    (nonempty : 0 < row.2.length) : Record :=
  ⟨row.1,normalizePositive row.2.length support.length nonempty positive,row.2,unresolvedPairs row.2⟩

def ledgerRows (support : List String) (positive : 0 < support.length) :
    (partition : Partition) → (∀ row, row ∈ partition → 0 < row.2.length) → List Record
  | [],_ => []
  | row :: rest,nonempty => makeRecord support positive row (nonempty row (List.Mem.head _)) ::
      ledgerRows support positive rest (fun held member => nonempty held (List.Mem.tail row member))

def entropyLedger (support : List String) (observation : Observation) : Except String (List Record) :=
  match h : exactPartition support observation with
  | .error e => .error e
  | .ok partition => .ok (ledgerRows support (supportPositive _ _ _ h) partition (membersPositive _ _ _ h))

theorem ledgerProjection (support : List String) (positive : 0 < support.length) (partition : Partition)
    (nonempty : ∀ row, row ∈ partition → 0 < row.2.length) :
    (ledgerRows support positive partition nonempty).map (fun row => (row.observation,row.microstates)) = partition := by
  induction partition with
  | nil => rfl
  | cons row rest ih =>
    exact congrArg (List.cons row) (ih (fun held member => nonempty held (List.Mem.tail row member)))

theorem ledgerMembership (support : List String) (positive : 0 < support.length) (partition : Partition)
    (nonempty : ∀ row, row ∈ partition → 0 < row.2.length) (record : Record) :
    record ∈ ledgerRows support positive partition nonempty ↔
      ∃ row, ∃ hr : row ∈ partition, record = makeRecord support positive row (nonempty row hr) := by
  induction partition with
  | nil => constructor; intro h; cases h; intro ⟨_,h,_⟩; cases h
  | cons row rest ih =>
    constructor
    · intro h
      cases h with
      | head => exact ⟨row,List.Mem.head _,rfl⟩
      | tail _ hm =>
        obtain ⟨held,hr,eq⟩ := (ih (fun held member => nonempty held (List.Mem.tail row member))).mp hm
        exact ⟨held,List.Mem.tail row hr,eq⟩
    · intro ⟨held,hr,eq⟩
      cases hr with
      | head => cases eq; exact List.Mem.head _
      | tail _ hm =>
        apply List.Mem.tail
        exact (ih (fun held member => nonempty held (List.Mem.tail row member))).mpr ⟨held,hm,eq⟩

theorem ledgerOutput (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) :
    entropyLedger support observation = .ok (ledgerRows support (supportPositive _ _ _ h) partition (membersPositive _ _ _ h)) := by
  unfold entropyLedger
  split
  · rename_i error he
    rw [h] at he; cases he
  · rename_i held he
    rw [h] at he
    cases he
    rfl

theorem ledgerPreservesError (support : List String) (observation : Observation) (error : String)
    (h : exactPartition support observation = .error error) : entropyLedger support observation = .error error := by
  unfold entropyLedger
  split
  · rename_i held he
    rw [h] at he; cases he; rfl
  · rename_i held he
    rw [h] at he; cases he

theorem ledgerData (support : List String) (observation : Observation) (records : List Record)
    (h : entropyLedger support observation = .ok records) :
    ∃ partition, ∃ hp : exactPartition support observation = .ok partition,
      records = ledgerRows support (supportPositive _ _ _ hp) partition (membersPositive _ _ _ hp) := by
  unfold entropyLedger at h
  split at h
  · cases h
  · rename_i partition hp
    exact ⟨partition,hp,(Except.ok.inj h).symm⟩

theorem entropyProvenance (support : List String) (observation : Observation) (records : List Record)
    (h : entropyLedger support observation = .ok records) :
    records.map (fun row => (row.observation,row.microstates)) = SFT.Mathematics.ProbabilityObservations.classRows support observation := by
  obtain ⟨partition,hp,eq⟩ := ledgerData _ _ _ h
  rw [eq,ledgerProjection]
  exact (partitionResult _ _ _ hp).2

theorem rowUncertainty (support : List String) (observation : Observation) (records : List Record)
    (h : entropyLedger support observation = .ok records) (record : Record) (hr : record ∈ records) :
    record.unresolvedDistinctions = unresolvedPairs record.microstates := by
  obtain ⟨partition,hp,eq⟩ := ledgerData _ _ _ h
  rw [eq] at hr
  obtain ⟨row,_,he⟩ := (ledgerMembership _ _ _ _ _).mp hr
  cases he; rfl

theorem rowExactPart (support : List String) (observation : Observation) (records : List Record)
    (h : entropyLedger support observation = .ok records) (record : Record) (hr : record ∈ records) :
    record.microstates.length * record.exactSupportPart.denominator =
      record.exactSupportPart.numerator * support.length := by
  obtain ⟨partition,hp,eq⟩ := ledgerData _ _ _ h
  rw [eq] at hr
  obtain ⟨row,hm,he⟩ := (ledgerMembership _ _ _ _ _).mp hr
  cases he
  exact normalizedValuePreserved row.2.length support.length (membersPositive _ _ _ hp row hm) (supportPositive _ _ _ hp)

theorem filterLengthBound (p : String → Bool) (states : List String) : (states.filter p).length ≤ states.length := by
  induction states with
  | nil => exact Nat.le_refl _
  | cons state rest ih =>
    change (match p state with | true => state :: rest.filter p | false => rest.filter p).length ≤ rest.length+1
    cases p state with
    | true => exact Nat.succ_le_succ ih
    | false => exact Nat.le_trans ih (Nat.le_succ _)

theorem rowPartThroughOne (support : List String) (observation : Observation) (records : List Record)
    (h : entropyLedger support observation = .ok records) (record : Record) (hr : record ∈ records) :
    record.exactSupportPart.numerator ≤ record.exactSupportPart.denominator := by
  obtain ⟨partition,hp,eq⟩ := ledgerData _ _ _ h
  rw [eq] at hr
  obtain ⟨row,hm,he⟩ := (ledgerMembership _ _ _ _ _).mp hr
  cases he
  apply normalizedThroughOne row.2.length support.length (membersPositive _ _ _ hp row hm) (supportPositive _ _ _ hp)
  have members := ((partitionMembership _ _ _ hp row.1 row.2).mp hm).2
  rw [members]
  exact filterLengthBound _ _

theorem recordClass (support : List String) (observation : Observation) (records : List Record)
    (h : entropyLedger support observation = .ok records) (record : Record) (hr : record ∈ records) :
    (record.observation,record.microstates) ∈ SFT.Mathematics.ProbabilityObservations.classRows support observation := by
  rw [← entropyProvenance _ _ _ h]
  exact memMap (fun row : Record => (row.observation,row.microstates)) record records hr

end SFT.InformationScience.EntropyLedger
