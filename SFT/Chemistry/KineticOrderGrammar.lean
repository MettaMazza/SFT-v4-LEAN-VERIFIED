import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.KineticOrderGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Reactant where
  | rejected | admitted

def reactantName : Reactant → String
  | .rejected => "anonymous-concentration"
  | .admitted => "named-reactant-coordinate"

inductive Intervention where
  | rejected | admitted

def interventionName : Intervention → String
  | .rejected => "passive-correlation"
  | .admitted => "source-bound-coordinate-intervention"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "single-rate-answer"
  | .admitted => "complete-rate-response-census"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "stoichiometric-coefficient-assumed"
  | .admitted => "forced-dependency-occurrence-count"

inductive Independence where
  | rejected | admitted

def independenceName : Independence → String
  | .rejected => "numerical-zero-order"
  | .admitted => "empty-dependency-form"

inductive Scope where
  | rejected | admitted

def scopeName : Scope → String
  | .rejected => "universal-condition-free-order"
  | .admitted => "condition-and-mechanism-bound-order"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "order-number-only"
  | .admitted => "reactant-intervention-response-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-power-law-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  reactant : Reactant
  intervention : Intervention
  response : Response
  multiplicity : Multiplicity
  independence : Independence
  scope : Scope
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [reactantName c.reactant, interventionName c.intervention, responseName c.response, multiplicityName c.multiplicity, independenceName c.independence, scopeName c.scope, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "reactant=" (reactantName c.reactant), SFT.Host.Text.append "intervention=" (interventionName c.intervention), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "independence=" (independenceName c.independence), SFT.Host.Text.append "scope=" (scopeName c.scope), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "named-reactant-coordinate__source-bound-coordinate-intervention__complete-rate-response-census__forced-dependency-occurrence-count__empty-dependency-form__condition-and-mechanism-bound-order__reactant-intervention-response-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (reactantName c.reactant) "named-reactant-coordinate" &&
  SFT.Host.Text.equal (interventionName c.intervention) "source-bound-coordinate-intervention" &&
  SFT.Host.Text.equal (responseName c.response) "complete-rate-response-census" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "forced-dependency-occurrence-count" &&
  SFT.Host.Text.equal (independenceName c.independence) "empty-dependency-form" &&
  SFT.Host.Text.equal (scopeName c.scope) "condition-and-mechanism-bound-order" &&
  SFT.Host.Text.equal (recordName c.record) "reactant-intervention-response-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (reactantName c.reactant) "named-reactant-coordinate") then "The dependency coordinate is lost." else
  if !(SFT.Host.Text.equal (interventionName c.intervention) "source-bound-coordinate-intervention") then "It cannot establish dependence." else
  if !(SFT.Host.Text.equal (responseName c.response) "complete-rate-response-census") then "Multiplicity cannot be recovered." else
  if !(SFT.Host.Text.equal (multiplicityName c.multiplicity) "forced-dependency-occurrence-count") then "Kinetic and endpoint counts need not coincide." else
  if !(SFT.Host.Text.equal (independenceName c.independence) "empty-dependency-form") then "Zero is prohibited as proof quantity." else
  if !(SFT.Host.Text.equal (scopeName c.scope) "condition-and-mechanism-bound-order") then "Observed order can be condition-specific." else
  if !(SFT.Host.Text.equal (recordName c.record) "reactant-intervention-response-trace") then "It cannot reproduce the intervention." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fit can select the exponent." else
  "named-reactant-coordinate__source-bound-coordinate-intervention__complete-rate-response-census__forced-dependency-occurrence-count__empty-dependency-form"

def generationRule : String := "Generate the literal product of reactant, intervention, response, multiplicity, independence, scope, record and extension choices."
def grammarBoundary : String := "Every finite source-bound intervention census for one reactant coordinate, retaining the exact multiplicity with which distinguishable occurrences of that coordinate participate in the rate dependency; absence is represented structurally."

def candidates : List Candidate :=
  ([Reactant.rejected,Reactant.admitted]).flatMap fun reactant =>
  ([Intervention.rejected,Intervention.admitted]).flatMap fun intervention =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Independence.rejected,Independence.admitted]).flatMap fun independence =>
  ([Scope.rejected,Scope.admitted]).flatMap fun scope =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨reactant,intervention,response,multiplicity,independence,scope,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk reactant intervention response multiplicity independence scope record extra =>
    have hreactant : reactant ∈ [Reactant.rejected,Reactant.admitted] := by
      cases reactant <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hintervention : intervention ∈ [Intervention.rejected,Intervention.admitted] := by
      cases intervention <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hindependence : independence ∈ [Independence.rejected,Independence.admitted] := by
      cases independence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscope : scope ∈ [Scope.rejected,Scope.admitted] := by
      cases scope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ reactant _ hreactant
    apply CommonRefinement.memFlatMap _ _ intervention _ hintervention
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ independence _ hindependence
    apply CommonRefinement.memFlatMap _ _ scope _ hscope
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk reactant intervention response multiplicity independence scope record extra =>
    cases reactant <;> cases intervention <;> cases response <;> cases multiplicity <;> cases independence <;> cases scope <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk reactant intervention response multiplicity independence scope record extra =>
    cases reactant <;> cases intervention <;> cases response <;> cases multiplicity <;> cases independence <;> cases scope <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.reactant = .admitted ∧ c.intervention = .admitted ∧ c.response = .admitted ∧ c.multiplicity = .admitted ∧ c.independence = .admitted ∧ c.scope = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk reactant intervention response multiplicity independence scope record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem reactant_rejected_rejected (c : Candidate) (h : c.reactant = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reactant eq
    rw [h] at field
    cases field

theorem intervention_rejected_rejected (c : Candidate) (h : c.intervention = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.intervention eq
    rw [h] at field
    cases field

theorem response_rejected_rejected (c : Candidate) (h : c.response = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.response eq
    rw [h] at field
    cases field

theorem multiplicity_rejected_rejected (c : Candidate) (h : c.multiplicity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.multiplicity eq
    rw [h] at field
    cases field

theorem independence_rejected_rejected (c : Candidate) (h : c.independence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.independence eq
    rw [h] at field
    cases field

theorem scope_rejected_rejected (c : Candidate) (h : c.scope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scope eq
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

end SFT.Chemistry.KineticOrderGrammar
