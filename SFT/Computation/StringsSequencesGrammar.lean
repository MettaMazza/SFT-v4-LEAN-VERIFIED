import SFT.Computation.StringsSequencesWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.StringsSequencesGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Domain where
  | rejected | admitted

def domainName : Domain → String
  | .rejected => "sampled-inputs"
  | .admitted => "complete-generated-input-domain"

inductive Precondition where
  | rejected | admitted

def preconditionName : Precondition → String
  | .rejected => "implicit-precondition"
  | .admitted => "exact-registered-precondition"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "answer-producing-heuristic"
  | .admitted => "exact-step-relation"

inductive Invariant where
  | rejected | admitted

def invariantName : Invariant → String
  | .rejected => "unchecked-intermediate-state"
  | .admitted => "retained-invariant-ledger"

inductive Output where
  | rejected | admitted

def outputName : Output → String
  | .rejected => "result-without-certificate"
  | .admitted => "reconstructible-output-certificate"

inductive Resource where
  | rejected | admitted

def resourceName : Resource → String
  | .rejected => "unreported-resources"
  | .admitted => "complete-time-space-trace"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "example-program"
  | .admitted => "input-successor-certificate"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "imported-algorithm"
  | .admitted => "no-extra-answer-model"

structure Candidate where
  domain : Domain
  precondition : Precondition
  transition : Transition
  invariant : Invariant
  output : Output
  resource : Resource
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [domainName c.domain, preconditionName c.precondition, transitionName c.transition, invariantName c.invariant, outputName c.output, resourceName c.resource, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "precondition=" (preconditionName c.precondition), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "invariant=" (invariantName c.invariant), SFT.Host.Text.append "output=" (outputName c.output), SFT.Host.Text.append "resource=" (resourceName c.resource), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-generated-input-domain__exact-registered-precondition__exact-step-relation__retained-invariant-ledger__reconstructible-output-certificate__complete-time-space-trace__input-successor-certificate__no-extra-answer-model"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (domainName c.domain) "complete-generated-input-domain" &&
  SFT.Host.Text.equal (preconditionName c.precondition) "exact-registered-precondition" &&
  SFT.Host.Text.equal (transitionName c.transition) "exact-step-relation" &&
  SFT.Host.Text.equal (invariantName c.invariant) "retained-invariant-ledger" &&
  SFT.Host.Text.equal (outputName c.output) "reconstructible-output-certificate" &&
  SFT.Host.Text.equal (resourceName c.resource) "complete-time-space-trace" &&
  SFT.Host.Text.equal (generalityName c.generality) "input-successor-certificate" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-answer-model"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (domainName c.domain) "complete-generated-input-domain") then "sampled-inputs removes a required exact domain condition." else
  if !(SFT.Host.Text.equal (preconditionName c.precondition) "exact-registered-precondition") then "implicit-precondition removes a required exact precondition condition." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "exact-step-relation") then "answer-producing-heuristic removes a required exact transition condition." else
  if !(SFT.Host.Text.equal (invariantName c.invariant) "retained-invariant-ledger") then "unchecked-intermediate-state removes a required exact invariant condition." else
  if !(SFT.Host.Text.equal (outputName c.output) "reconstructible-output-certificate") then "result-without-certificate removes a required exact output condition." else
  if !(SFT.Host.Text.equal (resourceName c.resource) "complete-time-space-trace") then "unreported-resources removes a required exact resource condition." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "input-successor-certificate") then "example-program removes a required exact generality condition." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-answer-model") then "imported-algorithm removes a required exact addition condition." else
  "The forced finite ordered symbol organizations kernel retains complete positions; held symbols; substring or subsequence relation; scan trace; match ledger; reconstruction witness; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."

def generationRule : String := "Generate the literal product of the eight registered Algorithms and Mathematical Data Structures structural axes for finite ordered symbol organizations."
def grammarBoundary : String := "All generated finite finite ordered symbol organizations structures whose carriers, relations, traces and interfaces are composed from admitted Foundation, Mathematics and Information Science forms. No ungenerated infinite stream is treated as complete."

def candidates : List Candidate :=
  ([Domain.rejected,Domain.admitted]).flatMap fun domain =>
  ([Precondition.rejected,Precondition.admitted]).flatMap fun precondition =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Invariant.rejected,Invariant.admitted]).flatMap fun invariant =>
  ([Output.rejected,Output.admitted]).flatMap fun output =>
  ([Resource.rejected,Resource.admitted]).flatMap fun resource =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨domain,precondition,transition,invariant,output,resource,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk domain precondition transition invariant output resource generality addition =>
    have hdomain : domain ∈ [Domain.rejected,Domain.admitted] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprecondition : precondition ∈ [Precondition.rejected,Precondition.admitted] := by
      cases precondition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinvariant : invariant ∈ [Invariant.rejected,Invariant.admitted] := by
      cases invariant <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have houtput : output ∈ [Output.rejected,Output.admitted] := by
      cases output <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresource : resource ∈ [Resource.rejected,Resource.admitted] := by
      cases resource <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ precondition _ hprecondition
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ invariant _ hinvariant
    apply CommonRefinement.memFlatMap _ _ output _ houtput
    apply CommonRefinement.memFlatMap _ _ resource _ hresource
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk domain precondition transition invariant output resource generality addition =>
    cases domain <;> cases precondition <;> cases transition <;> cases invariant <;> cases output <;> cases resource <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk domain precondition transition invariant output resource generality addition =>
    cases domain <;> cases precondition <;> cases transition <;> cases invariant <;> cases output <;> cases resource <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.domain = .admitted ∧ c.precondition = .admitted ∧ c.transition = .admitted ∧ c.invariant = .admitted ∧ c.output = .admitted ∧ c.resource = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk domain precondition transition invariant output resource generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem domain_rejected_rejected (c : Candidate) (h : c.domain = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.domain eq
    rw [h] at field
    cases field

theorem precondition_rejected_rejected (c : Candidate) (h : c.precondition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.precondition eq
    rw [h] at field
    cases field

theorem transition_rejected_rejected (c : Candidate) (h : c.transition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transition eq
    rw [h] at field
    cases field

theorem invariant_rejected_rejected (c : Candidate) (h : c.invariant = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.invariant eq
    rw [h] at field
    cases field

theorem output_rejected_rejected (c : Candidate) (h : c.output = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.output eq
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

end SFT.Computation.StringsSequencesGrammar
