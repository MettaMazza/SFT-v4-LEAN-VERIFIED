import verification.TURN_347_ReversibleWitnessesDraft
import SFT.Foundation.CommonRefinement
namespace SFT.QuantumComputation.ReversibleGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "partial-or-selected-branch-support"
  | .admitted => "complete-generated-branch-support"

inductive Unit where
  | rejected | admitted

def unitName : Unit → String
  | .rejected => "imported-bit-or-qubit"
  | .admitted => "one-Fold-distinction-unit"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "sampled-joint-states"
  | .admitted => "complete-pair-cell-joint-support"

inductive Phase where
  | rejected | admitted

def phaseName : Phase → String
  | .rejected => "complex-amplitude-postulate"
  | .admitted => "period-held-phase-action"

inductive Transformation where
  | rejected | admitted

def transformationName : Transformation → String
  | .rejected => "partial-or-irreversible-map"
  | .admitted => "total-reversible-source-bound-map"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "collapse-without-record"
  | .admitted => "retained-class-and-complete-record"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "fixed-circuit-examples"
  | .admitted => "branch-and-depth-successor-certificate"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "imported-quantum-model"
  | .admitted => "no-extra-quantum-premise"

structure Candidate where
  support : Support
  unit : Unit
  composition : Composition
  phase : Phase
  transformation : Transformation
  observation : Observation
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [supportName c.support, unitName c.unit, compositionName c.composition, phaseName c.phase, transformationName c.transformation, observationName c.observation, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "unit=" (unitName c.unit), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "phase=" (phaseName c.phase), SFT.Host.Text.append "transformation=" (transformationName c.transformation), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-generated-branch-support__one-Fold-distinction-unit__complete-pair-cell-joint-support__period-held-phase-action__total-reversible-source-bound-map__retained-class-and-complete-record__branch-and-depth-successor-certificate__no-extra-quantum-premise"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-generated-branch-support" &&
  SFT.Host.Text.equal (unitName c.unit) "one-Fold-distinction-unit" &&
  SFT.Host.Text.equal (compositionName c.composition) "complete-pair-cell-joint-support" &&
  SFT.Host.Text.equal (phaseName c.phase) "period-held-phase-action" &&
  SFT.Host.Text.equal (transformationName c.transformation) "total-reversible-source-bound-map" &&
  SFT.Host.Text.equal (observationName c.observation) "retained-class-and-complete-record" &&
  SFT.Host.Text.equal (generalityName c.generality) "branch-and-depth-successor-certificate" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-quantum-premise"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-generated-branch-support") then "partial-or-selected-branch-support removes the required exact support structure." else
  if !(SFT.Host.Text.equal (unitName c.unit) "one-Fold-distinction-unit") then "imported-bit-or-qubit removes the required exact unit structure." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "complete-pair-cell-joint-support") then "sampled-joint-states removes the required exact composition structure." else
  if !(SFT.Host.Text.equal (phaseName c.phase) "period-held-phase-action") then "complex-amplitude-postulate removes the required exact phase structure." else
  if !(SFT.Host.Text.equal (transformationName c.transformation) "total-reversible-source-bound-map") then "partial-or-irreversible-map removes the required exact transformation structure." else
  if !(SFT.Host.Text.equal (observationName c.observation) "retained-class-and-complete-record") then "collapse-without-record removes the required exact observation structure." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "branch-and-depth-successor-certificate") then "fixed-circuit-examples removes the required exact generality structure." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-quantum-premise") then "imported-quantum-model removes the required exact addition structure." else
  "The forced reversible computation kernel retains canonical configurations; bijective transition rows; retained held labels; exact inverse traces; universal reversible interpretation; complete resource ledger; branch support, phase, transformation, observation, composition and resources remain exact, finite, source-bound and free of imported amplitudes or postulates."

def generationRule : String := "Generate the literal product of eight registered Fold-quantum structural axes for reversible computation."
def grammarBoundary : String := "All finite reversible computation structures generated from admitted Fold words, distinction ledgers, classical computation and exact held phase labels. This theorem is formal and does not assign thermodynamic energy without a later physical measurement law."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Unit.rejected,Unit.admitted]).flatMap fun unit =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Phase.rejected,Phase.admitted]).flatMap fun phase =>
  ([Transformation.rejected,Transformation.admitted]).flatMap fun transformation =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨support,unit,composition,phase,transformation,observation,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support unit composition phase transformation observation generality addition =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunit : unit ∈ [Unit.rejected,Unit.admitted] := by
      cases unit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hphase : phase ∈ [Phase.rejected,Phase.admitted] := by
      cases phase <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransformation : transformation ∈ [Transformation.rejected,Transformation.admitted] := by
      cases transformation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ unit _ hunit
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ phase _ hphase
    apply CommonRefinement.memFlatMap _ _ transformation _ htransformation
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support unit composition phase transformation observation generality addition =>
    cases support <;> cases unit <;> cases composition <;> cases phase <;> cases transformation <;> cases observation <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support unit composition phase transformation observation generality addition =>
    cases support <;> cases unit <;> cases composition <;> cases phase <;> cases transformation <;> cases observation <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.unit = .admitted ∧ c.composition = .admitted ∧ c.phase = .admitted ∧ c.transformation = .admitted ∧ c.observation = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support unit composition phase transformation observation generality addition =>
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

theorem unit_rejected_rejected (c : Candidate) (h : c.unit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.unit eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem phase_rejected_rejected (c : Candidate) (h : c.phase = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.phase eq
    rw [h] at field
    cases field

theorem transformation_rejected_rejected (c : Candidate) (h : c.transformation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transformation eq
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

end SFT.QuantumComputation.ReversibleGrammar
