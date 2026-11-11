import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RateGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Event where
  | rejected | admitted

def eventName : Event → String
  | .rejected => "unidentified-change"
  | .admitted => "one-registered-reaction-event"

inductive Count where
  | rejected | admitted

def countName : Count → String
  | .rejected => "continuous-rate-primitive"
  | .admitted => "positive-completed-event-count"

inductive Duration where
  | rejected | admitted

def durationName : Duration → String
  | .rejected => "clock-free-count"
  | .admitted => "positive-reference-recurrence-count"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "unbounded-observation"
  | .admitted => "registered-species-observation-boundary"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "fitted-rate-value"
  | .admitted => "event-count-per-recurrence"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "conditions-erased"
  | .admitted => "source-bound-condition-record"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "rate-answer-only"
  | .admitted => "event-duration-boundary-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-rate-constant"
  | .admitted => "no-extra-rule"

structure Candidate where
  event : Event
  count : Count
  duration : Duration
  boundary : Boundary
  relation : Relation
  conditions : Conditions
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [eventName c.event, countName c.count, durationName c.duration, boundaryName c.boundary, relationName c.relation, conditionsName c.conditions, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "event=" (eventName c.event), SFT.Host.Text.append "count=" (countName c.count), SFT.Host.Text.append "duration=" (durationName c.duration), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "one-registered-reaction-event__positive-completed-event-count__positive-reference-recurrence-count__registered-species-observation-boundary__event-count-per-recurrence__source-bound-condition-record__event-duration-boundary-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (eventName c.event) "one-registered-reaction-event" &&
  SFT.Host.Text.equal (countName c.count) "positive-completed-event-count" &&
  SFT.Host.Text.equal (durationName c.duration) "positive-reference-recurrence-count" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "registered-species-observation-boundary" &&
  SFT.Host.Text.equal (relationName c.relation) "event-count-per-recurrence" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "source-bound-condition-record" &&
  SFT.Host.Text.equal (recordName c.record) "event-duration-boundary-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (eventName c.event) "one-registered-reaction-event") then "Events cannot be counted consistently." else
  if !(SFT.Host.Text.equal (countName c.count) "positive-completed-event-count") then "It imports a continuum quantity." else
  if !(SFT.Host.Text.equal (durationName c.duration) "positive-reference-recurrence-count") then "No rate relation follows." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "registered-species-observation-boundary") then "Amount change is undefined." else
  if !(SFT.Host.Text.equal (relationName c.relation) "event-count-per-recurrence") then "A fitted value is target-derived." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "source-bound-condition-record") then "Rates cannot be compared reproducibly." else
  if !(SFT.Host.Text.equal (recordName c.record) "event-duration-boundary-trace") then "It cannot reconstruct events or time." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A constant can tune any target." else
  "one-registered-reaction-event__positive-completed-event-count__positive-reference-recurrence-count__registered-species-observation-boundary__event-count-per-recurrence"

def generationRule : String := "Generate the literal product of event, count, duration, boundary, relation, condition, record and extension choices."
def grammarBoundary : String := "Every finite observation boundary with a positive counted set of completed instances of one reaction transition and a positive counted set of registered recurrence intervals, retaining species amount and conditions as source records."

def candidates : List Candidate :=
  ([Event.rejected,Event.admitted]).flatMap fun event =>
  ([Count.rejected,Count.admitted]).flatMap fun count =>
  ([Duration.rejected,Duration.admitted]).flatMap fun duration =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨event,count,duration,boundary,relation,conditions,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk event count duration boundary relation conditions record extra =>
    have hevent : event ∈ [Event.rejected,Event.admitted] := by
      cases event <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcount : count ∈ [Count.rejected,Count.admitted] := by
      cases count <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hduration : duration ∈ [Duration.rejected,Duration.admitted] := by
      cases duration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ event _ hevent
    apply CommonRefinement.memFlatMap _ _ count _ hcount
    apply CommonRefinement.memFlatMap _ _ duration _ hduration
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk event count duration boundary relation conditions record extra =>
    cases event <;> cases count <;> cases duration <;> cases boundary <;> cases relation <;> cases conditions <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk event count duration boundary relation conditions record extra =>
    cases event <;> cases count <;> cases duration <;> cases boundary <;> cases relation <;> cases conditions <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.event = .admitted ∧ c.count = .admitted ∧ c.duration = .admitted ∧ c.boundary = .admitted ∧ c.relation = .admitted ∧ c.conditions = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk event count duration boundary relation conditions record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem event_rejected_rejected (c : Candidate) (h : c.event = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.event eq
    rw [h] at field
    cases field

theorem count_rejected_rejected (c : Candidate) (h : c.count = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.count eq
    rw [h] at field
    cases field

theorem duration_rejected_rejected (c : Candidate) (h : c.duration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.duration eq
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

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
    rw [h] at field
    cases field

theorem conditions_rejected_rejected (c : Candidate) (h : c.conditions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conditions eq
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

theorem extra_rejected_rejected (c : Candidate) (h : c.extra = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Chemistry.RateGrammar
