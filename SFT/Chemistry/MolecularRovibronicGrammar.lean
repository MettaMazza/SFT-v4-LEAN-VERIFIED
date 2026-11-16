import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularRovibronicGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "detached-state-name"
  | .admitted => "identified-molecular-state-carrier"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "nuclei-or-electrons-erased"
  | .admitted => "nuclear-electronic-joint-support"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "imported-separation-approximation"
  | .admitted => "admitted-electronic-vibrational-rotational-order"

inductive Vibration where
  | rejected | admitted

def vibrationName : Vibration → String
  | .rejected => "continuum-vibrational-coordinate"
  | .admitted => "positive-odd-vibrational-recurrence"

inductive Rotation where
  | rejected | admitted

def rotationName : Rotation → String
  | .rejected => "signed-or-continuum-rotation"
  | .admitted => "positive-counted-rotational-recurrence"

inductive Spin where
  | rejected | admitted

def spinName : Spin → String
  | .rejected => "spin-erased-state"
  | .admitted => "held-spin-state"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "result-without-readout-record"
  | .admitted => "retained-rovibronic-observation"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-species-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  composition : Composition
  scale : Scale
  vibration : Vibration
  rotation : Rotation
  spin : Spin
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, compositionName c.composition, scaleName c.scale, vibrationName c.vibration, rotationName c.rotation, spinName c.spin, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "vibration=" (vibrationName c.vibration), SFT.Host.Text.append "rotation=" (rotationName c.rotation), SFT.Host.Text.append "spin=" (spinName c.spin), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "identified-molecular-state-carrier__nuclear-electronic-joint-support__admitted-electronic-vibrational-rotational-order__positive-odd-vibrational-recurrence__positive-counted-rotational-recurrence__held-spin-state__retained-rovibronic-observation__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "identified-molecular-state-carrier" &&
  SFT.Host.Text.equal (compositionName c.composition) "nuclear-electronic-joint-support" &&
  SFT.Host.Text.equal (scaleName c.scale) "admitted-electronic-vibrational-rotational-order" &&
  SFT.Host.Text.equal (vibrationName c.vibration) "positive-odd-vibrational-recurrence" &&
  SFT.Host.Text.equal (rotationName c.rotation) "positive-counted-rotational-recurrence" &&
  SFT.Host.Text.equal (spinName c.spin) "held-spin-state" &&
  SFT.Host.Text.equal (observationName c.observation) "retained-rovibronic-observation" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "identified-molecular-state-carrier") then "A detached name cannot identify the molecular whole carrying the state." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "nuclear-electronic-joint-support") then "Erasing either support merges distinguishable isotopologues or electronic states." else
  if !(SFT.Host.Text.equal (scaleName c.scale) "admitted-electronic-vibrational-rotational-order") then "An imported approximation cannot select a fundamental state organization." else
  if !(SFT.Host.Text.equal (vibrationName c.vibration) "positive-odd-vibrational-recurrence") then "A continuum coordinate is outside the exact generated grammar." else
  if !(SFT.Host.Text.equal (rotationName c.rotation) "positive-counted-rotational-recurrence") then "A signed continuum angle is not an exact proof carrier." else
  if !(SFT.Host.Text.equal (spinName c.spin) "held-spin-state") then "Erasing spin merges spectroscopically distinguishable molecular states." else
  if !(SFT.Host.Text.equal (observationName c.observation) "retained-rovibronic-observation") then "A state without a readout boundary cannot be reproduced or distinguished." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A species exception can fit any desired spectrum." else
  "identified-molecular-state-carrier__nuclear-electronic-joint-support__admitted-electronic-vibrational-rotational-order__positive-odd-vibrational-recurrence__positive-counted-rotational-recurrence__held-spin-state__retained-rovibronic-observation__no-extra-rule"

def generationRule : String := "Generate the literal eight-axis product of carrier, nuclear-electronic composition, scale order, vibrational recurrence, rotational recurrence, held spin, observation and extension forms; decide every form by preservation of the admitted dependency chain."
def grammarBoundary : String := "Every positive-finite molecular electronic carrier with positive-finite retained nuclei, isotope labels, positive vibration and rotation ordinals, held spin and a declared finite observation resolution."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Vibration.rejected,Vibration.admitted]).flatMap fun vibration =>
  ([Rotation.rejected,Rotation.admitted]).flatMap fun rotation =>
  ([Spin.rejected,Spin.admitted]).flatMap fun spin =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,composition,scale,vibration,rotation,spin,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier composition scale vibration rotation spin observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvibration : vibration ∈ [Vibration.rejected,Vibration.admitted] := by
      cases vibration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrotation : rotation ∈ [Rotation.rejected,Rotation.admitted] := by
      cases rotation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspin : spin ∈ [Spin.rejected,Spin.admitted] := by
      cases spin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ vibration _ hvibration
    apply CommonRefinement.memFlatMap _ _ rotation _ hrotation
    apply CommonRefinement.memFlatMap _ _ spin _ hspin
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier composition scale vibration rotation spin observation extension =>
    cases carrier <;> cases composition <;> cases scale <;> cases vibration <;> cases rotation <;> cases spin <;> cases observation <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier composition scale vibration rotation spin observation extension =>
    cases carrier <;> cases composition <;> cases scale <;> cases vibration <;> cases rotation <;> cases spin <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.composition = .admitted ∧ c.scale = .admitted ∧ c.vibration = .admitted ∧ c.rotation = .admitted ∧ c.spin = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier composition scale vibration rotation spin observation extension =>
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem scale_rejected_rejected (c : Candidate) (h : c.scale = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scale eq
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

theorem rotation_rejected_rejected (c : Candidate) (h : c.rotation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rotation eq
    rw [h] at field
    cases field

theorem spin_rejected_rejected (c : Candidate) (h : c.spin = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.spin eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.MolecularRovibronicGrammar
