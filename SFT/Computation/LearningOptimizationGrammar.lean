import SFT.Computation.LearningOptimizationWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.LearningOptimizationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "sampled-hypotheses"
  | .admitted => "complete-generated-hypothesis-support"

inductive Representation where
  | rejected | admitted

def representationName : Representation → String
  | .rejected => "opaque-representation"
  | .admitted => "traceable-canonical-representation"

inductive Inference where
  | rejected | admitted

def inferenceName : Inference → String
  | .rejected => "pretrained-answer"
  | .admitted => "exact-evidence-to-hypothesis-relation"

inductive Evaluation where
  | rejected | admitted

def evaluationName : Evaluation → String
  | .rejected => "development-score"
  | .admitted => "sealed-independent-evaluation"

inductive Uncertainty where
  | rejected | admitted

def uncertaintyName : Uncertainty → String
  | .rejected => "single-winner-erasure"
  | .admitted => "retained-alternative-ledger"

inductive Resources where
  | rejected | admitted

def resourcesName : Resources → String
  | .rejected => "unreported-search"
  | .admitted => "complete-learning-resource-trace"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "training-examples-only"
  | .admitted => "structural-or-empirical-target-boundary"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "fitted-weight-or-prior"
  | .admitted => "no-extra-learning-parameter"

structure Candidate where
  support : Support
  representation : Representation
  inference : Inference
  evaluation : Evaluation
  uncertainty : Uncertainty
  resources : Resources
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [supportName c.support, representationName c.representation, inferenceName c.inference, evaluationName c.evaluation, uncertaintyName c.uncertainty, resourcesName c.resources, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "representation=" (representationName c.representation), SFT.Host.Text.append "inference=" (inferenceName c.inference), SFT.Host.Text.append "evaluation=" (evaluationName c.evaluation), SFT.Host.Text.append "uncertainty=" (uncertaintyName c.uncertainty), SFT.Host.Text.append "resources=" (resourcesName c.resources), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-generated-hypothesis-support__traceable-canonical-representation__exact-evidence-to-hypothesis-relation__sealed-independent-evaluation__retained-alternative-ledger__complete-learning-resource-trace__structural-or-empirical-target-boundary__no-extra-learning-parameter"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-generated-hypothesis-support" &&
  SFT.Host.Text.equal (representationName c.representation) "traceable-canonical-representation" &&
  SFT.Host.Text.equal (inferenceName c.inference) "exact-evidence-to-hypothesis-relation" &&
  SFT.Host.Text.equal (evaluationName c.evaluation) "sealed-independent-evaluation" &&
  SFT.Host.Text.equal (uncertaintyName c.uncertainty) "retained-alternative-ledger" &&
  SFT.Host.Text.equal (resourcesName c.resources) "complete-learning-resource-trace" &&
  SFT.Host.Text.equal (generalityName c.generality) "structural-or-empirical-target-boundary" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-learning-parameter"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-generated-hypothesis-support") then "sampled-hypotheses removes a required exact support condition." else
  if !(SFT.Host.Text.equal (representationName c.representation) "traceable-canonical-representation") then "opaque-representation removes a required exact representation condition." else
  if !(SFT.Host.Text.equal (inferenceName c.inference) "exact-evidence-to-hypothesis-relation") then "pretrained-answer removes a required exact inference condition." else
  if !(SFT.Host.Text.equal (evaluationName c.evaluation) "sealed-independent-evaluation") then "development-score removes a required exact evaluation condition." else
  if !(SFT.Host.Text.equal (uncertaintyName c.uncertainty) "retained-alternative-ledger") then "single-winner-erasure removes a required exact uncertainty condition." else
  if !(SFT.Host.Text.equal (resourcesName c.resources) "complete-learning-resource-trace") then "unreported-search removes a required exact resources condition." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "structural-or-empirical-target-boundary") then "training-examples-only removes a required exact generality condition." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-learning-parameter") then "fitted-weight-or-prior removes a required exact addition condition." else
  "The forced exact objective selection over hypotheses kernel retains hypothesis support; exact objective relation; evidence rows; complete search or certified elimination; tied optimum class; update trace; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."

def generationRule : String := "Generate the literal product of the eight registered Learning and Intelligence Theory structural axes for exact objective selection over hypotheses."
def grammarBoundary : String := "All generated finite exact objective selection over hypotheses structures whose carriers, relations, traces and interfaces are composed from admitted Foundation, Mathematics and Information Science forms. Gradient, differentiability and fitted parameter spaces are not assumed."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Representation.rejected,Representation.admitted]).flatMap fun representation =>
  ([Inference.rejected,Inference.admitted]).flatMap fun inference =>
  ([Evaluation.rejected,Evaluation.admitted]).flatMap fun evaluation =>
  ([Uncertainty.rejected,Uncertainty.admitted]).flatMap fun uncertainty =>
  ([Resources.rejected,Resources.admitted]).flatMap fun resources =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨support,representation,inference,evaluation,uncertainty,resources,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support representation inference evaluation uncertainty resources generality addition =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrepresentation : representation ∈ [Representation.rejected,Representation.admitted] := by
      cases representation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinference : inference ∈ [Inference.rejected,Inference.admitted] := by
      cases inference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevaluation : evaluation ∈ [Evaluation.rejected,Evaluation.admitted] := by
      cases evaluation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huncertainty : uncertainty ∈ [Uncertainty.rejected,Uncertainty.admitted] := by
      cases uncertainty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresources : resources ∈ [Resources.rejected,Resources.admitted] := by
      cases resources <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ representation _ hrepresentation
    apply CommonRefinement.memFlatMap _ _ inference _ hinference
    apply CommonRefinement.memFlatMap _ _ evaluation _ hevaluation
    apply CommonRefinement.memFlatMap _ _ uncertainty _ huncertainty
    apply CommonRefinement.memFlatMap _ _ resources _ hresources
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support representation inference evaluation uncertainty resources generality addition =>
    cases support <;> cases representation <;> cases inference <;> cases evaluation <;> cases uncertainty <;> cases resources <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support representation inference evaluation uncertainty resources generality addition =>
    cases support <;> cases representation <;> cases inference <;> cases evaluation <;> cases uncertainty <;> cases resources <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.representation = .admitted ∧ c.inference = .admitted ∧ c.evaluation = .admitted ∧ c.uncertainty = .admitted ∧ c.resources = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support representation inference evaluation uncertainty resources generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem representation_rejected_rejected (c : Candidate) (h : c.representation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.representation eq
    rw [h] at field
    cases field

theorem inference_rejected_rejected (c : Candidate) (h : c.inference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.inference eq
    rw [h] at field
    cases field

theorem evaluation_rejected_rejected (c : Candidate) (h : c.evaluation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.evaluation eq
    rw [h] at field
    cases field

theorem uncertainty_rejected_rejected (c : Candidate) (h : c.uncertainty = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.uncertainty eq
    rw [h] at field
    cases field

theorem resources_rejected_rejected (c : Candidate) (h : c.resources = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.resources eq
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

end SFT.Computation.LearningOptimizationGrammar
