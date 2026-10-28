import SFT.InformationScience.ChannelWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.ChannelGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Inputs where
  | rejected | admitted

def inputsName : Inputs → String
  | .rejected => "partial-input-carrier"
  | .admitted => "complete-canonical-inputs"

inductive Outputs where
  | rejected | admitted

def outputsName : Outputs → String
  | .rejected => "partial-output-carrier"
  | .admitted => "complete-canonical-outputs"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "opaque-channel-box"
  | .admitted => "held-transport-relation"

inductive Totality where
  | rejected | admitted

def totalityName : Totality → String
  | .rejected => "missing-input-row"
  | .admitted => "nonempty-output-support-per-input"

inductive Confusability where
  | rejected | admitted

def confusabilityName : Confusability → String
  | .rejected => "probability-threshold"
  | .admitted => "overlapping-output-support"

inductive Codes where
  | rejected | admitted

def codesName : Codes → String
  | .rejected => "sampled-input-set"
  | .admitted => "pairwise-disjoint-output-selection"

inductive Capacity where
  | rejected | admitted

def capacityName : Capacity → String
  | .rejected => "logarithmic-rate"
  | .admitted => "complete-greatest-code-family"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "endpoint-guess"
  | .admitted => "exact-relational-paths"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "sampled-channels"
  | .admitted => "carrier-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-transition-probability"
  | .admitted => "no-extra-channel-model"

structure Candidate where
  inputs : Inputs
  outputs : Outputs
  relation : Relation
  totality : Totality
  confusability : Confusability
  codes : Codes
  capacity : Capacity
  composition : Composition
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [inputsName c.inputs, outputsName c.outputs, relationName c.relation, totalityName c.totality, confusabilityName c.confusability, codesName c.codes, capacityName c.capacity, compositionName c.composition, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "inputs=" (inputsName c.inputs), SFT.Host.Text.append "outputs=" (outputsName c.outputs), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "totality=" (totalityName c.totality), SFT.Host.Text.append "confusability=" (confusabilityName c.confusability), SFT.Host.Text.append "codes=" (codesName c.codes), SFT.Host.Text.append "capacity=" (capacityName c.capacity), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-inputs__complete-canonical-outputs__held-transport-relation__nonempty-output-support-per-input__overlapping-output-support__pairwise-disjoint-output-selection__complete-greatest-code-family__exact-relational-paths__carrier-successor__no-extra-channel-model"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (inputsName c.inputs) "complete-canonical-inputs" &&
  SFT.Host.Text.equal (outputsName c.outputs) "complete-canonical-outputs" &&
  SFT.Host.Text.equal (relationName c.relation) "held-transport-relation" &&
  SFT.Host.Text.equal (totalityName c.totality) "nonempty-output-support-per-input" &&
  SFT.Host.Text.equal (confusabilityName c.confusability) "overlapping-output-support" &&
  SFT.Host.Text.equal (codesName c.codes) "pairwise-disjoint-output-selection" &&
  SFT.Host.Text.equal (capacityName c.capacity) "complete-greatest-code-family" &&
  SFT.Host.Text.equal (compositionName c.composition) "exact-relational-paths" &&
  SFT.Host.Text.equal (generalityName c.generality) "carrier-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-channel-model"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (inputsName c.inputs) "complete-canonical-inputs") then "An omitted input changes possible messages and capacity." else
  if !(SFT.Host.Text.equal (outputsName c.outputs) "complete-canonical-outputs") then "An omitted output hides a possible transport image." else
  if !(SFT.Host.Text.equal (relationName c.relation) "held-transport-relation") then "An opaque box hides source-to-output alternatives." else
  if !(SFT.Host.Text.equal (totalityName c.totality) "nonempty-output-support-per-input") then "An input without an output is outside the claimed channel action." else
  if !(SFT.Host.Text.equal (confusabilityName c.confusability) "overlapping-output-support") then "A threshold imports a distribution and free scale." else
  if !(SFT.Host.Text.equal (codesName c.codes) "pairwise-disjoint-output-selection") then "Sampling cannot establish every pair separated." else
  if !(SFT.Host.Text.equal (capacityName c.capacity) "complete-greatest-code-family") then "A real logarithmic rate imports scale and asymptotic assumptions." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "exact-relational-paths") then "Endpoints alone omit the shared interface path." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "carrier-successor") then "Examples do not establish a fresh input relation." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-channel-model") then "A probability law is not supplied by the transport relation." else
  "The channel kernel is complete input/output carriers and held total transport, exact overlap confusability, exhaustive zero-error codes, the complete greatest code family, relational composition and no stochastic rule."

def generationRule : String := "Generate the complete product of input coverage, output coverage, relation provenance, transport totality, confusability, code generation, capacity selection, composition, generality and extra-channel status."
def grammarBoundary : String := "All finite channels generated from canonical carriers, held transport relations, complete output supports, pairwise confusability checks, exhaustive input selections and exact relation composition."

def candidates : List Candidate :=
  ([Inputs.rejected,Inputs.admitted]).flatMap fun inputs =>
  ([Outputs.rejected,Outputs.admitted]).flatMap fun outputs =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Totality.rejected,Totality.admitted]).flatMap fun totality =>
  ([Confusability.rejected,Confusability.admitted]).flatMap fun confusability =>
  ([Codes.rejected,Codes.admitted]).flatMap fun codes =>
  ([Capacity.rejected,Capacity.admitted]).flatMap fun capacity =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨inputs,outputs,relation,totality,confusability,codes,capacity,composition,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk inputs outputs relation totality confusability codes capacity composition generality addition =>
    have hinputs : inputs ∈ [Inputs.rejected,Inputs.admitted] := by
      cases inputs <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have houtputs : outputs ∈ [Outputs.rejected,Outputs.admitted] := by
      cases outputs <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htotality : totality ∈ [Totality.rejected,Totality.admitted] := by
      cases totality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconfusability : confusability ∈ [Confusability.rejected,Confusability.admitted] := by
      cases confusability <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcodes : codes ∈ [Codes.rejected,Codes.admitted] := by
      cases codes <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcapacity : capacity ∈ [Capacity.rejected,Capacity.admitted] := by
      cases capacity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ inputs _ hinputs
    apply CommonRefinement.memFlatMap _ _ outputs _ houtputs
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ totality _ htotality
    apply CommonRefinement.memFlatMap _ _ confusability _ hconfusability
    apply CommonRefinement.memFlatMap _ _ codes _ hcodes
    apply CommonRefinement.memFlatMap _ _ capacity _ hcapacity
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk inputs outputs relation totality confusability codes capacity composition generality addition =>
    cases inputs <;> cases outputs <;> cases relation <;> cases totality <;> cases confusability <;> cases codes <;> cases capacity <;> cases composition <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk inputs outputs relation totality confusability codes capacity composition generality addition =>
    cases inputs <;> cases outputs <;> cases relation <;> cases totality <;> cases confusability <;> cases codes <;> cases capacity <;> cases composition <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.inputs = .admitted ∧ c.outputs = .admitted ∧ c.relation = .admitted ∧ c.totality = .admitted ∧ c.confusability = .admitted ∧ c.codes = .admitted ∧ c.capacity = .admitted ∧ c.composition = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk inputs outputs relation totality confusability codes capacity composition generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem inputs_rejected_rejected (c : Candidate) (h : c.inputs = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.inputs eq
    rw [h] at field
    cases field

theorem outputs_rejected_rejected (c : Candidate) (h : c.outputs = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.outputs eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
    rw [h] at field
    cases field

theorem totality_rejected_rejected (c : Candidate) (h : c.totality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.totality eq
    rw [h] at field
    cases field

theorem confusability_rejected_rejected (c : Candidate) (h : c.confusability = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.confusability eq
    rw [h] at field
    cases field

theorem codes_rejected_rejected (c : Candidate) (h : c.codes = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.codes eq
    rw [h] at field
    cases field

theorem capacity_rejected_rejected (c : Candidate) (h : c.capacity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.capacity eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.InformationScience.ChannelGrammar
