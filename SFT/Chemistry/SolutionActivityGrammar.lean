import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.SolutionActivityGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "bulk-answer-or-unbound-activity-number"
  | .admitted => "complete-component-exchange-support-account"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "selected-or-erased-composition-and-condition"
  | .admitted => "complete-held-condition-and-component-coordinates"

inductive Activity where
  | rejected | admitted

def activityName : Activity → String
  | .rejected => "logarithm-fugacity-or-fitted-coefficient"
  | .admitted => "exact-accessible-support-over-reference-support"

inductive Interaction where
  | rejected | admitted

def interactionName : Interaction → String
  | .rejected => "ideal-mixture-prior-or-target-derived-correction"
  | .admitted => "exact-joint-versus-independent-support-relation"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-component-coordinate"
  | .admitted => "structural-EmptyOne-absent-component"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "activity-composition-or-condition-readable-before-seal"
  | .admitted => "complete-value-free-204-row-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-system-or-deleted-absence-boundary"
  | .admitted => "complete-nine-dataset-204-row-vector-with-68-EmptyOne-boundaries"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-after-support-replication"
  | .admitted => "depth-independent-exact-support-replication"

structure Candidate where
  carrier : Carrier
  composition : Composition
  activity : Activity
  interaction : Interaction
  absence : Absence
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, compositionName c.composition, activityName c.activity, interactionName c.interaction, absenceName c.absence, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "activity=" (activityName c.activity), SFT.Host.Text.append "interaction=" (interactionName c.interaction), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-component-exchange-support-account__complete-held-condition-and-component-coordinates__exact-accessible-support-over-reference-support__exact-joint-versus-independent-support-relation__structural-EmptyOne-absent-component__complete-value-free-204-row-identity-seal__complete-nine-dataset-204-row-vector-with-68-EmptyOne-boundaries__depth-independent-exact-support-replication"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-component-exchange-support-account" &&
  SFT.Host.Text.equal (compositionName c.composition) "complete-held-condition-and-component-coordinates" &&
  SFT.Host.Text.equal (activityName c.activity) "exact-accessible-support-over-reference-support" &&
  SFT.Host.Text.equal (interactionName c.interaction) "exact-joint-versus-independent-support-relation" &&
  SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-absent-component" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-204-row-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-nine-dataset-204-row-vector-with-68-EmptyOne-boundaries" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-exact-support-replication"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-component-exchange-support-account") then "An unbound number erases the component exchange support it measures." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "complete-held-condition-and-component-coordinates") then "Erasing composition or condition makes distinct solution states indistinguishable." else
  if !(SFT.Host.Text.equal (activityName c.activity) "exact-accessible-support-over-reference-support") then "A logarithm, fugacity model or fitted coefficient imports an unforced scalar model." else
  if !(SFT.Host.Text.equal (interactionName c.interaction) "exact-joint-versus-independent-support-relation") then "Assumed ideality or a target-derived correction selects the relation externally." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-absent-component") then "Numerical zero would introduce a non-SFT number for an absent component." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-204-row-identity-seal") then "Withheld values could select the support relation." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-nine-dataset-204-row-vector-with-68-EmptyOne-boundaries") then "Selecting a solution or dropping absent-component rows hides the complete evidence surface." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-exact-support-replication") then "Refitting after exact replication destroys the count relation." else
  "complete-component-exchange-support-account__complete-held-condition-and-component-coordinates__exact-accessible-support-over-reference-support__exact-joint-versus-independent-support-relation__structural-EmptyOne-absent-component__complete-value-free-204-row-identity-seal__complete-nine-dataset-204-row-vector-with-68-EmptyOne-boundaries__depth-independent-exact-support-replication"

def generationRule : String := "Generate the literal product of carrier, composition, activity, interaction, absence, prediction, record and extension forms; decide all 256 candidates only from admitted exact support-count, component-exchange, composition, condition and structural-absence laws."
def grammarBoundary : String := "Every finite solution component account with complete phase, environment and exact component coordinates, accessible/reference/independent support counts and exact-replication closure. External testing preserves the complete NIST TRC ThermoML record: six compounds, nine binary/ternary datasets, 204 direct isopiestic activity rows and all 68 absent-component boundaries."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Activity.rejected,Activity.admitted]).flatMap fun activity =>
  ([Interaction.rejected,Interaction.admitted]).flatMap fun interaction =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,composition,activity,interaction,absence,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier composition activity interaction absence prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hactivity : activity ∈ [Activity.rejected,Activity.admitted] := by
      cases activity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinteraction : interaction ∈ [Interaction.rejected,Interaction.admitted] := by
      cases interaction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
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
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ activity _ hactivity
    apply CommonRefinement.memFlatMap _ _ interaction _ hinteraction
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
 | mk carrier composition activity interaction absence prediction record extension =>
  cases carrier <;> cases composition <;> cases activity <;> cases interaction
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

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-component-exchange-support-account" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "complete-held-condition-and-component-coordinates" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem activityCriterion (value : Activity) : SFT.Host.Text.equal (activityName value) "exact-accessible-support-over-reference-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem interactionCriterion (value : Interaction) : SFT.Host.Text.equal (interactionName value) "exact-joint-versus-independent-support-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "structural-EmptyOne-absent-component" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-204-row-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-nine-dataset-204-row-vector-with-68-EmptyOne-boundaries" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-exact-support-replication" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, compositionCriterion, activityCriterion, interactionCriterion, absenceCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier composition activity interaction absence prediction record extension =>
    cases carrier <;> cases composition <;> cases activity <;> cases interaction <;> cases absence <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.composition = .admitted ∧ c.activity = .admitted ∧ c.interaction = .admitted ∧ c.absence = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier composition activity interaction absence prediction record extension =>
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

theorem activity_rejected_rejected (c : Candidate) (h : c.activity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.activity eq
    rw [h] at field
    cases field

theorem interaction_rejected_rejected (c : Candidate) (h : c.interaction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.interaction eq
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

end SFT.Chemistry.SolutionActivityGrammar
