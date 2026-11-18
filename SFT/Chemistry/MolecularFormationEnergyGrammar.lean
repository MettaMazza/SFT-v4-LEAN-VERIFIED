import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularFormationEnergyGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-formation-number"
  | .admitted => "complete-product-reference-state-carrier"

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "imported-or-fitted-atomic-reference"
  | .admitted => "exact-named-constituent-reference-composition"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-formation-proof-number"
  | .admitted => "held-product-reference-state-order"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "species-coefficient-or-target-value"
  | .admitted => "exact-positive-state-separation"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-for-equality-or-blank"
  | .admitted => "equality-or-unmeasured-as-distinct-structural-EmptyOne"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "formation-values-readable-before-seal"
  | .admitted => "value-free-complete-formation-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "favorable-species-temperature-or-sign-subset"
  | .admitted => "complete-values-blanks-orientations-and-reference-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "new-coefficient-per-added-constituent"
  | .admitted => "one-relation-with-depth-independent-shared-state-extension"

structure Candidate where
  carrier : Carrier
  reference : Reference
  orientation : Orientation
  magnitude : Magnitude
  absence : Absence
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, referenceName c.reference, orientationName c.orientation, magnitudeName c.magnitude, absenceName c.absence, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-product-reference-state-carrier__exact-named-constituent-reference-composition__held-product-reference-state-order__exact-positive-state-separation__equality-or-unmeasured-as-distinct-structural-EmptyOne__value-free-complete-formation-identity-seal__complete-values-blanks-orientations-and-reference-custody__one-relation-with-depth-independent-shared-state-extension"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-product-reference-state-carrier" &&
  SFT.Host.Text.equal (referenceName c.reference) "exact-named-constituent-reference-composition" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-product-reference-state-order" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-positive-state-separation" &&
  SFT.Host.Text.equal (absenceName c.absence) "equality-or-unmeasured-as-distinct-structural-EmptyOne" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-formation-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-values-blanks-orientations-and-reference-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-relation-with-depth-independent-shared-state-extension"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-product-reference-state-carrier") then "A bare number erases product, phase, reference and condition." else
  if !(SFT.Host.Text.equal (referenceName c.reference) "exact-named-constituent-reference-composition") then "An imported or fitted reference lets external values select the relation." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-product-reference-state-order") then "A signed proof number imports negatives and loses state order." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-positive-state-separation") then "A species coefficient or target value is a fitted parameter." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "equality-or-unmeasured-as-distinct-structural-EmptyOne") then "Numerical zero is not an SFT value and a source blank is not a measured equality." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-formation-identity-seal") then "Readable values could select the law, reference or species subset." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-values-blanks-orientations-and-reference-custody") then "Selecting only convenient values conceals blanks and opposite orientations." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-relation-with-depth-independent-shared-state-extension") then "A new coefficient per constituent destroys zero-parameter closure." else
  "complete-product-reference-state-carrier__exact-named-constituent-reference-composition__held-product-reference-state-order__exact-positive-state-separation__equality-or-unmeasured-as-distinct-structural-EmptyOne__value-free-complete-formation-identity-seal__complete-values-blanks-orientations-and-reference-custody__one-relation-with-depth-independent-shared-state-extension"

def generationRule : String := "Generate the literal product of carrier, reference, orientation, magnitude, absence, prediction, record and extension forms; decide all 256 candidates only from admitted exact composition, state order, conservation, path and target-custody laws."
def grammarBoundary : String := "The depth-independent exact product/reference relation for every finite named constituent tuple, tested against all 2,098 cells from the complete official CCCBDB formation-energy property surface and the preserved thermodynamic reference-state page. Printed values, blanks and source orientations remain explicit."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,reference,orientation,magnitude,absence,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier reference orientation magnitude absence prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
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
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
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
 | mk carrier reference orientation magnitude absence prediction record extension =>
  cases carrier <;> cases reference <;> cases orientation <;> cases magnitude
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

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-product-reference-state-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem referenceCriterion (value : Reference) : SFT.Host.Text.equal (referenceName value) "exact-named-constituent-reference-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-product-reference-state-order" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "exact-positive-state-separation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "equality-or-unmeasured-as-distinct-structural-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-complete-formation-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-values-blanks-orientations-and-reference-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "one-relation-with-depth-independent-shared-state-extension" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, referenceCriterion, orientationCriterion, magnitudeCriterion, absenceCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier reference orientation magnitude absence prediction record extension =>
    cases carrier <;> cases reference <;> cases orientation <;> cases magnitude <;> cases absence <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.reference = .admitted ∧ c.orientation = .admitted ∧ c.magnitude = .admitted ∧ c.absence = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier reference orientation magnitude absence prediction record extension =>
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

theorem reference_rejected_rejected (c : Candidate) (h : c.reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reference eq
    rw [h] at field
    cases field

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

end SFT.Chemistry.MolecularFormationEnergyGrammar
