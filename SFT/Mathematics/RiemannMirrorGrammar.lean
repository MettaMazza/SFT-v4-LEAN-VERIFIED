import SFT.Mathematics.RiemannMirror
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.RiemannMirrorGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Domain where
  | rejected | admitted

def domainName : Domain → String
  | .rejected => "complex-plane"
  | .admitted => "positive-parts"

inductive Involution where
  | rejected | admitted

def involutionName : Involution → String
  | .rejected => "imported-functional-equation"
  | .admitted => "one-complement"

inductive Fixed_point where
  | rejected | admitted

def fixed_pointName : Fixed_point → String
  | .rejected => "selected-half"
  | .admitted => "unique-self-complement"

inductive Off_axis where
  | rejected | admitted

def off_axisName : Off_axis → String
  | .rejected => "unpaired-values"
  | .admitted => "distinct-pairs"

inductive Prime_tie where
  | rejected | admitted

def prime_tieName : Prime_tie → String
  | .rejected => "zeta-import"
  | .admitted => "orbit-prime-skeleton"

inductive Zero_location where
  | rejected | admitted

def zero_locationName : Zero_location → String
  | .rejected => "claim-classical-rh"
  | .admitted => "explicit-language-boundary"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "bounded-denominator-only"
  | .admitted => "exact-part-identity"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-analysis"
  | .admitted => "no-extra-rule"

structure Candidate where
  domain : Domain
  involution : Involution
  fixed_point : Fixed_point
  off_axis : Off_axis
  prime_tie : Prime_tie
  zero_location : Zero_location
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [domainName c.domain, involutionName c.involution, fixed_pointName c.fixed_point, off_axisName c.off_axis, prime_tieName c.prime_tie, zero_locationName c.zero_location, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "involution=" (involutionName c.involution), SFT.Host.Text.append "fixed_point=" (fixed_pointName c.fixed_point), SFT.Host.Text.append "off_axis=" (off_axisName c.off_axis), SFT.Host.Text.append "prime_tie=" (prime_tieName c.prime_tie), SFT.Host.Text.append "zero_location=" (zero_locationName c.zero_location), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "positive-parts__one-complement__unique-self-complement__distinct-pairs__orbit-prime-skeleton__explicit-language-boundary__exact-part-identity__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (domainName c.domain) "positive-parts" &&
  SFT.Host.Text.equal (involutionName c.involution) "one-complement" &&
  SFT.Host.Text.equal (fixed_pointName c.fixed_point) "unique-self-complement" &&
  SFT.Host.Text.equal (off_axisName c.off_axis) "distinct-pairs" &&
  SFT.Host.Text.equal (prime_tieName c.prime_tie) "orbit-prime-skeleton" &&
  SFT.Host.Text.equal (zero_locationName c.zero_location) "explicit-language-boundary" &&
  SFT.Host.Text.equal (generalityName c.generality) "exact-part-identity" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (domainName c.domain) "positive-parts") then "Imaginary values are not admitted proof objects." else
  if !(SFT.Host.Text.equal (involutionName c.involution) "one-complement") then "An external equation cannot derive the Fold law." else
  if !(SFT.Host.Text.equal (fixed_pointName c.fixed_point) "unique-self-complement") then "Selecting one-half would not prove uniqueness." else
  if !(SFT.Host.Text.equal (off_axisName c.off_axis) "distinct-pairs") then "Complement is total on the declared part domain." else
  if !(SFT.Host.Text.equal (prime_tieName c.prime_tie) "orbit-prime-skeleton") then "The analytic zeta object is not an SFT input." else
  if !(SFT.Host.Text.equal (zero_locationName c.zero_location) "explicit-language-boundary") then "Symmetry alone cannot locate every classical complex zero." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "exact-part-identity") then "A fixed denominator table does not prove the involution law." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "Complex analysis is outside the registered dependencies." else
  "Half-One is the unique fixed axis of exact complement; every other positive part is paired. This closes the SFT Riemann-mirroring claim and explicitly does not assert classical complex zero location."

def generationRule : String := "Exhaust domain, involution, fixed point, off-axis pairing, prime tie, complex boundary, generality and extra-analytic choices."
def grammarBoundary : String := "Exact positive rational parts under complement within the One; no complex analytic continuation object."

def candidates : List Candidate :=
  ([Domain.rejected,Domain.admitted]).flatMap fun domain =>
  ([Involution.rejected,Involution.admitted]).flatMap fun involution =>
  ([Fixed_point.rejected,Fixed_point.admitted]).flatMap fun fixed_point =>
  ([Off_axis.rejected,Off_axis.admitted]).flatMap fun off_axis =>
  ([Prime_tie.rejected,Prime_tie.admitted]).flatMap fun prime_tie =>
  ([Zero_location.rejected,Zero_location.admitted]).flatMap fun zero_location =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨domain,involution,fixed_point,off_axis,prime_tie,zero_location,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk domain involution fixed_point off_axis prime_tie zero_location generality addition =>
    have hdomain : domain ∈ [Domain.rejected,Domain.admitted] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinvolution : involution ∈ [Involution.rejected,Involution.admitted] := by
      cases involution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfixed_point : fixed_point ∈ [Fixed_point.rejected,Fixed_point.admitted] := by
      cases fixed_point <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoff_axis : off_axis ∈ [Off_axis.rejected,Off_axis.admitted] := by
      cases off_axis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprime_tie : prime_tie ∈ [Prime_tie.rejected,Prime_tie.admitted] := by
      cases prime_tie <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hzero_location : zero_location ∈ [Zero_location.rejected,Zero_location.admitted] := by
      cases zero_location <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ involution _ hinvolution
    apply CommonRefinement.memFlatMap _ _ fixed_point _ hfixed_point
    apply CommonRefinement.memFlatMap _ _ off_axis _ hoff_axis
    apply CommonRefinement.memFlatMap _ _ prime_tie _ hprime_tie
    apply CommonRefinement.memFlatMap _ _ zero_location _ hzero_location
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk domain involution fixed_point off_axis prime_tie zero_location generality addition =>
    cases domain <;> cases involution <;> cases fixed_point <;> cases off_axis <;> cases prime_tie <;> cases zero_location <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk domain involution fixed_point off_axis prime_tie zero_location generality addition =>
    cases domain <;> cases involution <;> cases fixed_point <;> cases off_axis <;> cases prime_tie <;> cases zero_location <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.domain = .admitted ∧ c.involution = .admitted ∧ c.fixed_point = .admitted ∧ c.off_axis = .admitted ∧ c.prime_tie = .admitted ∧ c.zero_location = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk domain involution fixed_point off_axis prime_tie zero_location generality addition =>
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

theorem involution_rejected_rejected (c : Candidate) (h : c.involution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.involution eq
    rw [h] at field
    cases field

theorem fixed_point_rejected_rejected (c : Candidate) (h : c.fixed_point = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fixed_point eq
    rw [h] at field
    cases field

theorem off_axis_rejected_rejected (c : Candidate) (h : c.off_axis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.off_axis eq
    rw [h] at field
    cases field

theorem prime_tie_rejected_rejected (c : Candidate) (h : c.prime_tie = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prime_tie eq
    rw [h] at field
    cases field

theorem zero_location_rejected_rejected (c : Candidate) (h : c.zero_location = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.zero_location eq
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

end SFT.Mathematics.RiemannMirrorGrammar
