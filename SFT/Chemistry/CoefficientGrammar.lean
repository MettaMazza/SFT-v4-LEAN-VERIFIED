import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CoefficientGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "coefficient-list-without-species"
  | .admitted => "formula-bound-species-support"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "negative-reactant-count"
  | .admitted => "held-side-positive-count"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "unbalanced-count-vector"
  | .admitted => "element-balance-preserved"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "arbitrary-common-multiple"
  | .admitted => "primitive-positive-vector"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "zero-coefficient-species"
  | .admitted => "nonparticipants-omitted"

inductive Uniqueness where
  | rejected | admitted

def uniquenessName : Uniqueness → String
  | .rejected => "one-picked-balancing-vector"
  | .admitted => "unique-up-to-common-multiple"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "coefficient-answer-only"
  | .admitted => "formula-matrix-reduction-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-coefficient-adjustment"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  orientation : Orientation
  balance : Balance
  scale : Scale
  absence : Absence
  uniqueness : Uniqueness
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, orientationName c.orientation, balanceName c.balance, scaleName c.scale, absenceName c.absence, uniquenessName c.uniqueness, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "uniqueness=" (uniquenessName c.uniqueness), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "formula-bound-species-support__held-side-positive-count__element-balance-preserved__primitive-positive-vector__nonparticipants-omitted__unique-up-to-common-multiple__formula-matrix-reduction-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "formula-bound-species-support" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-side-positive-count" &&
  SFT.Host.Text.equal (balanceName c.balance) "element-balance-preserved" &&
  SFT.Host.Text.equal (scaleName c.scale) "primitive-positive-vector" &&
  SFT.Host.Text.equal (absenceName c.absence) "nonparticipants-omitted" &&
  SFT.Host.Text.equal (uniquenessName c.uniqueness) "unique-up-to-common-multiple" &&
  SFT.Host.Text.equal (recordName c.record) "formula-matrix-reduction-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "formula-bound-species-support") then "Counts detached from formulae have no chemical meaning." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-side-positive-count") then "Negative proof counts are inadmissible." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "element-balance-preserved") then "An unbalanced vector violates element conservation." else
  if !(SFT.Host.Text.equal (scaleName c.scale) "primitive-positive-vector") then "Common multiples are equivalent but not minimal." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "nonparticipants-omitted") then "A zero coefficient imports numerical zero." else
  if !(SFT.Host.Text.equal (uniquenessName c.uniqueness) "unique-up-to-common-multiple") then "Picking one vector does not eliminate rescalings." else
  if !(SFT.Host.Text.equal (recordName c.record) "formula-matrix-reduction-trace") then "A count list cannot prove its balance." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An adjustment can force a desired equation." else
  "formula-bound-species-support__held-side-positive-count__element-balance-preserved__primitive-positive-vector"

def generationRule : String := "Generate the literal product of the registered coefficient carrier, orientation, balance, scale, absence, uniqueness, record and extension choices."
def grammarBoundary : String := "Every balanceable finite chemical reaction support with participating species only, represented by the least common-factor-free vector of positive generated multiplicities."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Uniqueness.rejected,Uniqueness.admitted]).flatMap fun uniqueness =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,orientation,balance,scale,absence,uniqueness,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier orientation balance scale absence uniqueness record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huniqueness : uniqueness ∈ [Uniqueness.rejected,Uniqueness.admitted] := by
      cases uniqueness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ uniqueness _ huniqueness
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier orientation balance scale absence uniqueness record extension =>
    cases carrier <;> cases orientation <;> cases balance <;> cases scale <;> cases absence <;> cases uniqueness <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier orientation balance scale absence uniqueness record extension =>
    cases carrier <;> cases orientation <;> cases balance <;> cases scale <;> cases absence <;> cases uniqueness <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.orientation = .admitted ∧ c.balance = .admitted ∧ c.scale = .admitted ∧ c.absence = .admitted ∧ c.uniqueness = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier orientation balance scale absence uniqueness record extension =>
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

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

theorem scale_rejected_rejected (c : Candidate) (h : c.scale = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scale eq
    rw [h] at field
    cases field

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
    rw [h] at field
    cases field

theorem uniqueness_rejected_rejected (c : Candidate) (h : c.uniqueness = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.uniqueness eq
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

end SFT.Chemistry.CoefficientGrammar
