import «work».InfraredCarrier641
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.InfraredGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Input where
  | rejected | admitted

def inputName : Input → String
  | .rejected => "unregistered-incident-recurrence"
  | .admitted => "incident-infrared-support-held"

inductive Molecule where
  | rejected | admitted

def moleculeName : Molecule → String
  | .rejected => "molecular-identity-erased"
  | .admitted => "complete-molecular-carrier-held"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "static-geometry-only"
  | .admitted => "vibrational-state-transition-held"

inductive Coupling where
  | rejected | admitted

def couplingName : Coupling → String
  | .rejected => "all-transitions-assumed-visible"
  | .admitted => "dipole-response-change-required"

inductive Spectrum where
  | rejected | admitted

def spectrumName : Spectrum → String
  | .rejected => "one-line-answer"
  | .admitted => "complete-frequency-response-pattern"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "universal-one-line-identifier"
  | .admitted => "whole-pattern-molecular-distinction"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "condition-free-spectrum"
  | .admitted => "state-method-condition-boundary"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-infrared-line-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  input : Input
  molecule : Molecule
  transition : Transition
  coupling : Coupling
  spectrum : Spectrum
  identity : Identity
  conditions : Conditions
  extra : Extra

def sourceFields (c : Candidate) : List String := [inputName c.input, moleculeName c.molecule, transitionName c.transition, couplingName c.coupling, spectrumName c.spectrum, identityName c.identity, conditionsName c.conditions, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "input=" (inputName c.input), SFT.Host.Text.append "molecule=" (moleculeName c.molecule), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "coupling=" (couplingName c.coupling), SFT.Host.Text.append "spectrum=" (spectrumName c.spectrum), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "incident-infrared-support-held__complete-molecular-carrier-held__vibrational-state-transition-held__dipole-response-change-required__complete-frequency-response-pattern__whole-pattern-molecular-distinction__state-method-condition-boundary__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (inputName c.input) "incident-infrared-support-held" &&
  SFT.Host.Text.equal (moleculeName c.molecule) "complete-molecular-carrier-held" &&
  SFT.Host.Text.equal (transitionName c.transition) "vibrational-state-transition-held" &&
  SFT.Host.Text.equal (couplingName c.coupling) "dipole-response-change-required" &&
  SFT.Host.Text.equal (spectrumName c.spectrum) "complete-frequency-response-pattern" &&
  SFT.Host.Text.equal (identityName c.identity) "whole-pattern-molecular-distinction" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "state-method-condition-boundary" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (inputName c.input) "incident-infrared-support-held") then "No excitation comparison is defined." else
  if !(SFT.Host.Text.equal (moleculeName c.molecule) "complete-molecular-carrier-held") then "Response cannot distinguish carriers." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "vibrational-state-transition-held") then "A spectrum requires a state change." else
  if !(SFT.Host.Text.equal (couplingName c.coupling) "dipole-response-change-required") then "Observation requires a changed interaction trace." else
  if !(SFT.Host.Text.equal (spectrumName c.spectrum) "complete-frequency-response-pattern") then "Alternative recurrences are erased." else
  if !(SFT.Host.Text.equal (identityName c.identity) "whole-pattern-molecular-distinction") then "Different carriers may share a line." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "state-method-condition-boundary") then "State and method affect observation." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A lookup can force assignment." else
  "incident-infrared-support-held__complete-molecular-carrier-held__vibrational-state-transition-held__dipole-response-change-required__complete-frequency-response-pattern"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete distinction preservation, exact recurrence/equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite molecular carrier with generated internal recurrence states, paired transitions, interaction-change tests and a declared observation domain."

def candidates : List Candidate :=
  ([Input.rejected,Input.admitted]).flatMap fun input =>
  ([Molecule.rejected,Molecule.admitted]).flatMap fun molecule =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Coupling.rejected,Coupling.admitted]).flatMap fun coupling =>
  ([Spectrum.rejected,Spectrum.admitted]).flatMap fun spectrum =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨input,molecule,transition,coupling,spectrum,identity,conditions,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk input molecule transition coupling spectrum identity conditions extra =>
    have hinput : input ∈ [Input.rejected,Input.admitted] := by
      cases input <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmolecule : molecule ∈ [Molecule.rejected,Molecule.admitted] := by
      cases molecule <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoupling : coupling ∈ [Coupling.rejected,Coupling.admitted] := by
      cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspectrum : spectrum ∈ [Spectrum.rejected,Spectrum.admitted] := by
      cases spectrum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ input _ hinput
    apply CommonRefinement.memFlatMap _ _ molecule _ hmolecule
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ coupling _ hcoupling
    apply CommonRefinement.memFlatMap _ _ spectrum _ hspectrum
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk input molecule transition coupling spectrum identity conditions extra =>
    cases input <;> cases molecule <;> cases transition <;> cases coupling <;> cases spectrum <;> cases identity <;> cases conditions <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk input molecule transition coupling spectrum identity conditions extra =>
    cases input <;> cases molecule <;> cases transition <;> cases coupling <;> cases spectrum <;> cases identity <;> cases conditions <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.input = .admitted ∧ c.molecule = .admitted ∧ c.transition = .admitted ∧ c.coupling = .admitted ∧ c.spectrum = .admitted ∧ c.identity = .admitted ∧ c.conditions = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk input molecule transition coupling spectrum identity conditions extra =>
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

theorem molecule_rejected_rejected (c : Candidate) (h : c.molecule = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.molecule eq
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

theorem coupling_rejected_rejected (c : Candidate) (h : c.coupling = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coupling eq
    rw [h] at field
    cases field

theorem spectrum_rejected_rejected (c : Candidate) (h : c.spectrum = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.spectrum eq
    rw [h] at field
    cases field

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
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

end SFT.Physics.InfraredGrammar
