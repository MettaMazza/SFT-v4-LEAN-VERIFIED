import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ParallelMechanismGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-dominant-or-favorable-path-subset"
  | .admitted => "complete-registered-parallel-path-support"

inductive Origin where
  | rejected | admitted

def originName : Origin → String
  | .rejected => "unrelated-or-collapsed-initial-boundary"
  | .admitted => "exact-common-initial-state-boundary"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "endpoint-only-path-summary"
  | .admitted => "complete-state-edge-word-for-every-path"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "imported-stochastic-weight-or-parallel-rate-equation"
  | .admitted => "finite-source-ordered-parallel-path-composition"

inductive Sharing where
  | rejected | admitted

def sharingName : Sharing → String
  | .rejected => "shared-prefix-terminal-or-occurrence-collapsed"
  | .admitted => "shared-boundaries-retained-in-every-path-occurrence"

inductive Status where
  | rejected | admitted

def statusName : Status → String
  | .rejected => "weak-adverse-unresolved-or-unassigned-path-omitted"
  | .admitted => "all-path-statuses-and-unresolved-records-retained"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "selected-plot-mean-or-answer-only-product-table"
  | .admitted => "complete-article-supplement-and-twenty-eight-sheet-cell-ledger"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "product-time-value-readable-before-seal-or-corrected-after-release"
  | .admitted => "value-free-twenty-eight-sheet-identity-seal-and-depth-independent-path-successor"

structure Candidate where
  support : Support
  origin : Origin
  path : Path
  composition : Composition
  sharing : Sharing
  status : Status
  provenance : Provenance
  prediction : Prediction

def sourceFields (c : Candidate) : List String := [supportName c.support, originName c.origin, pathName c.path, compositionName c.composition, sharingName c.sharing, statusName c.status, provenanceName c.provenance, predictionName c.prediction]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "origin=" (originName c.origin), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "sharing=" (sharingName c.sharing), SFT.Host.Text.append "status=" (statusName c.status), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "prediction=" (predictionName c.prediction)]
def survivorId : String := "complete-registered-parallel-path-support__exact-common-initial-state-boundary__complete-state-edge-word-for-every-path__finite-source-ordered-parallel-path-composition__shared-boundaries-retained-in-every-path-occurrence__all-path-statuses-and-unresolved-records-retained__complete-article-supplement-and-twenty-eight-sheet-cell-ledger__value-free-twenty-eight-sheet-identity-seal-and-depth-independent-path-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-registered-parallel-path-support" &&
  SFT.Host.Text.equal (originName c.origin) "exact-common-initial-state-boundary" &&
  SFT.Host.Text.equal (pathName c.path) "complete-state-edge-word-for-every-path" &&
  SFT.Host.Text.equal (compositionName c.composition) "finite-source-ordered-parallel-path-composition" &&
  SFT.Host.Text.equal (sharingName c.sharing) "shared-boundaries-retained-in-every-path-occurrence" &&
  SFT.Host.Text.equal (statusName c.status) "all-path-statuses-and-unresolved-records-retained" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "complete-article-supplement-and-twenty-eight-sheet-cell-ledger" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-twenty-eight-sheet-identity-seal-and-depth-independent-path-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-registered-parallel-path-support") then "Selecting one visible path erases competing mechanism support." else
  if !(SFT.Host.Text.equal (originName c.origin) "exact-common-initial-state-boundary") then "Paths without the same retained source do not form one parallel mechanism." else
  if !(SFT.Host.Text.equal (pathName c.path) "complete-state-edge-word-for-every-path") then "Endpoints erase the states, edges and intermediates that distinguish paths." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "finite-source-ordered-parallel-path-composition") then "An imported probability or rate equation can select a favored path." else
  if !(SFT.Host.Text.equal (sharingName c.sharing) "shared-boundaries-retained-in-every-path-occurrence") then "Collapsing a shared occurrence destroys path-local reconstruction." else
  if !(SFT.Host.Text.equal (statusName c.status) "all-path-statuses-and-unresolved-records-retained") then "Omission makes the remaining path family falsely complete." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "complete-article-supplement-and-twenty-eight-sheet-cell-ledger") then "A selected plot or aggregate cannot reconstruct the complete evidence surface." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-twenty-eight-sheet-identity-seal-and-depth-independent-path-successor") then "Target access or correction can select a mechanism." else
  "complete-registered-parallel-path-support__exact-common-initial-state-boundary__complete-state-edge-word-for-every-path__finite-source-ordered-parallel-path-composition__shared-boundaries-retained-in-every-path-occurrence__all-path-statuses-and-unresolved-records-retained__complete-article-supplement-and-twenty-eight-sheet-cell-ledger__value-free-twenty-eight-sheet-identity-seal-and-depth-independent-path-successor"

def generationRule : String := "Generate the literal product of support, origin, path, composition, sharing, status, provenance and prediction forms; decide all 256 candidates only from admitted Fold state-transition, graph, complete-channel and sequential-composition laws."
def grammarBoundary : String := "Every finite complete source-ordered family of at least two distinct sequential mechanism words sharing one registered reaction and one exact initial state, with every path identity, source occurrence, state, elementary edge, intermediate, condition, status and terminal occurrence retained. External testing preserves the complete article, supplement, peer-review record, source workbook, all twenty-eight worksheets and all 18,158 registered rectangular cell positions."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Origin.rejected,Origin.admitted]).flatMap fun origin =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Sharing.rejected,Sharing.admitted]).flatMap fun sharing =>
  ([Status.rejected,Status.admitted]).flatMap fun status =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Prediction.rejected,Prediction.admitted]).map fun prediction =>
  ⟨support,origin,path,composition,sharing,status,provenance,prediction⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support origin path composition sharing status provenance prediction =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horigin : origin ∈ [Origin.rejected,Origin.admitted] := by
      cases origin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsharing : sharing ∈ [Sharing.rejected,Sharing.admitted] := by
      cases sharing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstatus : status ∈ [Status.rejected,Status.admitted] := by
      cases status <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ origin _ horigin
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ sharing _ hsharing
    apply CommonRefinement.memFlatMap _ _ status _ hstatus
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ prediction _ hprediction

theorem sourceDecisionBlock0000 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0001 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0010 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0011 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0100 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0101 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0110 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0111 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1000 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1001 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1010 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1011 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1100 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1101 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1110 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1111 (sharing : Sharing) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,sharing,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,sharing,status,provenance,prediction⟩ := by
 cases sharing <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk support origin path composition sharing status provenance prediction =>
  cases support <;> cases origin <;> cases path <;> cases composition
  · exact sourceDecisionBlock0000 sharing status provenance prediction
  · exact sourceDecisionBlock0001 sharing status provenance prediction
  · exact sourceDecisionBlock0010 sharing status provenance prediction
  · exact sourceDecisionBlock0011 sharing status provenance prediction
  · exact sourceDecisionBlock0100 sharing status provenance prediction
  · exact sourceDecisionBlock0101 sharing status provenance prediction
  · exact sourceDecisionBlock0110 sharing status provenance prediction
  · exact sourceDecisionBlock0111 sharing status provenance prediction
  · exact sourceDecisionBlock1000 sharing status provenance prediction
  · exact sourceDecisionBlock1001 sharing status provenance prediction
  · exact sourceDecisionBlock1010 sharing status provenance prediction
  · exact sourceDecisionBlock1011 sharing status provenance prediction
  · exact sourceDecisionBlock1100 sharing status provenance prediction
  · exact sourceDecisionBlock1101 sharing status provenance prediction
  · exact sourceDecisionBlock1110 sharing status provenance prediction
  · exact sourceDecisionBlock1111 sharing status provenance prediction

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-registered-parallel-path-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem originCriterion (value : Origin) : SFT.Host.Text.equal (originName value) "exact-common-initial-state-boundary" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "complete-state-edge-word-for-every-path" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "finite-source-ordered-parallel-path-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem sharingCriterion (value : Sharing) : SFT.Host.Text.equal (sharingName value) "shared-boundaries-retained-in-every-path-occurrence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem statusCriterion (value : Status) : SFT.Host.Text.equal (statusName value) "all-path-statuses-and-unresolved-records-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "complete-article-supplement-and-twenty-eight-sheet-cell-ledger" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-twenty-eight-sheet-identity-seal-and-depth-independent-path-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [supportCriterion, originCriterion, pathCriterion, compositionCriterion, sharingCriterion, statusCriterion, provenanceCriterion, predictionCriterion]
  cases c with
  | mk support origin path composition sharing status provenance prediction =>
    cases support <;> cases origin <;> cases path <;> cases composition <;> cases sharing <;> cases status <;> cases provenance <;> cases prediction
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.origin = .admitted ∧ c.path = .admitted ∧ c.composition = .admitted ∧ c.sharing = .admitted ∧ c.status = .admitted ∧ c.provenance = .admitted ∧ c.prediction = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support origin path composition sharing status provenance prediction =>
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

theorem origin_rejected_rejected (c : Candidate) (h : c.origin = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.origin eq
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem sharing_rejected_rejected (c : Candidate) (h : c.sharing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sharing eq
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

end SFT.Chemistry.ParallelMechanismGrammar
