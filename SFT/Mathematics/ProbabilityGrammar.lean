import SFT.Mathematics.ProbabilityWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.ProbabilityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "sampled-or-partial-support"
  | .admitted => "complete-generated-support"

inductive Event where
  | rejected | admitted

def eventName : Event → String
  | .rejected => "named-outcome"
  | .admitted => "held-support-selection"

inductive Weight where
  | rejected | admitted

def weightName : Weight → String
  | .rejected => "floating-propensity"
  | .admitted => "exact-held-whole-part"

inductive Uncertainty where
  | rejected | admitted

def uncertaintyName : Uncertainty → String
  | .rejected => "ontic-random-cause"
  | .admitted => "closed-observation-distinction"

inductive Conditioning where
  | rejected | admitted

def conditioningName : Conditioning → String
  | .rejected => "renormalized-guess"
  | .admitted => "exact-common-refinement"

inductive Independence where
  | rejected | admitted

def independenceName : Independence → String
  | .rejected => "uncorrelated-assertion"
  | .admitted => "pair-cell-factorization"

inductive Statistics where
  | rejected | admitted

def statisticsName : Statistics → String
  | .rejected => "opaque-estimator"
  | .admitted => "provenance-retaining-summary"

inductive Empirical where
  | rejected | admitted

def empiricalName : Empirical → String
  | .rejected => "target-informed-fit"
  | .admitted => "post-seal-blind-check"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-random-parameter"
  | .admitted => "no-extra-random-parameter"

structure Candidate where
  support : Support
  event : Event
  weight : Weight
  uncertainty : Uncertainty
  conditioning : Conditioning
  independence : Independence
  statistics : Statistics
  empirical : Empirical
  addition : Addition

def sourceFields (c : Candidate) : List String := [supportName c.support, eventName c.event, weightName c.weight, uncertaintyName c.uncertainty, conditioningName c.conditioning, independenceName c.independence, statisticsName c.statistics, empiricalName c.empirical, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "event=" (eventName c.event), SFT.Host.Text.append "weight=" (weightName c.weight), SFT.Host.Text.append "uncertainty=" (uncertaintyName c.uncertainty), SFT.Host.Text.append "conditioning=" (conditioningName c.conditioning), SFT.Host.Text.append "independence=" (independenceName c.independence), SFT.Host.Text.append "statistics=" (statisticsName c.statistics), SFT.Host.Text.append "empirical=" (empiricalName c.empirical), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-generated-support__held-support-selection__exact-held-whole-part__closed-observation-distinction__exact-common-refinement__pair-cell-factorization__provenance-retaining-summary__post-seal-blind-check__no-extra-random-parameter"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-generated-support" &&
  SFT.Host.Text.equal (eventName c.event) "held-support-selection" &&
  SFT.Host.Text.equal (weightName c.weight) "exact-held-whole-part" &&
  SFT.Host.Text.equal (uncertaintyName c.uncertainty) "closed-observation-distinction" &&
  SFT.Host.Text.equal (conditioningName c.conditioning) "exact-common-refinement" &&
  SFT.Host.Text.equal (independenceName c.independence) "pair-cell-factorization" &&
  SFT.Host.Text.equal (statisticsName c.statistics) "provenance-retaining-summary" &&
  SFT.Host.Text.equal (empiricalName c.empirical) "post-seal-blind-check" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-random-parameter"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-generated-support") then "A partial support silently changes every derived weight." else
  if !(SFT.Host.Text.equal (eventName c.event) "held-support-selection") then "A name without retained membership does not identify support." else
  if !(SFT.Host.Text.equal (weightName c.weight) "exact-held-whole-part") then "A floating propensity imports precision and a stochastic cause." else
  if !(SFT.Host.Text.equal (uncertaintyName c.uncertainty) "closed-observation-distinction") then "A causal random source is neither generated nor required." else
  if !(SFT.Host.Text.equal (conditioningName c.conditioning) "exact-common-refinement") then "A guessed renormalization can omit common support." else
  if !(SFT.Host.Text.equal (independenceName c.independence) "pair-cell-factorization") then "An assertion does not prove factorized joint support." else
  if !(SFT.Host.Text.equal (statisticsName c.statistics) "provenance-retaining-summary") then "An opaque scalar erases source rows and tie structure." else
  if !(SFT.Host.Text.equal (empiricalName c.empirical) "post-seal-blind-check") then "Using target rows during derivation allows them to select the law." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-random-parameter") then "A seed distribution or prior is a free parameter." else
  "The probability/statistics kernel is complete deterministic support, held events, exact held/whole weights, observation-class uncertainty, common-refinement conditioning, pair-cell independence, transparent finite summaries and post-seal empirical checking without random parameters."

def generationRule : String := "Generate the complete product of support coverage, event formation, weight, uncertainty status, conditioning, independence, statistics, empirical isolation and extra-random-law status."
def grammarBoundary : String := "All exact finite probability spaces and statistical traces generated from complete microstate support, held selections, observation classes, common refinement, exact parts and sealed empirical measurements."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Event.rejected,Event.admitted]).flatMap fun event =>
  ([Weight.rejected,Weight.admitted]).flatMap fun weight =>
  ([Uncertainty.rejected,Uncertainty.admitted]).flatMap fun uncertainty =>
  ([Conditioning.rejected,Conditioning.admitted]).flatMap fun conditioning =>
  ([Independence.rejected,Independence.admitted]).flatMap fun independence =>
  ([Statistics.rejected,Statistics.admitted]).flatMap fun statistics =>
  ([Empirical.rejected,Empirical.admitted]).flatMap fun empirical =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨support,event,weight,uncertainty,conditioning,independence,statistics,empirical,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support event weight uncertainty conditioning independence statistics empirical addition =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevent : event ∈ [Event.rejected,Event.admitted] := by
      cases event <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hweight : weight ∈ [Weight.rejected,Weight.admitted] := by
      cases weight <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huncertainty : uncertainty ∈ [Uncertainty.rejected,Uncertainty.admitted] := by
      cases uncertainty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditioning : conditioning ∈ [Conditioning.rejected,Conditioning.admitted] := by
      cases conditioning <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hindependence : independence ∈ [Independence.rejected,Independence.admitted] := by
      cases independence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstatistics : statistics ∈ [Statistics.rejected,Statistics.admitted] := by
      cases statistics <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hempirical : empirical ∈ [Empirical.rejected,Empirical.admitted] := by
      cases empirical <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ event _ hevent
    apply CommonRefinement.memFlatMap _ _ weight _ hweight
    apply CommonRefinement.memFlatMap _ _ uncertainty _ huncertainty
    apply CommonRefinement.memFlatMap _ _ conditioning _ hconditioning
    apply CommonRefinement.memFlatMap _ _ independence _ hindependence
    apply CommonRefinement.memFlatMap _ _ statistics _ hstatistics
    apply CommonRefinement.memFlatMap _ _ empirical _ hempirical
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support event weight uncertainty conditioning independence statistics empirical addition =>
    cases support <;> cases event <;> cases weight <;> cases uncertainty <;> cases conditioning <;> cases independence <;> cases statistics <;> cases empirical <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support event weight uncertainty conditioning independence statistics empirical addition =>
    cases support <;> cases event <;> cases weight <;> cases uncertainty <;> cases conditioning <;> cases independence <;> cases statistics <;> cases empirical <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.event = .admitted ∧ c.weight = .admitted ∧ c.uncertainty = .admitted ∧ c.conditioning = .admitted ∧ c.independence = .admitted ∧ c.statistics = .admitted ∧ c.empirical = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support event weight uncertainty conditioning independence statistics empirical addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem event_rejected_rejected (c : Candidate) (h : c.event = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.event eq
    rw [h] at field
    cases field

theorem weight_rejected_rejected (c : Candidate) (h : c.weight = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.weight eq
    rw [h] at field
    cases field

theorem uncertainty_rejected_rejected (c : Candidate) (h : c.uncertainty = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.uncertainty eq
    rw [h] at field
    cases field

theorem conditioning_rejected_rejected (c : Candidate) (h : c.conditioning = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conditioning eq
    rw [h] at field
    cases field

theorem independence_rejected_rejected (c : Candidate) (h : c.independence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.independence eq
    rw [h] at field
    cases field

theorem statistics_rejected_rejected (c : Candidate) (h : c.statistics = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.statistics eq
    rw [h] at field
    cases field

theorem empirical_rejected_rejected (c : Candidate) (h : c.empirical = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.empirical eq
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

end SFT.Mathematics.ProbabilityGrammar
