import SFT.Mathematics.AlgebraicBalance
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.AlgebraicBalanceGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Representation where
  | rejected | admitted

def representationName : Representation → String
  | .rejected => "irrational-scalar"
  | .admitted => "balance-certificate"

inductive Coefficients where
  | rejected | admitted

def coefficientsName : Coefficients → String
  | .rejected => "signed-polynomial"
  | .admitted => "positive-separated-sides"

inductive Enclosure where
  | rejected | admitted

def enclosureName : Enclosure → String
  | .rejected => "decimal-guess"
  | .admitted => "rational-order-swap"

inductive Refinement where
  | rejected | admitted

def refinementName : Refinement → String
  | .rejected => "floating-iteration"
  | .admitted => "exact-bisection"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "approximate-equality"
  | .admitted => "polynomial-balance"

inductive Reconstruction where
  | rejected | admitted

def reconstructionName : Reconstruction → String
  | .rejected => "unverified-root"
  | .admitted => "bracket-trace"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "named-radicals"
  | .admitted => "finite-polynomial-induction"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-field"
  | .admitted => "no-extra-rule"

structure Candidate where
  representation : Representation
  coefficients : Coefficients
  enclosure : Enclosure
  refinement : Refinement
  identity : Identity
  reconstruction : Reconstruction
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [representationName c.representation, coefficientsName c.coefficients, enclosureName c.enclosure, refinementName c.refinement, identityName c.identity, reconstructionName c.reconstruction, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "representation=" (representationName c.representation), SFT.Host.Text.append "coefficients=" (coefficientsName c.coefficients), SFT.Host.Text.append "enclosure=" (enclosureName c.enclosure), SFT.Host.Text.append "refinement=" (refinementName c.refinement), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "reconstruction=" (reconstructionName c.reconstruction), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "balance-certificate__positive-separated-sides__rational-order-swap__exact-bisection__polynomial-balance__bracket-trace__finite-polynomial-induction__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (representationName c.representation) "balance-certificate" &&
  SFT.Host.Text.equal (coefficientsName c.coefficients) "positive-separated-sides" &&
  SFT.Host.Text.equal (enclosureName c.enclosure) "rational-order-swap" &&
  SFT.Host.Text.equal (refinementName c.refinement) "exact-bisection" &&
  SFT.Host.Text.equal (identityName c.identity) "polynomial-balance" &&
  SFT.Host.Text.equal (reconstructionName c.reconstruction) "bracket-trace" &&
  SFT.Host.Text.equal (generalityName c.generality) "finite-polynomial-induction" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (representationName c.representation) "balance-certificate") then "The scalar is forbidden as a proof value." else
  if !(SFT.Host.Text.equal (coefficientsName c.coefficients) "positive-separated-sides") then "Negative coefficients import signed magnitude." else
  if !(SFT.Host.Text.equal (enclosureName c.enclosure) "rational-order-swap") then "A decimal guess is not exact." else
  if !(SFT.Host.Text.equal (refinementName c.refinement) "exact-bisection") then "Floating iteration loses exact provenance." else
  if !(SFT.Host.Text.equal (identityName c.identity) "polynomial-balance") then "Tolerance cannot define the algebraic object." else
  if !(SFT.Host.Text.equal (reconstructionName c.reconstruction) "bracket-trace") then "An asserted root has no certificate." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "finite-polynomial-induction") then "A radical list omits higher-degree forms." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "An algebraic field is not supplied by Foundation." else
  "The unique admitted algebraic-magnitude representation is a positive polynomial-balance identity with exact rational order-swap bracket and replayable bisection trace; the irrational root is never a proof value."

def generationRule : String := "Exhaust representation, coefficients, enclosure, refinement, identity, reconstruction, generality and extra-rule choices."
def grammarBoundary : String := "Positive polynomial-side evaluations and exact rational brackets at supplied finite refinement depth."

def candidates : List Candidate :=
  ([Representation.rejected,Representation.admitted]).flatMap fun representation =>
  ([Coefficients.rejected,Coefficients.admitted]).flatMap fun coefficients =>
  ([Enclosure.rejected,Enclosure.admitted]).flatMap fun enclosure =>
  ([Refinement.rejected,Refinement.admitted]).flatMap fun refinement =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Reconstruction.rejected,Reconstruction.admitted]).flatMap fun reconstruction =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨representation,coefficients,enclosure,refinement,identity,reconstruction,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk representation coefficients enclosure refinement identity reconstruction generality addition =>
    have hrepresentation : representation ∈ [Representation.rejected,Representation.admitted] := by
      cases representation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoefficients : coefficients ∈ [Coefficients.rejected,Coefficients.admitted] := by
      cases coefficients <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henclosure : enclosure ∈ [Enclosure.rejected,Enclosure.admitted] := by
      cases enclosure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrefinement : refinement ∈ [Refinement.rejected,Refinement.admitted] := by
      cases refinement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreconstruction : reconstruction ∈ [Reconstruction.rejected,Reconstruction.admitted] := by
      cases reconstruction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ representation _ hrepresentation
    apply CommonRefinement.memFlatMap _ _ coefficients _ hcoefficients
    apply CommonRefinement.memFlatMap _ _ enclosure _ henclosure
    apply CommonRefinement.memFlatMap _ _ refinement _ hrefinement
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ reconstruction _ hreconstruction
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk representation coefficients enclosure refinement identity reconstruction generality addition =>
    cases representation <;> cases coefficients <;> cases enclosure <;> cases refinement <;> cases identity <;> cases reconstruction <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk representation coefficients enclosure refinement identity reconstruction generality addition =>
    cases representation <;> cases coefficients <;> cases enclosure <;> cases refinement <;> cases identity <;> cases reconstruction <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.representation = .admitted ∧ c.coefficients = .admitted ∧ c.enclosure = .admitted ∧ c.refinement = .admitted ∧ c.identity = .admitted ∧ c.reconstruction = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk representation coefficients enclosure refinement identity reconstruction generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem representation_rejected_rejected (c : Candidate) (h : c.representation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.representation eq
    rw [h] at field
    cases field

theorem coefficients_rejected_rejected (c : Candidate) (h : c.coefficients = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coefficients eq
    rw [h] at field
    cases field

theorem enclosure_rejected_rejected (c : Candidate) (h : c.enclosure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.enclosure eq
    rw [h] at field
    cases field

theorem refinement_rejected_rejected (c : Candidate) (h : c.refinement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.refinement eq
    rw [h] at field
    cases field

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem reconstruction_rejected_rejected (c : Candidate) (h : c.reconstruction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reconstruction eq
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

end SFT.Mathematics.AlgebraicBalanceGrammar
