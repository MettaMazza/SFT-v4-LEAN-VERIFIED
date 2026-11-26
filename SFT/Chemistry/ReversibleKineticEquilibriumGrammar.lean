import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ReversibleKineticEquilibriumGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-forward-or-reverse-direction"
  | .admitted => "both-held-directional-transition-occurrences"

inductive Graph where
  | rejected | admitted

def graphName : Graph → String
  | .rejected => "separate-unrelated-forward-and-reverse-graphs"
  | .admitted => "same-exact-two-state-closed-transition-graph"

inductive Kinetics where
  | rejected | admitted

def kineticsName : Kinetics → String
  | .rejected => "endpoint-rate-fit-or-aggregate-only"
  | .admitted => "exact-ordered-directed-transition-word"

inductive Equilibrium where
  | rejected | admitted

def equilibriumName : Equilibrium → String
  | .rejected => "imported-equilibrium-constant-steady-state-or-balance-law"
  | .admitted => "closed-graph-recurrence-support"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "terminal-compositions-collapsed-or-averaged"
  | .admitted => "every-initial-terminal-composition-retained-separately"

inductive Status where
  | rejected | admitted

def statusName : Status → String
  | .rejected => "direction-label-disagreement-or-adverse-row-omitted"
  | .admitted => "all-favorable-adverse-and-disagreement-records-retained"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "selected-kinetic-pages-or-answer-table"
  | .admitted => "complete-article-supplement-movie-and-archive-ledger"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "state-time-composition-energy-or-target-readable-before-seal"
  | .admitted => "value-free-164-record-identity-seal-and-depth-independent-pair-successor"

structure Candidate where
  support : Support
  graph : Graph
  kinetics : Kinetics
  equilibrium : Equilibrium
  composition : Composition
  status : Status
  provenance : Provenance
  prediction : Prediction

def sourceFields (c : Candidate) : List String := [supportName c.support, graphName c.graph, kineticsName c.kinetics, equilibriumName c.equilibrium, compositionName c.composition, statusName c.status, provenanceName c.provenance, predictionName c.prediction]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "graph=" (graphName c.graph), SFT.Host.Text.append "kinetics=" (kineticsName c.kinetics), SFT.Host.Text.append "equilibrium=" (equilibriumName c.equilibrium), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "status=" (statusName c.status), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "prediction=" (predictionName c.prediction)]
def survivorId : String := "both-held-directional-transition-occurrences__same-exact-two-state-closed-transition-graph__exact-ordered-directed-transition-word__closed-graph-recurrence-support__every-initial-terminal-composition-retained-separately__all-favorable-adverse-and-disagreement-records-retained__complete-article-supplement-movie-and-archive-ledger__value-free-164-record-identity-seal-and-depth-independent-pair-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "both-held-directional-transition-occurrences" &&
  SFT.Host.Text.equal (graphName c.graph) "same-exact-two-state-closed-transition-graph" &&
  SFT.Host.Text.equal (kineticsName c.kinetics) "exact-ordered-directed-transition-word" &&
  SFT.Host.Text.equal (equilibriumName c.equilibrium) "closed-graph-recurrence-support" &&
  SFT.Host.Text.equal (compositionName c.composition) "every-initial-terminal-composition-retained-separately" &&
  SFT.Host.Text.equal (statusName c.status) "all-favorable-adverse-and-disagreement-records-retained" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "complete-article-supplement-movie-and-archive-ledger" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-164-record-identity-seal-and-depth-independent-pair-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "both-held-directional-transition-occurrences") then "One direction cannot establish a reversible pair." else
  if !(SFT.Host.Text.equal (graphName c.graph) "same-exact-two-state-closed-transition-graph") then "Unrelated paths cannot supply one kinetic-equilibrium correspondence." else
  if !(SFT.Host.Text.equal (kineticsName c.kinetics) "exact-ordered-directed-transition-word") then "A fit or endpoint erases ordered directed transition occurrences." else
  if !(SFT.Host.Text.equal (equilibriumName c.equilibrium) "closed-graph-recurrence-support") then "An imported equilibrium premise selects the correspondence." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "every-initial-terminal-composition-retained-separately") then "Averaging hides direction-specific observations." else
  if !(SFT.Host.Text.equal (statusName c.status) "all-favorable-adverse-and-disagreement-records-retained") then "Omission falsely regularizes the source." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "complete-article-supplement-movie-and-archive-ledger") then "A selected excerpt cannot prove complete source custody." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-164-record-identity-seal-and-depth-independent-pair-successor") then "Target access can select the graph." else
  "both-held-directional-transition-occurrences__same-exact-two-state-closed-transition-graph__exact-ordered-directed-transition-word__closed-graph-recurrence-support__every-initial-terminal-composition-retained-separately__all-favorable-adverse-and-disagreement-records-retained__complete-article-supplement-movie-and-archive-ledger__value-free-164-record-identity-seal-and-depth-independent-pair-successor"

def generationRule : String := "Generate the literal product of support, graph, kinetics, equilibrium, composition, status, provenance and prediction forms; decide all 256 candidates only from admitted exact state-transition, energy-order, complete-channel, sequential and parallel mechanism laws."
def grammarBoundary : String := "Every finite source-ordered family of complete two-state graphs containing two distinct registered states, one directed edge in each held orientation, one exact condition boundary and retained favorable, adverse or unresolved status. External testing binds all 164 pre-registered records: ten article pages, 144 supplementary pages, one additional-description page, one 73-frame movie and all eight source-data archive members."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Graph.rejected,Graph.admitted]).flatMap fun graph =>
  ([Kinetics.rejected,Kinetics.admitted]).flatMap fun kinetics =>
  ([Equilibrium.rejected,Equilibrium.admitted]).flatMap fun equilibrium =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Status.rejected,Status.admitted]).flatMap fun status =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Prediction.rejected,Prediction.admitted]).map fun prediction =>
  ⟨support,graph,kinetics,equilibrium,composition,status,provenance,prediction⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support graph kinetics equilibrium composition status provenance prediction =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgraph : graph ∈ [Graph.rejected,Graph.admitted] := by
      cases graph <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hkinetics : kinetics ∈ [Kinetics.rejected,Kinetics.admitted] := by
      cases kinetics <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequilibrium : equilibrium ∈ [Equilibrium.rejected,Equilibrium.admitted] := by
      cases equilibrium <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstatus : status ∈ [Status.rejected,Status.admitted] := by
      cases status <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ graph _ hgraph
    apply CommonRefinement.memFlatMap _ _ kinetics _ hkinetics
    apply CommonRefinement.memFlatMap _ _ equilibrium _ hequilibrium
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ status _ hstatus
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ prediction _ hprediction

theorem sourceDecisionBlock0000 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0001 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0010 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0011 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0100 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0101 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0110 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0111 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1000 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1001 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1010 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1011 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1100 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1101 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1110 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1111 (composition : Composition) (status : Status) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,composition,status,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,composition,status,provenance,prediction⟩ := by
 cases composition <;> cases status <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk support graph kinetics equilibrium composition status provenance prediction =>
  cases support <;> cases graph <;> cases kinetics <;> cases equilibrium
  · exact sourceDecisionBlock0000 composition status provenance prediction
  · exact sourceDecisionBlock0001 composition status provenance prediction
  · exact sourceDecisionBlock0010 composition status provenance prediction
  · exact sourceDecisionBlock0011 composition status provenance prediction
  · exact sourceDecisionBlock0100 composition status provenance prediction
  · exact sourceDecisionBlock0101 composition status provenance prediction
  · exact sourceDecisionBlock0110 composition status provenance prediction
  · exact sourceDecisionBlock0111 composition status provenance prediction
  · exact sourceDecisionBlock1000 composition status provenance prediction
  · exact sourceDecisionBlock1001 composition status provenance prediction
  · exact sourceDecisionBlock1010 composition status provenance prediction
  · exact sourceDecisionBlock1011 composition status provenance prediction
  · exact sourceDecisionBlock1100 composition status provenance prediction
  · exact sourceDecisionBlock1101 composition status provenance prediction
  · exact sourceDecisionBlock1110 composition status provenance prediction
  · exact sourceDecisionBlock1111 composition status provenance prediction

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "both-held-directional-transition-occurrences" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem graphCriterion (value : Graph) : SFT.Host.Text.equal (graphName value) "same-exact-two-state-closed-transition-graph" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem kineticsCriterion (value : Kinetics) : SFT.Host.Text.equal (kineticsName value) "exact-ordered-directed-transition-word" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem equilibriumCriterion (value : Equilibrium) : SFT.Host.Text.equal (equilibriumName value) "closed-graph-recurrence-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "every-initial-terminal-composition-retained-separately" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem statusCriterion (value : Status) : SFT.Host.Text.equal (statusName value) "all-favorable-adverse-and-disagreement-records-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "complete-article-supplement-movie-and-archive-ledger" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-164-record-identity-seal-and-depth-independent-pair-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [supportCriterion, graphCriterion, kineticsCriterion, equilibriumCriterion, compositionCriterion, statusCriterion, provenanceCriterion, predictionCriterion]
  cases c with
  | mk support graph kinetics equilibrium composition status provenance prediction =>
    cases support <;> cases graph <;> cases kinetics <;> cases equilibrium <;> cases composition <;> cases status <;> cases provenance <;> cases prediction
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.graph = .admitted ∧ c.kinetics = .admitted ∧ c.equilibrium = .admitted ∧ c.composition = .admitted ∧ c.status = .admitted ∧ c.provenance = .admitted ∧ c.prediction = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support graph kinetics equilibrium composition status provenance prediction =>
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

theorem graph_rejected_rejected (c : Candidate) (h : c.graph = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.graph eq
    rw [h] at field
    cases field

theorem kinetics_rejected_rejected (c : Candidate) (h : c.kinetics = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.kinetics eq
    rw [h] at field
    cases field

theorem equilibrium_rejected_rejected (c : Candidate) (h : c.equilibrium = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equilibrium eq
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

end SFT.Chemistry.ReversibleKineticEquilibriumGrammar
