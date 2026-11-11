import SFT.Chemistry.GroupPeriodCoordinates
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.GroupPeriodGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "printed-cell-coordinate"
  | .admitted => "periodic-element-carrier"

inductive Group where
  | rejected | admitted

def groupName : Group → String
  | .rejected => "column-number-as-premise"
  | .admitted => "outer-trace-equivalence-class"

inductive Period where
  | rejected | admitted

def periodName : Period → String
  | .rejected => "row-number-as-premise"
  | .admitted => "closure-reopening-depth"

inductive Pairing where
  | rejected | admitted

def pairingName : Pairing → String
  | .rejected => "group-only-or-period-only"
  | .admitted => "joint-group-period-coordinate"

inductive Ordering where
  | rejected | admitted

def orderingName : Ordering → String
  | .rejected => "layout-dependent-order"
  | .admitted => "atomic-number-order-retained"

inductive Equivalence where
  | rejected | admitted

def equivalenceName : Equivalence → String
  | .rejected => "namesake-family-only"
  | .admitted => "complete-trace-quotient"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "coordinate-without-witness"
  | .admitted => "element-order-recurrence-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-layout-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  group : Group
  period : Period
  pairing : Pairing
  ordering : Ordering
  equivalence : Equivalence
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, groupName c.group, periodName c.period, pairingName c.pairing, orderingName c.ordering, equivalenceName c.equivalence, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "group=" (groupName c.group), SFT.Host.Text.append "period=" (periodName c.period), SFT.Host.Text.append "pairing=" (pairingName c.pairing), SFT.Host.Text.append "ordering=" (orderingName c.ordering), SFT.Host.Text.append "equivalence=" (equivalenceName c.equivalence), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "periodic-element-carrier__outer-trace-equivalence-class__closure-reopening-depth__joint-group-period-coordinate__atomic-number-order-retained__complete-trace-quotient__element-order-recurrence-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "periodic-element-carrier" &&
  SFT.Host.Text.equal (groupName c.group) "outer-trace-equivalence-class" &&
  SFT.Host.Text.equal (periodName c.period) "closure-reopening-depth" &&
  SFT.Host.Text.equal (pairingName c.pairing) "joint-group-period-coordinate" &&
  SFT.Host.Text.equal (orderingName c.ordering) "atomic-number-order-retained" &&
  SFT.Host.Text.equal (equivalenceName c.equivalence) "complete-trace-quotient" &&
  SFT.Host.Text.equal (recordName c.record) "element-order-recurrence-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "periodic-element-carrier") then "A page coordinate is representational rather than chemical." else
  if !(SFT.Host.Text.equal (groupName c.group) "outer-trace-equivalence-class") then "A conventional column number cannot select equivalence." else
  if !(SFT.Host.Text.equal (periodName c.period) "closure-reopening-depth") then "A conventional row number cannot select recurrence depth." else
  if !(SFT.Host.Text.equal (pairingName c.pairing) "joint-group-period-coordinate") then "Either coordinate alone loses a required distinction." else
  if !(SFT.Host.Text.equal (orderingName c.ordering) "atomic-number-order-retained") then "Alternate drawings must not alter chemical coordinates." else
  if !(SFT.Host.Text.equal (equivalenceName c.equivalence) "complete-trace-quotient") then "A family name cannot prove matching transition support." else
  if !(SFT.Host.Text.equal (recordName c.record) "element-order-recurrence-trace") then "A coordinate without a recurrence witness is not auditable." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A layout exception can move an element without a chemical distinction." else
  "periodic-element-carrier__outer-trace-equivalence-class__closure-reopening-depth__joint-group-period-coordinate"

def generationRule : String := "Generate the literal product of the registered coordinate carrier, group, period, pairing, ordering, equivalence, record and extension choices."
def grammarBoundary : String := "Every finite periodic-order prefix partitioned by exact outer-trace recurrence, with each element assigned one recurrence-class coordinate and one counted closure-to-reopening depth."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Group.rejected,Group.admitted]).flatMap fun group =>
  ([Period.rejected,Period.admitted]).flatMap fun period =>
  ([Pairing.rejected,Pairing.admitted]).flatMap fun pairing =>
  ([Ordering.rejected,Ordering.admitted]).flatMap fun ordering =>
  ([Equivalence.rejected,Equivalence.admitted]).flatMap fun equivalence =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,group,period,pairing,ordering,equivalence,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier group period pairing ordering equivalence record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgroup : group ∈ [Group.rejected,Group.admitted] := by
      cases group <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hperiod : period ∈ [Period.rejected,Period.admitted] := by
      cases period <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpairing : pairing ∈ [Pairing.rejected,Pairing.admitted] := by
      cases pairing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hordering : ordering ∈ [Ordering.rejected,Ordering.admitted] := by
      cases ordering <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequivalence : equivalence ∈ [Equivalence.rejected,Equivalence.admitted] := by
      cases equivalence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ group _ hgroup
    apply CommonRefinement.memFlatMap _ _ period _ hperiod
    apply CommonRefinement.memFlatMap _ _ pairing _ hpairing
    apply CommonRefinement.memFlatMap _ _ ordering _ hordering
    apply CommonRefinement.memFlatMap _ _ equivalence _ hequivalence
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier group period pairing ordering equivalence record extension =>
    cases carrier <;> cases group <;> cases period <;> cases pairing <;> cases ordering <;> cases equivalence <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier group period pairing ordering equivalence record extension =>
    cases carrier <;> cases group <;> cases period <;> cases pairing <;> cases ordering <;> cases equivalence <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.group = .admitted ∧ c.period = .admitted ∧ c.pairing = .admitted ∧ c.ordering = .admitted ∧ c.equivalence = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier group period pairing ordering equivalence record extension =>
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

theorem group_rejected_rejected (c : Candidate) (h : c.group = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.group eq
    rw [h] at field
    cases field

theorem period_rejected_rejected (c : Candidate) (h : c.period = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.period eq
    rw [h] at field
    cases field

theorem pairing_rejected_rejected (c : Candidate) (h : c.pairing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pairing eq
    rw [h] at field
    cases field

theorem ordering_rejected_rejected (c : Candidate) (h : c.ordering = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ordering eq
    rw [h] at field
    cases field

theorem equivalence_rejected_rejected (c : Candidate) (h : c.equivalence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equivalence eq
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

end SFT.Chemistry.GroupPeriodGrammar
