import SFT.Mathematics.OptimizationWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.OptimizationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Candidates where
  | rejected | admitted

def candidatesName : Candidates → String
  | .rejected => "sampled-candidates"
  | .admitted => "complete-canonical-candidates"

inductive Feasibility where
  | rejected | admitted

def feasibilityName : Feasibility → String
  | .rejected => "implicit-constraint"
  | .admitted => "source-bound-verdicts"

inductive Preference where
  | rejected | admitted

def preferenceName : Preference → String
  | .rejected => "floating-score"
  | .admitted => "witnessed-order-relation"

inductive Solution where
  | rejected | admitted

def solutionName : Solution → String
  | .rejected => "first-found"
  | .admitted => "complete-undominated-selection"

inductive Ties where
  | rejected | admitted

def tiesName : Ties → String
  | .rejected => "silent-tie-break"
  | .admitted => "retained-equivalence-class"

inductive Constraints where
  | rejected | admitted

def constraintsName : Constraints → String
  | .rejected => "penalty-parameter"
  | .admitted => "exact-membership-predicate"

inductive Decomposition where
  | rejected | admitted

def decompositionName : Decomposition → String
  | .rejected => "assumed-separability"
  | .admitted => "exact-interface-factorization"

inductive Approximation where
  | rejected | admitted

def approximationName : Approximation → String
  | .rejected => "decimal-error"
  | .admitted => "exact-positive-part-bound"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-objective-or-tie-rule"
  | .admitted => "no-extra-objective"

structure Candidate where
  candidates : Candidates
  feasibility : Feasibility
  preference : Preference
  solution : Solution
  ties : Ties
  constraints : Constraints
  decomposition : Decomposition
  approximation : Approximation
  addition : Addition

def sourceFields (c : Candidate) : List String := [candidatesName c.candidates, feasibilityName c.feasibility, preferenceName c.preference, solutionName c.solution, tiesName c.ties, constraintsName c.constraints, decompositionName c.decomposition, approximationName c.approximation, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "candidates=" (candidatesName c.candidates), SFT.Host.Text.append "feasibility=" (feasibilityName c.feasibility), SFT.Host.Text.append "preference=" (preferenceName c.preference), SFT.Host.Text.append "solution=" (solutionName c.solution), SFT.Host.Text.append "ties=" (tiesName c.ties), SFT.Host.Text.append "constraints=" (constraintsName c.constraints), SFT.Host.Text.append "decomposition=" (decompositionName c.decomposition), SFT.Host.Text.append "approximation=" (approximationName c.approximation), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-candidates__source-bound-verdicts__witnessed-order-relation__complete-undominated-selection__retained-equivalence-class__exact-membership-predicate__exact-interface-factorization__exact-positive-part-bound__no-extra-objective"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (candidatesName c.candidates) "complete-canonical-candidates" &&
  SFT.Host.Text.equal (feasibilityName c.feasibility) "source-bound-verdicts" &&
  SFT.Host.Text.equal (preferenceName c.preference) "witnessed-order-relation" &&
  SFT.Host.Text.equal (solutionName c.solution) "complete-undominated-selection" &&
  SFT.Host.Text.equal (tiesName c.ties) "retained-equivalence-class" &&
  SFT.Host.Text.equal (constraintsName c.constraints) "exact-membership-predicate" &&
  SFT.Host.Text.equal (decompositionName c.decomposition) "exact-interface-factorization" &&
  SFT.Host.Text.equal (approximationName c.approximation) "exact-positive-part-bound" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-objective"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (candidatesName c.candidates) "complete-canonical-candidates") then "Sampling cannot prove that a better generated candidate was not omitted." else
  if !(SFT.Host.Text.equal (feasibilityName c.feasibility) "source-bound-verdicts") then "An implicit constraint has no candidate-level check trace." else
  if !(SFT.Host.Text.equal (preferenceName c.preference) "witnessed-order-relation") then "A floating score imports scale and precision choices." else
  if !(SFT.Host.Text.equal (solutionName c.solution) "complete-undominated-selection") then "First-found depends on traversal presentation." else
  if !(SFT.Host.Text.equal (tiesName c.ties) "retained-equivalence-class") then "A silent tie-break adds a free preference." else
  if !(SFT.Host.Text.equal (constraintsName c.constraints) "exact-membership-predicate") then "A tunable penalty is a free parameter and can select the answer." else
  if !(SFT.Host.Text.equal (decompositionName c.decomposition) "exact-interface-factorization") then "Shared constraints can invalidate separate optima." else
  if !(SFT.Host.Text.equal (approximationName c.approximation) "exact-positive-part-bound") then "A decimal error imports rounding and a scale." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-objective") then "An added score or tie rule is not forced by the instance." else
  "The optimization kernel is complete canonical candidates, source-bound feasibility, exact preference, complete undominated selection, retained ties, exact constraints and interfaces, and positive-part bounds without an added objective."

def generationRule : String := "Generate the complete product of candidate coverage, feasibility, preference, optimum selection, tie retention, constraint provenance, decomposition, approximation and extra-objective status."
def grammarBoundary : String := "All finite optimization instances generated from canonical candidates, exact predicates, held preference relations, complete dominance checks, interface-preserving decomposition and exact positive part bounds."

def candidates : List Candidate :=
  ([Candidates.rejected,Candidates.admitted]).flatMap fun candidates =>
  ([Feasibility.rejected,Feasibility.admitted]).flatMap fun feasibility =>
  ([Preference.rejected,Preference.admitted]).flatMap fun preference =>
  ([Solution.rejected,Solution.admitted]).flatMap fun solution =>
  ([Ties.rejected,Ties.admitted]).flatMap fun ties =>
  ([Constraints.rejected,Constraints.admitted]).flatMap fun constraints =>
  ([Decomposition.rejected,Decomposition.admitted]).flatMap fun decomposition =>
  ([Approximation.rejected,Approximation.admitted]).flatMap fun approximation =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨candidates,feasibility,preference,solution,ties,constraints,decomposition,approximation,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk candidates feasibility preference solution ties constraints decomposition approximation addition =>
    have hcandidates : candidates ∈ [Candidates.rejected,Candidates.admitted] := by
      cases candidates <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfeasibility : feasibility ∈ [Feasibility.rejected,Feasibility.admitted] := by
      cases feasibility <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpreference : preference ∈ [Preference.rejected,Preference.admitted] := by
      cases preference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsolution : solution ∈ [Solution.rejected,Solution.admitted] := by
      cases solution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hties : ties ∈ [Ties.rejected,Ties.admitted] := by
      cases ties <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconstraints : constraints ∈ [Constraints.rejected,Constraints.admitted] := by
      cases constraints <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdecomposition : decomposition ∈ [Decomposition.rejected,Decomposition.admitted] := by
      cases decomposition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have happroximation : approximation ∈ [Approximation.rejected,Approximation.admitted] := by
      cases approximation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold SFT.Mathematics.OptimizationGrammar.candidates
    apply CommonRefinement.memFlatMap _ _ candidates _ hcandidates
    apply CommonRefinement.memFlatMap _ _ feasibility _ hfeasibility
    apply CommonRefinement.memFlatMap _ _ preference _ hpreference
    apply CommonRefinement.memFlatMap _ _ solution _ hsolution
    apply CommonRefinement.memFlatMap _ _ ties _ hties
    apply CommonRefinement.memFlatMap _ _ constraints _ hconstraints
    apply CommonRefinement.memFlatMap _ _ decomposition _ hdecomposition
    apply CommonRefinement.memFlatMap _ _ approximation _ happroximation
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk candidates feasibility preference solution ties constraints decomposition approximation addition =>
    cases candidates <;> cases feasibility <;> cases preference <;> cases solution <;> cases ties <;> cases constraints <;> cases decomposition <;> cases approximation <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk candidates feasibility preference solution ties constraints decomposition approximation addition =>
    cases candidates <;> cases feasibility <;> cases preference <;> cases solution <;> cases ties <;> cases constraints <;> cases decomposition <;> cases approximation <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.candidates = .admitted ∧ c.feasibility = .admitted ∧ c.preference = .admitted ∧ c.solution = .admitted ∧ c.ties = .admitted ∧ c.constraints = .admitted ∧ c.decomposition = .admitted ∧ c.approximation = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk candidates feasibility preference solution ties constraints decomposition approximation addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem candidates_rejected_rejected (c : Candidate) (h : c.candidates = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.candidates eq
    rw [h] at field
    cases field

theorem feasibility_rejected_rejected (c : Candidate) (h : c.feasibility = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.feasibility eq
    rw [h] at field
    cases field

theorem preference_rejected_rejected (c : Candidate) (h : c.preference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.preference eq
    rw [h] at field
    cases field

theorem solution_rejected_rejected (c : Candidate) (h : c.solution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.solution eq
    rw [h] at field
    cases field

theorem ties_rejected_rejected (c : Candidate) (h : c.ties = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ties eq
    rw [h] at field
    cases field

theorem constraints_rejected_rejected (c : Candidate) (h : c.constraints = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.constraints eq
    rw [h] at field
    cases field

theorem decomposition_rejected_rejected (c : Candidate) (h : c.decomposition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.decomposition eq
    rw [h] at field
    cases field

theorem approximation_rejected_rejected (c : Candidate) (h : c.approximation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.approximation eq
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

end SFT.Mathematics.OptimizationGrammar
