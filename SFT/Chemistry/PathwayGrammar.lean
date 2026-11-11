import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PathwayGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Endpoints where
  | rejected | admitted

def endpointsName : Endpoints → String
  | .rejected => "different-overall-products"
  | .admitted => "same-overall-reaction"

inductive Mechanism where
  | rejected | admitted

def mechanismName : Mechanism → String
  | .rejected => "step-trace-erased"
  | .admitted => "alternative-reaction-mechanism"

inductive Barrier where
  | rejected | admitted

def barrierName : Barrier → String
  | .rejected => "imported-energy-number"
  | .admitted => "lower-activation-support"

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "catalyst-consumed"
  | .admitted => "catalyst-cycle-retained"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "free-intermediate"
  | .admitted => "all-intermediates-balanced"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "condition-free-path"
  | .admitted => "conditions-held"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "endpoint-answer-only"
  | .admitted => "pathwise-energy-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-mechanism-choice"
  | .admitted => "no-extra-rule"

structure Candidate where
  endpoints : Endpoints
  mechanism : Mechanism
  barrier : Barrier
  carrier : Carrier
  conservation : Conservation
  conditions : Conditions
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [endpointsName c.endpoints, mechanismName c.mechanism, barrierName c.barrier, carrierName c.carrier, conservationName c.conservation, conditionsName c.conditions, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "endpoints=" (endpointsName c.endpoints), SFT.Host.Text.append "mechanism=" (mechanismName c.mechanism), SFT.Host.Text.append "barrier=" (barrierName c.barrier), SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "same-overall-reaction__alternative-reaction-mechanism__lower-activation-support__catalyst-cycle-retained__all-intermediates-balanced__conditions-held__pathwise-energy-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (endpointsName c.endpoints) "same-overall-reaction" &&
  SFT.Host.Text.equal (mechanismName c.mechanism) "alternative-reaction-mechanism" &&
  SFT.Host.Text.equal (barrierName c.barrier) "lower-activation-support" &&
  SFT.Host.Text.equal (carrierName c.carrier) "catalyst-cycle-retained" &&
  SFT.Host.Text.equal (conservationName c.conservation) "all-intermediates-balanced" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "conditions-held" &&
  SFT.Host.Text.equal (recordName c.record) "pathwise-energy-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (endpointsName c.endpoints) "same-overall-reaction") then "The paths are not alternatives." else
  if !(SFT.Host.Text.equal (mechanismName c.mechanism) "alternative-reaction-mechanism") then "No pathway comparison exists." else
  if !(SFT.Host.Text.equal (barrierName c.barrier) "lower-activation-support") then "A target value is not forced." else
  if !(SFT.Host.Text.equal (carrierName c.carrier) "catalyst-cycle-retained") then "The cycle does not close." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "all-intermediates-balanced") then "Matter is unaccounted." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "conditions-held") then "Path availability is unbounded." else
  if !(SFT.Host.Text.equal (recordName c.record) "pathwise-energy-trace") then "The alternative path is unreproducible." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A choice can force any path." else
  "same-overall-reaction__alternative-reaction-mechanism__lower-activation-support__catalyst-cycle-retained__all-intermediates-balanced"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by carrier preservation, complete support, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite pair of balanced reaction mechanisms with common endpoints, complete intermediate and activation records, and one exact catalyst-return cycle."

def candidates : List Candidate :=
  ([Endpoints.rejected,Endpoints.admitted]).flatMap fun endpoints =>
  ([Mechanism.rejected,Mechanism.admitted]).flatMap fun mechanism =>
  ([Barrier.rejected,Barrier.admitted]).flatMap fun barrier =>
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨endpoints,mechanism,barrier,carrier,conservation,conditions,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk endpoints mechanism barrier carrier conservation conditions record extra =>
    have hendpoints : endpoints ∈ [Endpoints.rejected,Endpoints.admitted] := by
      cases endpoints <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmechanism : mechanism ∈ [Mechanism.rejected,Mechanism.admitted] := by
      cases mechanism <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbarrier : barrier ∈ [Barrier.rejected,Barrier.admitted] := by
      cases barrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ endpoints _ hendpoints
    apply CommonRefinement.memFlatMap _ _ mechanism _ hmechanism
    apply CommonRefinement.memFlatMap _ _ barrier _ hbarrier
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk endpoints mechanism barrier carrier conservation conditions record extra =>
    cases endpoints <;> cases mechanism <;> cases barrier <;> cases carrier <;> cases conservation <;> cases conditions <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk endpoints mechanism barrier carrier conservation conditions record extra =>
    cases endpoints <;> cases mechanism <;> cases barrier <;> cases carrier <;> cases conservation <;> cases conditions <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.endpoints = .admitted ∧ c.mechanism = .admitted ∧ c.barrier = .admitted ∧ c.carrier = .admitted ∧ c.conservation = .admitted ∧ c.conditions = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk endpoints mechanism barrier carrier conservation conditions record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem endpoints_rejected_rejected (c : Candidate) (h : c.endpoints = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.endpoints eq
    rw [h] at field
    cases field

theorem mechanism_rejected_rejected (c : Candidate) (h : c.mechanism = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mechanism eq
    rw [h] at field
    cases field

theorem barrier_rejected_rejected (c : Candidate) (h : c.barrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.barrier eq
    rw [h] at field
    cases field

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem conservation_rejected_rejected (c : Candidate) (h : c.conservation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conservation eq
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

end SFT.Chemistry.PathwayGrammar
