import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CatalyticTurnoverGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Catalyst where
  | rejected | admitted

def catalystName : Catalyst → String
  | .rejected => "selected-participant-or-renamed-product"
  | .admitted => "same-held-catalyst-identity-at-entry-through-every-state-and-return"

inductive Cycle where
  | rejected | admitted

def cycleName : Cycle → String
  | .rejected => "endpoint-pair-or-incomplete-intermediate-path"
  | .admitted => "complete-ordered-state-and-transition-word-closing-on-entry"

inductive Turnover where
  | rejected | admitted

def turnoverName : Turnover → String
  | .rejected => "imported-turnover-rate-equation-or-product-total"
  | .admitted => "one-complete-catalyst-return-word-is-one-turnover"

inductive Frequency where
  | rejected | admitted

def frequencyName : Frequency → String
  | .rejected => "fitted-continuum-rate-steady-state-or-stochastic-weight"
  | .admitted => "completed-return-words-per-exact-positive-observation-partition"

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "four-observed-conductance-levels-substituted-for-five-structural-states"
  | .admitted => "five-structural-states-with-four-separately-observed-statuses-distinguished"

inductive Status where
  | rejected | admitted

def statusName : Status → String
  | .rejected => "deactivation-insufficient-fit-control-or-unresolved-record-omitted"
  | .admitted => "all-favorable-adverse-control-and-unresolved-records-retained"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "selected-turnover-table-plot-or-fitted-answer"
  | .admitted => "complete-497-record-article-supplement-movie-archive-ledger"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "cycle-value-rate-frequency-condition-or-target-readable-before-seal"
  | .admitted => "value-free-497-record-identity-seal-and-depth-independent-cycle-successor"

structure Candidate where
  catalyst : Catalyst
  cycle : Cycle
  turnover : Turnover
  frequency : Frequency
  state : State
  status : Status
  provenance : Provenance
  prediction : Prediction

def sourceFields (c : Candidate) : List String := [catalystName c.catalyst, cycleName c.cycle, turnoverName c.turnover, frequencyName c.frequency, stateName c.state, statusName c.status, provenanceName c.provenance, predictionName c.prediction]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "catalyst=" (catalystName c.catalyst), SFT.Host.Text.append "cycle=" (cycleName c.cycle), SFT.Host.Text.append "turnover=" (turnoverName c.turnover), SFT.Host.Text.append "frequency=" (frequencyName c.frequency), SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "status=" (statusName c.status), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "prediction=" (predictionName c.prediction)]
def survivorId : String := "same-held-catalyst-identity-at-entry-through-every-state-and-return__complete-ordered-state-and-transition-word-closing-on-entry__one-complete-catalyst-return-word-is-one-turnover__completed-return-words-per-exact-positive-observation-partition__five-structural-states-with-four-separately-observed-statuses-distinguished__all-favorable-adverse-control-and-unresolved-records-retained__complete-497-record-article-supplement-movie-archive-ledger__value-free-497-record-identity-seal-and-depth-independent-cycle-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (catalystName c.catalyst) "same-held-catalyst-identity-at-entry-through-every-state-and-return" &&
  SFT.Host.Text.equal (cycleName c.cycle) "complete-ordered-state-and-transition-word-closing-on-entry" &&
  SFT.Host.Text.equal (turnoverName c.turnover) "one-complete-catalyst-return-word-is-one-turnover" &&
  SFT.Host.Text.equal (frequencyName c.frequency) "completed-return-words-per-exact-positive-observation-partition" &&
  SFT.Host.Text.equal (stateName c.state) "five-structural-states-with-four-separately-observed-statuses-distinguished" &&
  SFT.Host.Text.equal (statusName c.status) "all-favorable-adverse-control-and-unresolved-records-retained" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "complete-497-record-article-supplement-movie-archive-ledger" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-497-record-identity-seal-and-depth-independent-cycle-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (catalystName c.catalyst) "same-held-catalyst-identity-at-entry-through-every-state-and-return") then "A selected participant does not establish catalyst persistence." else
  if !(SFT.Host.Text.equal (cycleName c.cycle) "complete-ordered-state-and-transition-word-closing-on-entry") then "An open path is not a catalytic cycle." else
  if !(SFT.Host.Text.equal (turnoverName c.turnover) "one-complete-catalyst-return-word-is-one-turnover") then "An imported rate or product total cannot define a completed cycle." else
  if !(SFT.Host.Text.equal (frequencyName c.frequency) "completed-return-words-per-exact-positive-observation-partition") then "A fit or stochastic premise imports the frequency law." else
  if !(SFT.Host.Text.equal (stateName c.state) "five-structural-states-with-four-separately-observed-statuses-distinguished") then "Collapsing the structural intermediate breaks the complete transition word." else
  if !(SFT.Host.Text.equal (statusName c.status) "all-favorable-adverse-control-and-unresolved-records-retained") then "Omission regularizes the source surface." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "complete-497-record-article-supplement-movie-archive-ledger") then "A selected excerpt cannot establish complete custody." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-497-record-identity-seal-and-depth-independent-cycle-successor") then "Target access can select the law." else
  "same-held-catalyst-identity-at-entry-through-every-state-and-return__complete-ordered-state-and-transition-word-closing-on-entry__one-complete-catalyst-return-word-is-one-turnover__completed-return-words-per-exact-positive-observation-partition__five-structural-states-with-four-separately-observed-statuses-distinguished__all-favorable-adverse-control-and-unresolved-records-retained__complete-497-record-article-supplement-movie-archive-ledger__value-free-497-record-identity-seal-and-depth-independent-cycle-successor"

def generationRule : String := "Generate the literal product of catalyst, cycle, turnover, frequency, state-status, evidence-status, provenance and prediction forms; decide all 256 candidates only from admitted exact state-transition, complete-channel, sequential, parallel and reversible-graph laws."
def grammarBoundary : String := "Every finite source-ordered family of complete catalytic cycles with one held catalyst identity, two or more distinct registered states, one exact transition between each adjacent pair and a final transition returning to entry, one exact held condition and retained observed, structural, favorable, adverse, control or unresolved status. External testing binds all 497 pre-registered source records: article landing and unavailable-PDF response, 106 supplementary pages, one 1,604-frame movie, Zenodo metadata and all 387 members of seven archives."

def candidates : List Candidate :=
  ([Catalyst.rejected,Catalyst.admitted]).flatMap fun catalyst =>
  ([Cycle.rejected,Cycle.admitted]).flatMap fun cycle =>
  ([Turnover.rejected,Turnover.admitted]).flatMap fun turnover =>
  ([Frequency.rejected,Frequency.admitted]).flatMap fun frequency =>
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Status.rejected,Status.admitted]).flatMap fun status =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Prediction.rejected,Prediction.admitted]).map fun prediction =>
  ⟨catalyst,cycle,turnover,frequency,state,status,provenance,prediction⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk catalyst cycle turnover frequency state status provenance prediction =>
    have hcatalyst : catalyst ∈ [Catalyst.rejected,Catalyst.admitted] := by
      cases catalyst <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcycle : cycle ∈ [Cycle.rejected,Cycle.admitted] := by
      cases cycle <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hturnover : turnover ∈ [Turnover.rejected,Turnover.admitted] := by
      cases turnover <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfrequency : frequency ∈ [Frequency.rejected,Frequency.admitted] := by
      cases frequency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstatus : status ∈ [Status.rejected,Status.admitted] := by
      cases status <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ catalyst _ hcatalyst
    apply CommonRefinement.memFlatMap _ _ cycle _ hcycle
    apply CommonRefinement.memFlatMap _ _ turnover _ hturnover
    apply CommonRefinement.memFlatMap _ _ frequency _ hfrequency
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ status _ hstatus
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ prediction _ hprediction

theorem sourceDecisionBlock0000 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,state,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0001 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,state,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0010 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,state,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0011 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,state,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0100 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,state,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0101 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,state,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0110 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,state,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0111 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,state,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1000 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,state,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1001 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,state,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1010 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,state,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1011 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,state,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1100 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,state,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1101 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,state,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1110 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,state,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1111 (state : State) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,state,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,state,status,provenance,prediction⟩ := by
 cases state <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk catalyst cycle turnover frequency state status provenance prediction =>
  cases catalyst <;> cases cycle <;> cases turnover <;> cases frequency
  · exact sourceDecisionBlock0000 state status provenance prediction
  · exact sourceDecisionBlock0001 state status provenance prediction
  · exact sourceDecisionBlock0010 state status provenance prediction
  · exact sourceDecisionBlock0011 state status provenance prediction
  · exact sourceDecisionBlock0100 state status provenance prediction
  · exact sourceDecisionBlock0101 state status provenance prediction
  · exact sourceDecisionBlock0110 state status provenance prediction
  · exact sourceDecisionBlock0111 state status provenance prediction
  · exact sourceDecisionBlock1000 state status provenance prediction
  · exact sourceDecisionBlock1001 state status provenance prediction
  · exact sourceDecisionBlock1010 state status provenance prediction
  · exact sourceDecisionBlock1011 state status provenance prediction
  · exact sourceDecisionBlock1100 state status provenance prediction
  · exact sourceDecisionBlock1101 state status provenance prediction
  · exact sourceDecisionBlock1110 state status provenance prediction
  · exact sourceDecisionBlock1111 state status provenance prediction

theorem catalystCriterion (value : Catalyst) : SFT.Host.Text.equal (catalystName value) "same-held-catalyst-identity-at-entry-through-every-state-and-return" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem cycleCriterion (value : Cycle) : SFT.Host.Text.equal (cycleName value) "complete-ordered-state-and-transition-word-closing-on-entry" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem turnoverCriterion (value : Turnover) : SFT.Host.Text.equal (turnoverName value) "one-complete-catalyst-return-word-is-one-turnover" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem frequencyCriterion (value : Frequency) : SFT.Host.Text.equal (frequencyName value) "completed-return-words-per-exact-positive-observation-partition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem stateCriterion (value : State) : SFT.Host.Text.equal (stateName value) "five-structural-states-with-four-separately-observed-statuses-distinguished" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem statusCriterion (value : Status) : SFT.Host.Text.equal (statusName value) "all-favorable-adverse-control-and-unresolved-records-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "complete-497-record-article-supplement-movie-archive-ledger" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-497-record-identity-seal-and-depth-independent-cycle-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [catalystCriterion, cycleCriterion, turnoverCriterion, frequencyCriterion, stateCriterion, statusCriterion, provenanceCriterion, predictionCriterion]
  cases c with
  | mk catalyst cycle turnover frequency state status provenance prediction =>
    cases catalyst <;> cases cycle <;> cases turnover <;> cases frequency <;> cases state <;> cases status <;> cases provenance <;> cases prediction
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.catalyst = .admitted ∧ c.cycle = .admitted ∧ c.turnover = .admitted ∧ c.frequency = .admitted ∧ c.state = .admitted ∧ c.status = .admitted ∧ c.provenance = .admitted ∧ c.prediction = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk catalyst cycle turnover frequency state status provenance prediction =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem catalyst_rejected_rejected (c : Candidate) (h : c.catalyst = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.catalyst eq
    rw [h] at field
    cases field

theorem cycle_rejected_rejected (c : Candidate) (h : c.cycle = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cycle eq
    rw [h] at field
    cases field

theorem turnover_rejected_rejected (c : Candidate) (h : c.turnover = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.turnover eq
    rw [h] at field
    cases field

theorem frequency_rejected_rejected (c : Candidate) (h : c.frequency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.frequency eq
    rw [h] at field
    cases field

theorem state_rejected_rejected (c : Candidate) (h : c.state = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.state eq
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

end SFT.Chemistry.CatalyticTurnoverGrammar
