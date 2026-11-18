import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AnalyticalSensitivityGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "anonymous-response"
  | .admitted => "held-analyte-method-condition"

inductive Input where
  | rejected | admitted

def inputName : Input → String
  | .rejected => "continuum-input-premise"
  | .admitted => "positive-ordered-input-support"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "response-fit-only"
  | .admitted => "paired-complete-response-support"

inductive Change where
  | rejected | admitted

def changeName : Change → String
  | .rejected => "signed-response-change"
  | .admitted => "held-response-side-positive-change-or-EmptyOne"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "fitted-global-slope"
  | .admitted => "exact-local-response-per-input-ratio"

inductive Domain where
  | rejected | admitted

def domainName : Domain → String
  | .rejected => "universal-linearity"
  | .admitted => "finite-registered-segment-domain"

inductive Noise where
  | rejected | admitted

def noiseName : Noise → String
  | .rejected => "drift-noise-erased"
  | .admitted => "complete-drift-noise-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refitted-history"
  | .admitted => "successor-retains-and-adds-segment"

structure Candidate where
  identity : Identity
  input : Input
  response : Response
  change : Change
  relation : Relation
  domain : Domain
  noise : Noise
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, inputName c.input, responseName c.response, changeName c.change, relationName c.relation, domainName c.domain, noiseName c.noise, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "input=" (inputName c.input), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "change=" (changeName c.change), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "noise=" (noiseName c.noise), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-analyte-method-condition__positive-ordered-input-support__paired-complete-response-support__held-response-side-positive-change-or-EmptyOne__exact-local-response-per-input-ratio__finite-registered-segment-domain__complete-drift-noise-custody__successor-retains-and-adds-segment"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-analyte-method-condition" &&
  SFT.Host.Text.equal (inputName c.input) "positive-ordered-input-support" &&
  SFT.Host.Text.equal (responseName c.response) "paired-complete-response-support" &&
  SFT.Host.Text.equal (changeName c.change) "held-response-side-positive-change-or-EmptyOne" &&
  SFT.Host.Text.equal (relationName c.relation) "exact-local-response-per-input-ratio" &&
  SFT.Host.Text.equal (domainName c.domain) "finite-registered-segment-domain" &&
  SFT.Host.Text.equal (noiseName c.noise) "complete-drift-noise-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-adds-segment"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-analyte-method-condition") then "No sensitivity is attributable." else
  if !(SFT.Host.Text.equal (inputName c.input) "positive-ordered-input-support") then "Uncounted support cannot be audited." else
  if !(SFT.Host.Text.equal (responseName c.response) "paired-complete-response-support") then "Observed rows are erased." else
  if !(SFT.Host.Text.equal (changeName c.change) "held-response-side-positive-change-or-EmptyOne") then "A sign is not a proof magnitude." else
  if !(SFT.Host.Text.equal (relationName c.relation) "exact-local-response-per-input-ratio") then "A global fit can hide local behavior." else
  if !(SFT.Host.Text.equal (domainName c.domain) "finite-registered-segment-domain") then "Sensitivity is condition-bound." else
  if !(SFT.Host.Text.equal (noiseName c.noise) "complete-drift-noise-custody") then "Sensitivity alone cannot establish resolution." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-adds-segment") then "A refit changes earlier relations." else
  "held-analyte-method-condition__positive-ordered-input-support__paired-complete-response-support__held-response-side-positive-change-or-EmptyOne__exact-local-response-per-input-ratio__finite-registered-segment-domain__complete-drift-noise-custody__successor-retains-and-adds-segment"

def generationRule : String := "Generate the literal product of eight registered analytical decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, input, response, change, relation, domain, noise and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Input.rejected,Input.admitted]).flatMap fun input =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Change.rejected,Change.admitted]).flatMap fun change =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Domain.rejected,Domain.admitted]).flatMap fun domain =>
  ([Noise.rejected,Noise.admitted]).flatMap fun noise =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,input,response,change,relation,domain,noise,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity input response change relation domain noise extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinput : input ∈ [Input.rejected,Input.admitted] := by
      cases input <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchange : change ∈ [Change.rejected,Change.admitted] := by
      cases change <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdomain : domain ∈ [Domain.rejected,Domain.admitted] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnoise : noise ∈ [Noise.rejected,Noise.admitted] := by
      cases noise <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ input _ hinput
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ change _ hchange
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ noise _ hnoise
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,relation,domain,noise,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,relation,domain,noise,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,relation,domain,noise,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,relation,domain,noise,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,relation,domain,noise,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,relation,domain,noise,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,relation,domain,noise,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,relation,domain,noise,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,relation,domain,noise,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,relation,domain,noise,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,relation,domain,noise,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,relation,domain,noise,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,relation,domain,noise,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,relation,domain,noise,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,relation,domain,noise,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (relation : Relation) (domain : Domain) (noise : Noise) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,relation,domain,noise,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,relation,domain,noise,extension⟩ := by
 cases relation <;> cases domain <;> cases noise <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity input response change relation domain noise extension =>
  cases identity <;> cases input <;> cases response <;> cases change
  · exact sourceDecisionBlock0000 relation domain noise extension
  · exact sourceDecisionBlock0001 relation domain noise extension
  · exact sourceDecisionBlock0010 relation domain noise extension
  · exact sourceDecisionBlock0011 relation domain noise extension
  · exact sourceDecisionBlock0100 relation domain noise extension
  · exact sourceDecisionBlock0101 relation domain noise extension
  · exact sourceDecisionBlock0110 relation domain noise extension
  · exact sourceDecisionBlock0111 relation domain noise extension
  · exact sourceDecisionBlock1000 relation domain noise extension
  · exact sourceDecisionBlock1001 relation domain noise extension
  · exact sourceDecisionBlock1010 relation domain noise extension
  · exact sourceDecisionBlock1011 relation domain noise extension
  · exact sourceDecisionBlock1100 relation domain noise extension
  · exact sourceDecisionBlock1101 relation domain noise extension
  · exact sourceDecisionBlock1110 relation domain noise extension
  · exact sourceDecisionBlock1111 relation domain noise extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-analyte-method-condition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem inputCriterion (value : Input) : SFT.Host.Text.equal (inputName value) "positive-ordered-input-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem responseCriterion (value : Response) : SFT.Host.Text.equal (responseName value) "paired-complete-response-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem changeCriterion (value : Change) : SFT.Host.Text.equal (changeName value) "held-response-side-positive-change-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "exact-local-response-per-input-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem domainCriterion (value : Domain) : SFT.Host.Text.equal (domainName value) "finite-registered-segment-domain" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem noiseCriterion (value : Noise) : SFT.Host.Text.equal (noiseName value) "complete-drift-noise-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-retains-and-adds-segment" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, inputCriterion, responseCriterion, changeCriterion, relationCriterion, domainCriterion, noiseCriterion, extensionCriterion]
  cases c with
  | mk identity input response change relation domain noise extension =>
    cases identity <;> cases input <;> cases response <;> cases change <;> cases relation <;> cases domain <;> cases noise <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.input = .admitted ∧ c.response = .admitted ∧ c.change = .admitted ∧ c.relation = .admitted ∧ c.domain = .admitted ∧ c.noise = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity input response change relation domain noise extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem input_rejected_rejected (c : Candidate) (h : c.input = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.input eq
    rw [h] at field
    cases field

theorem response_rejected_rejected (c : Candidate) (h : c.response = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.response eq
    rw [h] at field
    cases field

theorem change_rejected_rejected (c : Candidate) (h : c.change = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.change eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
    rw [h] at field
    cases field

theorem domain_rejected_rejected (c : Candidate) (h : c.domain = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.domain eq
    rw [h] at field
    cases field

theorem noise_rejected_rejected (c : Candidate) (h : c.noise = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.noise eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.AnalyticalSensitivityGrammar
