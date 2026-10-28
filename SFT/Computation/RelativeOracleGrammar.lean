import SFT.Computation.RelativeOracleWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.RelativeOracleGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Domain where
  | rejected | admitted

def domainName : Domain → String
  | .rejected => "sampled-descriptions"
  | .admitted => "complete-generated-description-domain"

inductive Execution where
  | rejected | admitted

def executionName : Execution → String
  | .rejected => "verdict-without-run"
  | .admitted => "exact-recognition-execution-trace"

inductive Result where
  | rejected | admitted

def resultName : Result → String
  | .rejected => "implicit-nontermination"
  | .admitted => "accept-reject-continue-classes"

inductive Self_reference where
  | rejected | admitted

def self_referenceName : Self_reference → String
  | .rejected => "self-reference-excluded"
  | .admitted => "generated-self-description-support"

inductive Totality where
  | rejected | admitted

def totalityName : Totality → String
  | .rejected => "assumed-total-decider"
  | .admitted => "explicit-totality-or-partiality-boundary"

inductive Translation where
  | rejected | admitted

def translationName : Translation → String
  | .rejected => "answer-changing-map"
  | .admitted => "answer-preserving-reduction"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "fixed-depth-table"
  | .admitted => "description-successor-certificate"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "hidden-oracle"
  | .admitted => "no-undeclared-computational-power"

structure Candidate where
  domain : Domain
  execution : Execution
  result : Result
  self_reference : Self_reference
  totality : Totality
  translation : Translation
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [domainName c.domain, executionName c.execution, resultName c.result, self_referenceName c.self_reference, totalityName c.totality, translationName c.translation, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "execution=" (executionName c.execution), SFT.Host.Text.append "result=" (resultName c.result), SFT.Host.Text.append "self_reference=" (self_referenceName c.self_reference), SFT.Host.Text.append "totality=" (totalityName c.totality), SFT.Host.Text.append "translation=" (translationName c.translation), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-generated-description-domain__exact-recognition-execution-trace__accept-reject-continue-classes__generated-self-description-support__explicit-totality-or-partiality-boundary__answer-preserving-reduction__description-successor-certificate__no-undeclared-computational-power"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (domainName c.domain) "complete-generated-description-domain" &&
  SFT.Host.Text.equal (executionName c.execution) "exact-recognition-execution-trace" &&
  SFT.Host.Text.equal (resultName c.result) "accept-reject-continue-classes" &&
  SFT.Host.Text.equal (self_referenceName c.self_reference) "generated-self-description-support" &&
  SFT.Host.Text.equal (totalityName c.totality) "explicit-totality-or-partiality-boundary" &&
  SFT.Host.Text.equal (translationName c.translation) "answer-preserving-reduction" &&
  SFT.Host.Text.equal (generalityName c.generality) "description-successor-certificate" &&
  SFT.Host.Text.equal (additionName c.addition) "no-undeclared-computational-power"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (domainName c.domain) "complete-generated-description-domain") then "sampled-descriptions removes a required exact domain condition." else
  if !(SFT.Host.Text.equal (executionName c.execution) "exact-recognition-execution-trace") then "verdict-without-run removes a required exact execution condition." else
  if !(SFT.Host.Text.equal (resultName c.result) "accept-reject-continue-classes") then "implicit-nontermination removes a required exact result condition." else
  if !(SFT.Host.Text.equal (self_referenceName c.self_reference) "generated-self-description-support") then "self-reference-excluded removes a required exact self_reference condition." else
  if !(SFT.Host.Text.equal (totalityName c.totality) "explicit-totality-or-partiality-boundary") then "assumed-total-decider removes a required exact totality condition." else
  if !(SFT.Host.Text.equal (translationName c.translation) "answer-preserving-reduction") then "answer-changing-map removes a required exact translation condition." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "description-successor-certificate") then "fixed-depth-table removes a required exact generality condition." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-undeclared-computational-power") then "hidden-oracle removes a required exact addition condition." else
  "The forced explicit external answer interfaces kernel retains base process; named query alphabet; declared oracle relation; query and answer trace; relative recognition; oracle-identity ledger; nesting boundary; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."

def generationRule : String := "Generate the literal product of the eight registered Computability structural axes for explicit external answer interfaces."
def grammarBoundary : String := "All generated finite explicit external answer interfaces structures whose carriers, relations, traces and interfaces are composed from admitted Foundation, Mathematics and Information Science forms. An oracle is a registered interface, never unexplained computational power."

def candidates : List Candidate :=
  ([Domain.rejected,Domain.admitted]).flatMap fun domain =>
  ([Execution.rejected,Execution.admitted]).flatMap fun execution =>
  ([Result.rejected,Result.admitted]).flatMap fun result =>
  ([Self_reference.rejected,Self_reference.admitted]).flatMap fun self_reference =>
  ([Totality.rejected,Totality.admitted]).flatMap fun totality =>
  ([Translation.rejected,Translation.admitted]).flatMap fun translation =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨domain,execution,result,self_reference,totality,translation,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk domain execution result self_reference totality translation generality addition =>
    have hdomain : domain ∈ [Domain.rejected,Domain.admitted] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexecution : execution ∈ [Execution.rejected,Execution.admitted] := by
      cases execution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresult : result ∈ [Result.rejected,Result.admitted] := by
      cases result <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hself_reference : self_reference ∈ [Self_reference.rejected,Self_reference.admitted] := by
      cases self_reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htotality : totality ∈ [Totality.rejected,Totality.admitted] := by
      cases totality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htranslation : translation ∈ [Translation.rejected,Translation.admitted] := by
      cases translation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ execution _ hexecution
    apply CommonRefinement.memFlatMap _ _ result _ hresult
    apply CommonRefinement.memFlatMap _ _ self_reference _ hself_reference
    apply CommonRefinement.memFlatMap _ _ totality _ htotality
    apply CommonRefinement.memFlatMap _ _ translation _ htranslation
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk domain execution result self_reference totality translation generality addition =>
    cases domain <;> cases execution <;> cases result <;> cases self_reference <;> cases totality <;> cases translation <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk domain execution result self_reference totality translation generality addition =>
    cases domain <;> cases execution <;> cases result <;> cases self_reference <;> cases totality <;> cases translation <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.domain = .admitted ∧ c.execution = .admitted ∧ c.result = .admitted ∧ c.self_reference = .admitted ∧ c.totality = .admitted ∧ c.translation = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk domain execution result self_reference totality translation generality addition =>
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

theorem execution_rejected_rejected (c : Candidate) (h : c.execution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.execution eq
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

theorem self_reference_rejected_rejected (c : Candidate) (h : c.self_reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.self_reference eq
    rw [h] at field
    cases field

theorem totality_rejected_rejected (c : Candidate) (h : c.totality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.totality eq
    rw [h] at field
    cases field

theorem translation_rejected_rejected (c : Candidate) (h : c.translation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.translation eq
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

end SFT.Computation.RelativeOracleGrammar
