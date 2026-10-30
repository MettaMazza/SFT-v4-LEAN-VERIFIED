import SFT.Physics.CapabilityExecution
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CapabilityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Input where
  | rejected | admitted

def inputName : Input → String
  | .rejected => "ambient-input"
  | .admitted => "registered-input-only"

inductive Value where
  | rejected | admitted

def valueName : Value → String
  | .rejected => "host-scalar-domain"
  | .admitted => "exact-fold-domain"

inductive Operation where
  | rejected | admitted

def operationName : Operation → String
  | .rejected => "contributor-executable-source"
  | .admitted => "data-only-generated-operations"

inductive Capability where
  | rejected | admitted

def capabilityName : Capability → String
  | .rejected => "ambient-capability"
  | .admitted => "no-ambient-capability"

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "mutable-overwrite"
  | .admitted => "single-assignment-held-state"

inductive Termination where
  | rejected | admitted

def terminationName : Termination → String
  | .rejected => "implicit-or-open-ended"
  | .admitted => "one-terminal-emission"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "result-only"
  | .admitted => "complete-step-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  input : Input
  value : Value
  operation : Operation
  capability : Capability
  state : State
  termination : Termination
  trace : Trace
  extension : Extension

def sourceFields (c : Candidate) : List String := [inputName c.input, valueName c.value, operationName c.operation, capabilityName c.capability, stateName c.state, terminationName c.termination, traceName c.trace, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "input=" (inputName c.input), SFT.Host.Text.append "value=" (valueName c.value), SFT.Host.Text.append "operation=" (operationName c.operation), SFT.Host.Text.append "capability=" (capabilityName c.capability), SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "termination=" (terminationName c.termination), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "registered-input-only__exact-fold-domain__data-only-generated-operations__no-ambient-capability__single-assignment-held-state__one-terminal-emission__complete-step-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (inputName c.input) "registered-input-only" &&
  SFT.Host.Text.equal (valueName c.value) "exact-fold-domain" &&
  SFT.Host.Text.equal (operationName c.operation) "data-only-generated-operations" &&
  SFT.Host.Text.equal (capabilityName c.capability) "no-ambient-capability" &&
  SFT.Host.Text.equal (stateName c.state) "single-assignment-held-state" &&
  SFT.Host.Text.equal (terminationName c.termination) "one-terminal-emission" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-step-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (inputName c.input) "registered-input-only") then "Ambient input can contain the withheld target or an answer-producing channel." else
  if !(SFT.Host.Text.equal (valueName c.value) "exact-fold-domain") then "Host scalars import forbidden or platform-dependent proof values." else
  if !(SFT.Host.Text.equal (operationName c.operation) "data-only-generated-operations") then "Arbitrary source can create operations outside the registered grammar." else
  if !(SFT.Host.Text.equal (capabilityName c.capability) "no-ambient-capability") then "An ambient resource can reveal target, comparison or mutable authority state." else
  if !(SFT.Host.Text.equal (stateName c.state) "single-assignment-held-state") then "Silent overwrite loses the exact predecessor and permits untraced replacement." else
  if !(SFT.Host.Text.equal (terminationName c.termination) "one-terminal-emission") then "Implicit or open-ended completion cannot certify a complete prediction artifact." else
  if !(SFT.Host.Text.equal (traceName c.trace) "complete-step-trace") then "A result alone hides the operational relation and its resource path." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An extra instruction or capability is a free answer-selecting parameter." else
  "Registered exact inputs, a data-only closed opcode surface, no ambient capability, single-assignment state, one final emission, complete trace and no extra rule."

def generationRule : String := "Generate the complete product of input, value, operation, capability, state, termination, trace and extension forms."
def grammarBoundary : String := "All finite data-only prediction interpreters assembled from admitted exact values, registered inputs, generated operations, immutable held states, a declared terminal emission and no host capability."

def candidates : List Candidate :=
  ([Input.rejected,Input.admitted]).flatMap fun input =>
  ([Value.rejected,Value.admitted]).flatMap fun value =>
  ([Operation.rejected,Operation.admitted]).flatMap fun operation =>
  ([Capability.rejected,Capability.admitted]).flatMap fun capability =>
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Termination.rejected,Termination.admitted]).flatMap fun termination =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨input,value,operation,capability,state,termination,trace,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk input value operation capability state termination trace extension =>
    have hinput : input ∈ [Input.rejected,Input.admitted] := by
      cases input <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvalue : value ∈ [Value.rejected,Value.admitted] := by
      cases value <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperation : operation ∈ [Operation.rejected,Operation.admitted] := by
      cases operation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcapability : capability ∈ [Capability.rejected,Capability.admitted] := by
      cases capability <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htermination : termination ∈ [Termination.rejected,Termination.admitted] := by
      cases termination <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ input _ hinput
    apply CommonRefinement.memFlatMap _ _ value _ hvalue
    apply CommonRefinement.memFlatMap _ _ operation _ hoperation
    apply CommonRefinement.memFlatMap _ _ capability _ hcapability
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ termination _ htermination
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk input value operation capability state termination trace extension =>
    cases input <;> cases value <;> cases operation <;> cases capability <;> cases state <;> cases termination <;> cases trace <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk input value operation capability state termination trace extension =>
    cases input <;> cases value <;> cases operation <;> cases capability <;> cases state <;> cases termination <;> cases trace <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.input = .admitted ∧ c.value = .admitted ∧ c.operation = .admitted ∧ c.capability = .admitted ∧ c.state = .admitted ∧ c.termination = .admitted ∧ c.trace = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk input value operation capability state termination trace extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem input_rejected_rejected (c : Candidate) (h : c.input = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.input eq
    rw [h] at field
    cases field

theorem value_rejected_rejected (c : Candidate) (h : c.value = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.value eq
    rw [h] at field
    cases field

theorem operation_rejected_rejected (c : Candidate) (h : c.operation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.operation eq
    rw [h] at field
    cases field

theorem capability_rejected_rejected (c : Candidate) (h : c.capability = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.capability eq
    rw [h] at field
    cases field

theorem state_rejected_rejected (c : Candidate) (h : c.state = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.state eq
    rw [h] at field
    cases field

theorem termination_rejected_rejected (c : Candidate) (h : c.termination = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.termination eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.CapabilityGrammar
