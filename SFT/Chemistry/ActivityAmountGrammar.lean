import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ActivityAmountGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "anonymous-activity-number"
  | .admitted => "held-nuclide-species"

inductive Amount where
  | rejected | admitted

def amountName : Amount → String
  | .rejected => "continuum-amount-premise"
  | .admitted => "positive-counted-initial-occurrences"

inductive Events where
  | rejected | admitted

def eventsName : Events → String
  | .rejected => "expected-decay-number"
  | .admitted => "positive-counted-transformations"

inductive Time where
  | rejected | admitted

def timeName : Time → String
  | .rejected => "continuous-time-premise"
  | .admitted => "positive-counted-resource-intervals"

inductive Activity where
  | rejected | admitted

def activityName : Activity → String
  | .rejected => "fitted-decay-constant"
  | .admitted => "exact-transformations-per-resource"

inductive Remaining where
  | rejected | admitted

def remainingName : Remaining → String
  | .rejected => "signed-amount-difference"
  | .admitted => "positive-Take-or-EmptyOne-retained-amount"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-reference-time"
  | .admitted => "complete-activity-amount-time-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "differential-equation-premise"
  | .admitted => "ledger-successor-recomputes-relation"

structure Candidate where
  identity : Identity
  amount : Amount
  events : Events
  time : Time
  activity : Activity
  remaining : Remaining
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, amountName c.amount, eventsName c.events, timeName c.time, activityName c.activity, remainingName c.remaining, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "amount=" (amountName c.amount), SFT.Host.Text.append "events=" (eventsName c.events), SFT.Host.Text.append "time=" (timeName c.time), SFT.Host.Text.append "activity=" (activityName c.activity), SFT.Host.Text.append "remaining=" (remainingName c.remaining), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-nuclide-species__positive-counted-initial-occurrences__positive-counted-transformations__positive-counted-resource-intervals__exact-transformations-per-resource__positive-Take-or-EmptyOne-retained-amount__complete-activity-amount-time-vector__ledger-successor-recomputes-relation"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-nuclide-species" &&
  SFT.Host.Text.equal (amountName c.amount) "positive-counted-initial-occurrences" &&
  SFT.Host.Text.equal (eventsName c.events) "positive-counted-transformations" &&
  SFT.Host.Text.equal (timeName c.time) "positive-counted-resource-intervals" &&
  SFT.Host.Text.equal (activityName c.activity) "exact-transformations-per-resource" &&
  SFT.Host.Text.equal (remainingName c.remaining) "positive-Take-or-EmptyOne-retained-amount" &&
  SFT.Host.Text.equal (recordName c.record) "complete-activity-amount-time-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "ledger-successor-recomputes-relation"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-nuclide-species") then "Activity needs nuclide/species custody." else
  if !(SFT.Host.Text.equal (amountName c.amount) "positive-counted-initial-occurrences") then "Continuum amount hides occurrences." else
  if !(SFT.Host.Text.equal (eventsName c.events) "positive-counted-transformations") then "Expectation is not event custody." else
  if !(SFT.Host.Text.equal (timeName c.time) "positive-counted-resource-intervals") then "Continuum time is not proof support." else
  if !(SFT.Host.Text.equal (activityName c.activity) "exact-transformations-per-resource") then "A fit cannot define activity." else
  if !(SFT.Host.Text.equal (remainingName c.remaining) "positive-Take-or-EmptyOne-retained-amount") then "Signed subtraction imports negative values." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-activity-amount-time-vector") then "One time hides evolution." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "ledger-successor-recomputes-relation") then "A differential equation is not required." else
  "held-nuclide-species__positive-counted-initial-occurrences__positive-counted-transformations__positive-counted-resource-intervals__exact-transformations-per-resource__positive-Take-or-EmptyOne-retained-amount__complete-activity-amount-time-vector__ledger-successor-recomputes-relation"

def generationRule : String := "Generate the literal product of eight registered activity decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, amount, events, time, activity, remaining amount, record and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Amount.rejected,Amount.admitted]).flatMap fun amount =>
  ([Events.rejected,Events.admitted]).flatMap fun events =>
  ([Time.rejected,Time.admitted]).flatMap fun time =>
  ([Activity.rejected,Activity.admitted]).flatMap fun activity =>
  ([Remaining.rejected,Remaining.admitted]).flatMap fun remaining =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,amount,events,time,activity,remaining,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity amount events time activity remaining record extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hamount : amount ∈ [Amount.rejected,Amount.admitted] := by
      cases amount <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevents : events ∈ [Events.rejected,Events.admitted] := by
      cases events <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htime : time ∈ [Time.rejected,Time.admitted] := by
      cases time <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hactivity : activity ∈ [Activity.rejected,Activity.admitted] := by
      cases activity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hremaining : remaining ∈ [Remaining.rejected,Remaining.admitted] := by
      cases remaining <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ amount _ hamount
    apply CommonRefinement.memFlatMap _ _ events _ hevents
    apply CommonRefinement.memFlatMap _ _ time _ htime
    apply CommonRefinement.memFlatMap _ _ activity _ hactivity
    apply CommonRefinement.memFlatMap _ _ remaining _ hremaining
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,activity,remaining,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,activity,remaining,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,activity,remaining,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,activity,remaining,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,activity,remaining,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,activity,remaining,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,activity,remaining,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,activity,remaining,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,activity,remaining,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,activity,remaining,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,activity,remaining,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,activity,remaining,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,activity,remaining,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,activity,remaining,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,activity,remaining,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (activity : Activity) (remaining : Remaining) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,activity,remaining,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,activity,remaining,record,extension⟩ := by
 cases activity <;> cases remaining <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity amount events time activity remaining record extension =>
  cases identity <;> cases amount <;> cases events <;> cases time
  · exact sourceDecisionBlock0000 activity remaining record extension
  · exact sourceDecisionBlock0001 activity remaining record extension
  · exact sourceDecisionBlock0010 activity remaining record extension
  · exact sourceDecisionBlock0011 activity remaining record extension
  · exact sourceDecisionBlock0100 activity remaining record extension
  · exact sourceDecisionBlock0101 activity remaining record extension
  · exact sourceDecisionBlock0110 activity remaining record extension
  · exact sourceDecisionBlock0111 activity remaining record extension
  · exact sourceDecisionBlock1000 activity remaining record extension
  · exact sourceDecisionBlock1001 activity remaining record extension
  · exact sourceDecisionBlock1010 activity remaining record extension
  · exact sourceDecisionBlock1011 activity remaining record extension
  · exact sourceDecisionBlock1100 activity remaining record extension
  · exact sourceDecisionBlock1101 activity remaining record extension
  · exact sourceDecisionBlock1110 activity remaining record extension
  · exact sourceDecisionBlock1111 activity remaining record extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-nuclide-species" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem amountCriterion (value : Amount) : SFT.Host.Text.equal (amountName value) "positive-counted-initial-occurrences" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem eventsCriterion (value : Events) : SFT.Host.Text.equal (eventsName value) "positive-counted-transformations" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem timeCriterion (value : Time) : SFT.Host.Text.equal (timeName value) "positive-counted-resource-intervals" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem activityCriterion (value : Activity) : SFT.Host.Text.equal (activityName value) "exact-transformations-per-resource" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem remainingCriterion (value : Remaining) : SFT.Host.Text.equal (remainingName value) "positive-Take-or-EmptyOne-retained-amount" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-activity-amount-time-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "ledger-successor-recomputes-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, amountCriterion, eventsCriterion, timeCriterion, activityCriterion, remainingCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk identity amount events time activity remaining record extension =>
    cases identity <;> cases amount <;> cases events <;> cases time <;> cases activity <;> cases remaining <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.amount = .admitted ∧ c.events = .admitted ∧ c.time = .admitted ∧ c.activity = .admitted ∧ c.remaining = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity amount events time activity remaining record extension =>
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

theorem amount_rejected_rejected (c : Candidate) (h : c.amount = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.amount eq
    rw [h] at field
    cases field

theorem events_rejected_rejected (c : Candidate) (h : c.events = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.events eq
    rw [h] at field
    cases field

theorem time_rejected_rejected (c : Candidate) (h : c.time = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.time eq
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

theorem remaining_rejected_rejected (c : Candidate) (h : c.remaining = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.remaining eq
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

end SFT.Chemistry.ActivityAmountGrammar
