import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.LimitingGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "named-reagent-only"
  | .admitted => "available-reactant-support"

inductive Requirement where
  | rejected | admitted

def requirementName : Requirement → String
  | .rejected => "unbalanced-requirement"
  | .admitted => "primitive-coefficient-requirement"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "floating-ratio-ranking"
  | .admitted => "exact-available-required-ratios"

inductive Selection where
  | rejected | admitted

def selectionName : Selection → String
  | .rejected => "first-considered-reactant"
  | .admitted => "complete-least-ratio-support"

inductive Consumption where
  | rejected | admitted

def consumptionName : Consumption → String
  | .rejected => "negative-remainder"
  | .admitted => "complete-consumption-boundary"

inductive Excess where
  | rejected | admitted

def excessName : Excess → String
  | .rejected => "excess-erased"
  | .admitted => "retained-excess-support"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "limiter-name-only"
  | .admitted => "amount-coefficient-ratio-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-limiter-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  requirement : Requirement
  comparison : Comparison
  selection : Selection
  consumption : Consumption
  excess : Excess
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, requirementName c.requirement, comparisonName c.comparison, selectionName c.selection, consumptionName c.consumption, excessName c.excess, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "requirement=" (requirementName c.requirement), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "selection=" (selectionName c.selection), SFT.Host.Text.append "consumption=" (consumptionName c.consumption), SFT.Host.Text.append "excess=" (excessName c.excess), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "available-reactant-support__primitive-coefficient-requirement__exact-available-required-ratios__complete-least-ratio-support__complete-consumption-boundary__retained-excess-support__amount-coefficient-ratio-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "available-reactant-support" &&
  SFT.Host.Text.equal (requirementName c.requirement) "primitive-coefficient-requirement" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "exact-available-required-ratios" &&
  SFT.Host.Text.equal (selectionName c.selection) "complete-least-ratio-support" &&
  SFT.Host.Text.equal (consumptionName c.consumption) "complete-consumption-boundary" &&
  SFT.Host.Text.equal (excessName c.excess) "retained-excess-support" &&
  SFT.Host.Text.equal (recordName c.record) "amount-coefficient-ratio-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "available-reactant-support") then "A name without amount and coefficient cannot limit progress." else
  if !(SFT.Host.Text.equal (requirementName c.requirement) "primitive-coefficient-requirement") then "Consumption requirements must come from the balanced reaction." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "exact-available-required-ratios") then "Floating comparison cannot certify ties or minima." else
  if !(SFT.Host.Text.equal (selectionName c.selection) "complete-least-ratio-support") then "Ordering of inspection cannot select the limiter." else
  if !(SFT.Host.Text.equal (consumptionName c.consumption) "complete-consumption-boundary") then "Overrunning the least support would require unavailable matter." else
  if !(SFT.Host.Text.equal (excessName c.excess) "retained-excess-support") then "Nonlimiting remainder is part of the result." else
  if !(SFT.Host.Text.equal (recordName c.record) "amount-coefficient-ratio-trace") then "A name cannot reproduce the comparison." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A preference could choose a nonminimal reagent." else
  "available-reactant-support__primitive-coefficient-requirement__exact-available-required-ratios__complete-least-ratio-support"

def generationRule : String := "Generate the literal product of the registered limiting carrier, requirement, comparison, selection, consumption, excess, record and extension choices."
def grammarBoundary : String := "Every finite reaction input with exact positive available amounts and primitive required coefficients, where complete reaction progress is bounded by every available-to-required ratio."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Requirement.rejected,Requirement.admitted]).flatMap fun requirement =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Selection.rejected,Selection.admitted]).flatMap fun selection =>
  ([Consumption.rejected,Consumption.admitted]).flatMap fun consumption =>
  ([Excess.rejected,Excess.admitted]).flatMap fun excess =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,requirement,comparison,selection,consumption,excess,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier requirement comparison selection consumption excess record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrequirement : requirement ∈ [Requirement.rejected,Requirement.admitted] := by
      cases requirement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hselection : selection ∈ [Selection.rejected,Selection.admitted] := by
      cases selection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconsumption : consumption ∈ [Consumption.rejected,Consumption.admitted] := by
      cases consumption <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexcess : excess ∈ [Excess.rejected,Excess.admitted] := by
      cases excess <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ requirement _ hrequirement
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ selection _ hselection
    apply CommonRefinement.memFlatMap _ _ consumption _ hconsumption
    apply CommonRefinement.memFlatMap _ _ excess _ hexcess
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier requirement comparison selection consumption excess record extension =>
    cases carrier <;> cases requirement <;> cases comparison <;> cases selection <;> cases consumption <;> cases excess <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier requirement comparison selection consumption excess record extension =>
    cases carrier <;> cases requirement <;> cases comparison <;> cases selection <;> cases consumption <;> cases excess <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.requirement = .admitted ∧ c.comparison = .admitted ∧ c.selection = .admitted ∧ c.consumption = .admitted ∧ c.excess = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier requirement comparison selection consumption excess record extension =>
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

theorem requirement_rejected_rejected (c : Candidate) (h : c.requirement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.requirement eq
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

theorem selection_rejected_rejected (c : Candidate) (h : c.selection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.selection eq
    rw [h] at field
    cases field

theorem consumption_rejected_rejected (c : Candidate) (h : c.consumption = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.consumption eq
    rw [h] at field
    cases field

theorem excess_rejected_rejected (c : Candidate) (h : c.excess = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.excess eq
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

end SFT.Chemistry.LimitingGrammar
