import SFT.InformationScience.NoiseWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.NoiseGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "partial-source-support"
  | .admitted => "complete-canonical-sources"

inductive Received where
  | rejected | admitted

def receivedName : Received → String
  | .rejected => "sampled-received-forms"
  | .admitted => "complete-registered-images"

inductive Action where
  | rejected | admitted

def actionName : Action → String
  | .rejected => "opaque-perturbation"
  | .admitted => "held-action-relation"

inductive Error where
  | rejected | admitted

def errorName : Error → String
  | .rejected => "scalar-error-size"
  | .admitted => "complete-changed-position-trace"

inductive Detection where
  | rejected | admitted

def detectionName : Detection → String
  | .rejected => "probability-threshold"
  | .admitted => "invalid-codeword-witness"

inductive Predecessors where
  | rejected | admitted

def predecessorsName : Predecessors → String
  | .rejected => "chosen-likely-source"
  | .admitted => "complete-source-class"

inductive Correction where
  | rejected | admitted

def correctionName : Correction → String
  | .rejected => "nearest-form-assumption"
  | .admitted => "singleton-predecessor"

inductive Cause where
  | rejected | admitted

def causeName : Cause → String
  | .rejected => "stochastic-noise-source"
  | .admitted => "deterministic-transformation-family"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "sampled-masks"
  | .admitted => "action-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-error-rate-or-metric"
  | .admitted => "no-extra-error-model"

structure Candidate where
  source : Source
  received : Received
  action : Action
  error : Error
  detection : Detection
  predecessors : Predecessors
  correction : Correction
  cause : Cause
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [sourceName c.source, receivedName c.received, actionName c.action, errorName c.error, detectionName c.detection, predecessorsName c.predecessors, correctionName c.correction, causeName c.cause, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "received=" (receivedName c.received), SFT.Host.Text.append "action=" (actionName c.action), SFT.Host.Text.append "error=" (errorName c.error), SFT.Host.Text.append "detection=" (detectionName c.detection), SFT.Host.Text.append "predecessors=" (predecessorsName c.predecessors), SFT.Host.Text.append "correction=" (correctionName c.correction), SFT.Host.Text.append "cause=" (causeName c.cause), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-sources__complete-registered-images__held-action-relation__complete-changed-position-trace__invalid-codeword-witness__complete-source-class__singleton-predecessor__deterministic-transformation-family__action-successor__no-extra-error-model"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sourceName c.source) "complete-canonical-sources" &&
  SFT.Host.Text.equal (receivedName c.received) "complete-registered-images" &&
  SFT.Host.Text.equal (actionName c.action) "held-action-relation" &&
  SFT.Host.Text.equal (errorName c.error) "complete-changed-position-trace" &&
  SFT.Host.Text.equal (detectionName c.detection) "invalid-codeword-witness" &&
  SFT.Host.Text.equal (predecessorsName c.predecessors) "complete-source-class" &&
  SFT.Host.Text.equal (correctionName c.correction) "singleton-predecessor" &&
  SFT.Host.Text.equal (causeName c.cause) "deterministic-transformation-family" &&
  SFT.Host.Text.equal (generalityName c.generality) "action-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-error-model"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (sourceName c.source) "complete-canonical-sources") then "An omitted source hides a possible predecessor." else
  if !(SFT.Host.Text.equal (receivedName c.received) "complete-registered-images") then "Sampling cannot establish the transformation boundary complete." else
  if !(SFT.Host.Text.equal (actionName c.action) "held-action-relation") then "An opaque change hides which source produced which image." else
  if !(SFT.Host.Text.equal (errorName c.error) "complete-changed-position-trace") then "A scalar count erases changed positions and labels." else
  if !(SFT.Host.Text.equal (detectionName c.detection) "invalid-codeword-witness") then "A threshold imports a distribution and free parameter." else
  if !(SFT.Host.Text.equal (predecessorsName c.predecessors) "complete-source-class") then "Choosing one predecessor imports a prior." else
  if !(SFT.Host.Text.equal (correctionName c.correction) "singleton-predecessor") then "Nearest requires an unforced metric and can tie." else
  if !(SFT.Host.Text.equal (causeName c.cause) "deterministic-transformation-family") then "A random cause is neither generated nor needed." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "action-successor") then "Examples do not establish a fresh action image." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-error-model") then "A rate, distribution or metric is not supplied by exact transformations." else
  "The noise/error kernel is complete source and received support, held action provenance, exact position traces, invalid-code detection, complete predecessor classes, singleton correction and no stochastic or metric rule."

def generationRule : String := "Generate the complete product of source support, received support, transformation provenance, error trace, detection, predecessor classes, correction, deterministic status, generality and extra-noise status."
def grammarBoundary : String := "All finite error systems generated from canonical source and received words, held transformation actions, exact changed-position traces, valid code support and complete predecessor classes."

def candidates : List Candidate :=
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Received.rejected,Received.admitted]).flatMap fun received =>
  ([Action.rejected,Action.admitted]).flatMap fun action =>
  ([Error.rejected,Error.admitted]).flatMap fun error =>
  ([Detection.rejected,Detection.admitted]).flatMap fun detection =>
  ([Predecessors.rejected,Predecessors.admitted]).flatMap fun predecessors =>
  ([Correction.rejected,Correction.admitted]).flatMap fun correction =>
  ([Cause.rejected,Cause.admitted]).flatMap fun cause =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨source,received,action,error,detection,predecessors,correction,cause,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk source received action error detection predecessors correction cause generality addition =>
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreceived : received ∈ [Received.rejected,Received.admitted] := by
      cases received <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haction : action ∈ [Action.rejected,Action.admitted] := by
      cases action <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have herror : error ∈ [Error.rejected,Error.admitted] := by
      cases error <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdetection : detection ∈ [Detection.rejected,Detection.admitted] := by
      cases detection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpredecessors : predecessors ∈ [Predecessors.rejected,Predecessors.admitted] := by
      cases predecessors <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcorrection : correction ∈ [Correction.rejected,Correction.admitted] := by
      cases correction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcause : cause ∈ [Cause.rejected,Cause.admitted] := by
      cases cause <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ received _ hreceived
    apply CommonRefinement.memFlatMap _ _ action _ haction
    apply CommonRefinement.memFlatMap _ _ error _ herror
    apply CommonRefinement.memFlatMap _ _ detection _ hdetection
    apply CommonRefinement.memFlatMap _ _ predecessors _ hpredecessors
    apply CommonRefinement.memFlatMap _ _ correction _ hcorrection
    apply CommonRefinement.memFlatMap _ _ cause _ hcause
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk source received action error detection predecessors correction cause generality addition =>
    cases source <;> cases received <;> cases action <;> cases error <;> cases detection <;> cases predecessors <;> cases correction <;> cases cause <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk source received action error detection predecessors correction cause generality addition =>
    cases source <;> cases received <;> cases action <;> cases error <;> cases detection <;> cases predecessors <;> cases correction <;> cases cause <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.source = .admitted ∧ c.received = .admitted ∧ c.action = .admitted ∧ c.error = .admitted ∧ c.detection = .admitted ∧ c.predecessors = .admitted ∧ c.correction = .admitted ∧ c.cause = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk source received action error detection predecessors correction cause generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
    rw [h] at field
    cases field

theorem received_rejected_rejected (c : Candidate) (h : c.received = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.received eq
    rw [h] at field
    cases field

theorem action_rejected_rejected (c : Candidate) (h : c.action = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.action eq
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

theorem detection_rejected_rejected (c : Candidate) (h : c.detection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.detection eq
    rw [h] at field
    cases field

theorem predecessors_rejected_rejected (c : Candidate) (h : c.predecessors = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessors eq
    rw [h] at field
    cases field

theorem correction_rejected_rejected (c : Candidate) (h : c.correction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.correction eq
    rw [h] at field
    cases field

theorem cause_rejected_rejected (c : Candidate) (h : c.cause = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cause eq
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

end SFT.InformationScience.NoiseGrammar
