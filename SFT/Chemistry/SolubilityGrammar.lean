import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.SolubilityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Solution where
  | rejected | admitted

def solutionName : Solution → String
  | .rejected => "unidentified-mixture"
  | .admitted => "retained-solute-solvent-organization"

inductive Dissolution where
  | rejected | admitted

def dissolutionName : Dissolution → String
  | .rejected => "one-way-dissolution-only"
  | .admitted => "dissolution-and-return-transitions"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "unpaired-event-support"
  | .admitted => "paired-opposed-event-support"

inductive Saturation where
  | rejected | admitted

def saturationName : Saturation → String
  | .rejected => "free-solubility-number"
  | .admitted => "source-bounded-capacity-boundary"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "microscopic-state-fixed"
  | .admitted => "macroscopic-dissolved-class-recurs"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "condition-free-solubility"
  | .admitted => "phase-temperature-pressure-held"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "solubility-answer-only"
  | .admitted => "solution-event-composition-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-equilibrium-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  solution : Solution
  dissolution : Dissolution
  balance : Balance
  saturation : Saturation
  composition : Composition
  conditions : Conditions
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [solutionName c.solution, dissolutionName c.dissolution, balanceName c.balance, saturationName c.saturation, compositionName c.composition, conditionsName c.conditions, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "solution=" (solutionName c.solution), SFT.Host.Text.append "dissolution=" (dissolutionName c.dissolution), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "saturation=" (saturationName c.saturation), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "retained-solute-solvent-organization__dissolution-and-return-transitions__paired-opposed-event-support__source-bounded-capacity-boundary__macroscopic-dissolved-class-recurs__phase-temperature-pressure-held__solution-event-composition-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (solutionName c.solution) "retained-solute-solvent-organization" &&
  SFT.Host.Text.equal (dissolutionName c.dissolution) "dissolution-and-return-transitions" &&
  SFT.Host.Text.equal (balanceName c.balance) "paired-opposed-event-support" &&
  SFT.Host.Text.equal (saturationName c.saturation) "source-bounded-capacity-boundary" &&
  SFT.Host.Text.equal (compositionName c.composition) "macroscopic-dissolved-class-recurs" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "phase-temperature-pressure-held" &&
  SFT.Host.Text.equal (recordName c.record) "solution-event-composition-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (solutionName c.solution) "retained-solute-solvent-organization") then "Solute and solvent roles are lost." else
  if !(SFT.Host.Text.equal (dissolutionName c.dissolution) "dissolution-and-return-transitions") then "No equilibrium can close." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "paired-opposed-event-support") then "Composition would drift." else
  if !(SFT.Host.Text.equal (saturationName c.saturation) "source-bounded-capacity-boundary") then "A measured number imports the target." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "macroscopic-dissolved-class-recurs") then "Individual events may continue." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "phase-temperature-pressure-held") then "Solubility changes with conditions." else
  if !(SFT.Host.Text.equal (recordName c.record) "solution-event-composition-trace") then "It cannot reproduce the dynamics." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fit can select any saturation." else
  "retained-solute-solvent-organization__dissolution-and-return-transitions__paired-opposed-event-support__source-bounded-capacity-boundary__macroscopic-dissolved-class-recurs"

def generationRule : String := "Generate the literal product of solution, dissolution, balance, saturation, composition, condition, record and extension choices."
def grammarBoundary : String := "Every finite solution boundary containing a retained solvent/solute organization and opposed dissolution/return transitions whose complete event supports pair at saturation while the macroscopic dissolved-composition class recurs."

def candidates : List Candidate :=
  ([Solution.rejected,Solution.admitted]).flatMap fun solution =>
  ([Dissolution.rejected,Dissolution.admitted]).flatMap fun dissolution =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Saturation.rejected,Saturation.admitted]).flatMap fun saturation =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨solution,dissolution,balance,saturation,composition,conditions,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk solution dissolution balance saturation composition conditions record extra =>
    have hsolution : solution ∈ [Solution.rejected,Solution.admitted] := by
      cases solution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdissolution : dissolution ∈ [Dissolution.rejected,Dissolution.admitted] := by
      cases dissolution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsaturation : saturation ∈ [Saturation.rejected,Saturation.admitted] := by
      cases saturation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ solution _ hsolution
    apply CommonRefinement.memFlatMap _ _ dissolution _ hdissolution
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ saturation _ hsaturation
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk solution dissolution balance saturation composition conditions record extra =>
    cases solution <;> cases dissolution <;> cases balance <;> cases saturation <;> cases composition <;> cases conditions <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk solution dissolution balance saturation composition conditions record extra =>
    cases solution <;> cases dissolution <;> cases balance <;> cases saturation <;> cases composition <;> cases conditions <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.solution = .admitted ∧ c.dissolution = .admitted ∧ c.balance = .admitted ∧ c.saturation = .admitted ∧ c.composition = .admitted ∧ c.conditions = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk solution dissolution balance saturation composition conditions record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem solution_rejected_rejected (c : Candidate) (h : c.solution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.solution eq
    rw [h] at field
    cases field

theorem dissolution_rejected_rejected (c : Candidate) (h : c.dissolution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dissolution eq
    rw [h] at field
    cases field

theorem balance_rejected_rejected (c : Candidate) (h : c.balance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.balance eq
    rw [h] at field
    cases field

theorem saturation_rejected_rejected (c : Candidate) (h : c.saturation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.saturation eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
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

end SFT.Chemistry.SolubilityGrammar
