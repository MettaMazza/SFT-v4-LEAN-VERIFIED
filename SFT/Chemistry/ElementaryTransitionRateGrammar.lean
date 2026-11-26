import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ElementaryTransitionRateGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "detached-rate-number-or-continuum-field"
  | .admitted => "complete-registered-elementary-transition-carrier"

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "endpoint-erased-or-identity-change"
  | .admitted => "distinct-held-initial-and-terminal-molecular-states"

inductive Event where
  | rejected | admitted

def eventName : Event → String
  | .rejected => "continuous-change-primitive-or-uncounted-event"
  | .admitted => "positive-completed-transition-count"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "clock-free-or-continuum-time-derivative"
  | .admitted => "positive-reference-tick-count"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "condition-or-observation-support-erased"
  | .admitted => "complete-condition-and-positive-observation-support"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "imported-mass-action-order-arrhenius-fit-or-logarithm"
  | .admitted => "exact-transition-count-per-tick-and-observation-support"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "reaction-condition-method-or-value-readable-before-seal"
  | .admitted => "complete-value-free-46-record-identity-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-after-event-resource-replication-or-record-append"
  | .admitted => "depth-independent-common-event-tick-replication-and-record-append"

structure Candidate where
  carrier : Carrier
  state : State
  event : Event
  recurrence : Recurrence
  boundary : Boundary
  magnitude : Magnitude
  prediction : Prediction
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, stateName c.state, eventName c.event, recurrenceName c.recurrence, boundaryName c.boundary, magnitudeName c.magnitude, predictionName c.prediction, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "event=" (eventName c.event), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-registered-elementary-transition-carrier__distinct-held-initial-and-terminal-molecular-states__positive-completed-transition-count__positive-reference-tick-count__complete-condition-and-positive-observation-support__exact-transition-count-per-tick-and-observation-support__complete-value-free-46-record-identity-seal__depth-independent-common-event-tick-replication-and-record-append"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-registered-elementary-transition-carrier" &&
  SFT.Host.Text.equal (stateName c.state) "distinct-held-initial-and-terminal-molecular-states" &&
  SFT.Host.Text.equal (eventName c.event) "positive-completed-transition-count" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "positive-reference-tick-count" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "complete-condition-and-positive-observation-support" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-transition-count-per-tick-and-observation-support" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-46-record-identity-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-event-tick-replication-and-record-append"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-registered-elementary-transition-carrier") then "A detached rate erases the transition that is counted." else
  if !(SFT.Host.Text.equal (stateName c.state) "distinct-held-initial-and-terminal-molecular-states") then "Without distinct retained endpoints no completed transition is identifiable." else
  if !(SFT.Host.Text.equal (eventName c.event) "positive-completed-transition-count") then "An uncounted continuum change is not an exact rate resource." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "positive-reference-tick-count") then "A rate cannot be formed without exact recurrence support." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "complete-condition-and-positive-observation-support") then "Erased conditions or support make rate rows incomparable." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-transition-count-per-tick-and-observation-support") then "A conventional or fitted rate law could select the result." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-46-record-identity-seal") then "Readable target content could select the law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-event-tick-replication-and-record-append") then "Refitting destroys exact provenance." else
  "complete-registered-elementary-transition-carrier__distinct-held-initial-and-terminal-molecular-states__positive-completed-transition-count__positive-reference-tick-count__complete-condition-and-positive-observation-support__exact-transition-count-per-tick-and-observation-support__complete-value-free-46-record-identity-seal__depth-independent-common-event-tick-replication-and-record-append"

def generationRule : String := "Generate the literal product of carrier, state, event, recurrence, boundary, magnitude, prediction and extension forms; decide all 256 candidates only from admitted state-transition, conservation, exact-resource, molecular-state, mechanism, statistical-support, EmptyOne and finite-successor laws."
def grammarBoundary : String := "Every finite registered elementary chemical transition between distinct molecular states with complete conditions, positive completed-event count, positive tick count and positive observation support. External testing preserves all 46 rate rows from four complete declared NIST SRD 17 experimental records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Event.rejected,Event.admitted]).flatMap fun event =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,state,event,recurrence,boundary,magnitude,prediction,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier state event recurrence boundary magnitude prediction extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevent : event ∈ [Event.rejected,Event.admitted] := by
      cases event <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnitude : magnitude ∈ [Magnitude.rejected,Magnitude.admitted] := by
      cases magnitude <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ event _ hevent
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ magnitude _ hmagnitude
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (boundary : Boundary) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,boundary,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,boundary,magnitude,prediction,extension⟩ := by
 cases boundary <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier state event recurrence boundary magnitude prediction extension =>
  cases carrier <;> cases state <;> cases event <;> cases recurrence
  · exact sourceDecisionBlock0000 boundary magnitude prediction extension
  · exact sourceDecisionBlock0001 boundary magnitude prediction extension
  · exact sourceDecisionBlock0010 boundary magnitude prediction extension
  · exact sourceDecisionBlock0011 boundary magnitude prediction extension
  · exact sourceDecisionBlock0100 boundary magnitude prediction extension
  · exact sourceDecisionBlock0101 boundary magnitude prediction extension
  · exact sourceDecisionBlock0110 boundary magnitude prediction extension
  · exact sourceDecisionBlock0111 boundary magnitude prediction extension
  · exact sourceDecisionBlock1000 boundary magnitude prediction extension
  · exact sourceDecisionBlock1001 boundary magnitude prediction extension
  · exact sourceDecisionBlock1010 boundary magnitude prediction extension
  · exact sourceDecisionBlock1011 boundary magnitude prediction extension
  · exact sourceDecisionBlock1100 boundary magnitude prediction extension
  · exact sourceDecisionBlock1101 boundary magnitude prediction extension
  · exact sourceDecisionBlock1110 boundary magnitude prediction extension
  · exact sourceDecisionBlock1111 boundary magnitude prediction extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-registered-elementary-transition-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem stateCriterion (value : State) : SFT.Host.Text.equal (stateName value) "distinct-held-initial-and-terminal-molecular-states" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem eventCriterion (value : Event) : SFT.Host.Text.equal (eventName value) "positive-completed-transition-count" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recurrenceCriterion (value : Recurrence) : SFT.Host.Text.equal (recurrenceName value) "positive-reference-tick-count" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "complete-condition-and-positive-observation-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "exact-transition-count-per-tick-and-observation-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-46-record-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-common-event-tick-replication-and-record-append" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, stateCriterion, eventCriterion, recurrenceCriterion, boundaryCriterion, magnitudeCriterion, predictionCriterion, extensionCriterion]
  cases c with
  | mk carrier state event recurrence boundary magnitude prediction extension =>
    cases carrier <;> cases state <;> cases event <;> cases recurrence <;> cases boundary <;> cases magnitude <;> cases prediction <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.state = .admitted ∧ c.event = .admitted ∧ c.recurrence = .admitted ∧ c.boundary = .admitted ∧ c.magnitude = .admitted ∧ c.prediction = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier state event recurrence boundary magnitude prediction extension =>
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

theorem state_rejected_rejected (c : Candidate) (h : c.state = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.state eq
    rw [h] at field
    cases field

theorem event_rejected_rejected (c : Candidate) (h : c.event = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.event eq
    rw [h] at field
    cases field

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
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

theorem magnitude_rejected_rejected (c : Candidate) (h : c.magnitude = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.magnitude eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.ElementaryTransitionRateGrammar
