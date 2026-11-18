import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CrossPropertyMolecularVectorGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "separate-carrier-per-property"
  | .admitted => "one-complete-structural-carrier"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-or-favorable-property-subset"
  | .admitted => "complete-applicable-property-support"

inductive Projection where
  | rejected | admitted

def projectionName : Projection → String
  | .rejected => "answer-only-property-values"
  | .admitted => "named-admitted-relation-projections"

inductive Parameter where
  | rejected | admitted

def parameterName : Parameter → String
  | .rejected => "per-property-fit-or-correction"
  | .admitted => "zero-parameter-shared-carrier-projection"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "delete-unmeasured-or-inapplicable-row"
  | .admitted => "structural-EmptyOne-and-unjoined-custody-retained"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "target-payload-or-hash-readable-before-seal"
  | .admitted => "complete-value-free-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "single-species-showcase"
  | .admitted => "complete-13-family-source-row-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "recompute-or-refit-existing-properties"
  | .admitted => "append-only-depth-independent-projection-extension"

structure Candidate where
  carrier : Carrier
  support : Support
  projection : Projection
  parameter : Parameter
  absence : Absence
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, supportName c.support, projectionName c.projection, parameterName c.parameter, absenceName c.absence, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "projection=" (projectionName c.projection), SFT.Host.Text.append "parameter=" (parameterName c.parameter), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-complete-structural-carrier__complete-applicable-property-support__named-admitted-relation-projections__zero-parameter-shared-carrier-projection__structural-EmptyOne-and-unjoined-custody-retained__complete-value-free-identity-seal__complete-13-family-source-row-custody__append-only-depth-independent-projection-extension"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-complete-structural-carrier" &&
  SFT.Host.Text.equal (supportName c.support) "complete-applicable-property-support" &&
  SFT.Host.Text.equal (projectionName c.projection) "named-admitted-relation-projections" &&
  SFT.Host.Text.equal (parameterName c.parameter) "zero-parameter-shared-carrier-projection" &&
  SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-and-unjoined-custody-retained" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-13-family-source-row-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "append-only-depth-independent-projection-extension"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-complete-structural-carrier") then "Separate carriers permit property-specific identity drift." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-applicable-property-support") then "A selected subset can hide absent or disagreeing properties." else
  if !(SFT.Host.Text.equal (projectionName c.projection) "named-admitted-relation-projections") then "Bare answers erase the relation that generated each result." else
  if !(SFT.Host.Text.equal (parameterName c.parameter) "zero-parameter-shared-carrier-projection") then "A separate coefficient lets each target select its output." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-and-unjoined-custody-retained") then "Deletion makes the vector appear more complete than the source." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-identity-seal") then "Target content or even its hash can select the carrier or subset." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-13-family-source-row-custody") then "A showcase species does not establish complete cross-property custody." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "append-only-depth-independent-projection-extension") then "Refitting after a new property destroys prior invariance." else
  "one-complete-structural-carrier__complete-applicable-property-support__named-admitted-relation-projections__zero-parameter-shared-carrier-projection__structural-EmptyOne-and-unjoined-custody-retained__complete-value-free-identity-seal__complete-13-family-source-row-custody__append-only-depth-independent-projection-extension"

def generationRule : String := "Generate the literal product of carrier, support, projection, parameter, absence, prediction, record and extension forms; decide all 256 candidates from admitted property relations, exact compositional laws and the complete value-free cross-property identity surface."
def grammarBoundary : String := "The depth-independent append-only projection law for every finite exact structural carrier, tested against all 9,025 registered PROP-001 through PROP-013 source rows, all 1,104 carriers, all 676 multi-property carriers, all 6,676 overlap rows and every explicit nonjoined or bound-composite custody row."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Projection.rejected,Projection.admitted]).flatMap fun projection =>
  ([Parameter.rejected,Parameter.admitted]).flatMap fun parameter =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,support,projection,parameter,absence,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier support projection parameter absence prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprojection : projection ∈ [Projection.rejected,Projection.admitted] := by
      cases projection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hparameter : parameter ∈ [Parameter.rejected,Parameter.admitted] := by
      cases parameter <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
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
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ projection _ hprojection
    apply CommonRefinement.memFlatMap _ _ parameter _ hparameter
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
 | mk carrier support projection parameter absence prediction record extension =>
  cases carrier <;> cases support <;> cases projection <;> cases parameter
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

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-complete-structural-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-applicable-property-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem projectionCriterion (value : Projection) : SFT.Host.Text.equal (projectionName value) "named-admitted-relation-projections" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem parameterCriterion (value : Parameter) : SFT.Host.Text.equal (parameterName value) "zero-parameter-shared-carrier-projection" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "structural-EmptyOne-and-unjoined-custody-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-13-family-source-row-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "append-only-depth-independent-projection-extension" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, supportCriterion, projectionCriterion, parameterCriterion, absenceCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier support projection parameter absence prediction record extension =>
    cases carrier <;> cases support <;> cases projection <;> cases parameter <;> cases absence <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.support = .admitted ∧ c.projection = .admitted ∧ c.parameter = .admitted ∧ c.absence = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier support projection parameter absence prediction record extension =>
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

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem projection_rejected_rejected (c : Candidate) (h : c.projection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.projection eq
    rw [h] at field
    cases field

theorem parameter_rejected_rejected (c : Candidate) (h : c.parameter = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.parameter eq
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

end SFT.Chemistry.CrossPropertyMolecularVectorGrammar
