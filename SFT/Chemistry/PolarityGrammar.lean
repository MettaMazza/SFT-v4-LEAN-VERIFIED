import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PolarityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Bond where
  | rejected | admitted

def bondName : Bond → String
  | .rejected => "two-unjoined-atoms"
  | .admitted => "registered-covalent-bond"

inductive Affinity where
  | rejected | admitted

def affinityName : Affinity → String
  | .rejected => "equal-or-unknown-affinity"
  | .admitted => "unequal-complete-affinity"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "different-electrons-compared"
  | .admitted => "same-shared-electron-support"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "full-transfer"
  | .admitted => "unequal-shared-partition"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "negative-charge-number"
  | .admitted => "held-partial-charge-fibres"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "one-endpoint-only"
  | .admitted => "paired-endpoint-response"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "polar-label-only"
  | .admitted => "bond-affinity-partition-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-polarity-threshold"
  | .admitted => "no-extra-rule"

structure Candidate where
  bond : Bond
  affinity : Affinity
  support : Support
  partition : Partition
  orientation : Orientation
  closure : Closure
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [bondName c.bond, affinityName c.affinity, supportName c.support, partitionName c.partition, orientationName c.orientation, closureName c.closure, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "bond=" (bondName c.bond), SFT.Host.Text.append "affinity=" (affinityName c.affinity), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "registered-covalent-bond__unequal-complete-affinity__same-shared-electron-support__unequal-shared-partition__held-partial-charge-fibres__paired-endpoint-response__bond-affinity-partition-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (bondName c.bond) "registered-covalent-bond" &&
  SFT.Host.Text.equal (affinityName c.affinity) "unequal-complete-affinity" &&
  SFT.Host.Text.equal (supportName c.support) "same-shared-electron-support" &&
  SFT.Host.Text.equal (partitionName c.partition) "unequal-shared-partition" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-partial-charge-fibres" &&
  SFT.Host.Text.equal (closureName c.closure) "paired-endpoint-response" &&
  SFT.Host.Text.equal (recordName c.record) "bond-affinity-partition-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (bondName c.bond) "registered-covalent-bond") then "Polarity belongs to a shared bond." else
  if !(SFT.Host.Text.equal (affinityName c.affinity) "unequal-complete-affinity") then "No direction follows from equality or missing evidence." else
  if !(SFT.Host.Text.equal (supportName c.support) "same-shared-electron-support") then "Different support cannot orient one bond." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "unequal-shared-partition") then "Full transfer changes the bonding class." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-partial-charge-fibres") then "A negative scalar is unnecessary." else
  if !(SFT.Host.Text.equal (closureName c.closure) "paired-endpoint-response") then "One endpoint leaves the bond record open." else
  if !(SFT.Host.Text.equal (recordName c.record) "bond-affinity-partition-trace") then "A label cannot reproduce the comparison." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A threshold imports a parameter." else
  "registered-covalent-bond__unequal-complete-affinity__same-shared-electron-support__unequal-shared-partition__held-partial-charge-fibres"

def generationRule : String := "Generate the literal product of bond, affinity, support, partition, orientation, closure, record and extra-rule choices."
def grammarBoundary : String := "Every finite covalent bond whose two named endpoints have unequal complete affinity traces for the same shared support, producing one held orientation of the support partition while retaining the bond whole."

def candidates : List Candidate :=
  ([Bond.rejected,Bond.admitted]).flatMap fun bond =>
  ([Affinity.rejected,Affinity.admitted]).flatMap fun affinity =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨bond,affinity,support,partition,orientation,closure,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk bond affinity support partition orientation closure record extra =>
    have hbond : bond ∈ [Bond.rejected,Bond.admitted] := by
      cases bond <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haffinity : affinity ∈ [Affinity.rejected,Affinity.admitted] := by
      cases affinity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ bond _ hbond
    apply CommonRefinement.memFlatMap _ _ affinity _ haffinity
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk bond affinity support partition orientation closure record extra =>
    cases bond <;> cases affinity <;> cases support <;> cases partition <;> cases orientation <;> cases closure <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk bond affinity support partition orientation closure record extra =>
    cases bond <;> cases affinity <;> cases support <;> cases partition <;> cases orientation <;> cases closure <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.bond = .admitted ∧ c.affinity = .admitted ∧ c.support = .admitted ∧ c.partition = .admitted ∧ c.orientation = .admitted ∧ c.closure = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk bond affinity support partition orientation closure record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem bond_rejected_rejected (c : Candidate) (h : c.bond = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bond eq
    rw [h] at field
    cases field

theorem affinity_rejected_rejected (c : Candidate) (h : c.affinity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.affinity eq
    rw [h] at field
    cases field

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
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

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
    rw [h] at field
    cases field

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
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

end SFT.Chemistry.PolarityGrammar
