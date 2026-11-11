import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AnalyticalSelectivityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "response-without-analyte"
  | .admitted => "analyte-response-held"

inductive Alternatives where
  | rejected | admitted

def alternativesName : Alternatives → String
  | .rejected => "other-components-erased"
  | .admitted => "declared-interferent-support"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "single-response-only"
  | .admitted => "all-analyte-interferent-responses-compared"

inductive Decision where
  | rejected | admitted

def decisionName : Decision → String
  | .rejected => "name-based-assignment"
  | .admitted => "distinguishable-analyte-response"

inductive Interference where
  | rejected | admitted

def interferenceName : Interference → String
  | .rejected => "failed-alternatives-deleted"
  | .admitted => "interference-boundary-retained"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "universal-selectivity"
  | .admitted => "method-and-condition-bounded"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selectivity-scalar-only"
  | .admitted => "complete-response-comparison-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-selectivity-threshold"
  | .admitted => "no-extra-rule"

structure Candidate where
  target : Target
  alternatives : Alternatives
  comparison : Comparison
  decision : Decision
  interference : Interference
  conditions : Conditions
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [targetName c.target, alternativesName c.alternatives, comparisonName c.comparison, decisionName c.decision, interferenceName c.interference, conditionsName c.conditions, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "alternatives=" (alternativesName c.alternatives), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "decision=" (decisionName c.decision), SFT.Host.Text.append "interference=" (interferenceName c.interference), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "analyte-response-held__declared-interferent-support__all-analyte-interferent-responses-compared__distinguishable-analyte-response__interference-boundary-retained__method-and-condition-bounded__complete-response-comparison-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (targetName c.target) "analyte-response-held" &&
  SFT.Host.Text.equal (alternativesName c.alternatives) "declared-interferent-support" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "all-analyte-interferent-responses-compared" &&
  SFT.Host.Text.equal (decisionName c.decision) "distinguishable-analyte-response" &&
  SFT.Host.Text.equal (interferenceName c.interference) "interference-boundary-retained" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "method-and-condition-bounded" &&
  SFT.Host.Text.equal (recordName c.record) "complete-response-comparison-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (targetName c.target) "analyte-response-held") then "Selectivity has no target." else
  if !(SFT.Host.Text.equal (alternativesName c.alternatives) "declared-interferent-support") then "Competing support is hidden." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "all-analyte-interferent-responses-compared") then "No discrimination is tested." else
  if !(SFT.Host.Text.equal (decisionName c.decision) "distinguishable-analyte-response") then "A name cannot prove attribution." else
  if !(SFT.Host.Text.equal (interferenceName c.interference) "interference-boundary-retained") then "Unfavorable rows disappear." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "method-and-condition-bounded") then "Response depends on method and conditions." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-response-comparison-trace") then "The tested alternatives cannot be audited." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "An arbitrary threshold can force success." else
  "analyte-response-held__declared-interferent-support__all-analyte-interferent-responses-compared__distinguishable-analyte-response__interference-boundary-retained"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete distinction preservation, exact recurrence/equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite analyte/interferent response support under one registered method and condition class."

def candidates : List Candidate :=
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Alternatives.rejected,Alternatives.admitted]).flatMap fun alternatives =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Decision.rejected,Decision.admitted]).flatMap fun decision =>
  ([Interference.rejected,Interference.admitted]).flatMap fun interference =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨target,alternatives,comparison,decision,interference,conditions,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk target alternatives comparison decision interference conditions record extra =>
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have halternatives : alternatives ∈ [Alternatives.rejected,Alternatives.admitted] := by
      cases alternatives <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdecision : decision ∈ [Decision.rejected,Decision.admitted] := by
      cases decision <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinterference : interference ∈ [Interference.rejected,Interference.admitted] := by
      cases interference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ alternatives _ halternatives
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ decision _ hdecision
    apply CommonRefinement.memFlatMap _ _ interference _ hinterference
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk target alternatives comparison decision interference conditions record extra =>
    cases target <;> cases alternatives <;> cases comparison <;> cases decision <;> cases interference <;> cases conditions <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk target alternatives comparison decision interference conditions record extra =>
    cases target <;> cases alternatives <;> cases comparison <;> cases decision <;> cases interference <;> cases conditions <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.target = .admitted ∧ c.alternatives = .admitted ∧ c.comparison = .admitted ∧ c.decision = .admitted ∧ c.interference = .admitted ∧ c.conditions = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk target alternatives comparison decision interference conditions record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
    rw [h] at field
    cases field

theorem alternatives_rejected_rejected (c : Candidate) (h : c.alternatives = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.alternatives eq
    rw [h] at field
    cases field

theorem comparison_rejected_rejected (c : Candidate) (h : c.comparison = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.comparison eq
    rw [h] at field
    cases field

theorem decision_rejected_rejected (c : Candidate) (h : c.decision = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.decision eq
    rw [h] at field
    cases field

theorem interference_rejected_rejected (c : Candidate) (h : c.interference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.interference eq
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

end SFT.Chemistry.AnalyticalSelectivityGrammar
