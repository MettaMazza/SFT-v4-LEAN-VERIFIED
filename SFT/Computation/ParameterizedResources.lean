import SFT.Computation.ApproximationResources
namespace SFT.Computation.ParameterizedResources
open SFT.InformationScience.EncodingMaps
open SFT.Mathematics.DiscreteObjects
open CompletenessResources ReductionTrace BoundResources

-- A structural coordinate is selected by name from the retained input form.
abbrev Fields := List (String × List String)
abbrev Forms := List (String × Fields)

def extract (forms : Forms) (name input : String) : Option (List String) :=
  match lookupFirst forms input with
  | none => none
  | some fields => lookupFirst fields name

def CompleteExtraction (inputs : List String) (forms : Forms) (name : String) : Prop :=
  ∀ input, input ∈ inputs → ∃ coordinate, extract forms name input = some coordinate

theorem extractionProvenance (forms : Forms) (name input : String) (coordinate : List String)
    (extracted : extract forms name input = some coordinate) :
    ∃ fields, (input,fields) ∈ forms ∧ (name,coordinate) ∈ fields := by
  unfold extract at extracted
  cases selected : lookupFirst forms input with
  | none => rw [selected] at extracted; cases extracted
  | some fields =>
    rw [selected] at extracted
    exact ⟨fields,lookupRow _ _ _ selected,lookupRow _ _ _ extracted⟩

theorem extractionUnique (forms : Forms) (name input : String) (first second : List String)
    (one : extract forms name input = some first) (two : extract forms name input = some second) :
    first = second := by
  rw [one] at two
  cases two
  rfl

def family (inputs : List String) (forms : Forms) (name : String) (coordinate : List String) : List String :=
  inputs.filter fun input => decide (extract forms name input = some coordinate)

theorem familyMeaning (inputs : List String) (forms : Forms) (name input : String) (coordinate : List String) :
    input ∈ family inputs forms name coordinate ↔ input ∈ inputs ∧ extract forms name input = some coordinate := by
  constructor
  · intro held
    have parts := (filterMemberIff _ _ _).mp held
    exact ⟨parts.1,of_decide_eq_true parts.2⟩
  · intro parts
    exact (filterMemberIff _ _ _).mpr ⟨parts.1,decide_eq_true parts.2⟩

theorem partitionCoverage (inputs : List String) (forms : Forms) (name : String)
    (complete : CompleteExtraction inputs forms name) (input : String) (held : input ∈ inputs) :
    ∃ coordinate, input ∈ family inputs forms name coordinate := by
  obtain ⟨coordinate,extracted⟩ := complete input held
  exact ⟨coordinate,(familyMeaning _ _ _ _ _).mpr ⟨held,extracted⟩⟩

theorem partitionDisjoint (inputs : List String) (forms : Forms) (name input : String)
    (first second : List String) (one : input ∈ family inputs forms name first)
    (two : input ∈ family inputs forms name second) : first = second :=
  extractionUnique _ _ _ _ _ ((familyMeaning _ _ _ _ _).mp one).2 ((familyMeaning _ _ _ _ _).mp two).2

theorem missingCoordinateExcluded (inputs : List String) (forms : Forms) (name input : String)
    (held : input ∈ inputs) (missing : extract forms name input = none) :
    ¬ CompleteExtraction inputs forms name := by
  intro complete
  obtain ⟨coordinate,found⟩ := complete input held
  rw [missing] at found
  cases found

theorem familyComposition (left right : List String) (forms : Forms) (name : String) (coordinate : List String) :
    family (left ++ right) forms name coordinate = family left forms name coordinate ++ family right forms name coordinate := by
  induction left with
  | nil => rfl
  | cons input rest ih =>
    unfold family at *
    change (input :: (rest ++ right)).filter _ = (input :: rest).filter _ ++ right.filter _
    by_cases h : extract forms name input = some coordinate
    · rw [List.filter_cons_of_pos (p := fun item => decide (extract forms name item = some coordinate)) (decide_eq_true h), List.filter_cons_of_pos (p := fun item => decide (extract forms name item = some coordinate)) (decide_eq_true h)]
      exact congrArg (List.cons input) ih
    · rw [List.filter_cons_of_neg (p := fun item => decide (extract forms name item = some coordinate)) (fun ht => h (of_decide_eq_true ht)), List.filter_cons_of_neg (p := fun item => decide (extract forms name item = some coordinate)) (fun ht => h (of_decide_eq_true ht))]
      exact ih

theorem singletonFamily (forms : Forms) (name input : String) (coordinate : List String)
    (extracted : extract forms name input = some coordinate) : family [input] forms name coordinate = [input] := by
  unfold family
  rw [List.filter_cons_of_pos (p := fun item => decide (extract forms name item = some coordinate)) (decide_eq_true extracted)]
  rfl

theorem successorFamily (inputs : List String) (forms : Forms) (name input : String) (coordinate : List String)
    (extracted : extract forms name input = some coordinate) :
    family (inputs ++ [input]) forms name coordinate = family inputs forms name coordinate ++ [input] := by
  rw [familyComposition,singletonFamily _ _ _ _ extracted]

def CompleteResources (inputs : List String) (records : List (String × Record))
    (registry : List (String × UniversalInterpretation.Request)) : Prop :=
  ∀ input, input ∈ inputs → ∃ record, lookupFirst records input = some record ∧ Verified registry record

theorem familyResourceTrace (inputs : List String) (forms : Forms) (name input : String) (coordinate : List String)
    (records : List (String × Record)) (registry : List (String × UniversalInterpretation.Request))
    (complete : CompleteResources inputs records registry) (held : input ∈ family inputs forms name coordinate) :
    ∃ record, (input,record) ∈ records ∧ extract forms name input = some coordinate ∧
      record.resources.timeTrace.map Prod.snd = record.observed ∧
      record.resources.spaceSupport = record.occupied ∧
      record.resources.timeCount = record.observed.length ∧ record.resources.spaceCount = record.occupied.length := by
  have parts := (familyMeaning _ _ _ _ _).mp held
  obtain ⟨record,selected,verified⟩ := complete input parts.1
  exact ⟨record,lookupRow _ _ _ selected,parts.2,ResourceRecord.recordReconstructs _ _ _ verified.2.2⟩

-- Preservation is checked on the actual input map and extracted coordinates.
def PreservesCoordinate (inputs : List String) (source target : Forms) (name : String) (mapping : Mapping) : Prop :=
  ∀ input, input ∈ inputs → ∀ output, Mapped mapping input output →
    extract target name output = extract source name input

theorem reductionFamily (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop)
    (source target : Problem) (reduction : Reduction) (first second : Forms) (name : String)
    (verified : VerifiedReduction registry resourceLaw source target reduction)
    (preserved : PreservesCoordinate source.inputs first second name reduction.inputMap)
    (input : String) (coordinate : List String) (held : input ∈ family source.inputs first name coordinate) :
    ∃ output record, output ∈ family target.inputs second name coordinate ∧ Mapped reduction.inputMap input output ∧
      lookupFirst reduction.overhead input = some record ∧ Verified registry record ∧ resourceLaw record ∧
      ∀ answer, source.answers input answer ↔ ∃ targetAnswer,
        target.answers output targetAnswer ∧ Mapped reduction.answerMap targetAnswer answer := by
  have parts := (familyMeaning _ _ _ _ _).mp held
  obtain ⟨output,record,bound,mapped,lookup,valid,law,answers⟩ := completeTranslation _ _ _ _ _ verified input parts.1
  exact ⟨output,record,(familyMeaning _ _ _ _ _).mpr
    ⟨bound,(preserved input parts.1 output mapped).trans parts.2⟩,mapped,lookup,valid,law,answers⟩

theorem coordinateComposition (inputs middle : List String) (first second third : Forms) (name : String)
    (one two : Mapping) (left : PreservesCoordinate inputs first second name one)
    (right : PreservesCoordinate middle second third name two)
    (input intermediate output : String) (held : input ∈ inputs) (mid : intermediate ∈ middle)
    (mappedOne : Mapped one input intermediate) (mappedTwo : Mapped two intermediate output) :
    extract third name output = extract first name input :=
  (right intermediate mid output mappedTwo).trans (left input held intermediate mappedOne)

end SFT.Computation.ParameterizedResources
