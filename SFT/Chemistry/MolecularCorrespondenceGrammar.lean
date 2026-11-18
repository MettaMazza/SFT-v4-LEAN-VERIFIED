import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularCorrespondenceGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Description where
  | rejected | admitted

def descriptionName : Description → String
  | .rejected => "different-classical-and-quantum-chemistries"
  | .admitted => "common-generated-molecular-description"

inductive Embedding where
  | rejected | admitted

def embeddingName : Embedding → String
  | .rejected => "lossy-classical-reencoding"
  | .admitted => "singleton-branch-classical-embedding"

inductive Reversibility where
  | rejected | admitted

def reversibilityName : Reversibility → String
  | .rejected => "hidden-irreversible-predecessor"
  | .admitted => "reversible-classical-transition-submodel"

inductive Quantum where
  | rejected | admitted

def quantumName : Quantum → String
  | .rejected => "selected-branch-execution"
  | .admitted => "complete-branchwise-quantum-execution"

inductive Chemistry where
  | rejected | admitted

def chemistryName : Chemistry → String
  | .rejected => "mode-specific-transition-law"
  | .admitted => "one-admitted-chemical-transition-law"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "result-without-shared-decoder"
  | .admitted => "shared-chemical-decoder-and-record"

inductive Result where
  | rejected | admitted

def resultName : Result → String
  | .rejected => "one-way-result-simulation"
  | .admitted => "bidirectional-result-and-inverse-preservation"

inductive Resource where
  | rejected | admitted

def resourceName : Resource → String
  | .rejected => "uncounted-correspondence-overhead"
  | .admitted => "exact-positive-overhead-ledger"

structure Candidate where
  description : Description
  embedding : Embedding
  reversibility : Reversibility
  quantum : Quantum
  chemistry : Chemistry
  observation : Observation
  result : Result
  resource : Resource

def sourceFields (c : Candidate) : List String := [descriptionName c.description, embeddingName c.embedding, reversibilityName c.reversibility, quantumName c.quantum, chemistryName c.chemistry, observationName c.observation, resultName c.result, resourceName c.resource]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "description=" (descriptionName c.description), SFT.Host.Text.append "embedding=" (embeddingName c.embedding), SFT.Host.Text.append "reversibility=" (reversibilityName c.reversibility), SFT.Host.Text.append "quantum=" (quantumName c.quantum), SFT.Host.Text.append "chemistry=" (chemistryName c.chemistry), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "result=" (resultName c.result), SFT.Host.Text.append "resource=" (resourceName c.resource)]
def survivorId : String := "common-generated-molecular-description__singleton-branch-classical-embedding__reversible-classical-transition-submodel__complete-branchwise-quantum-execution__one-admitted-chemical-transition-law__shared-chemical-decoder-and-record__bidirectional-result-and-inverse-preservation__exact-positive-overhead-ledger"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (descriptionName c.description) "common-generated-molecular-description" &&
  SFT.Host.Text.equal (embeddingName c.embedding) "singleton-branch-classical-embedding" &&
  SFT.Host.Text.equal (reversibilityName c.reversibility) "reversible-classical-transition-submodel" &&
  SFT.Host.Text.equal (quantumName c.quantum) "complete-branchwise-quantum-execution" &&
  SFT.Host.Text.equal (chemistryName c.chemistry) "one-admitted-chemical-transition-law" &&
  SFT.Host.Text.equal (observationName c.observation) "shared-chemical-decoder-and-record" &&
  SFT.Host.Text.equal (resultName c.result) "bidirectional-result-and-inverse-preservation" &&
  SFT.Host.Text.equal (resourceName c.resource) "exact-positive-overhead-ledger"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (descriptionName c.description) "common-generated-molecular-description") then "Different chemical descriptions make result agreement accidental." else
  if !(SFT.Host.Text.equal (embeddingName c.embedding) "singleton-branch-classical-embedding") then "Lossy embedding cannot preserve a chemical state." else
  if !(SFT.Host.Text.equal (reversibilityName c.reversibility) "reversible-classical-transition-submodel") then "A hidden predecessor prevents inverse execution." else
  if !(SFT.Host.Text.equal (quantumName c.quantum) "complete-branchwise-quantum-execution") then "Selected execution does not establish branchwise equivalence." else
  if !(SFT.Host.Text.equal (chemistryName c.chemistry) "one-admitted-chemical-transition-law") then "Mode-specific laws allow the machine to select Chemistry." else
  if !(SFT.Host.Text.equal (observationName c.observation) "shared-chemical-decoder-and-record") then "Unrelated outputs cannot be compared." else
  if !(SFT.Host.Text.equal (resultName c.result) "bidirectional-result-and-inverse-preservation") then "One-way simulation is not full operational correspondence." else
  if !(SFT.Host.Text.equal (resourceName c.resource) "exact-positive-overhead-ledger") then "Uncounted overhead hides the operational distinction." else
  "common-generated-molecular-description__singleton-branch-classical-embedding__reversible-classical-transition-submodel__complete-branchwise-quantum-execution__one-admitted-chemical-transition-law__shared-chemical-decoder-and-record__bidirectional-result-and-inverse-preservation__exact-positive-overhead-ledger"

def generationRule : String := "Generate the literal product of description, embedding, reversibility, quantum execution, Chemistry ownership, observation, result and resource forms; decide all 256 only from admitted molecular transition, measurement and classical--quantum computation laws."
def grammarBoundary : String := "Every positive finite reversible molecular transition table under one admitted Chemistry law, with complete classical rows, quantum branches, observation records, inverse trace and exact positive resource ledger."

def candidates : List Candidate :=
  ([Description.rejected,Description.admitted]).flatMap fun description =>
  ([Embedding.rejected,Embedding.admitted]).flatMap fun embedding =>
  ([Reversibility.rejected,Reversibility.admitted]).flatMap fun reversibility =>
  ([Quantum.rejected,Quantum.admitted]).flatMap fun quantum =>
  ([Chemistry.rejected,Chemistry.admitted]).flatMap fun chemistry =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Result.rejected,Result.admitted]).flatMap fun result =>
  ([Resource.rejected,Resource.admitted]).map fun resource =>
  ⟨description,embedding,reversibility,quantum,chemistry,observation,result,resource⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk description embedding reversibility quantum chemistry observation result resource =>
    have hdescription : description ∈ [Description.rejected,Description.admitted] := by
      cases description <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hembedding : embedding ∈ [Embedding.rejected,Embedding.admitted] := by
      cases embedding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreversibility : reversibility ∈ [Reversibility.rejected,Reversibility.admitted] := by
      cases reversibility <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquantum : quantum ∈ [Quantum.rejected,Quantum.admitted] := by
      cases quantum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchemistry : chemistry ∈ [Chemistry.rejected,Chemistry.admitted] := by
      cases chemistry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresult : result ∈ [Result.rejected,Result.admitted] := by
      cases result <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresource : resource ∈ [Resource.rejected,Resource.admitted] := by
      cases resource <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ description _ hdescription
    apply CommonRefinement.memFlatMap _ _ embedding _ hembedding
    apply CommonRefinement.memFlatMap _ _ reversibility _ hreversibility
    apply CommonRefinement.memFlatMap _ _ quantum _ hquantum
    apply CommonRefinement.memFlatMap _ _ chemistry _ hchemistry
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ result _ hresult
    exact Count.TraceDerivation.memMap _ resource _ hresource

theorem sourceDecisionBlock0000 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock0001 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock0010 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock0011 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock0100 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock0101 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock0110 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock0111 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock1000 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock1001 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock1010 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock1011 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock1100 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock1101 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock1110 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionBlock1111 (chemistry : Chemistry) (observation : Observation) (result : Result) (resource : Resource) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,chemistry,observation,result,resource⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,chemistry,observation,result,resource⟩ := by
 cases chemistry <;> cases observation <;> cases result <;> cases resource <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk description embedding reversibility quantum chemistry observation result resource =>
  cases description <;> cases embedding <;> cases reversibility <;> cases quantum
  · exact sourceDecisionBlock0000 chemistry observation result resource
  · exact sourceDecisionBlock0001 chemistry observation result resource
  · exact sourceDecisionBlock0010 chemistry observation result resource
  · exact sourceDecisionBlock0011 chemistry observation result resource
  · exact sourceDecisionBlock0100 chemistry observation result resource
  · exact sourceDecisionBlock0101 chemistry observation result resource
  · exact sourceDecisionBlock0110 chemistry observation result resource
  · exact sourceDecisionBlock0111 chemistry observation result resource
  · exact sourceDecisionBlock1000 chemistry observation result resource
  · exact sourceDecisionBlock1001 chemistry observation result resource
  · exact sourceDecisionBlock1010 chemistry observation result resource
  · exact sourceDecisionBlock1011 chemistry observation result resource
  · exact sourceDecisionBlock1100 chemistry observation result resource
  · exact sourceDecisionBlock1101 chemistry observation result resource
  · exact sourceDecisionBlock1110 chemistry observation result resource
  · exact sourceDecisionBlock1111 chemistry observation result resource

theorem descriptionCriterion (value : Description) : SFT.Host.Text.equal (descriptionName value) "common-generated-molecular-description" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem embeddingCriterion (value : Embedding) : SFT.Host.Text.equal (embeddingName value) "singleton-branch-classical-embedding" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem reversibilityCriterion (value : Reversibility) : SFT.Host.Text.equal (reversibilityName value) "reversible-classical-transition-submodel" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem quantumCriterion (value : Quantum) : SFT.Host.Text.equal (quantumName value) "complete-branchwise-quantum-execution" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem chemistryCriterion (value : Chemistry) : SFT.Host.Text.equal (chemistryName value) "one-admitted-chemical-transition-law" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "shared-chemical-decoder-and-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem resultCriterion (value : Result) : SFT.Host.Text.equal (resultName value) "bidirectional-result-and-inverse-preservation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem resourceCriterion (value : Resource) : SFT.Host.Text.equal (resourceName value) "exact-positive-overhead-ledger" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [descriptionCriterion, embeddingCriterion, reversibilityCriterion, quantumCriterion, chemistryCriterion, observationCriterion, resultCriterion, resourceCriterion]
  cases c with
  | mk description embedding reversibility quantum chemistry observation result resource =>
    cases description <;> cases embedding <;> cases reversibility <;> cases quantum <;> cases chemistry <;> cases observation <;> cases result <;> cases resource
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.description = .admitted ∧ c.embedding = .admitted ∧ c.reversibility = .admitted ∧ c.quantum = .admitted ∧ c.chemistry = .admitted ∧ c.observation = .admitted ∧ c.result = .admitted ∧ c.resource = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk description embedding reversibility quantum chemistry observation result resource =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem description_rejected_rejected (c : Candidate) (h : c.description = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.description eq
    rw [h] at field
    cases field

theorem embedding_rejected_rejected (c : Candidate) (h : c.embedding = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.embedding eq
    rw [h] at field
    cases field

theorem reversibility_rejected_rejected (c : Candidate) (h : c.reversibility = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reversibility eq
    rw [h] at field
    cases field

theorem quantum_rejected_rejected (c : Candidate) (h : c.quantum = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.quantum eq
    rw [h] at field
    cases field

theorem chemistry_rejected_rejected (c : Candidate) (h : c.chemistry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.chemistry eq
    rw [h] at field
    cases field

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
    rw [h] at field
    cases field

theorem result_rejected_rejected (c : Candidate) (h : c.result = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.result eq
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

end SFT.Chemistry.MolecularCorrespondenceGrammar
