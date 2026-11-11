import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RotVibGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "point-label-only"
  | .admitted => "complete-molecular-geometry-held"

inductive Rotation where
  | rejected | admitted

def rotationName : Rotation → String
  | .rejected => "orientation-history-erased"
  | .admitted => "rotational-state-classes-held"

inductive Vibration where
  | rejected | admitted

def vibrationName : Vibration → String
  | .rejected => "relative-displacement-erased"
  | .admitted => "vibrational-state-classes-held"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "motions-collapsed-together"
  | .admitted => "rotational-vibrational-composition"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "states-without-transition-map"
  | .admitted => "allowed-state-transition-trace"

inductive Spectrum where
  | rejected | admitted

def spectrumName : Spectrum → String
  | .rejected => "one-frequency-only"
  | .admitted => "complete-transition-frequency-pattern"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "universal-spectrum"
  | .admitted => "state-method-condition-boundary"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-rotor-oscillator-equation"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  rotation : Rotation
  vibration : Vibration
  composition : Composition
  transition : Transition
  spectrum : Spectrum
  conditions : Conditions
  extra : Extra

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, rotationName c.rotation, vibrationName c.vibration, compositionName c.composition, transitionName c.transition, spectrumName c.spectrum, conditionsName c.conditions, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "rotation=" (rotationName c.rotation), SFT.Host.Text.append "vibration=" (vibrationName c.vibration), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "spectrum=" (spectrumName c.spectrum), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "complete-molecular-geometry-held__rotational-state-classes-held__vibrational-state-classes-held__rotational-vibrational-composition__allowed-state-transition-trace__complete-transition-frequency-pattern__state-method-condition-boundary__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-molecular-geometry-held" &&
  SFT.Host.Text.equal (rotationName c.rotation) "rotational-state-classes-held" &&
  SFT.Host.Text.equal (vibrationName c.vibration) "vibrational-state-classes-held" &&
  SFT.Host.Text.equal (compositionName c.composition) "rotational-vibrational-composition" &&
  SFT.Host.Text.equal (transitionName c.transition) "allowed-state-transition-trace" &&
  SFT.Host.Text.equal (spectrumName c.spectrum) "complete-transition-frequency-pattern" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "state-method-condition-boundary" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-molecular-geometry-held") then "Internal molecular motion is absent." else
  if !(SFT.Host.Text.equal (rotationName c.rotation) "rotational-state-classes-held") then "Rotational recurrence cannot be distinguished." else
  if !(SFT.Host.Text.equal (vibrationName c.vibration) "vibrational-state-classes-held") then "Vibrational recurrence cannot be distinguished." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "rotational-vibrational-composition") then "Joint spectral structure is lost." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "allowed-state-transition-trace") then "No spectral event is generated." else
  if !(SFT.Host.Text.equal (spectrumName c.spectrum) "complete-transition-frequency-pattern") then "Resolved organization is erased." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "state-method-condition-boundary") then "Population and resolution are bounded." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "An imported model can select the spectrum." else
  "complete-molecular-geometry-held__rotational-state-classes-held__vibrational-state-classes-held__rotational-vibrational-composition__allowed-state-transition-trace"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete distinction preservation, exact recurrence/equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite molecular geometry with generated rotational and vibrational recurrence classes, paired transitions and declared observation support."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Rotation.rejected,Rotation.admitted]).flatMap fun rotation =>
  ([Vibration.rejected,Vibration.admitted]).flatMap fun vibration =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Spectrum.rejected,Spectrum.admitted]).flatMap fun spectrum =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨carrier,rotation,vibration,composition,transition,spectrum,conditions,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier rotation vibration composition transition spectrum conditions extra =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrotation : rotation ∈ [Rotation.rejected,Rotation.admitted] := by
      cases rotation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvibration : vibration ∈ [Vibration.rejected,Vibration.admitted] := by
      cases vibration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspectrum : spectrum ∈ [Spectrum.rejected,Spectrum.admitted] := by
      cases spectrum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ rotation _ hrotation
    apply CommonRefinement.memFlatMap _ _ vibration _ hvibration
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ spectrum _ hspectrum
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier rotation vibration composition transition spectrum conditions extra =>
    cases carrier <;> cases rotation <;> cases vibration <;> cases composition <;> cases transition <;> cases spectrum <;> cases conditions <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier rotation vibration composition transition spectrum conditions extra =>
    cases carrier <;> cases rotation <;> cases vibration <;> cases composition <;> cases transition <;> cases spectrum <;> cases conditions <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.rotation = .admitted ∧ c.vibration = .admitted ∧ c.composition = .admitted ∧ c.transition = .admitted ∧ c.spectrum = .admitted ∧ c.conditions = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier rotation vibration composition transition spectrum conditions extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem rotation_rejected_rejected (c : Candidate) (h : c.rotation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rotation eq
    rw [h] at field
    cases field

theorem vibration_rejected_rejected (c : Candidate) (h : c.vibration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.vibration eq
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

theorem transition_rejected_rejected (c : Candidate) (h : c.transition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transition eq
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

end SFT.Chemistry.RotVibGrammar
