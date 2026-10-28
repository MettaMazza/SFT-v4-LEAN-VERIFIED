import SFT.InformationScience.ClassicalSupport
namespace SFT.InformationScience.ClassicalLedger
open ClassicalSupport
open SFT.Mathematics.ProbabilityObservations
open SFT.Foundation.ExactOperations SFT.Foundation.Count.TraceDerivation

structure ProbabilityRow where
  observedLabel : String
  microstates : List String
  exactSupportPart : PositiveFraction

structure PushforwardRow where
  image : String
  predecessors : List String
  exactSupportPart : PositiveFraction

def probabilityRow (row : EntropyLedger.Record) : ProbabilityRow :=
  ⟨row.observation,row.microstates,row.exactSupportPart⟩

def pushforwardRow (row : EntropyLedger.Record) : PushforwardRow :=
  ⟨row.observation,row.microstates,row.exactSupportPart⟩

def probabilityLedger (support : List String) (observation : Observation) : Except String (List ProbabilityRow) :=
  match validateProbability support observation with
  | .error e => .error e
  | .ok _ => match EntropyLedger.entropyLedger support observation with
    | .error e => .error e
    | .ok rows => .ok (rows.map probabilityRow)

def pushforwardLedger (support : List String) (mapping : Observation) : Except String (List PushforwardRow) :=
  match validatePushforward support mapping with
  | .error e => .error e
  | .ok _ => match EntropyLedger.entropyLedger support mapping with
    | .error e => .error e
    | .ok rows => .ok (rows.map pushforwardRow)

theorem probabilityOutput (support : List String) (observation : Observation) (rows : List EntropyLedger.Record)
    (valid : validateProbability support observation = .ok observation)
    (h : EntropyLedger.entropyLedger support observation = .ok rows) :
    probabilityLedger support observation = .ok (rows.map probabilityRow) := by
  unfold probabilityLedger
  rw [valid,h]

theorem pushforwardOutput (support : List String) (mapping : Observation) (rows : List EntropyLedger.Record)
    (valid : validatePushforward support mapping = .ok mapping)
    (h : EntropyLedger.entropyLedger support mapping = .ok rows) :
    pushforwardLedger support mapping = .ok (rows.map pushforwardRow) := by
  unfold pushforwardLedger
  rw [valid,h]

theorem admittedLedgerExists (support : List String) (observation : Observation)
    (valid : validateProbability support observation = .ok observation) :
    ∃ rows, EntropyLedger.entropyLedger support observation = .ok rows := by
  have h := probabilityPartition _ _ valid
  exact ⟨_,EntropyLedger.ledgerOutput _ _ _ h⟩

theorem probabilityRowMeaning (support : List String) (observation : Observation) (rows : List EntropyLedger.Record)
    (h : EntropyLedger.entropyLedger support observation = .ok rows) (row : ProbabilityRow)
    (member : row ∈ rows.map probabilityRow) :
    (row.observedLabel,row.microstates) ∈ classRows support observation ∧
      row.microstates.length*row.exactSupportPart.denominator = row.exactSupportPart.numerator*support.length ∧
      0 < row.exactSupportPart.numerator := by
  obtain ⟨original,hm,eq⟩ := memMapPreimage probabilityRow row rows member
  cases eq
  exact ⟨EntropyLedger.recordClass _ _ _ h _ hm,EntropyLedger.rowExactPart _ _ _ h _ hm,original.exactSupportPart.positive⟩

theorem pushforwardRowMeaning (support : List String) (mapping : Observation) (rows : List EntropyLedger.Record)
    (h : EntropyLedger.entropyLedger support mapping = .ok rows) (row : PushforwardRow)
    (member : row ∈ rows.map pushforwardRow) :
    (row.image,row.predecessors) ∈ classRows support mapping ∧
      row.predecessors.length*row.exactSupportPart.denominator = row.exactSupportPart.numerator*support.length ∧
      0 < row.exactSupportPart.numerator := by
  obtain ⟨original,hm,eq⟩ := memMapPreimage pushforwardRow row rows member
  cases eq
  exact ⟨EntropyLedger.recordClass _ _ _ h _ hm,EntropyLedger.rowExactPart _ _ _ h _ hm,original.exactSupportPart.positive⟩

theorem probabilityProjection (rows : List EntropyLedger.Record) :
    (rows.map probabilityRow).map (fun row => (row.observedLabel,row.microstates)) =
      rows.map (fun row => (row.observation,row.microstates)) := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons (row.observation,row.microstates)) ih

theorem pushforwardProjection (rows : List EntropyLedger.Record) :
    (rows.map pushforwardRow).map (fun row => (row.image,row.predecessors)) =
      rows.map (fun row => (row.observation,row.microstates)) := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons (row.observation,row.microstates)) ih

end SFT.InformationScience.ClassicalLedger
