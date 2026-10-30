import SFT.Computation.ComputationalDynamicsWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.ComputationalDynamicsGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Model where
  | rejected | admitted

def modelName : Model → String
  | .rejected => "unstated-model"
  | .admitted => "registered-exact-model-relation"

inductive Inputs where
  | rejected | admitted

def inputsName : Inputs → String
  | .rejected => "sampled-or-fitted-inputs"
  | .admitted => "complete-declared-input-support"

inductive Operation where
  | rejected | admitted

def operationName : Operation → String
  | .rejected => "opaque-calculation"
  | .admitted => "exact-executable-operation-trace"

inductive Error where
  | rejected | admitted

def errorName : Error → String
  | .rejected => "unsigned-error-scalar"
  | .admitted => "orientation-labelled-error-ledger"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "visual-convergence"
  | .admitted => "base-successor-closure-certificate"

inductive Validation where
  | rejected | admitted

def validationName : Validation → String
  | .rejected => "fit-only"
  | .admitted => "sealed-falsifiable-comparison-boundary"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "single-resolution"
  | .admitted => "generated-refinement-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "imported-equation-or-parameter"
  | .admitted => "no-extra-scientific-prior"

structure Candidate where
  model : Model
  inputs : Inputs
  operation : Operation
  error : Error
  closure : Closure
  validation : Validation
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [modelName c.model, inputsName c.inputs, operationName c.operation, errorName c.error, closureName c.closure, validationName c.validation, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "model=" (modelName c.model), SFT.Host.Text.append "inputs=" (inputsName c.inputs), SFT.Host.Text.append "operation=" (operationName c.operation), SFT.Host.Text.append "error=" (errorName c.error), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "validation=" (validationName c.validation), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "registered-exact-model-relation__complete-declared-input-support__exact-executable-operation-trace__orientation-labelled-error-ledger__base-successor-closure-certificate__sealed-falsifiable-comparison-boundary__generated-refinement-successor__no-extra-scientific-prior"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (modelName c.model) "registered-exact-model-relation" &&
  SFT.Host.Text.equal (inputsName c.inputs) "complete-declared-input-support" &&
  SFT.Host.Text.equal (operationName c.operation) "exact-executable-operation-trace" &&
  SFT.Host.Text.equal (errorName c.error) "orientation-labelled-error-ledger" &&
  SFT.Host.Text.equal (closureName c.closure) "base-successor-closure-certificate" &&
  SFT.Host.Text.equal (validationName c.validation) "sealed-falsifiable-comparison-boundary" &&
  SFT.Host.Text.equal (generalityName c.generality) "generated-refinement-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-scientific-prior"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (modelName c.model) "registered-exact-model-relation") then "unstated-model removes a required exact model condition." else
  if !(SFT.Host.Text.equal (inputsName c.inputs) "complete-declared-input-support") then "sampled-or-fitted-inputs removes a required exact inputs condition." else
  if !(SFT.Host.Text.equal (operationName c.operation) "exact-executable-operation-trace") then "opaque-calculation removes a required exact operation condition." else
  if !(SFT.Host.Text.equal (errorName c.error) "orientation-labelled-error-ledger") then "unsigned-error-scalar removes a required exact error condition." else
  if !(SFT.Host.Text.equal (closureName c.closure) "base-successor-closure-certificate") then "visual-convergence removes a required exact closure condition." else
  if !(SFT.Host.Text.equal (validationName c.validation) "sealed-falsifiable-comparison-boundary") then "fit-only removes a required exact validation condition." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "generated-refinement-successor") then "single-resolution removes a required exact generality condition." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-scientific-prior") then "imported-equation-or-parameter removes a required exact addition condition." else
  "The forced iterated exact finite state transformation kernel retains state support; update relation; successor time labels; orbit traces; terminal and cycle classes; invariant ledger; perturbation support; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."

def generationRule : String := "Generate the literal product of the eight registered Scientific Computation structural axes for iterated exact finite state transformation."
def grammarBoundary : String := "All generated finite iterated exact finite state transformation structures whose carriers, relations, traces and interfaces are composed from admitted Foundation, Mathematics and Information Science forms. Physical time and continuous dynamics require later empirical correspondence."

def candidates : List Candidate :=
  ([Model.rejected,Model.admitted]).flatMap fun model =>
  ([Inputs.rejected,Inputs.admitted]).flatMap fun inputs =>
  ([Operation.rejected,Operation.admitted]).flatMap fun operation =>
  ([Error.rejected,Error.admitted]).flatMap fun error =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Validation.rejected,Validation.admitted]).flatMap fun validation =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨model,inputs,operation,error,closure,validation,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk model inputs operation error closure validation generality addition =>
    have hmodel : model ∈ [Model.rejected,Model.admitted] := by
      cases model <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinputs : inputs ∈ [Inputs.rejected,Inputs.admitted] := by
      cases inputs <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperation : operation ∈ [Operation.rejected,Operation.admitted] := by
      cases operation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have herror : error ∈ [Error.rejected,Error.admitted] := by
      cases error <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvalidation : validation ∈ [Validation.rejected,Validation.admitted] := by
      cases validation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ model _ hmodel
    apply CommonRefinement.memFlatMap _ _ inputs _ hinputs
    apply CommonRefinement.memFlatMap _ _ operation _ hoperation
    apply CommonRefinement.memFlatMap _ _ error _ herror
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ validation _ hvalidation
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk model inputs operation error closure validation generality addition =>
    cases model <;> cases inputs <;> cases operation <;> cases error <;> cases closure <;> cases validation <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk model inputs operation error closure validation generality addition =>
    cases model <;> cases inputs <;> cases operation <;> cases error <;> cases closure <;> cases validation <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.model = .admitted ∧ c.inputs = .admitted ∧ c.operation = .admitted ∧ c.error = .admitted ∧ c.closure = .admitted ∧ c.validation = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk model inputs operation error closure validation generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem model_rejected_rejected (c : Candidate) (h : c.model = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.model eq
    rw [h] at field
    cases field

theorem inputs_rejected_rejected (c : Candidate) (h : c.inputs = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.inputs eq
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

theorem error_rejected_rejected (c : Candidate) (h : c.error = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.error eq
    rw [h] at field
    cases field

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
    rw [h] at field
    cases field

theorem validation_rejected_rejected (c : Candidate) (h : c.validation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.validation eq
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

end SFT.Computation.ComputationalDynamicsGrammar
