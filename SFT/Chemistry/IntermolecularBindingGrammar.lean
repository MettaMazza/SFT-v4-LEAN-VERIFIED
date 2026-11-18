import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.IntermolecularBindingGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-binding-number-with-erased-components"
  | .admitted => "named-constituents-and-bound-composite-carrier"

inductive Separation where
  | rejected | admitted

def separationName : Separation → String
  | .rejected => "continuum-distance-or-imported-potential-coordinate"
  | .admitted => "finite-held-separation-organization"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "constituent-energies-erased-or-merged"
  | .admitted => "exact-positive-constituent-state-composition"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "signed-free-energy-or-negative-binding-number"
  | .admitted => "ordered-positive-separated-Take-bound"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "assume-every-generated-aggregate-is-bound"
  | .admitted => "strict-bound-order-or-structural-EmptyOne"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "binding-target-readable-before-seal"
  | .admitted => "value-free-complete-dimer-cluster-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "favorable-dimer-method-or-measurement-subset"
  | .admitted => "complete-computed-measured-adverse-and-scope-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "fitted-interaction-coefficient-or-species-correction"
  | .admitted => "one-state-order-law-with-depth-independent-constituent-extension"

structure Candidate where
  carrier : Carrier
  separation : Separation
  composition : Composition
  magnitude : Magnitude
  absence : Absence
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, separationName c.separation, compositionName c.composition, magnitudeName c.magnitude, absenceName c.absence, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "separation=" (separationName c.separation), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "named-constituents-and-bound-composite-carrier__finite-held-separation-organization__exact-positive-constituent-state-composition__ordered-positive-separated-Take-bound__strict-bound-order-or-structural-EmptyOne__value-free-complete-dimer-cluster-identity-seal__complete-computed-measured-adverse-and-scope-custody__one-state-order-law-with-depth-independent-constituent-extension"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "named-constituents-and-bound-composite-carrier" &&
  SFT.Host.Text.equal (separationName c.separation) "finite-held-separation-organization" &&
  SFT.Host.Text.equal (compositionName c.composition) "exact-positive-constituent-state-composition" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "ordered-positive-separated-Take-bound" &&
  SFT.Host.Text.equal (absenceName c.absence) "strict-bound-order-or-structural-EmptyOne" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-dimer-cluster-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-computed-measured-adverse-and-scope-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-state-order-law-with-depth-independent-constituent-extension"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "named-constituents-and-bound-composite-carrier") then "An answer-only magnitude cannot distinguish an intermolecular composite from an internal molecular state." else
  if !(SFT.Host.Text.equal (separationName c.separation) "finite-held-separation-organization") then "A continuum coordinate or potential surface imports an ungenerated mathematical model." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "exact-positive-constituent-state-composition") then "Erasing constituent states destroys the separated endpoint and prevents reconstruction." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "ordered-positive-separated-Take-bound") then "A signed answer leaves the positive Fold domain and obscures state order." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "strict-bound-order-or-structural-EmptyOne") then "A proximity or calculation label does not force a stable lower composite state." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-dimer-cluster-identity-seal") then "A readable binding value could select the law, source rows or an interaction coefficient." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-computed-measured-adverse-and-scope-custody") then "Selecting only positive or agreeing rows conceals adverse and unavailable source records." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-state-order-law-with-depth-independent-constituent-extension") then "A fitted coefficient or species residual lets the target choose the result." else
  "named-constituents-and-bound-composite-carrier__finite-held-separation-organization__exact-positive-constituent-state-composition__ordered-positive-separated-Take-bound__strict-bound-order-or-structural-EmptyOne__value-free-complete-dimer-cluster-identity-seal__complete-computed-measured-adverse-and-scope-custody__one-state-order-law-with-depth-independent-constituent-extension"

def generationRule : String := "Generate the literal product of carrier, separation, composition, magnitude, absence, prediction, record and extension forms; decide all 256 candidates from admitted exact state order, molecular identity, intermolecular support, path composition and target-custody laws."
def grammarBoundary : String := "The depth-independent exact state-order relation for every finite named constituent tuple, tested against all 11 official CCCBDB hydrogen-bonded dimers, all 1,297 linked method/basis value rows including every signed adverse inscription, two reported water-cluster dissociation values with uncertainty, and the preserved complete 62-page NIST ion-cluster thermochemistry scope record. Calculated, measured, unavailable and adverse evidence classes remain separate."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Separation.rejected,Separation.admitted]).flatMap fun separation =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,separation,composition,magnitude,absence,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier separation composition magnitude absence prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hseparation : separation ∈ [Separation.rejected,Separation.admitted] := by
      cases separation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnitude : magnitude ∈ [Magnitude.rejected,Magnitude.admitted] := by
      cases magnitude <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ separation _ hseparation
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ magnitude _ hmagnitude
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,absence,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,absence,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,absence,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,absence,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,absence,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,absence,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,absence,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,absence,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,absence,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,absence,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,absence,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,absence,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,absence,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,absence,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,absence,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (absence : Absence) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,absence,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,absence,prediction,record,extension⟩ := by
 cases absence <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier separation composition magnitude absence prediction record extension =>
  cases carrier <;> cases separation <;> cases composition <;> cases magnitude
  · exact sourceDecisionBlock0000 absence prediction record extension
  · exact sourceDecisionBlock0001 absence prediction record extension
  · exact sourceDecisionBlock0010 absence prediction record extension
  · exact sourceDecisionBlock0011 absence prediction record extension
  · exact sourceDecisionBlock0100 absence prediction record extension
  · exact sourceDecisionBlock0101 absence prediction record extension
  · exact sourceDecisionBlock0110 absence prediction record extension
  · exact sourceDecisionBlock0111 absence prediction record extension
  · exact sourceDecisionBlock1000 absence prediction record extension
  · exact sourceDecisionBlock1001 absence prediction record extension
  · exact sourceDecisionBlock1010 absence prediction record extension
  · exact sourceDecisionBlock1011 absence prediction record extension
  · exact sourceDecisionBlock1100 absence prediction record extension
  · exact sourceDecisionBlock1101 absence prediction record extension
  · exact sourceDecisionBlock1110 absence prediction record extension
  · exact sourceDecisionBlock1111 absence prediction record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "named-constituents-and-bound-composite-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem separationCriterion (value : Separation) : SFT.Host.Text.equal (separationName value) "finite-held-separation-organization" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "exact-positive-constituent-state-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "ordered-positive-separated-Take-bound" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "strict-bound-order-or-structural-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-complete-dimer-cluster-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-computed-measured-adverse-and-scope-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "one-state-order-law-with-depth-independent-constituent-extension" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, separationCriterion, compositionCriterion, magnitudeCriterion, absenceCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier separation composition magnitude absence prediction record extension =>
    cases carrier <;> cases separation <;> cases composition <;> cases magnitude <;> cases absence <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.separation = .admitted ∧ c.composition = .admitted ∧ c.magnitude = .admitted ∧ c.absence = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier separation composition magnitude absence prediction record extension =>
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

theorem separation_rejected_rejected (c : Candidate) (h : c.separation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.separation eq
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

theorem magnitude_rejected_rejected (c : Candidate) (h : c.magnitude = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.magnitude eq
    rw [h] at field
    cases field

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.IntermolecularBindingGrammar
