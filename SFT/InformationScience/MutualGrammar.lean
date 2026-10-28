import SFT.InformationScience.MutualWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.MutualGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "partial-source-support"
  | .admitted => "complete-deterministic-support"

inductive Observations where
  | rejected | admitted

def observationsName : Observations → String
  | .rejected => "partial-or-multivalued-views"
  | .admitted => "two-total-observation-maps"

inductive Marginals where
  | rejected | admitted

def marginalsName : Marginals → String
  | .rejected => "named-marginal-scores"
  | .admitted => "exact-provenance-classes"

inductive Joint where
  | rejected | admitted

def jointName : Joint → String
  | .rejected => "sampled-joint-cells"
  | .admitted => "complete-joint-incidence-ledger"

inductive Conditional where
  | rejected | admitted

def conditionalName : Conditional → String
  | .rejected => "renormalized-prior"
  | .admitted => "exact-class-restriction"

inductive Mutual where
  | rejected | admitted

def mutualName : Mutual → String
  | .rejected => "scalar-log-ratio"
  | .admitted => "joint-versus-product-ledger"

inductive Factorization where
  | rejected | admitted

def factorizationName : Factorization → String
  | .rejected => "uncorrelated-assertion"
  | .admitted => "all-cell-exact-equality"

inductive Cause where
  | rejected | admitted

def causeName : Cause → String
  | .rejected => "stochastic-source-premise"
  | .admitted => "deterministic-observation-incidence"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "small-table-only"
  | .admitted => "source-successor-update"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-base-prior-or-scalar"
  | .admitted => "no-extra-information-measure"

structure Candidate where
  support : Support
  observations : Observations
  marginals : Marginals
  joint : Joint
  conditional : Conditional
  «mutual» : Mutual
  factorization : Factorization
  cause : Cause
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [supportName c.support, observationsName c.observations, marginalsName c.marginals, jointName c.joint, conditionalName c.conditional, mutualName c.«mutual», factorizationName c.factorization, causeName c.cause, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "observations=" (observationsName c.observations), SFT.Host.Text.append "marginals=" (marginalsName c.marginals), SFT.Host.Text.append "joint=" (jointName c.joint), SFT.Host.Text.append "conditional=" (conditionalName c.conditional), SFT.Host.Text.append "mutual=" (mutualName c.«mutual»), SFT.Host.Text.append "factorization=" (factorizationName c.factorization), SFT.Host.Text.append "cause=" (causeName c.cause), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-deterministic-support__two-total-observation-maps__exact-provenance-classes__complete-joint-incidence-ledger__exact-class-restriction__joint-versus-product-ledger__all-cell-exact-equality__deterministic-observation-incidence__source-successor-update__no-extra-information-measure"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-deterministic-support" &&
  SFT.Host.Text.equal (observationsName c.observations) "two-total-observation-maps" &&
  SFT.Host.Text.equal (marginalsName c.marginals) "exact-provenance-classes" &&
  SFT.Host.Text.equal (jointName c.joint) "complete-joint-incidence-ledger" &&
  SFT.Host.Text.equal (conditionalName c.conditional) "exact-class-restriction" &&
  SFT.Host.Text.equal (mutualName c.«mutual») "joint-versus-product-ledger" &&
  SFT.Host.Text.equal (factorizationName c.factorization) "all-cell-exact-equality" &&
  SFT.Host.Text.equal (causeName c.cause) "deterministic-observation-incidence" &&
  SFT.Host.Text.equal (generalityName c.generality) "source-successor-update" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-information-measure"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-deterministic-support") then "Omission changes marginal, joint and conditional parts." else
  if !(SFT.Host.Text.equal (observationsName c.observations) "two-total-observation-maps") then "An incomplete or multivalued view cannot form exact classes." else
  if !(SFT.Host.Text.equal (marginalsName c.marginals) "exact-provenance-classes") then "Scores erase which source forms produce each image." else
  if !(SFT.Host.Text.equal (jointName c.joint) "complete-joint-incidence-ledger") then "Sampling can hide absent or repeated combinations." else
  if !(SFT.Host.Text.equal (conditionalName c.conditional) "exact-class-restriction") then "A prior or guessed normalization is not generated." else
  if !(SFT.Host.Text.equal (mutualName c.«mutual») "joint-versus-product-ledger") then "A log ratio imports real values and erases the cells responsible." else
  if !(SFT.Host.Text.equal (factorizationName c.factorization) "all-cell-exact-equality") then "A label does not establish every joint cell and weight." else
  if !(SFT.Host.Text.equal (causeName c.cause) "deterministic-observation-incidence") then "A random cause is neither forced nor required." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "source-successor-update") then "A table does not establish the next source update." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-information-measure") then "The added choice is a free parameter." else
  "The mutual/conditional kernel is complete deterministic support, two total observations, exact marginal and joint classes, exact conditional restrictions, provenance-retaining joint/product comparison, all-cell factorization, successor closure and no stochastic or logarithmic measure."

def generationRule : String := "Generate the complete product of support, two observations, marginal classes, joint incidence, conditional restriction, dependence comparison, factorization, deterministic status, generality and extra-measure status."
def grammarBoundary : String := "All finite mutual and conditional information structures generated from complete deterministic support, two total observation maps, their exact marginal classes, complete joint cells and exact positive part relations."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Observations.rejected,Observations.admitted]).flatMap fun observations =>
  ([Marginals.rejected,Marginals.admitted]).flatMap fun marginals =>
  ([Joint.rejected,Joint.admitted]).flatMap fun joint =>
  ([Conditional.rejected,Conditional.admitted]).flatMap fun conditional =>
  ([Mutual.rejected,Mutual.admitted]).flatMap fun «mutual» =>
  ([Factorization.rejected,Factorization.admitted]).flatMap fun factorization =>
  ([Cause.rejected,Cause.admitted]).flatMap fun cause =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨support,observations,marginals,joint,conditional,«mutual»,factorization,cause,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support observations marginals joint conditional «mutual» factorization cause generality addition =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservations : observations ∈ [Observations.rejected,Observations.admitted] := by
      cases observations <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmarginals : marginals ∈ [Marginals.rejected,Marginals.admitted] := by
      cases marginals <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjoint : joint ∈ [Joint.rejected,Joint.admitted] := by
      cases joint <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditional : conditional ∈ [Conditional.rejected,Conditional.admitted] := by
      cases conditional <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmutual : «mutual» ∈ [Mutual.rejected,Mutual.admitted] := by
      cases «mutual» <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfactorization : factorization ∈ [Factorization.rejected,Factorization.admitted] := by
      cases factorization <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcause : cause ∈ [Cause.rejected,Cause.admitted] := by
      cases cause <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ observations _ hobservations
    apply CommonRefinement.memFlatMap _ _ marginals _ hmarginals
    apply CommonRefinement.memFlatMap _ _ joint _ hjoint
    apply CommonRefinement.memFlatMap _ _ conditional _ hconditional
    apply CommonRefinement.memFlatMap _ _ «mutual» _ hmutual
    apply CommonRefinement.memFlatMap _ _ factorization _ hfactorization
    apply CommonRefinement.memFlatMap _ _ cause _ hcause
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support observations marginals joint conditional «mutual» factorization cause generality addition =>
    cases support <;> cases observations <;> cases marginals <;> cases joint <;> cases conditional <;> cases «mutual» <;> cases factorization <;> cases cause <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support observations marginals joint conditional «mutual» factorization cause generality addition =>
    cases support <;> cases observations <;> cases marginals <;> cases joint <;> cases conditional <;> cases «mutual» <;> cases factorization <;> cases cause <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.observations = .admitted ∧ c.marginals = .admitted ∧ c.joint = .admitted ∧ c.conditional = .admitted ∧ c.«mutual» = .admitted ∧ c.factorization = .admitted ∧ c.cause = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support observations marginals joint conditional «mutual» factorization cause generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem observations_rejected_rejected (c : Candidate) (h : c.observations = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observations eq
    rw [h] at field
    cases field

theorem marginals_rejected_rejected (c : Candidate) (h : c.marginals = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.marginals eq
    rw [h] at field
    cases field

theorem joint_rejected_rejected (c : Candidate) (h : c.joint = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.joint eq
    rw [h] at field
    cases field

theorem conditional_rejected_rejected (c : Candidate) (h : c.conditional = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conditional eq
    rw [h] at field
    cases field

theorem mutual_rejected_rejected (c : Candidate) (h : c.«mutual» = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.«mutual» eq
    rw [h] at field
    cases field

theorem factorization_rejected_rejected (c : Candidate) (h : c.factorization = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.factorization eq
    rw [h] at field
    cases field

theorem cause_rejected_rejected (c : Candidate) (h : c.cause = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cause eq
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

end SFT.InformationScience.MutualGrammar
