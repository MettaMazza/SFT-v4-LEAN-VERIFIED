import SFT.Computation.CommunicationQueryWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.CommunicationQueryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Input where
  | rejected | admitted

def inputName : Input → String
  | .rejected => "presentation-length"
  | .admitted => "canonical-encoding-support"

inductive Resource where
  | rejected | admitted

def resourceName : Resource → String
  | .rejected => "unrecorded-cost"
  | .admitted => "complete-resource-ledger"

inductive Model where
  | rejected | admitted

def modelName : Model → String
  | .rejected => "model-unspecified"
  | .admitted => "registered-computation-model"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "unmatched-instances"
  | .admitted => "common-family-comparison"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "cost-erasing-composition"
  | .admitted => "overhead-retaining-composition"

inductive Witness where
  | rejected | admitted

def witnessName : Witness → String
  | .rejected => "claimed-bound"
  | .admitted => "constructive-or-adversarial-bound-witness"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "benchmark-only"
  | .admitted => "family-successor-certificate"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "imported-scale-or-rate"
  | .admitted => "no-extra-resource-parameter"

structure Candidate where
  input : Input
  resource : Resource
  model : Model
  comparison : Comparison
  composition : Composition
  witness : Witness
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [inputName c.input, resourceName c.resource, modelName c.model, comparisonName c.comparison, compositionName c.composition, witnessName c.witness, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "input=" (inputName c.input), SFT.Host.Text.append "resource=" (resourceName c.resource), SFT.Host.Text.append "model=" (modelName c.model), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "witness=" (witnessName c.witness), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "canonical-encoding-support__complete-resource-ledger__registered-computation-model__common-family-comparison__overhead-retaining-composition__constructive-or-adversarial-bound-witness__family-successor-certificate__no-extra-resource-parameter"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (inputName c.input) "canonical-encoding-support" &&
  SFT.Host.Text.equal (resourceName c.resource) "complete-resource-ledger" &&
  SFT.Host.Text.equal (modelName c.model) "registered-computation-model" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "common-family-comparison" &&
  SFT.Host.Text.equal (compositionName c.composition) "overhead-retaining-composition" &&
  SFT.Host.Text.equal (witnessName c.witness) "constructive-or-adversarial-bound-witness" &&
  SFT.Host.Text.equal (generalityName c.generality) "family-successor-certificate" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-resource-parameter"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (inputName c.input) "canonical-encoding-support") then "presentation-length removes a required exact input condition." else
  if !(SFT.Host.Text.equal (resourceName c.resource) "complete-resource-ledger") then "unrecorded-cost removes a required exact resource condition." else
  if !(SFT.Host.Text.equal (modelName c.model) "registered-computation-model") then "model-unspecified removes a required exact model condition." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "common-family-comparison") then "unmatched-instances removes a required exact comparison condition." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "overhead-retaining-composition") then "cost-erasing-composition removes a required exact composition condition." else
  if !(SFT.Host.Text.equal (witnessName c.witness) "constructive-or-adversarial-bound-witness") then "claimed-bound removes a required exact witness condition." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "family-successor-certificate") then "benchmark-only removes a required exact generality condition." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-resource-parameter") then "imported-scale-or-rate removes a required exact addition condition." else
  "The forced cross-interface and information-request resources kernel retains distributed input support; sent records; received records; named query interface; answer trace; retained local knowledge; result certificate; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."

def generationRule : String := "Generate the literal product of the eight registered Computational Complexity structural axes for cross-interface and information-request resources."
def grammarBoundary : String := "All generated finite cross-interface and information-request resources structures whose carriers, relations, traces and interfaces are composed from admitted Foundation, Mathematics and Information Science forms. The exact protocol and oracle identity must be registered."

def candidates : List Candidate :=
  ([Input.rejected,Input.admitted]).flatMap fun input =>
  ([Resource.rejected,Resource.admitted]).flatMap fun resource =>
  ([Model.rejected,Model.admitted]).flatMap fun model =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Witness.rejected,Witness.admitted]).flatMap fun witness =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨input,resource,model,comparison,composition,witness,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk input resource model comparison composition witness generality addition =>
    have hinput : input ∈ [Input.rejected,Input.admitted] := by
      cases input <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresource : resource ∈ [Resource.rejected,Resource.admitted] := by
      cases resource <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmodel : model ∈ [Model.rejected,Model.admitted] := by
      cases model <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hwitness : witness ∈ [Witness.rejected,Witness.admitted] := by
      cases witness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ input _ hinput
    apply CommonRefinement.memFlatMap _ _ resource _ hresource
    apply CommonRefinement.memFlatMap _ _ model _ hmodel
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ witness _ hwitness
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk input resource model comparison composition witness generality addition =>
    cases input <;> cases resource <;> cases model <;> cases comparison <;> cases composition <;> cases witness <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk input resource model comparison composition witness generality addition =>
    cases input <;> cases resource <;> cases model <;> cases comparison <;> cases composition <;> cases witness <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.input = .admitted ∧ c.resource = .admitted ∧ c.model = .admitted ∧ c.comparison = .admitted ∧ c.composition = .admitted ∧ c.witness = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk input resource model comparison composition witness generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem input_rejected_rejected (c : Candidate) (h : c.input = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.input eq
    rw [h] at field
    cases field

theorem resource_rejected_rejected (c : Candidate) (h : c.resource = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.resource eq
    rw [h] at field
    cases field

theorem model_rejected_rejected (c : Candidate) (h : c.model = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.model eq
    rw [h] at field
    cases field

theorem comparison_rejected_rejected (c : Candidate) (h : c.comparison = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.comparison eq
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

theorem witness_rejected_rejected (c : Candidate) (h : c.witness = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.witness eq
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

end SFT.Computation.CommunicationQueryGrammar
