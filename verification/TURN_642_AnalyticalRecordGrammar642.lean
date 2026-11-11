import «work».AnalyticalRecordCarrier642
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.AnalyticalRecordGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Question where
  | rejected | admitted

def questionName : Question → String
  | .rejected => "unstated-measurand"
  | .admitted => "measurand-and-purpose-held"

inductive Sample where
  | rejected | admitted

def sampleName : Sample → String
  | .rejected => "sample-identity-erased"
  | .admitted => "sample-analyte-matrix-record"

inductive Method where
  | rejected | admitted

def methodName : Method → String
  | .rejected => "method-erased"
  | .admitted => "method-and-condition-record"

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "reference-erased"
  | .admitted => "calibration-and-reference-chain"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "accepted-values-only"
  | .admitted => "all-raw-and-derived-rows-held"

inductive Uncertainty where
  | rejected | admitted

def uncertaintyName : Uncertainty → String
  | .rejected => "single-value-certainty"
  | .admitted => "uncertainty-and-resolution-held"

inductive Falsification where
  | rejected | admitted

def falsificationName : Falsification → String
  | .rejected => "success-only-report"
  | .admitted => "failed-tampered-and-falsification-record"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-reporting-omission"
  | .admitted => "no-extra-rule"

structure Candidate where
  question : Question
  sample : Sample
  method : Method
  reference : Reference
  observation : Observation
  uncertainty : Uncertainty
  falsification : Falsification
  extra : Extra

def sourceFields (c : Candidate) : List String := [questionName c.question, sampleName c.sample, methodName c.method, referenceName c.reference, observationName c.observation, uncertaintyName c.uncertainty, falsificationName c.falsification, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "question=" (questionName c.question), SFT.Host.Text.append "sample=" (sampleName c.sample), SFT.Host.Text.append "method=" (methodName c.method), SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "uncertainty=" (uncertaintyName c.uncertainty), SFT.Host.Text.append "falsification=" (falsificationName c.falsification), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "measurand-and-purpose-held__sample-analyte-matrix-record__method-and-condition-record__calibration-and-reference-chain__all-raw-and-derived-rows-held__uncertainty-and-resolution-held__failed-tampered-and-falsification-record__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (questionName c.question) "measurand-and-purpose-held" &&
  SFT.Host.Text.equal (sampleName c.sample) "sample-analyte-matrix-record" &&
  SFT.Host.Text.equal (methodName c.method) "method-and-condition-record" &&
  SFT.Host.Text.equal (referenceName c.reference) "calibration-and-reference-chain" &&
  SFT.Host.Text.equal (observationName c.observation) "all-raw-and-derived-rows-held" &&
  SFT.Host.Text.equal (uncertaintyName c.uncertainty) "uncertainty-and-resolution-held" &&
  SFT.Host.Text.equal (falsificationName c.falsification) "failed-tampered-and-falsification-record" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (questionName c.question) "measurand-and-purpose-held") then "The result has no declared target." else
  if !(SFT.Host.Text.equal (sampleName c.sample) "sample-analyte-matrix-record") then "The result cannot be located." else
  if !(SFT.Host.Text.equal (methodName c.method) "method-and-condition-record") then "The transformation cannot be reproduced." else
  if !(SFT.Host.Text.equal (referenceName c.reference) "calibration-and-reference-chain") then "Traceability is lost." else
  if !(SFT.Host.Text.equal (observationName c.observation) "all-raw-and-derived-rows-held") then "Unfavorable evidence disappears." else
  if !(SFT.Host.Text.equal (uncertaintyName c.uncertainty) "uncertainty-and-resolution-held") then "Admissible alternatives are hidden." else
  if !(SFT.Host.Text.equal (falsificationName c.falsification) "failed-tampered-and-falsification-record") then "The claim cannot fail publicly." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "Discretion can hide a contradiction." else
  "measurand-and-purpose-held__sample-analyte-matrix-record__method-and-condition-record__calibration-and-reference-chain__all-raw-and-derived-rows-held__uncertainty-and-resolution-held__failed-tampered-and-falsification-record"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete distinction preservation, exact recurrence/equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite analytical execution with registered question, material, method, reference, observations, transformations, uncertainty and controls."

def candidates : List Candidate :=
  ([Question.rejected,Question.admitted]).flatMap fun question =>
  ([Sample.rejected,Sample.admitted]).flatMap fun sample =>
  ([Method.rejected,Method.admitted]).flatMap fun method =>
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Uncertainty.rejected,Uncertainty.admitted]).flatMap fun uncertainty =>
  ([Falsification.rejected,Falsification.admitted]).flatMap fun falsification =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨question,sample,method,reference,observation,uncertainty,falsification,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk question sample method reference observation uncertainty falsification extra =>
    have hquestion : question ∈ [Question.rejected,Question.admitted] := by
      cases question <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsample : sample ∈ [Sample.rejected,Sample.admitted] := by
      cases sample <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmethod : method ∈ [Method.rejected,Method.admitted] := by
      cases method <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huncertainty : uncertainty ∈ [Uncertainty.rejected,Uncertainty.admitted] := by
      cases uncertainty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfalsification : falsification ∈ [Falsification.rejected,Falsification.admitted] := by
      cases falsification <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ question _ hquestion
    apply CommonRefinement.memFlatMap _ _ sample _ hsample
    apply CommonRefinement.memFlatMap _ _ method _ hmethod
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ uncertainty _ huncertainty
    apply CommonRefinement.memFlatMap _ _ falsification _ hfalsification
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk question sample method reference observation uncertainty falsification extra =>
    cases question <;> cases sample <;> cases method <;> cases reference <;> cases observation <;> cases uncertainty <;> cases falsification <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk question sample method reference observation uncertainty falsification extra =>
    cases question <;> cases sample <;> cases method <;> cases reference <;> cases observation <;> cases uncertainty <;> cases falsification <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.question = .admitted ∧ c.sample = .admitted ∧ c.method = .admitted ∧ c.reference = .admitted ∧ c.observation = .admitted ∧ c.uncertainty = .admitted ∧ c.falsification = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk question sample method reference observation uncertainty falsification extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem question_rejected_rejected (c : Candidate) (h : c.question = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.question eq
    rw [h] at field
    cases field

theorem sample_rejected_rejected (c : Candidate) (h : c.sample = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sample eq
    rw [h] at field
    cases field

theorem method_rejected_rejected (c : Candidate) (h : c.method = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.method eq
    rw [h] at field
    cases field

theorem reference_rejected_rejected (c : Candidate) (h : c.reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reference eq
    rw [h] at field
    cases field

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
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

theorem falsification_rejected_rejected (c : Candidate) (h : c.falsification = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.falsification eq
    rw [h] at field
    cases field

theorem extra_rejected_rejected (c : Candidate) (h : c.extra = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Physics.AnalyticalRecordGrammar
