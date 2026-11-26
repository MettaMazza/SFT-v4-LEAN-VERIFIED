import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.SequentialMechanismGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "endpoint-only-or-selected-snapshot-support"
  | .admitted => "complete-source-ordered-state-and-transition-support"

inductive Adjacency where
  | rejected | admitted

def adjacencyName : Adjacency → String
  | .rejected => "aggregate-start-to-finish-jump"
  | .admitted => "exact-entry-exit-boundary-matching-for-every-edge"

inductive Intermediate where
  | rejected | admitted

def intermediateName : Intermediate → String
  | .rejected => "implicit-eliminated-or-fitted-intermediate"
  | .admitted => "every-intermediate-occurrence-retained-explicitly"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "imported-differential-exponential-or-lifetime-law"
  | .admitted => "finite-exact-ordered-edge-composition"

inductive Condition where
  | rejected | admitted

def conditionName : Condition → String
  | .rejected => "condition-time-or-dose-collapsed"
  | .admitted => "held-state-and-transition-condition-boundaries"

inductive Status where
  | rejected | admitted

def statusName : Status → String
  | .rejected => "adverse-unresolved-or-parallel-record-omitted"
  | .admitted => "favorable-adverse-unresolved-and-parallel-status-retained"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "structure-answer-without-source-custody"
  | .admitted => "complete-article-supplement-PDB-raw-custody-and-control-record"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "time-coordinate-occupancy-or-target-readable-before-seal"
  | .admitted => "value-free-seventeen-record-identity-seal-and-depth-independent-successor"

structure Candidate where
  support : Support
  adjacency : Adjacency
  intermediate : Intermediate
  composition : Composition
  condition : Condition
  status : Status
  provenance : Provenance
  prediction : Prediction

def sourceFields (c : Candidate) : List String := [supportName c.support, adjacencyName c.adjacency, intermediateName c.intermediate, compositionName c.composition, conditionName c.condition, statusName c.status, provenanceName c.provenance, predictionName c.prediction]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "adjacency=" (adjacencyName c.adjacency), SFT.Host.Text.append "intermediate=" (intermediateName c.intermediate), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "condition=" (conditionName c.condition), SFT.Host.Text.append "status=" (statusName c.status), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "prediction=" (predictionName c.prediction)]
def survivorId : String := "complete-source-ordered-state-and-transition-support__exact-entry-exit-boundary-matching-for-every-edge__every-intermediate-occurrence-retained-explicitly__finite-exact-ordered-edge-composition__held-state-and-transition-condition-boundaries__favorable-adverse-unresolved-and-parallel-status-retained__complete-article-supplement-PDB-raw-custody-and-control-record__value-free-seventeen-record-identity-seal-and-depth-independent-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-source-ordered-state-and-transition-support" &&
  SFT.Host.Text.equal (adjacencyName c.adjacency) "exact-entry-exit-boundary-matching-for-every-edge" &&
  SFT.Host.Text.equal (intermediateName c.intermediate) "every-intermediate-occurrence-retained-explicitly" &&
  SFT.Host.Text.equal (compositionName c.composition) "finite-exact-ordered-edge-composition" &&
  SFT.Host.Text.equal (conditionName c.condition) "held-state-and-transition-condition-boundaries" &&
  SFT.Host.Text.equal (statusName c.status) "favorable-adverse-unresolved-and-parallel-status-retained" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "complete-article-supplement-PDB-raw-custody-and-control-record" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-seventeen-record-identity-seal-and-depth-independent-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-source-ordered-state-and-transition-support") then "Endpoints erase the mechanism path." else
  if !(SFT.Host.Text.equal (adjacencyName c.adjacency) "exact-entry-exit-boundary-matching-for-every-edge") then "An aggregate jump does not prove its elementary boundaries." else
  if !(SFT.Host.Text.equal (intermediateName c.intermediate) "every-intermediate-occurrence-retained-explicitly") then "An omitted intermediate cannot be reconstructed." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "finite-exact-ordered-edge-composition") then "An imported evolution equation can select the answer." else
  if !(SFT.Host.Text.equal (conditionName c.condition) "held-state-and-transition-condition-boundaries") then "Collapsed conditions can join incompatible observations." else
  if !(SFT.Host.Text.equal (statusName c.status) "favorable-adverse-unresolved-and-parallel-status-retained") then "Removing an unfavorable record overstates the path." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "complete-article-supplement-PDB-raw-custody-and-control-record") then "An answer-only path cannot be independently audited." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-seventeen-record-identity-seal-and-depth-independent-successor") then "Target access can select the sequence." else
  "complete-source-ordered-state-and-transition-support__exact-entry-exit-boundary-matching-for-every-edge__every-intermediate-occurrence-retained-explicitly__finite-exact-ordered-edge-composition__held-state-and-transition-condition-boundaries__favorable-adverse-unresolved-and-parallel-status-retained__complete-article-supplement-PDB-raw-custody-and-control-record__value-free-seventeen-record-identity-seal-and-depth-independent-successor"

def generationRule : String := "Generate the literal product of support, adjacency, intermediate, composition, condition, status, provenance and prediction forms; decide all 256 candidates only from admitted exact state-transition, path, mechanism, rate, activation-boundary and complete-channel laws."
def grammarBoundary : String := "Every finite complete ordered mechanism word with at least two registered state occurrences, exactly one registered elementary edge between each adjacent occurrence, exact positive ordinals, held conditions and held measured, adverse or unresolved status. External testing binds seventeen source categories: five deposited structures, two late unresolved states, seven complete power-titration columns and three favorable, adverse or unresolved controls, together with the complete article, thirteen supplementary files, three PDFs, five PDB records and CXIDB 221 custody metadata."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Adjacency.rejected,Adjacency.admitted]).flatMap fun adjacency =>
  ([Intermediate.rejected,Intermediate.admitted]).flatMap fun intermediate =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Condition.rejected,Condition.admitted]).flatMap fun condition =>
  ([Status.rejected,Status.admitted]).flatMap fun status =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Prediction.rejected,Prediction.admitted]).map fun prediction =>
  ⟨support,adjacency,intermediate,composition,condition,status,provenance,prediction⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support adjacency intermediate composition condition status provenance prediction =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadjacency : adjacency ∈ [Adjacency.rejected,Adjacency.admitted] := by
      cases adjacency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hintermediate : intermediate ∈ [Intermediate.rejected,Intermediate.admitted] := by
      cases intermediate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcondition : condition ∈ [Condition.rejected,Condition.admitted] := by
      cases condition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstatus : status ∈ [Status.rejected,Status.admitted] := by
      cases status <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ adjacency _ hadjacency
    apply CommonRefinement.memFlatMap _ _ intermediate _ hintermediate
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ condition _ hcondition
    apply CommonRefinement.memFlatMap _ _ status _ hstatus
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ prediction _ hprediction

theorem sourceDecisionBlock0000 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0001 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0010 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0011 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0100 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0101 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0110 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0111 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1000 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1001 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1010 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1011 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1100 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1101 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1110 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1111 (condition : Condition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,condition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,condition,status,provenance,prediction⟩ := by
 cases condition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk support adjacency intermediate composition condition status provenance prediction =>
  cases support <;> cases adjacency <;> cases intermediate <;> cases composition
  · exact sourceDecisionBlock0000 condition status provenance prediction
  · exact sourceDecisionBlock0001 condition status provenance prediction
  · exact sourceDecisionBlock0010 condition status provenance prediction
  · exact sourceDecisionBlock0011 condition status provenance prediction
  · exact sourceDecisionBlock0100 condition status provenance prediction
  · exact sourceDecisionBlock0101 condition status provenance prediction
  · exact sourceDecisionBlock0110 condition status provenance prediction
  · exact sourceDecisionBlock0111 condition status provenance prediction
  · exact sourceDecisionBlock1000 condition status provenance prediction
  · exact sourceDecisionBlock1001 condition status provenance prediction
  · exact sourceDecisionBlock1010 condition status provenance prediction
  · exact sourceDecisionBlock1011 condition status provenance prediction
  · exact sourceDecisionBlock1100 condition status provenance prediction
  · exact sourceDecisionBlock1101 condition status provenance prediction
  · exact sourceDecisionBlock1110 condition status provenance prediction
  · exact sourceDecisionBlock1111 condition status provenance prediction

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-source-ordered-state-and-transition-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem adjacencyCriterion (value : Adjacency) : SFT.Host.Text.equal (adjacencyName value) "exact-entry-exit-boundary-matching-for-every-edge" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem intermediateCriterion (value : Intermediate) : SFT.Host.Text.equal (intermediateName value) "every-intermediate-occurrence-retained-explicitly" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "finite-exact-ordered-edge-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem conditionCriterion (value : Condition) : SFT.Host.Text.equal (conditionName value) "held-state-and-transition-condition-boundaries" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem statusCriterion (value : Status) : SFT.Host.Text.equal (statusName value) "favorable-adverse-unresolved-and-parallel-status-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "complete-article-supplement-PDB-raw-custody-and-control-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-seventeen-record-identity-seal-and-depth-independent-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [supportCriterion, adjacencyCriterion, intermediateCriterion, compositionCriterion, conditionCriterion, statusCriterion, provenanceCriterion, predictionCriterion]
  cases c with
  | mk support adjacency intermediate composition condition status provenance prediction =>
    cases support <;> cases adjacency <;> cases intermediate <;> cases composition <;> cases condition <;> cases status <;> cases provenance <;> cases prediction
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.adjacency = .admitted ∧ c.intermediate = .admitted ∧ c.composition = .admitted ∧ c.condition = .admitted ∧ c.status = .admitted ∧ c.provenance = .admitted ∧ c.prediction = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support adjacency intermediate composition condition status provenance prediction =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem adjacency_rejected_rejected (c : Candidate) (h : c.adjacency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.adjacency eq
    rw [h] at field
    cases field

theorem intermediate_rejected_rejected (c : Candidate) (h : c.intermediate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.intermediate eq
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

theorem condition_rejected_rejected (c : Candidate) (h : c.condition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.condition eq
    rw [h] at field
    cases field

theorem status_rejected_rejected (c : Candidate) (h : c.status = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.status eq
    rw [h] at field
    cases field

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
    rw [h] at field
    cases field

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
    rw [h] at field
    cases field

end SFT.Chemistry.SequentialMechanismGrammar
