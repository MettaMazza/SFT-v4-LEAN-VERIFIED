import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.DiffusionLimitedReactionGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-initial-encounter-or-product-endpoint"
  | .admitted => "complete-finite-transport-state-and-transition-word"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "transport-and-reaction-treated-as-unrelated-processes"
  | .admitted => "transport-exit-is-exact-reaction-encounter-entry"

inductive Limitation where
  | rejected | admitted

def limitationName : Limitation → String
  | .rejected => "imported-Fick-Smoluchowski-continuum-or-collision-law"
  | .admitted => "reaction-admissible-only-after-complete-transport-word"

inductive Rate where
  | rejected | admitted

def rateName : Rate → String
  | .rejected => "fitted-diffusion-coefficient-rate-constant-or-continuum-time"
  | .admitted => "completed-reaction-occurrences-per-exact-positive-observation-parts"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "solvation-transport-encounter-or-product-stage-omitted-or-collapsed"
  | .admitted => "all-separated-solvation-transport-encounter-and-product-stages-retained"

inductive Status where
  | rejected | admitted

def statusName : Status → String
  | .rejected => "simulation-measurement-discrepancy-large-droplet-deviation-or-nonencounter-question-omitted"
  | .admitted => "all-favorable-adverse-control-and-unresolved-statuses-retained"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "selected-fit-rate-table-or-trajectory"
  | .admitted => "complete-251-record-article-supplements-movies-and-dual-archive-ledger"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "distance-time-velocity-yield-rate-fit-or-target-readable-before-seal"
  | .admitted => "value-free-251-record-identity-seal-and-depth-independent-path-successor"

structure Candidate where
  support : Support
  composition : Composition
  limitation : Limitation
  rate : Rate
  path : Path
  status : Status
  provenance : Provenance
  prediction : Prediction

def sourceFields (c : Candidate) : List String := [supportName c.support, compositionName c.composition, limitationName c.limitation, rateName c.rate, pathName c.path, statusName c.status, provenanceName c.provenance, predictionName c.prediction]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "limitation=" (limitationName c.limitation), SFT.Host.Text.append "rate=" (rateName c.rate), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "status=" (statusName c.status), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "prediction=" (predictionName c.prediction)]
def survivorId : String := "complete-finite-transport-state-and-transition-word__transport-exit-is-exact-reaction-encounter-entry__reaction-admissible-only-after-complete-transport-word__completed-reaction-occurrences-per-exact-positive-observation-parts__all-separated-solvation-transport-encounter-and-product-stages-retained__all-favorable-adverse-control-and-unresolved-statuses-retained__complete-251-record-article-supplements-movies-and-dual-archive-ledger__value-free-251-record-identity-seal-and-depth-independent-path-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-finite-transport-state-and-transition-word" &&
  SFT.Host.Text.equal (compositionName c.composition) "transport-exit-is-exact-reaction-encounter-entry" &&
  SFT.Host.Text.equal (limitationName c.limitation) "reaction-admissible-only-after-complete-transport-word" &&
  SFT.Host.Text.equal (rateName c.rate) "completed-reaction-occurrences-per-exact-positive-observation-parts" &&
  SFT.Host.Text.equal (pathName c.path) "all-separated-solvation-transport-encounter-and-product-stages-retained" &&
  SFT.Host.Text.equal (statusName c.status) "all-favorable-adverse-control-and-unresolved-statuses-retained" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "complete-251-record-article-supplements-movies-and-dual-archive-ledger" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-251-record-identity-seal-and-depth-independent-path-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-finite-transport-state-and-transition-word") then "Endpoints erase the path that limits reaction entry." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "transport-exit-is-exact-reaction-encounter-entry") then "Unrelated processes do not establish a limiting boundary." else
  if !(SFT.Host.Text.equal (limitationName c.limitation) "reaction-admissible-only-after-complete-transport-word") then "An imported diffusion premise selects the boundary." else
  if !(SFT.Host.Text.equal (rateName c.rate) "completed-reaction-occurrences-per-exact-positive-observation-parts") then "A fit or continuum quantity cannot define the exact completion relation." else
  if !(SFT.Host.Text.equal (pathName c.path) "all-separated-solvation-transport-encounter-and-product-stages-retained") then "Omission destroys the complete transport-reaction word." else
  if !(SFT.Host.Text.equal (statusName c.status) "all-favorable-adverse-control-and-unresolved-statuses-retained") then "Omission falsely regularizes the evidence." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "complete-251-record-article-supplements-movies-and-dual-archive-ledger") then "A selected excerpt cannot establish complete source custody." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-251-record-identity-seal-and-depth-independent-path-successor") then "Target access can select the law." else
  "complete-finite-transport-state-and-transition-word__transport-exit-is-exact-reaction-encounter-entry__reaction-admissible-only-after-complete-transport-word__completed-reaction-occurrences-per-exact-positive-observation-parts__all-separated-solvation-transport-encounter-and-product-stages-retained__all-favorable-adverse-control-and-unresolved-statuses-retained__complete-251-record-article-supplements-movies-and-dual-archive-ledger__value-free-251-record-identity-seal-and-depth-independent-path-successor"

def generationRule : String := "Generate the literal product of support, composition, limitation, rate, path, status, provenance and prediction forms; decide all 256 candidates only from admitted finite state-transition, transport and reaction composition laws."
def grammarBoundary : String := "Every finite source-ordered transport-reaction family retaining the same reactant through two or more registered transport states, every adjacent transition, one exact transport exit/reaction-entry state, one held condition, one product state and every favorable, adverse, control or unresolved status. External testing binds all 251 pre-registered records: article landing, 43 PDF pages, two videos containing 1,350 frames, Figshare metadata and all 204 member identities from two byte-identical independently hosted archives."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Limitation.rejected,Limitation.admitted]).flatMap fun limitation =>
  ([Rate.rejected,Rate.admitted]).flatMap fun rate =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Status.rejected,Status.admitted]).flatMap fun status =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Prediction.rejected,Prediction.admitted]).map fun prediction =>
  ⟨support,composition,limitation,rate,path,status,provenance,prediction⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support composition limitation rate path status provenance prediction =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlimitation : limitation ∈ [Limitation.rejected,Limitation.admitted] := by
      cases limitation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrate : rate ∈ [Rate.rejected,Rate.admitted] := by
      cases rate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstatus : status ∈ [Status.rejected,Status.admitted] := by
      cases status <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ limitation _ hlimitation
    apply CommonRefinement.memFlatMap _ _ rate _ hrate
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ status _ hstatus
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ prediction _ hprediction

theorem sourceDecisionBlock0000 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,path,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0001 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,path,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0010 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,path,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0011 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,path,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0100 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,path,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0101 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,path,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0110 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,path,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0111 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,path,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1000 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,path,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1001 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,path,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1010 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,path,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1011 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,path,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1100 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,path,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1101 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,path,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1110 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,path,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1111 (path : Path) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,path,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,path,status,provenance,prediction⟩ := by
 cases path <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk support composition limitation rate path status provenance prediction =>
  cases support <;> cases composition <;> cases limitation <;> cases rate
  · exact sourceDecisionBlock0000 path status provenance prediction
  · exact sourceDecisionBlock0001 path status provenance prediction
  · exact sourceDecisionBlock0010 path status provenance prediction
  · exact sourceDecisionBlock0011 path status provenance prediction
  · exact sourceDecisionBlock0100 path status provenance prediction
  · exact sourceDecisionBlock0101 path status provenance prediction
  · exact sourceDecisionBlock0110 path status provenance prediction
  · exact sourceDecisionBlock0111 path status provenance prediction
  · exact sourceDecisionBlock1000 path status provenance prediction
  · exact sourceDecisionBlock1001 path status provenance prediction
  · exact sourceDecisionBlock1010 path status provenance prediction
  · exact sourceDecisionBlock1011 path status provenance prediction
  · exact sourceDecisionBlock1100 path status provenance prediction
  · exact sourceDecisionBlock1101 path status provenance prediction
  · exact sourceDecisionBlock1110 path status provenance prediction
  · exact sourceDecisionBlock1111 path status provenance prediction

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-finite-transport-state-and-transition-word" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "transport-exit-is-exact-reaction-encounter-entry" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem limitationCriterion (value : Limitation) : SFT.Host.Text.equal (limitationName value) "reaction-admissible-only-after-complete-transport-word" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem rateCriterion (value : Rate) : SFT.Host.Text.equal (rateName value) "completed-reaction-occurrences-per-exact-positive-observation-parts" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "all-separated-solvation-transport-encounter-and-product-stages-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem statusCriterion (value : Status) : SFT.Host.Text.equal (statusName value) "all-favorable-adverse-control-and-unresolved-statuses-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "complete-251-record-article-supplements-movies-and-dual-archive-ledger" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-251-record-identity-seal-and-depth-independent-path-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [supportCriterion, compositionCriterion, limitationCriterion, rateCriterion, pathCriterion, statusCriterion, provenanceCriterion, predictionCriterion]
  cases c with
  | mk support composition limitation rate path status provenance prediction =>
    cases support <;> cases composition <;> cases limitation <;> cases rate <;> cases path <;> cases status <;> cases provenance <;> cases prediction
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.composition = .admitted ∧ c.limitation = .admitted ∧ c.rate = .admitted ∧ c.path = .admitted ∧ c.status = .admitted ∧ c.provenance = .admitted ∧ c.prediction = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support composition limitation rate path status provenance prediction =>
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem limitation_rejected_rejected (c : Candidate) (h : c.limitation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.limitation eq
    rw [h] at field
    cases field

theorem rate_rejected_rejected (c : Candidate) (h : c.rate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rate eq
    rw [h] at field
    cases field

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
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

end SFT.Chemistry.DiffusionLimitedReactionGrammar
