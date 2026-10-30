import SFT.Computation.SecurityDefinitionWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.SecurityDefinitionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "sampled-messages-or-keys"
  | .admitted => "complete-generated-challenge-support"

inductive Adversary where
  | rejected | admitted

def adversaryName : Adversary → String
  | .rejected => "undefined-adversary"
  | .admitted => "exact-adversary-process-grammar"

inductive Interaction where
  | rejected | admitted

def interactionName : Interaction → String
  | .rejected => "outcome-only"
  | .admitted => "complete-interaction-trace"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "implicit-leakage"
  | .admitted => "exact-adversary-observation"

inductive Security where
  | rejected | admitted

def securityName : Security → String
  | .rejected => "informal-security"
  | .admitted => "retained-closed-distinction-property"

inductive Resources where
  | rejected | admitted

def resourcesName : Resources → String
  | .rejected => "unbounded-claim"
  | .admitted => "declared-information-or-resource-bound"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "challenge-examples"
  | .admitted => "support-successor-certificate"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "imported-hardness-assumption"
  | .admitted => "no-extra-security-premise"

structure Candidate where
  support : Support
  adversary : Adversary
  interaction : Interaction
  observation : Observation
  security : Security
  resources : Resources
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [supportName c.support, adversaryName c.adversary, interactionName c.interaction, observationName c.observation, securityName c.security, resourcesName c.resources, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "adversary=" (adversaryName c.adversary), SFT.Host.Text.append "interaction=" (interactionName c.interaction), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "security=" (securityName c.security), SFT.Host.Text.append "resources=" (resourcesName c.resources), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-generated-challenge-support__exact-adversary-process-grammar__complete-interaction-trace__exact-adversary-observation__retained-closed-distinction-property__declared-information-or-resource-bound__support-successor-certificate__no-extra-security-premise"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-generated-challenge-support" &&
  SFT.Host.Text.equal (adversaryName c.adversary) "exact-adversary-process-grammar" &&
  SFT.Host.Text.equal (interactionName c.interaction) "complete-interaction-trace" &&
  SFT.Host.Text.equal (observationName c.observation) "exact-adversary-observation" &&
  SFT.Host.Text.equal (securityName c.security) "retained-closed-distinction-property" &&
  SFT.Host.Text.equal (resourcesName c.resources) "declared-information-or-resource-bound" &&
  SFT.Host.Text.equal (generalityName c.generality) "support-successor-certificate" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-security-premise"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-generated-challenge-support") then "sampled-messages-or-keys removes a required exact support condition." else
  if !(SFT.Host.Text.equal (adversaryName c.adversary) "exact-adversary-process-grammar") then "undefined-adversary removes a required exact adversary condition." else
  if !(SFT.Host.Text.equal (interactionName c.interaction) "complete-interaction-trace") then "outcome-only removes a required exact interaction condition." else
  if !(SFT.Host.Text.equal (observationName c.observation) "exact-adversary-observation") then "implicit-leakage removes a required exact observation condition." else
  if !(SFT.Host.Text.equal (securityName c.security) "retained-closed-distinction-property") then "informal-security removes a required exact security condition." else
  if !(SFT.Host.Text.equal (resourcesName c.resources) "declared-information-or-resource-bound") then "unbounded-claim removes a required exact resources condition." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "support-successor-certificate") then "challenge-examples removes a required exact generality condition." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-security-premise") then "imported-hardness-assumption removes a required exact addition condition." else
  "The forced exact separation of unconditional and resource-bounded security kernel retains secret support; observation classes; adversary support; resource law; exact success parts; perfect and bounded cases; reduction certificate; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."

def generationRule : String := "Generate the literal product of the eight registered Cryptography and Computational Security structural axes for exact separation of unconditional and resource-bounded security."
def grammarBoundary : String := "All generated finite exact separation of unconditional and resource-bounded security structures whose carriers, relations, traces and interfaces are composed from admitted Foundation, Mathematics and Information Science forms. Information-theoretic and computational claims must never be conflated."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Adversary.rejected,Adversary.admitted]).flatMap fun adversary =>
  ([Interaction.rejected,Interaction.admitted]).flatMap fun interaction =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Security.rejected,Security.admitted]).flatMap fun security =>
  ([Resources.rejected,Resources.admitted]).flatMap fun resources =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨support,adversary,interaction,observation,security,resources,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support adversary interaction observation security resources generality addition =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadversary : adversary ∈ [Adversary.rejected,Adversary.admitted] := by
      cases adversary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinteraction : interaction ∈ [Interaction.rejected,Interaction.admitted] := by
      cases interaction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsecurity : security ∈ [Security.rejected,Security.admitted] := by
      cases security <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresources : resources ∈ [Resources.rejected,Resources.admitted] := by
      cases resources <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ adversary _ hadversary
    apply CommonRefinement.memFlatMap _ _ interaction _ hinteraction
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ security _ hsecurity
    apply CommonRefinement.memFlatMap _ _ resources _ hresources
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support adversary interaction observation security resources generality addition =>
    cases support <;> cases adversary <;> cases interaction <;> cases observation <;> cases security <;> cases resources <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support adversary interaction observation security resources generality addition =>
    cases support <;> cases adversary <;> cases interaction <;> cases observation <;> cases security <;> cases resources <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.adversary = .admitted ∧ c.interaction = .admitted ∧ c.observation = .admitted ∧ c.security = .admitted ∧ c.resources = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support adversary interaction observation security resources generality addition =>
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

theorem adversary_rejected_rejected (c : Candidate) (h : c.adversary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.adversary eq
    rw [h] at field
    cases field

theorem interaction_rejected_rejected (c : Candidate) (h : c.interaction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.interaction eq
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

theorem security_rejected_rejected (c : Candidate) (h : c.security = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.security eq
    rw [h] at field
    cases field

theorem resources_rejected_rejected (c : Candidate) (h : c.resources = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.resources eq
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

end SFT.Computation.SecurityDefinitionGrammar
