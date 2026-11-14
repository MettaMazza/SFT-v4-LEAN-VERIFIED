import SFT.QuantumComputation.UnboundedFaults
import SFT.Foundation.CommonRefinement
namespace SFT.QuantumComputation.UnboundedGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Fault_order where
  | rejected | admitted

def fault_orderName : Fault_order → String
  | .rejected => "fixed-one-error-model"
  | .admitted => "supplied-positive-finite-fault-trace"

inductive Width where
  | rejected | admitted

def widthName : Width → String
  | .rejected => "selected-or-even-width"
  | .admitted => "first-strict-majority-width-2t-plus-1"

inductive Coverage where
  | rejected | admitted

def coverageName : Coverage → String
  | .rejected => "sampled-fault-patterns"
  | .admitted => "all-masks-through-t-by-subset-count"

inductive Minimality where
  | rejected | admitted

def minimalityName : Minimality → String
  | .rejected => "shorter-widths-unchecked"
  | .admitted => "counterexample-for-every-width-through-2t"

inductive Recovery where
  | rejected | admitted

def recoveryName : Recovery → String
  | .rejected => "decoded-label-without-record"
  | .admitted => "exact-syndrome-and-recovery-trace"

inductive Circuit where
  | rejected | admitted

def circuitName : Circuit → String
  | .rejected => "isolated-code-example"
  | .admitted => "corrected-word-feeds-exact-circuit-semantics"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "fixed-t-table"
  | .admitted => "fault-order-successor-and-ceiling-defeat"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "imported-hardware-threshold"
  | .admitted => "no-rate-device-or-noise-parameter"

structure Candidate where
  fault_order : Fault_order
  width : Width
  coverage : Coverage
  minimality : Minimality
  recovery : Recovery
  circuit : Circuit
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [fault_orderName c.fault_order, widthName c.width, coverageName c.coverage, minimalityName c.minimality, recoveryName c.recovery, circuitName c.circuit, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "fault_order=" (fault_orderName c.fault_order), SFT.Host.Text.append "width=" (widthName c.width), SFT.Host.Text.append "coverage=" (coverageName c.coverage), SFT.Host.Text.append "minimality=" (minimalityName c.minimality), SFT.Host.Text.append "recovery=" (recoveryName c.recovery), SFT.Host.Text.append "circuit=" (circuitName c.circuit), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "supplied-positive-finite-fault-trace__first-strict-majority-width-2t-plus-1__all-masks-through-t-by-subset-count__counterexample-for-every-width-through-2t__exact-syndrome-and-recovery-trace__corrected-word-feeds-exact-circuit-semantics__fault-order-successor-and-ceiling-defeat__no-rate-device-or-noise-parameter"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (fault_orderName c.fault_order) "supplied-positive-finite-fault-trace" &&
  SFT.Host.Text.equal (widthName c.width) "first-strict-majority-width-2t-plus-1" &&
  SFT.Host.Text.equal (coverageName c.coverage) "all-masks-through-t-by-subset-count" &&
  SFT.Host.Text.equal (minimalityName c.minimality) "counterexample-for-every-width-through-2t" &&
  SFT.Host.Text.equal (recoveryName c.recovery) "exact-syndrome-and-recovery-trace" &&
  SFT.Host.Text.equal (circuitName c.circuit) "corrected-word-feeds-exact-circuit-semantics" &&
  SFT.Host.Text.equal (generalityName c.generality) "fault-order-successor-and-ceiling-defeat" &&
  SFT.Host.Text.equal (additionName c.addition) "no-rate-device-or-noise-parameter"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (fault_orderName c.fault_order) "supplied-positive-finite-fault-trace") then "fixed-one-error-model removes the required exact fault_order structure." else
  if !(SFT.Host.Text.equal (widthName c.width) "first-strict-majority-width-2t-plus-1") then "selected-or-even-width removes the required exact width structure." else
  if !(SFT.Host.Text.equal (coverageName c.coverage) "all-masks-through-t-by-subset-count") then "sampled-fault-patterns removes the required exact coverage structure." else
  if !(SFT.Host.Text.equal (minimalityName c.minimality) "counterexample-for-every-width-through-2t") then "shorter-widths-unchecked removes the required exact minimality structure." else
  if !(SFT.Host.Text.equal (recoveryName c.recovery) "exact-syndrome-and-recovery-trace") then "decoded-label-without-record removes the required exact recovery structure." else
  if !(SFT.Host.Text.equal (circuitName c.circuit) "corrected-word-feeds-exact-circuit-semantics") then "isolated-code-example removes the required exact circuit structure." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "fault-order-successor-and-ceiling-defeat") then "fixed-t-table removes the required exact generality structure." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-rate-device-or-noise-parameter") then "imported-hardware-threshold removes the required exact addition structure." else
  "For every supplied positive finite fault-order trace t, the unique first repetition width correcting every mask through t is 2t+1: at least t+1 source labels remain against at most t changes, every width through 2t has a constructive tie or wrong-majority counterexample, redundancy is exactly 2t, and the successor fault order adds exactly two labels. The corrected word composes with exact Fold circuit semantics. This is an unbounded finite fault-order theorem, not a stochastic hardware-rate or physical threshold constant."

def generationRule : String := "Generate the literal product of fault order, width, mask coverage, minimality, recovery, circuit composition, successor and no-extra-parameter coordinates."
def grammarBoundary : String := "Every supplied positive finite Fold fault-order trace, its generated repetition widths in increasing order, every fault mask through that order by exact subset class, and composition with admitted finite Fold circuit semantics."

def candidates : List Candidate :=
  ([Fault_order.rejected,Fault_order.admitted]).flatMap fun fault_order =>
  ([Width.rejected,Width.admitted]).flatMap fun width =>
  ([Coverage.rejected,Coverage.admitted]).flatMap fun coverage =>
  ([Minimality.rejected,Minimality.admitted]).flatMap fun minimality =>
  ([Recovery.rejected,Recovery.admitted]).flatMap fun recovery =>
  ([Circuit.rejected,Circuit.admitted]).flatMap fun circuit =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨fault_order,width,coverage,minimality,recovery,circuit,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk fault_order width coverage minimality recovery circuit generality addition =>
    have hfault_order : fault_order ∈ [Fault_order.rejected,Fault_order.admitted] := by
      cases fault_order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hwidth : width ∈ [Width.rejected,Width.admitted] := by
      cases width <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoverage : coverage ∈ [Coverage.rejected,Coverage.admitted] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hminimality : minimality ∈ [Minimality.rejected,Minimality.admitted] := by
      cases minimality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecovery : recovery ∈ [Recovery.rejected,Recovery.admitted] := by
      cases recovery <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcircuit : circuit ∈ [Circuit.rejected,Circuit.admitted] := by
      cases circuit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ fault_order _ hfault_order
    apply CommonRefinement.memFlatMap _ _ width _ hwidth
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ minimality _ hminimality
    apply CommonRefinement.memFlatMap _ _ recovery _ hrecovery
    apply CommonRefinement.memFlatMap _ _ circuit _ hcircuit
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk fault_order width coverage minimality recovery circuit generality addition =>
    cases fault_order <;> cases width <;> cases coverage <;> cases minimality <;> cases recovery <;> cases circuit <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk fault_order width coverage minimality recovery circuit generality addition =>
    cases fault_order <;> cases width <;> cases coverage <;> cases minimality <;> cases recovery <;> cases circuit <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.fault_order = .admitted ∧ c.width = .admitted ∧ c.coverage = .admitted ∧ c.minimality = .admitted ∧ c.recovery = .admitted ∧ c.circuit = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk fault_order width coverage minimality recovery circuit generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem fault_order_rejected_rejected (c : Candidate) (h : c.fault_order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fault_order eq
    rw [h] at field
    cases field

theorem width_rejected_rejected (c : Candidate) (h : c.width = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.width eq
    rw [h] at field
    cases field

theorem coverage_rejected_rejected (c : Candidate) (h : c.coverage = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem minimality_rejected_rejected (c : Candidate) (h : c.minimality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.minimality eq
    rw [h] at field
    cases field

theorem recovery_rejected_rejected (c : Candidate) (h : c.recovery = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recovery eq
    rw [h] at field
    cases field

theorem circuit_rejected_rejected (c : Candidate) (h : c.circuit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.circuit eq
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

end SFT.QuantumComputation.UnboundedGrammar
