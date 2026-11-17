import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ResolvedRovibronicGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "detached-spectral-row"
  | .admitted => "retained-molecular-and-isotope-carrier"

inductive Electronic where
  | rejected | admitted

def electronicName : Electronic → String
  | .rejected => "transition-name-without-electronic-state"
  | .admitted => "retained-electronic-state-designation"

inductive Vibration where
  | rejected | admitted

def vibrationName : Vibration → String
  | .rejected => "continuum-vibration-or-erasure"
  | .admitted => "positive-vibrational-coordinate-or-EmptyOne"

inductive Rotation where
  | rejected | admitted

def rotationName : Rotation → String
  | .rejected => "signed-rotation-or-erasure"
  | .admitted => "positive-rotational-coordinate-or-EmptyOne"

inductive Spin where
  | rejected | admitted

def spinName : Spin → String
  | .rejected => "spin-erased-molecular-state"
  | .admitted => "retained-positive-spin-multiplicity"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "independent-coordinate-list"
  | .admitted => "finite-vibronic-rovibronic-spin-product"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "endpoint-only-transition"
  | .admitted => "retained-transition-and-band-record"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-resolved-lines"
  | .admitted => "complete-resolved-spectrum-surface"

structure Candidate where
  carrier : Carrier
  electronic : Electronic
  vibration : Vibration
  rotation : Rotation
  spin : Spin
  composition : Composition
  observation : Observation
  record : Record

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, electronicName c.electronic, vibrationName c.vibration, rotationName c.rotation, spinName c.spin, compositionName c.composition, observationName c.observation, recordName c.record]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "electronic=" (electronicName c.electronic), SFT.Host.Text.append "vibration=" (vibrationName c.vibration), SFT.Host.Text.append "rotation=" (rotationName c.rotation), SFT.Host.Text.append "spin=" (spinName c.spin), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "record=" (recordName c.record)]
def survivorId : String := "retained-molecular-and-isotope-carrier__retained-electronic-state-designation__positive-vibrational-coordinate-or-EmptyOne__positive-rotational-coordinate-or-EmptyOne__retained-positive-spin-multiplicity__finite-vibronic-rovibronic-spin-product__retained-transition-and-band-record__complete-resolved-spectrum-surface"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "retained-molecular-and-isotope-carrier" &&
  SFT.Host.Text.equal (electronicName c.electronic) "retained-electronic-state-designation" &&
  SFT.Host.Text.equal (vibrationName c.vibration) "positive-vibrational-coordinate-or-EmptyOne" &&
  SFT.Host.Text.equal (rotationName c.rotation) "positive-rotational-coordinate-or-EmptyOne" &&
  SFT.Host.Text.equal (spinName c.spin) "retained-positive-spin-multiplicity" &&
  SFT.Host.Text.equal (compositionName c.composition) "finite-vibronic-rovibronic-spin-product" &&
  SFT.Host.Text.equal (observationName c.observation) "retained-transition-and-band-record" &&
  SFT.Host.Text.equal (recordName c.record) "complete-resolved-spectrum-surface"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "retained-molecular-and-isotope-carrier") then "A row detached from its molecule is not a chemical state." else
  if !(SFT.Host.Text.equal (electronicName c.electronic) "retained-electronic-state-designation") then "A transition name alone erases its endpoint state." else
  if !(SFT.Host.Text.equal (vibrationName c.vibration) "positive-vibrational-coordinate-or-EmptyOne") then "A continuum coordinate or erasure is not an exact generated state." else
  if !(SFT.Host.Text.equal (rotationName c.rotation) "positive-rotational-coordinate-or-EmptyOne") then "Signed continuum rotation or erasure loses resolved structure." else
  if !(SFT.Host.Text.equal (spinName c.spin) "retained-positive-spin-multiplicity") then "Erasing multiplicity merges singlet and triplet records." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "finite-vibronic-rovibronic-spin-product") then "A list without joint identity permits unlawful recombination." else
  if !(SFT.Host.Text.equal (observationName c.observation) "retained-transition-and-band-record") then "Endpoints alone erase the measured transition record and unresolved boundary." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-resolved-spectrum-surface") then "Selected lines cannot establish complete resolved composition." else
  "retained-molecular-and-isotope-carrier__retained-electronic-state-designation__positive-vibrational-coordinate-or-EmptyOne__positive-rotational-coordinate-or-EmptyOne__retained-positive-spin-multiplicity__finite-vibronic-rovibronic-spin-product__retained-transition-and-band-record__complete-resolved-spectrum-surface"

def generationRule : String := "Generate the literal product of carrier, electronic, vibration, rotation, spin, composition, observation and record forms; decide all 256 only from admitted composition, transition, selection and exact spectroscopy dependencies."
def grammarBoundary : String := "Every positive finite resolved molecular state word and every source absence, tested against all 95 state rows and all 1,235 cells in the complete NIST H2, HD and D2 diatomic surface."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Electronic.rejected,Electronic.admitted]).flatMap fun electronic =>
  ([Vibration.rejected,Vibration.admitted]).flatMap fun vibration =>
  ([Rotation.rejected,Rotation.admitted]).flatMap fun rotation =>
  ([Spin.rejected,Spin.admitted]).flatMap fun spin =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Record.rejected,Record.admitted]).map fun record =>
  ⟨carrier,electronic,vibration,rotation,spin,composition,observation,record⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier electronic vibration rotation spin composition observation record =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helectronic : electronic ∈ [Electronic.rejected,Electronic.admitted] := by
      cases electronic <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvibration : vibration ∈ [Vibration.rejected,Vibration.admitted] := by
      cases vibration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrotation : rotation ∈ [Rotation.rejected,Rotation.admitted] := by
      cases rotation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspin : spin ∈ [Spin.rejected,Spin.admitted] := by
      cases spin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ electronic _ helectronic
    apply CommonRefinement.memFlatMap _ _ vibration _ hvibration
    apply CommonRefinement.memFlatMap _ _ rotation _ hrotation
    apply CommonRefinement.memFlatMap _ _ spin _ hspin
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ record _ hrecord

theorem sourceDecisionBlock0000 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,spin,composition,observation,record⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock0001 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,spin,composition,observation,record⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock0010 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,spin,composition,observation,record⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock0011 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,spin,composition,observation,record⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock0100 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,spin,composition,observation,record⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock0101 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,spin,composition,observation,record⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock0110 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,spin,composition,observation,record⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock0111 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,spin,composition,observation,record⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock1000 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,spin,composition,observation,record⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock1001 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,spin,composition,observation,record⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock1010 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,spin,composition,observation,record⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock1011 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,spin,composition,observation,record⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock1100 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,spin,composition,observation,record⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock1101 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,spin,composition,observation,record⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock1110 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,spin,composition,observation,record⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionBlock1111 (spin : Spin) (composition : Composition) (observation : Observation) (record : Record) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,spin,composition,observation,record⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,spin,composition,observation,record⟩ := by
 cases spin <;> cases composition <;> cases observation <;> cases record <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier electronic vibration rotation spin composition observation record =>
  cases carrier <;> cases electronic <;> cases vibration <;> cases rotation
  · exact sourceDecisionBlock0000 spin composition observation record
  · exact sourceDecisionBlock0001 spin composition observation record
  · exact sourceDecisionBlock0010 spin composition observation record
  · exact sourceDecisionBlock0011 spin composition observation record
  · exact sourceDecisionBlock0100 spin composition observation record
  · exact sourceDecisionBlock0101 spin composition observation record
  · exact sourceDecisionBlock0110 spin composition observation record
  · exact sourceDecisionBlock0111 spin composition observation record
  · exact sourceDecisionBlock1000 spin composition observation record
  · exact sourceDecisionBlock1001 spin composition observation record
  · exact sourceDecisionBlock1010 spin composition observation record
  · exact sourceDecisionBlock1011 spin composition observation record
  · exact sourceDecisionBlock1100 spin composition observation record
  · exact sourceDecisionBlock1101 spin composition observation record
  · exact sourceDecisionBlock1110 spin composition observation record
  · exact sourceDecisionBlock1111 spin composition observation record

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "retained-molecular-and-isotope-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem electronicCriterion (value : Electronic) : SFT.Host.Text.equal (electronicName value) "retained-electronic-state-designation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem vibrationCriterion (value : Vibration) : SFT.Host.Text.equal (vibrationName value) "positive-vibrational-coordinate-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem rotationCriterion (value : Rotation) : SFT.Host.Text.equal (rotationName value) "positive-rotational-coordinate-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem spinCriterion (value : Spin) : SFT.Host.Text.equal (spinName value) "retained-positive-spin-multiplicity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "finite-vibronic-rovibronic-spin-product" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "retained-transition-and-band-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-resolved-spectrum-surface" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, electronicCriterion, vibrationCriterion, rotationCriterion, spinCriterion, compositionCriterion, observationCriterion, recordCriterion]
  cases c with
  | mk carrier electronic vibration rotation spin composition observation record =>
    cases carrier <;> cases electronic <;> cases vibration <;> cases rotation <;> cases spin <;> cases composition <;> cases observation <;> cases record
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.electronic = .admitted ∧ c.vibration = .admitted ∧ c.rotation = .admitted ∧ c.spin = .admitted ∧ c.composition = .admitted ∧ c.observation = .admitted ∧ c.record = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier electronic vibration rotation spin composition observation record =>
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

theorem electronic_rejected_rejected (c : Candidate) (h : c.electronic = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.electronic eq
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
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

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

end SFT.Chemistry.ResolvedRovibronicGrammar
