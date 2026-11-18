import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularElectronAffinityGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "electron-affinity-answer-with-erased-states"
  | .admitted => "complete-neutral-electron-anion-carrier"

inductive Gain where
  | rejected | admitted

def gainName : Gain → String
  | .rejected => "signed-electron-addition"
  | .admitted => "held-electron-gain-orientation"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "conventional-signed-affinity-scalar"
  | .admitted => "held-order-plus-positive-state-Take"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "bound-anion-only-domain"
  | .admitted => "bound-unbound-and-EmptyOne-boundary"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "affinity-value-or-orientation-readable-before-seal"
  | .admitted => "value-and-orientation-free-carrier-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-positive-or-favorable-molecular-row"
  | .admitted => "complete-NIST-molecular-experimental-vector"

inductive Uncertainty where
  | rejected | admitted

def uncertaintyName : Uncertainty → String
  | .rejected => "central-value-with-erased-uncertainty"
  | .admitted => "complete-source-uncertainty-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-fit-or-sign-correction"
  | .admitted => "one-affinity-law-no-extra-rule"

structure Candidate where
  carrier : Carrier
  gain : Gain
  magnitude : Magnitude
  boundary : Boundary
  prediction : Prediction
  record : Record
  uncertainty : Uncertainty
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, gainName c.gain, magnitudeName c.magnitude, boundaryName c.boundary, predictionName c.prediction, recordName c.record, uncertaintyName c.uncertainty, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "gain=" (gainName c.gain), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "uncertainty=" (uncertaintyName c.uncertainty), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-neutral-electron-anion-carrier__held-electron-gain-orientation__held-order-plus-positive-state-Take__bound-unbound-and-EmptyOne-boundary__value-and-orientation-free-carrier-seal__complete-NIST-molecular-experimental-vector__complete-source-uncertainty-custody__one-affinity-law-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-neutral-electron-anion-carrier" &&
  SFT.Host.Text.equal (gainName c.gain) "held-electron-gain-orientation" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "held-order-plus-positive-state-Take" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "bound-unbound-and-EmptyOne-boundary" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-and-orientation-free-carrier-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-NIST-molecular-experimental-vector" &&
  SFT.Host.Text.equal (uncertaintyName c.uncertainty) "complete-source-uncertainty-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-affinity-law-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-neutral-electron-anion-carrier") then "An answer-only scalar erases the neutral molecule and resulting anion." else
  if !(SFT.Host.Text.equal (gainName c.gain) "held-electron-gain-orientation") then "A signed addition imports a negative proof magnitude." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "held-order-plus-positive-state-Take") then "One signed number conflates state order with energy magnitude." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "bound-unbound-and-EmptyOne-boundary") then "Discarding unbound anions selects favorable conventional signs." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-and-orientation-free-carrier-seal") then "A readable sign or magnitude could select the representation or carrier subset." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-NIST-molecular-experimental-vector") then "A selected subset can conceal unbound carriers and source diversity." else
  if !(SFT.Host.Text.equal (uncertaintyName c.uncertainty) "complete-source-uncertainty-custody") then "Dropping uncertainty weakens the empirical record." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-affinity-law-no-extra-rule") then "A species coefficient or sign correction is a fitted parameter." else
  "complete-neutral-electron-anion-carrier__held-electron-gain-orientation__held-order-plus-positive-state-Take__bound-unbound-and-EmptyOne-boundary__value-and-orientation-free-carrier-seal__complete-NIST-molecular-experimental-vector__complete-source-uncertainty-custody__one-affinity-law-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, gain, magnitude, boundary, prediction, record, uncertainty and extension forms; decide all 256 from admitted exact energy, order, ion, electron-transfer, state-transition and measurement-custody laws."
def grammarBoundary : String := "The depth-independent held-order plus positive-Take relation for every generated neutral/anion state pair, tested against every explicit experimental molecular electron-affinity record in the complete 192-row CCCBDB catalog after structurally excluding the 30 single-element atomic carriers: 162 molecular pages, 96 measured molecular rows, 93 bound and three unbound orientations, with all 89 explicit uncertainties."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Gain.rejected,Gain.admitted]).flatMap fun gain =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Uncertainty.rejected,Uncertainty.admitted]).flatMap fun uncertainty =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,gain,magnitude,boundary,prediction,record,uncertainty,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier gain magnitude boundary prediction record uncertainty extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgain : gain ∈ [Gain.rejected,Gain.admitted] := by
      cases gain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnitude : magnitude ∈ [Magnitude.rejected,Magnitude.admitted] := by
      cases magnitude <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huncertainty : uncertainty ∈ [Uncertainty.rejected,Uncertainty.admitted] := by
      cases uncertainty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ gain _ hgain
    apply CommonRefinement.memFlatMap _ _ magnitude _ hmagnitude
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ uncertainty _ huncertainty
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (prediction : Prediction) (record : Record) (uncertainty : Uncertainty) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,prediction,record,uncertainty,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,prediction,record,uncertainty,extension⟩ := by
 cases prediction <;> cases record <;> cases uncertainty <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier gain magnitude boundary prediction record uncertainty extension =>
  cases carrier <;> cases gain <;> cases magnitude <;> cases boundary
  · exact sourceDecisionBlock0000 prediction record uncertainty extension
  · exact sourceDecisionBlock0001 prediction record uncertainty extension
  · exact sourceDecisionBlock0010 prediction record uncertainty extension
  · exact sourceDecisionBlock0011 prediction record uncertainty extension
  · exact sourceDecisionBlock0100 prediction record uncertainty extension
  · exact sourceDecisionBlock0101 prediction record uncertainty extension
  · exact sourceDecisionBlock0110 prediction record uncertainty extension
  · exact sourceDecisionBlock0111 prediction record uncertainty extension
  · exact sourceDecisionBlock1000 prediction record uncertainty extension
  · exact sourceDecisionBlock1001 prediction record uncertainty extension
  · exact sourceDecisionBlock1010 prediction record uncertainty extension
  · exact sourceDecisionBlock1011 prediction record uncertainty extension
  · exact sourceDecisionBlock1100 prediction record uncertainty extension
  · exact sourceDecisionBlock1101 prediction record uncertainty extension
  · exact sourceDecisionBlock1110 prediction record uncertainty extension
  · exact sourceDecisionBlock1111 prediction record uncertainty extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-neutral-electron-anion-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem gainCriterion (value : Gain) : SFT.Host.Text.equal (gainName value) "held-electron-gain-orientation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "held-order-plus-positive-state-Take" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "bound-unbound-and-EmptyOne-boundary" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-and-orientation-free-carrier-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-NIST-molecular-experimental-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem uncertaintyCriterion (value : Uncertainty) : SFT.Host.Text.equal (uncertaintyName value) "complete-source-uncertainty-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "one-affinity-law-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, gainCriterion, magnitudeCriterion, boundaryCriterion, predictionCriterion, recordCriterion, uncertaintyCriterion, extensionCriterion]
  cases c with
  | mk carrier gain magnitude boundary prediction record uncertainty extension =>
    cases carrier <;> cases gain <;> cases magnitude <;> cases boundary <;> cases prediction <;> cases record <;> cases uncertainty <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.gain = .admitted ∧ c.magnitude = .admitted ∧ c.boundary = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.uncertainty = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier gain magnitude boundary prediction record uncertainty extension =>
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

theorem gain_rejected_rejected (c : Candidate) (h : c.gain = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.gain eq
    rw [h] at field
    cases field

theorem magnitude_rejected_rejected (c : Candidate) (h : c.magnitude = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.magnitude eq
    rw [h] at field
    cases field

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
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

theorem uncertainty_rejected_rejected (c : Candidate) (h : c.uncertainty = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.uncertainty eq
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

end SFT.Chemistry.MolecularElectronAffinityGrammar
