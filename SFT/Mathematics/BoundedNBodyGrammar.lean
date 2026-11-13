import SFT.Mathematics.BoundedFoldTransient
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.BoundedNBodyGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive State_domain where
  | rejected | admitted

def state_domainName : State_domain → String
  | .rejected => "continuum-coordinates"
  | .admitted => "finite-rational-tuple"

inductive Component_rule where
  | rejected | admitted

def component_ruleName : Component_rule → String
  | .rejected => "imported-force-law"
  | .admitted => "componentwise-fold"

inductive Denominator where
  | rejected | admitted

def denominatorName : Denominator → String
  | .rejected => "unbounded-drift"
  | .admitted => "conserved-odd-core"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "uncounted-space"
  | .admitted => "finite-product-support"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "chaos-label"
  | .admitted => "exact-return"

inductive Period where
  | rejected | admitted

def periodName : Period → String
  | .rejected => "selected-period"
  | .admitted => "least-common-period"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "three-body-table"
  | .admitted => "tuple-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "external-dynamics"
  | .admitted => "no-extra-rule"

structure Candidate where
  state_domain : State_domain
  component_rule : Component_rule
  denominator : Denominator
  support : Support
  recurrence : Recurrence
  period : Period
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [state_domainName c.state_domain, component_ruleName c.component_rule, denominatorName c.denominator, supportName c.support, recurrenceName c.recurrence, periodName c.period, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "state_domain=" (state_domainName c.state_domain), SFT.Host.Text.append "component_rule=" (component_ruleName c.component_rule), SFT.Host.Text.append "denominator=" (denominatorName c.denominator), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "period=" (periodName c.period), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "finite-rational-tuple__componentwise-fold__conserved-odd-core__finite-product-support__exact-return__least-common-period__tuple-successor__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (state_domainName c.state_domain) "finite-rational-tuple" &&
  SFT.Host.Text.equal (component_ruleName c.component_rule) "componentwise-fold" &&
  SFT.Host.Text.equal (denominatorName c.denominator) "conserved-odd-core" &&
  SFT.Host.Text.equal (supportName c.support) "finite-product-support" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "exact-return" &&
  SFT.Host.Text.equal (periodName c.period) "least-common-period" &&
  SFT.Host.Text.equal (generalityName c.generality) "tuple-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (state_domainName c.state_domain) "finite-rational-tuple") then "Continuum coordinates are outside the object language." else
  if !(SFT.Host.Text.equal (component_ruleName c.component_rule) "componentwise-fold") then "An imported force law changes the system." else
  if !(SFT.Host.Text.equal (denominatorName c.denominator) "conserved-odd-core") then "Fold cannot introduce a new denominator factor." else
  if !(SFT.Host.Text.equal (supportName c.support) "finite-product-support") then "An uncounted space cannot establish recurrence." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "exact-return") then "A label does not defeat a finite deterministic return certificate." else
  if !(SFT.Host.Text.equal (periodName c.period) "least-common-period") then "A selected period is not forced." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "tuple-successor") then "One tuple size is not the theorem." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "External gravitational dynamics is a different claim." else
  "All finite componentwise Fold tuples are eventually recurrent; their recurrent joint period is the iterated least common multiple of component odd-core periods."

def generationRule : String := "Exhaust state domain, component rule, denominator custody, support, recurrence, period, generality and extra-dynamics choices."
def grammarBoundary : String := "Finite tuples whose dynamics is exactly componentwise Fold on generated rational parts."

def candidates : List Candidate :=
  ([State_domain.rejected,State_domain.admitted]).flatMap fun state_domain =>
  ([Component_rule.rejected,Component_rule.admitted]).flatMap fun component_rule =>
  ([Denominator.rejected,Denominator.admitted]).flatMap fun denominator =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Period.rejected,Period.admitted]).flatMap fun period =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨state_domain,component_rule,denominator,support,recurrence,period,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk state_domain component_rule denominator support recurrence period generality addition =>
    have hstate_domain : state_domain ∈ [State_domain.rejected,State_domain.admitted] := by
      cases state_domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomponent_rule : component_rule ∈ [Component_rule.rejected,Component_rule.admitted] := by
      cases component_rule <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdenominator : denominator ∈ [Denominator.rejected,Denominator.admitted] := by
      cases denominator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hperiod : period ∈ [Period.rejected,Period.admitted] := by
      cases period <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ state_domain _ hstate_domain
    apply CommonRefinement.memFlatMap _ _ component_rule _ hcomponent_rule
    apply CommonRefinement.memFlatMap _ _ denominator _ hdenominator
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ period _ hperiod
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk state_domain component_rule denominator support recurrence period generality addition =>
    cases state_domain <;> cases component_rule <;> cases denominator <;> cases support <;> cases recurrence <;> cases period <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk state_domain component_rule denominator support recurrence period generality addition =>
    cases state_domain <;> cases component_rule <;> cases denominator <;> cases support <;> cases recurrence <;> cases period <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.state_domain = .admitted ∧ c.component_rule = .admitted ∧ c.denominator = .admitted ∧ c.support = .admitted ∧ c.recurrence = .admitted ∧ c.period = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk state_domain component_rule denominator support recurrence period generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem state_domain_rejected_rejected (c : Candidate) (h : c.state_domain = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.state_domain eq
    rw [h] at field
    cases field

theorem component_rule_rejected_rejected (c : Candidate) (h : c.component_rule = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.component_rule eq
    rw [h] at field
    cases field

theorem denominator_rejected_rejected (c : Candidate) (h : c.denominator = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.denominator eq
    rw [h] at field
    cases field

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
    rw [h] at field
    cases field

theorem period_rejected_rejected (c : Candidate) (h : c.period = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.period eq
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

end SFT.Mathematics.BoundedNBodyGrammar
