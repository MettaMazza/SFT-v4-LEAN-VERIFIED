import SFT.Mathematics.FlooredFluid
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.FlooredFluidGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Lattice where
  | rejected | admitted

def latticeName : Lattice → String
  | .rejected => "continuum-points"
  | .admitted => "generated-grid"

inductive Spacing where
  | rejected | admitted

def spacingName : Spacing → String
  | .rejected => "vanishing-length"
  | .admitted => "positive-floor"

inductive Velocity where
  | rejected | admitted

def velocityName : Velocity → String
  | .rejected => "unbounded-speed"
  | .admitted => "one-bounded-gap"

inductive Derivative where
  | rejected | admitted

def derivativeName : Derivative → String
  | .rejected => "limit-derivative"
  | .admitted => "edge-quotient"

inductive Bound where
  | rejected | admitted

def boundName : Bound → String
  | .rejected => "inserted-cap"
  | .admitted => "derived-reciprocal-floor"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "floating-rescale"
  | .admitted => "edge-ledger"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "depth-five-only"
  | .admitted => "depth-successor"

inductive Scope where
  | rejected | admitted

def scopeName : Scope → String
  | .rejected => "continuum-millennium"
  | .admitted => "fold-lattice-regularity"

structure Candidate where
  lattice : Lattice
  spacing : Spacing
  velocity : Velocity
  derivative : Derivative
  bound : Bound
  conservation : Conservation
  generality : Generality
  scope : Scope

def sourceFields (c : Candidate) : List String := [latticeName c.lattice, spacingName c.spacing, velocityName c.velocity, derivativeName c.derivative, boundName c.bound, conservationName c.conservation, generalityName c.generality, scopeName c.scope]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "lattice=" (latticeName c.lattice), SFT.Host.Text.append "spacing=" (spacingName c.spacing), SFT.Host.Text.append "velocity=" (velocityName c.velocity), SFT.Host.Text.append "derivative=" (derivativeName c.derivative), SFT.Host.Text.append "bound=" (boundName c.bound), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "scope=" (scopeName c.scope)]
def survivorId : String := "generated-grid__positive-floor__one-bounded-gap__edge-quotient__derived-reciprocal-floor__edge-ledger__depth-successor__fold-lattice-regularity"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (latticeName c.lattice) "generated-grid" &&
  SFT.Host.Text.equal (spacingName c.spacing) "positive-floor" &&
  SFT.Host.Text.equal (velocityName c.velocity) "one-bounded-gap" &&
  SFT.Host.Text.equal (derivativeName c.derivative) "edge-quotient" &&
  SFT.Host.Text.equal (boundName c.bound) "derived-reciprocal-floor" &&
  SFT.Host.Text.equal (conservationName c.conservation) "edge-ledger" &&
  SFT.Host.Text.equal (generalityName c.generality) "depth-successor" &&
  SFT.Host.Text.equal (scopeName c.scope) "fold-lattice-regularity"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (latticeName c.lattice) "generated-grid") then "An ungenerated continuum has no smallest spacing." else
  if !(SFT.Host.Text.equal (spacingName c.spacing) "positive-floor") then "Numerical zero is outside the domain." else
  if !(SFT.Host.Text.equal (velocityName c.velocity) "one-bounded-gap") then "Unbounded speed violates the One ceiling." else
  if !(SFT.Host.Text.equal (derivativeName c.derivative) "edge-quotient") then "A continuum limit changes the claim." else
  if !(SFT.Host.Text.equal (boundName c.bound) "derived-reciprocal-floor") then "An inserted cap would be an engineering parameter." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "edge-ledger") then "Floating rescaling cannot prove exact transport." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "depth-successor") then "One depth is only an example." else
  if !(SFT.Host.Text.equal (scopeName c.scope) "fold-lattice-regularity") then "The classical continuum problem is not the same grammar." else
  "The native Fold-lattice gradient bound is b^k at depth k, attained by a One velocity gap across one minimum edge; the depth-five value is thirty-two and every finite-depth field remains bounded."

def generationRule : String := "Exhaust lattice, spacing, velocity, derivative, bound, conservation, generality and continuum-scope choices."
def grammarBoundary : String := "Exact finite Fold lattices with positive minimum spacing and bounded positive velocity differences."

def candidates : List Candidate :=
  ([Lattice.rejected,Lattice.admitted]).flatMap fun lattice =>
  ([Spacing.rejected,Spacing.admitted]).flatMap fun spacing =>
  ([Velocity.rejected,Velocity.admitted]).flatMap fun velocity =>
  ([Derivative.rejected,Derivative.admitted]).flatMap fun derivative =>
  ([Bound.rejected,Bound.admitted]).flatMap fun bound =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Scope.rejected,Scope.admitted]).map fun scope =>
  ⟨lattice,spacing,velocity,derivative,bound,conservation,generality,scope⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk lattice spacing velocity derivative bound conservation generality scope =>
    have hlattice : lattice ∈ [Lattice.rejected,Lattice.admitted] := by
      cases lattice <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspacing : spacing ∈ [Spacing.rejected,Spacing.admitted] := by
      cases spacing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvelocity : velocity ∈ [Velocity.rejected,Velocity.admitted] := by
      cases velocity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hderivative : derivative ∈ [Derivative.rejected,Derivative.admitted] := by
      cases derivative <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbound : bound ∈ [Bound.rejected,Bound.admitted] := by
      cases bound <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscope : scope ∈ [Scope.rejected,Scope.admitted] := by
      cases scope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ lattice _ hlattice
    apply CommonRefinement.memFlatMap _ _ spacing _ hspacing
    apply CommonRefinement.memFlatMap _ _ velocity _ hvelocity
    apply CommonRefinement.memFlatMap _ _ derivative _ hderivative
    apply CommonRefinement.memFlatMap _ _ bound _ hbound
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ scope _ hscope

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk lattice spacing velocity derivative bound conservation generality scope =>
    cases lattice <;> cases spacing <;> cases velocity <;> cases derivative <;> cases bound <;> cases conservation <;> cases generality <;> cases scope
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk lattice spacing velocity derivative bound conservation generality scope =>
    cases lattice <;> cases spacing <;> cases velocity <;> cases derivative <;> cases bound <;> cases conservation <;> cases generality <;> cases scope
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.lattice = .admitted ∧ c.spacing = .admitted ∧ c.velocity = .admitted ∧ c.derivative = .admitted ∧ c.bound = .admitted ∧ c.conservation = .admitted ∧ c.generality = .admitted ∧ c.scope = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk lattice spacing velocity derivative bound conservation generality scope =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem lattice_rejected_rejected (c : Candidate) (h : c.lattice = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.lattice eq
    rw [h] at field
    cases field

theorem spacing_rejected_rejected (c : Candidate) (h : c.spacing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.spacing eq
    rw [h] at field
    cases field

theorem velocity_rejected_rejected (c : Candidate) (h : c.velocity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.velocity eq
    rw [h] at field
    cases field

theorem derivative_rejected_rejected (c : Candidate) (h : c.derivative = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.derivative eq
    rw [h] at field
    cases field

theorem bound_rejected_rejected (c : Candidate) (h : c.bound = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bound eq
    rw [h] at field
    cases field

theorem conservation_rejected_rejected (c : Candidate) (h : c.conservation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conservation eq
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

theorem scope_rejected_rejected (c : Candidate) (h : c.scope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scope eq
    rw [h] at field
    cases field

end SFT.Mathematics.FlooredFluidGrammar
