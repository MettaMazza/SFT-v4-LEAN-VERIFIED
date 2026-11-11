import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.OxidationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Whole where
  | rejected | admitted

def wholeName : Whole → String
  | .rejected => "isolated-atom-answer"
  | .admitted => "complete-bonded-chemical-whole"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "unstated-electron-rule"
  | .admitted => "declared-ionic-approximation"

inductive UnequalBond where
  | rejected | admitted

def unequalBondName : UnequalBond → String
  | .rejected => "split-despite-preference"
  | .admitted => "assign-to-preferred-endpoint"

inductive EqualBond where
  | rejected | admitted

def equalBondName : EqualBond → String
  | .rejected => "arbitrary-endpoint"
  | .admitted => "equal-endpoint-division"

inductive Count where
  | rejected | admitted

def countName : Count → String
  | .rejected => "signed-integer-primitive"
  | .admitted => "positive-count-plus-held-orientation"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "electron-created-or-lost"
  | .admitted => "each-electron-assigned-once"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "oxidation-number-only"
  | .admitted => "atom-bond-assignment-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-state-table"
  | .admitted => "no-extra-rule"

structure Candidate where
  whole : Whole
  partition : Partition
  unequalBond : UnequalBond
  equalBond : EqualBond
  count : Count
  conservation : Conservation
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [wholeName c.whole, partitionName c.partition, unequalBondName c.unequalBond, equalBondName c.equalBond, countName c.count, conservationName c.conservation, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "whole=" (wholeName c.whole), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "unequal-bond=" (unequalBondName c.unequalBond), SFT.Host.Text.append "equal-bond=" (equalBondName c.equalBond), SFT.Host.Text.append "count=" (countName c.count), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "complete-bonded-chemical-whole__declared-ionic-approximation__assign-to-preferred-endpoint__equal-endpoint-division__positive-count-plus-held-orientation__each-electron-assigned-once__atom-bond-assignment-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (wholeName c.whole) "complete-bonded-chemical-whole" &&
  SFT.Host.Text.equal (partitionName c.partition) "declared-ionic-approximation" &&
  SFT.Host.Text.equal (unequalBondName c.unequalBond) "assign-to-preferred-endpoint" &&
  SFT.Host.Text.equal (equalBondName c.equalBond) "equal-endpoint-division" &&
  SFT.Host.Text.equal (countName c.count) "positive-count-plus-held-orientation" &&
  SFT.Host.Text.equal (conservationName c.conservation) "each-electron-assigned-once" &&
  SFT.Host.Text.equal (recordName c.record) "atom-bond-assignment-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (wholeName c.whole) "complete-bonded-chemical-whole") then "Oxidation accounting is composition-relative." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "declared-ionic-approximation") then "An unstated rule permits arbitrary answers." else
  if !(SFT.Host.Text.equal (unequalBondName c.unequalBond) "assign-to-preferred-endpoint") then "It contradicts complete affinity order." else
  if !(SFT.Host.Text.equal (equalBondName c.equalBond) "equal-endpoint-division") then "Equal traces cannot choose an endpoint." else
  if !(SFT.Host.Text.equal (countName c.count) "positive-count-plus-held-orientation") then "A signed number hides orientation." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "each-electron-assigned-once") then "Open assignment violates the whole." else
  if !(SFT.Host.Text.equal (recordName c.record) "atom-bond-assignment-trace") then "A number cannot reproduce the assignment." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A table can select desired values." else
  "complete-bonded-chemical-whole__declared-ionic-approximation__assign-to-preferred-endpoint__equal-endpoint-division__each-electron-assigned-once"

def generationRule : String := "Generate the literal product of whole, partition, unequal-bond, equal-bond, count, conservation, record and extra-rule choices."
def grammarBoundary : String := "Every finite bonded chemical whole under one declared ionic-approximation partition, assigning each bond-electron occurrence exactly once by complete affinity order (or equal division for tied endpoints), retaining atom identity, orientation and total carrier conservation."

def candidates : List Candidate :=
  ([Whole.rejected,Whole.admitted]).flatMap fun whole =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([UnequalBond.rejected,UnequalBond.admitted]).flatMap fun unequalBond =>
  ([EqualBond.rejected,EqualBond.admitted]).flatMap fun equalBond =>
  ([Count.rejected,Count.admitted]).flatMap fun count =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨whole,partition,unequalBond,equalBond,count,conservation,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk whole partition unequalBond equalBond count conservation record extra =>
    have hwhole : whole ∈ [Whole.rejected,Whole.admitted] := by
      cases whole <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunequalBond : unequalBond ∈ [UnequalBond.rejected,UnequalBond.admitted] := by
      cases unequalBond <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequalBond : equalBond ∈ [EqualBond.rejected,EqualBond.admitted] := by
      cases equalBond <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcount : count ∈ [Count.rejected,Count.admitted] := by
      cases count <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ whole _ hwhole
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ unequalBond _ hunequalBond
    apply CommonRefinement.memFlatMap _ _ equalBond _ hequalBond
    apply CommonRefinement.memFlatMap _ _ count _ hcount
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk whole partition unequalBond equalBond count conservation record extra =>
    cases whole <;> cases partition <;> cases unequalBond <;> cases equalBond <;> cases count <;> cases conservation <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk whole partition unequalBond equalBond count conservation record extra =>
    cases whole <;> cases partition <;> cases unequalBond <;> cases equalBond <;> cases count <;> cases conservation <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.whole = .admitted ∧ c.partition = .admitted ∧ c.unequalBond = .admitted ∧ c.equalBond = .admitted ∧ c.count = .admitted ∧ c.conservation = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk whole partition unequalBond equalBond count conservation record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem whole_rejected_rejected (c : Candidate) (h : c.whole = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.whole eq
    rw [h] at field
    cases field

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
    rw [h] at field
    cases field

theorem unequalBond_rejected_rejected (c : Candidate) (h : c.unequalBond = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.unequalBond eq
    rw [h] at field
    cases field

theorem equalBond_rejected_rejected (c : Candidate) (h : c.equalBond = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equalBond eq
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

end SFT.Chemistry.OxidationGrammar
