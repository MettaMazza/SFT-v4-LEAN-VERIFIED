import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CompetingChannelGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-dominant-or-favorable-channel-subset"
  | .admitted => "complete-registered-product-channel-support"

inductive Whole where
  | rejected | admitted

def wholeName : Whole → String
  | .rejected => "imported-probability-normalization-axiom"
  | .admitted => "exact-sum-of-complete-retained-support"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "fitted-or-free-branching-ratio"
  | .admitted => "exact-channel-support-over-complete-support"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "reaction-condition-or-product-identity-collapsed"
  | .admitted => "held-reaction-condition-product-and-source-row-identities"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "unfavorable-null-or-unresolved-channel-omitted"
  | .admitted => "structural-EmptyOne-channel-retained-without-invented-value"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "ratio-answer-only-or-renormalized-table"
  | .admitted => "complete-source-ordered-support-share-uncertainty-and-adverse-record"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "experimental-and-calculated-columns-mixed"
  | .admitted => "experimental-vector-separated-from-calculated-and-analysis-disclosures"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "branch-value-readable-before-seal-or-corrected-after-release"
  | .admitted => "value-free-complete-eight-channel-identity-seal-and-depth-independent-successor"

structure Candidate where
  support : Support
  whole : Whole
  relation : Relation
  identity : Identity
  absence : Absence
  record : Record
  provenance : Provenance
  prediction : Prediction

def sourceFields (c : Candidate) : List String := [supportName c.support, wholeName c.whole, relationName c.relation, identityName c.identity, absenceName c.absence, recordName c.record, provenanceName c.provenance, predictionName c.prediction]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "whole=" (wholeName c.whole), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "prediction=" (predictionName c.prediction)]
def survivorId : String := "complete-registered-product-channel-support__exact-sum-of-complete-retained-support__exact-channel-support-over-complete-support__held-reaction-condition-product-and-source-row-identities__structural-EmptyOne-channel-retained-without-invented-value__complete-source-ordered-support-share-uncertainty-and-adverse-record__experimental-vector-separated-from-calculated-and-analysis-disclosures__value-free-complete-eight-channel-identity-seal-and-depth-independent-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-registered-product-channel-support" &&
  SFT.Host.Text.equal (wholeName c.whole) "exact-sum-of-complete-retained-support" &&
  SFT.Host.Text.equal (relationName c.relation) "exact-channel-support-over-complete-support" &&
  SFT.Host.Text.equal (identityName c.identity) "held-reaction-condition-product-and-source-row-identities" &&
  SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-channel-retained-without-invented-value" &&
  SFT.Host.Text.equal (recordName c.record) "complete-source-ordered-support-share-uncertainty-and-adverse-record" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "experimental-vector-separated-from-calculated-and-analysis-disclosures" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-eight-channel-identity-seal-and-depth-independent-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-registered-product-channel-support") then "Selecting abundant products erases competing support." else
  if !(SFT.Host.Text.equal (wholeName c.whole) "exact-sum-of-complete-retained-support") then "An imported normalization premise could choose the relation." else
  if !(SFT.Host.Text.equal (relationName c.relation) "exact-channel-support-over-complete-support") then "A fitted fraction is not forced by the channel record." else
  if !(SFT.Host.Text.equal (identityName c.identity) "held-reaction-condition-product-and-source-row-identities") then "Collapsed identity can combine unrelated products or conditions." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-channel-retained-without-invented-value") then "Omission can inflate remaining shares." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-source-ordered-support-share-uncertainty-and-adverse-record") then "An answer-only table cannot reconstruct source support." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "experimental-vector-separated-from-calculated-and-analysis-disclosures") then "Mixing columns can substitute theory for measurement." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-eight-channel-identity-seal-and-depth-independent-successor") then "Target access or correction can select the result." else
  "complete-registered-product-channel-support__exact-sum-of-complete-retained-support__exact-channel-support-over-complete-support__held-reaction-condition-product-and-source-row-identities__structural-EmptyOne-channel-retained-without-invented-value__complete-source-ordered-support-share-uncertainty-and-adverse-record__experimental-vector-separated-from-calculated-and-analysis-disclosures__value-free-complete-eight-channel-identity-seal-and-depth-independent-successor"

def generationRule : String := "Generate the literal product of support, whole, relation, identity, absence, record, provenance and prediction forms; decide all 256 candidates only from admitted exact arithmetic, combinatorics, conditional information, reaction-mechanism, complete path, rate, activation and transition-boundary laws."
def grammarBoundary : String := "Every finite complete source-ordered product-channel word with held reaction, condition, product and row identities, exact positive support or structural EmptyOne, at least two competing channels and one positive complete support. External testing preserves all eight experimental products, every uncertainty, the separate calculated column, the complete article, nineteen supplementary files and both supplement PDFs."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Whole.rejected,Whole.admitted]).flatMap fun whole =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Prediction.rejected,Prediction.admitted]).map fun prediction =>
  ⟨support,whole,relation,identity,absence,record,provenance,prediction⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support whole relation identity absence record provenance prediction =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hwhole : whole ∈ [Whole.rejected,Whole.admitted] := by
      cases whole <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ whole _ hwhole
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ prediction _ hprediction

theorem sourceDecisionBlock0000 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0001 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0010 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0011 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0100 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0101 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0110 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock0111 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1000 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1001 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1010 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1011 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1100 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1101 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1110 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionBlock1111 (absence : Absence) (record : Record) (provenance : Provenance) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,absence,record,provenance,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,absence,record,provenance,prediction⟩ := by
 cases absence <;> cases record <;> cases provenance <;> cases prediction <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk support whole relation identity absence record provenance prediction =>
  cases support <;> cases whole <;> cases relation <;> cases identity
  · exact sourceDecisionBlock0000 absence record provenance prediction
  · exact sourceDecisionBlock0001 absence record provenance prediction
  · exact sourceDecisionBlock0010 absence record provenance prediction
  · exact sourceDecisionBlock0011 absence record provenance prediction
  · exact sourceDecisionBlock0100 absence record provenance prediction
  · exact sourceDecisionBlock0101 absence record provenance prediction
  · exact sourceDecisionBlock0110 absence record provenance prediction
  · exact sourceDecisionBlock0111 absence record provenance prediction
  · exact sourceDecisionBlock1000 absence record provenance prediction
  · exact sourceDecisionBlock1001 absence record provenance prediction
  · exact sourceDecisionBlock1010 absence record provenance prediction
  · exact sourceDecisionBlock1011 absence record provenance prediction
  · exact sourceDecisionBlock1100 absence record provenance prediction
  · exact sourceDecisionBlock1101 absence record provenance prediction
  · exact sourceDecisionBlock1110 absence record provenance prediction
  · exact sourceDecisionBlock1111 absence record provenance prediction

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-registered-product-channel-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem wholeCriterion (value : Whole) : SFT.Host.Text.equal (wholeName value) "exact-sum-of-complete-retained-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "exact-channel-support-over-complete-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-reaction-condition-product-and-source-row-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "structural-EmptyOne-channel-retained-without-invented-value" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-source-ordered-support-share-uncertainty-and-adverse-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "experimental-vector-separated-from-calculated-and-analysis-disclosures" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-complete-eight-channel-identity-seal-and-depth-independent-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [supportCriterion, wholeCriterion, relationCriterion, identityCriterion, absenceCriterion, recordCriterion, provenanceCriterion, predictionCriterion]
  cases c with
  | mk support whole relation identity absence record provenance prediction =>
    cases support <;> cases whole <;> cases relation <;> cases identity <;> cases absence <;> cases record <;> cases provenance <;> cases prediction
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.whole = .admitted ∧ c.relation = .admitted ∧ c.identity = .admitted ∧ c.absence = .admitted ∧ c.record = .admitted ∧ c.provenance = .admitted ∧ c.prediction = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support whole relation identity absence record provenance prediction =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem whole_rejected_rejected (c : Candidate) (h : c.whole = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.whole eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
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

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
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

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
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

end SFT.Chemistry.CompetingChannelGrammar
