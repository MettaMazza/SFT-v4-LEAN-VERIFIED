import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RadiochemicalGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "anonymous-activity-pair"
  | .admitted => "held-parent-daughter-identity"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "continuous-time-premise"
  | .admitted => "positive-ordered-resource-intervals"

inductive Activity where
  | rejected | admitted

def activityName : Activity → String
  | .rejected => "fitted-decay-curve"
  | .admitted => "exact-counted-activity-pair"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "signed-activity-difference"
  | .admitted => "held-ratio-or-structural-absence"

inductive Transient where
  | rejected | admitted

def transientName : Transient → String
  | .rejected => "named-transient-assumption"
  | .admitted => "persistent-nonOne-ratio-forces-transient"

inductive Secular where
  | rejected | admitted

def secularName : Secular → String
  | .rejected => "approximate-equality-tolerance"
  | .admitted => "persistent-One-ratio-forces-secular"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-timepoint"
  | .admitted => "complete-parent-daughter-time-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "differential-equation-premise"
  | .admitted => "finite-successor-recomputes-regime"

structure Candidate where
  identity : Identity
  support : Support
  activity : Activity
  relation : Relation
  transient : Transient
  secular : Secular
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, supportName c.support, activityName c.activity, relationName c.relation, transientName c.transient, secularName c.secular, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "activity=" (activityName c.activity), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "transient=" (transientName c.transient), SFT.Host.Text.append "secular=" (secularName c.secular), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-parent-daughter-identity__positive-ordered-resource-intervals__exact-counted-activity-pair__held-ratio-or-structural-absence__persistent-nonOne-ratio-forces-transient__persistent-One-ratio-forces-secular__complete-parent-daughter-time-vector__finite-successor-recomputes-regime"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-parent-daughter-identity" &&
  SFT.Host.Text.equal (supportName c.support) "positive-ordered-resource-intervals" &&
  SFT.Host.Text.equal (activityName c.activity) "exact-counted-activity-pair" &&
  SFT.Host.Text.equal (relationName c.relation) "held-ratio-or-structural-absence" &&
  SFT.Host.Text.equal (transientName c.transient) "persistent-nonOne-ratio-forces-transient" &&
  SFT.Host.Text.equal (secularName c.secular) "persistent-One-ratio-forces-secular" &&
  SFT.Host.Text.equal (recordName c.record) "complete-parent-daughter-time-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "finite-successor-recomputes-regime"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-parent-daughter-identity") then "Equilibrium needs parent/daughter identity." else
  if !(SFT.Host.Text.equal (supportName c.support) "positive-ordered-resource-intervals") then "Continuum time is not proof support." else
  if !(SFT.Host.Text.equal (activityName c.activity) "exact-counted-activity-pair") then "A fitted curve cannot define activity." else
  if !(SFT.Host.Text.equal (relationName c.relation) "held-ratio-or-structural-absence") then "A signed scalar imports negative values." else
  if !(SFT.Host.Text.equal (transientName c.transient) "persistent-nonOne-ratio-forces-transient") then "A name cannot establish a regime." else
  if !(SFT.Host.Text.equal (secularName c.secular) "persistent-One-ratio-forces-secular") then "A tolerance is a free parameter." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-parent-daughter-time-vector") then "One point cannot establish recurrence." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "finite-successor-recomputes-regime") then "No imported differential equation is needed." else
  "held-parent-daughter-identity__positive-ordered-resource-intervals__exact-counted-activity-pair__held-ratio-or-structural-absence__persistent-nonOne-ratio-forces-transient__persistent-One-ratio-forces-secular__complete-parent-daughter-time-vector__finite-successor-recomputes-regime"

def generationRule : String := "Generate the literal product of eight registered equilibrium decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, support, activity, ratio, transient, secular, record and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Activity.rejected,Activity.admitted]).flatMap fun activity =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Transient.rejected,Transient.admitted]).flatMap fun transient =>
  ([Secular.rejected,Secular.admitted]).flatMap fun secular =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,support,activity,relation,transient,secular,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity support activity relation transient secular record extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hactivity : activity ∈ [Activity.rejected,Activity.admitted] := by
      cases activity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransient : transient ∈ [Transient.rejected,Transient.admitted] := by
      cases transient <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsecular : secular ∈ [Secular.rejected,Secular.admitted] := by
      cases secular <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ activity _ hactivity
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ transient _ htransient
    apply CommonRefinement.memFlatMap _ _ secular _ hsecular
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,transient,secular,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,transient,secular,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,transient,secular,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,transient,secular,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,transient,secular,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,transient,secular,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,transient,secular,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,transient,secular,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,transient,secular,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,transient,secular,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,transient,secular,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,transient,secular,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,transient,secular,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,transient,secular,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,transient,secular,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (transient : Transient) (secular : Secular) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,transient,secular,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,transient,secular,record,extension⟩ := by
 cases transient <;> cases secular <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity support activity relation transient secular record extension =>
  cases identity <;> cases support <;> cases activity <;> cases relation
  · exact sourceDecisionBlock0000 transient secular record extension
  · exact sourceDecisionBlock0001 transient secular record extension
  · exact sourceDecisionBlock0010 transient secular record extension
  · exact sourceDecisionBlock0011 transient secular record extension
  · exact sourceDecisionBlock0100 transient secular record extension
  · exact sourceDecisionBlock0101 transient secular record extension
  · exact sourceDecisionBlock0110 transient secular record extension
  · exact sourceDecisionBlock0111 transient secular record extension
  · exact sourceDecisionBlock1000 transient secular record extension
  · exact sourceDecisionBlock1001 transient secular record extension
  · exact sourceDecisionBlock1010 transient secular record extension
  · exact sourceDecisionBlock1011 transient secular record extension
  · exact sourceDecisionBlock1100 transient secular record extension
  · exact sourceDecisionBlock1101 transient secular record extension
  · exact sourceDecisionBlock1110 transient secular record extension
  · exact sourceDecisionBlock1111 transient secular record extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-parent-daughter-identity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "positive-ordered-resource-intervals" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem activityCriterion (value : Activity) : SFT.Host.Text.equal (activityName value) "exact-counted-activity-pair" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "held-ratio-or-structural-absence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem transientCriterion (value : Transient) : SFT.Host.Text.equal (transientName value) "persistent-nonOne-ratio-forces-transient" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem secularCriterion (value : Secular) : SFT.Host.Text.equal (secularName value) "persistent-One-ratio-forces-secular" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-parent-daughter-time-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "finite-successor-recomputes-regime" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, supportCriterion, activityCriterion, relationCriterion, transientCriterion, secularCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk identity support activity relation transient secular record extension =>
    cases identity <;> cases support <;> cases activity <;> cases relation <;> cases transient <;> cases secular <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.support = .admitted ∧ c.activity = .admitted ∧ c.relation = .admitted ∧ c.transient = .admitted ∧ c.secular = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity support activity relation transient secular record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
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

theorem activity_rejected_rejected (c : Candidate) (h : c.activity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.activity eq
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

theorem transient_rejected_rejected (c : Candidate) (h : c.transient = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transient eq
    rw [h] at field
    cases field

theorem secular_rejected_rejected (c : Candidate) (h : c.secular = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.secular eq
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

end SFT.Chemistry.RadiochemicalGrammar
