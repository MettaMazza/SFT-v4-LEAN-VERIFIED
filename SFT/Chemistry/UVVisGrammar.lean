import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.UVVisGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Input where
  | rejected | admitted

def inputName : Input → String
  | .rejected => "unregistered-radiation"
  | .admitted => "ultraviolet-visible-support-held"

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "chemical-carrier-erased"
  | .admitted => "molecular-or-ionic-carrier-held"

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "single-state-only"
  | .admitted => "paired-electronic-states"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "energy-order-erased"
  | .admitted => "higher-state-transition-held"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "absorption-number-only"
  | .admitted => "wavelength-response-pattern-held"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "response-detached-from-carrier"
  | .admitted => "carrier-state-response-map"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "universal-response"
  | .admitted => "state-method-condition-boundary"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-electronic-band-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  input : Input
  carrier : Carrier
  state : State
  transition : Transition
  response : Response
  composition : Composition
  conditions : Conditions
  extra : Extra

def sourceFields (c : Candidate) : List String := [inputName c.input, carrierName c.carrier, stateName c.state, transitionName c.transition, responseName c.response, compositionName c.composition, conditionsName c.conditions, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "input=" (inputName c.input), SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "ultraviolet-visible-support-held__molecular-or-ionic-carrier-held__paired-electronic-states__higher-state-transition-held__wavelength-response-pattern-held__carrier-state-response-map__state-method-condition-boundary__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (inputName c.input) "ultraviolet-visible-support-held" &&
  SFT.Host.Text.equal (carrierName c.carrier) "molecular-or-ionic-carrier-held" &&
  SFT.Host.Text.equal (stateName c.state) "paired-electronic-states" &&
  SFT.Host.Text.equal (transitionName c.transition) "higher-state-transition-held" &&
  SFT.Host.Text.equal (responseName c.response) "wavelength-response-pattern-held" &&
  SFT.Host.Text.equal (compositionName c.composition) "carrier-state-response-map" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "state-method-condition-boundary" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (inputName c.input) "ultraviolet-visible-support-held") then "No excitation support is identified." else
  if !(SFT.Host.Text.equal (carrierName c.carrier) "molecular-or-ionic-carrier-held") then "Absorption cannot be assigned." else
  if !(SFT.Host.Text.equal (stateName c.state) "paired-electronic-states") then "No transition occurs." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "higher-state-transition-held") then "Absorption direction is ambiguous." else
  if !(SFT.Host.Text.equal (responseName c.response) "wavelength-response-pattern-held") then "Spectral support is lost." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "carrier-state-response-map") then "Molecular distinction cannot be tested." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "state-method-condition-boundary") then "Environment and method affect observation." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fitted band can select the answer." else
  "ultraviolet-visible-support-held__molecular-or-ionic-carrier-held__paired-electronic-states__higher-state-transition-held__wavelength-response-pattern-held"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete distinction preservation, exact recurrence/equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite chemical carrier with paired generated electronic state classes, ordered transitions and a declared ultraviolet-visible observation domain."

def candidates : List Candidate :=
  ([Input.rejected,Input.admitted]).flatMap fun input =>
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨input,carrier,state,transition,response,composition,conditions,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk input carrier state transition response composition conditions extra =>
    have hinput : input ∈ [Input.rejected,Input.admitted] := by
      cases input <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ input _ hinput
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk input carrier state transition response composition conditions extra =>
    cases input <;> cases carrier <;> cases state <;> cases transition <;> cases response <;> cases composition <;> cases conditions <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk input carrier state transition response composition conditions extra =>
    cases input <;> cases carrier <;> cases state <;> cases transition <;> cases response <;> cases composition <;> cases conditions <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.input = .admitted ∧ c.carrier = .admitted ∧ c.state = .admitted ∧ c.transition = .admitted ∧ c.response = .admitted ∧ c.composition = .admitted ∧ c.conditions = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk input carrier state transition response composition conditions extra =>
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

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
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

theorem transition_rejected_rejected (c : Candidate) (h : c.transition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transition eq
    rw [h] at field
    cases field

theorem response_rejected_rejected (c : Candidate) (h : c.response = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.response eq
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

theorem conditions_rejected_rejected (c : Candidate) (h : c.conditions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conditions eq
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

end SFT.Chemistry.UVVisGrammar
