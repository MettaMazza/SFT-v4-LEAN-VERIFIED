import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MechanismGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Steps where
  | rejected | admitted

def stepsName : Steps → String
  | .rejected => "unordered-step-list"
  | .admitted => "ordered-elementary-step-word"

inductive Adjacency where
  | rejected | admitted

def adjacencyName : Adjacency → String
  | .rejected => "unmatched-step-endpoints"
  | .admitted => "adjacent-state-composition"

inductive Elementarity where
  | rejected | admitted

def elementarityName : Elementarity → String
  | .rejected => "hidden-substeps"
  | .admitted => "declared-indivisible-steps"

inductive Internal where
  | rejected | admitted

def internalName : Internal → String
  | .rejected => "internal-species-erased"
  | .admitted => "internal-states-held"

inductive Endpoints where
  | rejected | admitted

def endpointsName : Endpoints → String
  | .rejected => "different-overall-reaction"
  | .admitted => "same-overall-endpoints"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "carrier-loss-between-steps"
  | .admitted => "carrier-conservation-each-step"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "mechanism-label-only"
  | .admitted => "complete-ordered-step-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-hidden-path"
  | .admitted => "no-extra-rule"

structure Candidate where
  steps : Steps
  adjacency : Adjacency
  elementarity : Elementarity
  internal : Internal
  endpoints : Endpoints
  conservation : Conservation
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [stepsName c.steps, adjacencyName c.adjacency, elementarityName c.elementarity, internalName c.internal, endpointsName c.endpoints, conservationName c.conservation, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "steps=" (stepsName c.steps), SFT.Host.Text.append "adjacency=" (adjacencyName c.adjacency), SFT.Host.Text.append "elementarity=" (elementarityName c.elementarity), SFT.Host.Text.append "internal=" (internalName c.internal), SFT.Host.Text.append "endpoints=" (endpointsName c.endpoints), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "ordered-elementary-step-word__adjacent-state-composition__declared-indivisible-steps__internal-states-held__same-overall-endpoints__carrier-conservation-each-step__complete-ordered-step-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (stepsName c.steps) "ordered-elementary-step-word" &&
  SFT.Host.Text.equal (adjacencyName c.adjacency) "adjacent-state-composition" &&
  SFT.Host.Text.equal (elementarityName c.elementarity) "declared-indivisible-steps" &&
  SFT.Host.Text.equal (internalName c.internal) "internal-states-held" &&
  SFT.Host.Text.equal (endpointsName c.endpoints) "same-overall-endpoints" &&
  SFT.Host.Text.equal (conservationName c.conservation) "carrier-conservation-each-step" &&
  SFT.Host.Text.equal (recordName c.record) "complete-ordered-step-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (stepsName c.steps) "ordered-elementary-step-word") then "Unordered changes do not form a path." else
  if !(SFT.Host.Text.equal (adjacencyName c.adjacency) "adjacent-state-composition") then "The proposed path is discontinuous." else
  if !(SFT.Host.Text.equal (elementarityName c.elementarity) "declared-indivisible-steps") then "The trace is incomplete at its declared boundary." else
  if !(SFT.Host.Text.equal (internalName c.internal) "internal-states-held") then "Cancellation cannot be audited." else
  if !(SFT.Host.Text.equal (endpointsName c.endpoints) "same-overall-endpoints") then "The path does not explain the claim." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "carrier-conservation-each-step") then "Local openness breaks global closure." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-ordered-step-trace") then "A label cannot reproduce the path." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "An unseen path can explain any endpoint." else
  "ordered-elementary-step-word__adjacent-state-composition__declared-indivisible-steps__internal-states-held__same-overall-endpoints"

def generationRule : String := "Generate the literal product of step, adjacency, elementarity, internal-state, endpoint, conservation, record and extension choices."
def grammarBoundary : String := "Every finite ordered sequence of elementary chemical transitions whose adjacent states compose exactly and whose endpoint composition equals one registered overall reaction after internal states cancel."

def candidates : List Candidate :=
  ([Steps.rejected,Steps.admitted]).flatMap fun steps =>
  ([Adjacency.rejected,Adjacency.admitted]).flatMap fun adjacency =>
  ([Elementarity.rejected,Elementarity.admitted]).flatMap fun elementarity =>
  ([Internal.rejected,Internal.admitted]).flatMap fun internal =>
  ([Endpoints.rejected,Endpoints.admitted]).flatMap fun endpoints =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨steps,adjacency,elementarity,internal,endpoints,conservation,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk steps adjacency elementarity internal endpoints conservation record extra =>
    have hsteps : steps ∈ [Steps.rejected,Steps.admitted] := by
      cases steps <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadjacency : adjacency ∈ [Adjacency.rejected,Adjacency.admitted] := by
      cases adjacency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helementarity : elementarity ∈ [Elementarity.rejected,Elementarity.admitted] := by
      cases elementarity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinternal : internal ∈ [Internal.rejected,Internal.admitted] := by
      cases internal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hendpoints : endpoints ∈ [Endpoints.rejected,Endpoints.admitted] := by
      cases endpoints <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ steps _ hsteps
    apply CommonRefinement.memFlatMap _ _ adjacency _ hadjacency
    apply CommonRefinement.memFlatMap _ _ elementarity _ helementarity
    apply CommonRefinement.memFlatMap _ _ internal _ hinternal
    apply CommonRefinement.memFlatMap _ _ endpoints _ hendpoints
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk steps adjacency elementarity internal endpoints conservation record extra =>
    cases steps <;> cases adjacency <;> cases elementarity <;> cases internal <;> cases endpoints <;> cases conservation <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk steps adjacency elementarity internal endpoints conservation record extra =>
    cases steps <;> cases adjacency <;> cases elementarity <;> cases internal <;> cases endpoints <;> cases conservation <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.steps = .admitted ∧ c.adjacency = .admitted ∧ c.elementarity = .admitted ∧ c.internal = .admitted ∧ c.endpoints = .admitted ∧ c.conservation = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk steps adjacency elementarity internal endpoints conservation record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem steps_rejected_rejected (c : Candidate) (h : c.steps = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.steps eq
    rw [h] at field
    cases field

theorem adjacency_rejected_rejected (c : Candidate) (h : c.adjacency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.adjacency eq
    rw [h] at field
    cases field

theorem elementarity_rejected_rejected (c : Candidate) (h : c.elementarity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.elementarity eq
    rw [h] at field
    cases field

theorem internal_rejected_rejected (c : Candidate) (h : c.internal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.internal eq
    rw [h] at field
    cases field

theorem endpoints_rejected_rejected (c : Candidate) (h : c.endpoints = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.endpoints eq
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

end SFT.Chemistry.MechanismGrammar
