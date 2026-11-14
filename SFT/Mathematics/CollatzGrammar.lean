import SFT.Mathematics.CollatzComplete
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.CollatzGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Range where
  | rejected | admitted

def rangeName : Range → String
  | .rejected => "sampled-starts"
  | .admitted => "all-declared-starts"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "fold-analogy"
  | .admitted => "exact-collatz"

inductive Parity where
  | rejected | admitted

def parityName : Parity → String
  | .rejected => "assumed-even"
  | .admitted => "computed-parity"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "terminal-only"
  | .admitted => "complete-step-trace"

inductive Cycle where
  | rejected | admitted

def cycleName : Cycle → String
  | .rejected => "zero-sink"
  | .admitted => "one-four-two"

inductive Contraction where
  | rejected | admitted

def contractionName : Contraction → String
  | .rejected => "constant-three-quarters"
  | .admitted => "executed-variable-descent"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "unrestricted-collatz"
  | .admitted => "explicit-one-hundred-thousand"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "external-sequence"
  | .admitted => "no-extra-rule"

structure Candidate where
  range : Range
  transition : Transition
  parity : Parity
  trace : Trace
  cycle : Cycle
  contraction : Contraction
  boundary : Boundary
  addition : Addition

def sourceFields (c : Candidate) : List String := [rangeName c.range, transitionName c.transition, parityName c.parity, traceName c.trace, cycleName c.cycle, contractionName c.contraction, boundaryName c.boundary, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "range=" (rangeName c.range), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "parity=" (parityName c.parity), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "cycle=" (cycleName c.cycle), SFT.Host.Text.append "contraction=" (contractionName c.contraction), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "all-declared-starts__exact-collatz__computed-parity__complete-step-trace__one-four-two__executed-variable-descent__explicit-one-hundred-thousand__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (rangeName c.range) "all-declared-starts" &&
  SFT.Host.Text.equal (transitionName c.transition) "exact-collatz" &&
  SFT.Host.Text.equal (parityName c.parity) "computed-parity" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-step-trace" &&
  SFT.Host.Text.equal (cycleName c.cycle) "one-four-two" &&
  SFT.Host.Text.equal (contractionName c.contraction) "executed-variable-descent" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "explicit-one-hundred-thousand" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (rangeName c.range) "all-declared-starts") then "Sampling cannot close the declared range." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "exact-collatz") then "An analogy is not the conventional Collatz map." else
  if !(SFT.Host.Text.equal (parityName c.parity) "computed-parity") then "Parity must be checked from exact whole arithmetic." else
  if !(SFT.Host.Text.equal (traceName c.trace) "complete-step-trace") then "A terminal result without its path cannot be replayed." else
  if !(SFT.Host.Text.equal (cycleName c.cycle) "one-four-two") then "Zero is not in the declared positive domain." else
  if !(SFT.Host.Text.equal (contractionName c.contraction) "executed-variable-descent") then "The shortcut is false: the odd macrostep from three reaches five after removing all binary factors." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "explicit-one-hundred-thousand") then "A finite census cannot establish the unrestricted conjecture." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "A published trajectory cannot enter the execution." else
  "The complete starts 1..100,000 census has zero failures, start 27 takes 111 steps, the terminal cycle is 1-4-2, and the constant-3/4 pointwise contraction premise is rejected."

def generationRule : String := "Exhaust range, transition, parity, trace, cycle, contraction, boundary and extra-theorem choices."
def grammarBoundary : String := "Positive whole starts one through one hundred thousand under the exact conventional Collatz transition."

def candidates : List Candidate :=
  ([Range.rejected,Range.admitted]).flatMap fun range =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Parity.rejected,Parity.admitted]).flatMap fun parity =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Cycle.rejected,Cycle.admitted]).flatMap fun cycle =>
  ([Contraction.rejected,Contraction.admitted]).flatMap fun contraction =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨range,transition,parity,trace,cycle,contraction,boundary,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk range transition parity trace cycle contraction boundary addition =>
    have hrange : range ∈ [Range.rejected,Range.admitted] := by
      cases range <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hparity : parity ∈ [Parity.rejected,Parity.admitted] := by
      cases parity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcycle : cycle ∈ [Cycle.rejected,Cycle.admitted] := by
      cases cycle <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontraction : contraction ∈ [Contraction.rejected,Contraction.admitted] := by
      cases contraction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ range _ hrange
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ parity _ hparity
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    apply CommonRefinement.memFlatMap _ _ cycle _ hcycle
    apply CommonRefinement.memFlatMap _ _ contraction _ hcontraction
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk range transition parity trace cycle contraction boundary addition =>
    cases range <;> cases transition <;> cases parity <;> cases trace <;> cases cycle <;> cases contraction <;> cases boundary <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk range transition parity trace cycle contraction boundary addition =>
    cases range <;> cases transition <;> cases parity <;> cases trace <;> cases cycle <;> cases contraction <;> cases boundary <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.range = .admitted ∧ c.transition = .admitted ∧ c.parity = .admitted ∧ c.trace = .admitted ∧ c.cycle = .admitted ∧ c.contraction = .admitted ∧ c.boundary = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk range transition parity trace cycle contraction boundary addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem range_rejected_rejected (c : Candidate) (h : c.range = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.range eq
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

theorem parity_rejected_rejected (c : Candidate) (h : c.parity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.parity eq
    rw [h] at field
    cases field

theorem trace_rejected_rejected (c : Candidate) (h : c.trace = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trace eq
    rw [h] at field
    cases field

theorem cycle_rejected_rejected (c : Candidate) (h : c.cycle = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cycle eq
    rw [h] at field
    cases field

theorem contraction_rejected_rejected (c : Candidate) (h : c.contraction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.contraction eq
    rw [h] at field
    cases field

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
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

end SFT.Mathematics.CollatzGrammar
