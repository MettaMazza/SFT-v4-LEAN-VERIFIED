import SFT.Computation.BoundResources
import SFT.Computation.ReductionTrace
namespace SFT.Computation.CompletenessResources
open ReductionTrace BoundResources
open SFT.InformationScience.EncodingMaps
open SFT.Foundation.Count.TraceDerivation

structure Problem where
  identity : String
  inputs : List String
  answers : String → String → Prop

structure Reduction where
  inputMap : Mapping
  answerMap : Mapping
  overhead : List (String × Record)

def VerifiedReduction (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop)
    (source target : Problem) (reduction : Reduction) : Prop :=
  TotalOn reduction.inputMap source.inputs target.inputs ∧
  PreservesAnswers source.inputs reduction.inputMap reduction.answerMap source.answers target.answers ∧
  ∀ input, input ∈ source.inputs → ∃ record,
    lookupFirst reduction.overhead input = some record ∧ Verified registry record ∧ resourceLaw record

theorem completeTranslation (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop)
    (source target : Problem) (reduction : Reduction)
    (verified : VerifiedReduction registry resourceLaw source target reduction)
    (input : String) (held : input ∈ source.inputs) :
    ∃ output record, output ∈ target.inputs ∧ Mapped reduction.inputMap input output ∧
      lookupFirst reduction.overhead input = some record ∧ Verified registry record ∧ resourceLaw record ∧
      ∀ answer, source.answers input answer ↔ ∃ targetAnswer,
        target.answers output targetAnswer ∧ Mapped reduction.answerMap targetAnswer answer := by
  obtain ⟨output,bound,mapped⟩ := verified.1 input held
  obtain ⟨record,lookup,actual,law⟩ := verified.2.2 input held
  exact ⟨output,record,bound,mapped,lookup,actual,law,verified.2.1 input held output mapped⟩

theorem overheadTrace (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop)
    (source target : Problem) (reduction : Reduction)
    (verified : VerifiedReduction registry resourceLaw source target reduction)
    (input : String) (held : input ∈ source.inputs) :
    ∃ record, (input,record) ∈ reduction.overhead ∧
      record.resources.timeTrace.map Prod.snd = record.observed ∧
      record.resources.spaceSupport = record.occupied ∧
      record.resources.timeCount = record.observed.length ∧
      record.resources.spaceCount = record.occupied.length := by
  obtain ⟨record,lookup,actual,law⟩ := verified.2.2 input held
  exact ⟨record,lookupRow _ _ _ lookup,ResourceRecord.recordReconstructs _ _ _ actual.2.2⟩

def stageTrace : List Record → List String
 | [] => []
 | record :: rest => record.observed ++ stageTrace rest

def stageCost : List Record → Nat
 | [] => 0
 | record :: rest => record.resources.timeCount + stageCost rest

theorem exactStageCost (registry : List (String × UniversalInterpretation.Request))
    (records : List Record) (verified : ∀ record, record ∈ records → Verified registry record) :
    stageCost records = (stageTrace records).length := by
  induction records with
  | nil => rfl
  | cons record rest ih =>
    change record.resources.timeCount + stageCost rest = (record.observed ++ stageTrace rest).length
    rw [(ResourceRecord.recordReconstructs _ _ _ (verified record (.head rest)).2.2).2.2.1,
      ih (fun other held => verified other (.tail record held)),CommunicationResources.countAppend]

theorem stageComposition (first second : List Record) :
    stageTrace (first ++ second) = stageTrace first ++ stageTrace second ∧
      stageCost (first ++ second) = stageCost first + stageCost second := by
  induction first with
  | nil => exact ⟨rfl,(Nat.zero_add _).symm⟩
  | cons record rest ih =>
    constructor
    · change record.observed ++ stageTrace (rest ++ second) = _
      rw [ih.1]
      exact (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _).symm
    · change record.resources.timeCount + stageCost (rest ++ second) = _
      rw [ih.2]
      exact (Nat.add_assoc _ _ _).symm

-- Every edge of a class reduction retains its original encoders, answer
-- decoder, source domain and measured overhead record.
inductive Chain (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop) : Problem → Problem → Prop where
 | identity (problem) : Chain registry resourceLaw problem problem
 | next (source middle target : Problem) (reduction : Reduction)
     (verified : VerifiedReduction registry resourceLaw source middle reduction)
     (rest : Chain registry resourceLaw middle target) : Chain registry resourceLaw source target

theorem chainComposition (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop)
    (source middle target : Problem) (first : Chain registry resourceLaw source middle)
    (second : Chain registry resourceLaw middle target) : Chain registry resourceLaw source target := by
  induction first with
  | identity => exact second
  | next source next middle reduction verified rest ih =>
    exact .next _ _ _ reduction verified (ih second)

def Hard (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop)
    (inventory : List Problem) (target : Problem) : Prop :=
  ∀ problem, problem ∈ inventory → Chain registry resourceLaw problem target

def Complete (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop)
    (inventory : List Problem) (target : Problem) : Prop := target ∈ inventory ∧ Hard registry resourceLaw inventory target

theorem completenessMeaning (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop)
    (inventory : List Problem) (target : Problem) (complete : Complete registry resourceLaw inventory target) :
    target ∈ inventory ∧ ∀ source, source ∈ inventory → Chain registry resourceLaw source target := complete

theorem hardnessTransport (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop)
    (inventory : List Problem) (middle target : Problem) (hard : Hard registry resourceLaw inventory middle)
    (reduction : Chain registry resourceLaw middle target) : Hard registry resourceLaw inventory target :=
  fun source held => chainComposition _ _ _ _ _ (hard source held) reduction

theorem inventorySuccessor (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop)
    (inventory : List Problem) (fresh target : Problem) :
    Hard registry resourceLaw (fresh :: inventory) target ↔
      Chain registry resourceLaw fresh target ∧ Hard registry resourceLaw inventory target := by
  constructor
  · intro hard; exact ⟨hard fresh (.head _),fun source held => hard source (.tail _ held)⟩
  · intro both source held
    cases held with
    | head => exact both.1
    | tail _ member => exact both.2 source member

theorem singletonComplete (registry : List (String × UniversalInterpretation.Request)) (resourceLaw : Record → Prop) (problem : Problem) :
    Complete registry resourceLaw [problem] problem := by
  refine ⟨.head [],?_⟩
  intro source held
  cases held with
  | head => exact .identity problem
  | tail _ impossible => cases impossible
end SFT.Computation.CompletenessResources
