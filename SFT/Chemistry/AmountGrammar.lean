import SFT.Chemistry.AmountCount
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AmountGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-amount"
  | .admitted => "amount-carrier"

inductive Entity_reference where
  | rejected | admitted

def entity_referenceName : Entity_reference → String
  | .rejected => "unspecified-entities"
  | .admitted => "specified-entity-reference"

inductive Count where
  | rejected | admitted

def countName : Count → String
  | .rejected => "mass-proxy-count"
  | .admitted => "generated-cardinality"

inductive Measure where
  | rejected | admitted

def measureName : Measure → String
  | .rejected => "unrelated-count-and-quantity"
  | .admitted => "count-measure"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "single-presupposed-entity-kind"
  | .admitted => "generated-entity-support"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "total-without-members"
  | .admitted => "member-and-reference-trace"

inductive Unit where
  | rejected | admitted

def unitName : Unit → String
  | .rejected => "unit-scale-as-proof"
  | .admitted => "separate-unit-comparison"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-amount-factor"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  entity_reference : Entity_reference
  count : Count
  measure : Measure
  support : Support
  record : Record
  unit : Unit
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, entity_referenceName c.entity_reference, countName c.count, measureName c.measure, supportName c.support, recordName c.record, unitName c.unit, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "entity_reference=" (entity_referenceName c.entity_reference), SFT.Host.Text.append "count=" (countName c.count), SFT.Host.Text.append "measure=" (measureName c.measure), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "unit=" (unitName c.unit), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "amount-carrier__specified-entity-reference__generated-cardinality__count-measure__generated-entity-support__member-and-reference-trace__separate-unit-comparison__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "amount-carrier" &&
  SFT.Host.Text.equal (entity_referenceName c.entity_reference) "specified-entity-reference" &&
  SFT.Host.Text.equal (countName c.count) "generated-cardinality" &&
  SFT.Host.Text.equal (measureName c.measure) "count-measure" &&
  SFT.Host.Text.equal (supportName c.support) "generated-entity-support" &&
  SFT.Host.Text.equal (recordName c.record) "member-and-reference-trace" &&
  SFT.Host.Text.equal (unitName c.unit) "separate-unit-comparison" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "amount-carrier") then "An answer label does not retain the entities being counted." else
  if !(SFT.Host.Text.equal (entity_referenceName c.entity_reference) "specified-entity-reference") then "A count without a specified elementary-entity kind changes meaning under substitution." else
  if !(SFT.Host.Text.equal (countName c.count) "generated-cardinality") then "A mass proxy can vary with isotope and cannot establish entity cardinality." else
  if !(SFT.Host.Text.equal (measureName c.measure) "count-measure") then "An unrelated quantity does not measure how many referenced entities occur." else
  if !(SFT.Host.Text.equal (supportName c.support) "generated-entity-support") then "Presupposing one conventional entity kind excludes other generated elementary carriers." else
  if !(SFT.Host.Text.equal (recordName c.record) "member-and-reference-trace") then "A total without its entity reference cannot be independently reconstructed." else
  if !(SFT.Host.Text.equal (unitName c.unit) "separate-unit-comparison") then "A conventional scale cannot select the amount law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An extra multiplier is a free answer-selecting parameter." else
  "amount-carrier__count-measure__specified-entity-reference__generated-entity-support"

def generationRule : String := "Generate the literal product of the registered amount carrier, entity reference, count, measure, support, record, unit and extension choices."
def grammarBoundary : String := "Every positive-finite generated collection of one specified admitted chemical-entity kind, together with its exact member/reference trace and separately registered unit comparison."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Entity_reference.rejected,Entity_reference.admitted]).flatMap fun entity_reference =>
  ([Count.rejected,Count.admitted]).flatMap fun count =>
  ([Measure.rejected,Measure.admitted]).flatMap fun measure =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Unit.rejected,Unit.admitted]).flatMap fun unit =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,entity_reference,count,measure,support,record,unit,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier entity_reference count measure support record unit extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hentity_reference : entity_reference ∈ [Entity_reference.rejected,Entity_reference.admitted] := by
      cases entity_reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcount : count ∈ [Count.rejected,Count.admitted] := by
      cases count <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasure : measure ∈ [Measure.rejected,Measure.admitted] := by
      cases measure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunit : unit ∈ [Unit.rejected,Unit.admitted] := by
      cases unit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ entity_reference _ hentity_reference
    apply CommonRefinement.memFlatMap _ _ count _ hcount
    apply CommonRefinement.memFlatMap _ _ measure _ hmeasure
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ unit _ hunit
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier entity_reference count measure support record unit extension =>
    cases carrier <;> cases entity_reference <;> cases count <;> cases measure <;> cases support <;> cases record <;> cases unit <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier entity_reference count measure support record unit extension =>
    cases carrier <;> cases entity_reference <;> cases count <;> cases measure <;> cases support <;> cases record <;> cases unit <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.entity_reference = .admitted ∧ c.count = .admitted ∧ c.measure = .admitted ∧ c.support = .admitted ∧ c.record = .admitted ∧ c.unit = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier entity_reference count measure support record unit extension =>
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

theorem entity_reference_rejected_rejected (c : Candidate) (h : c.entity_reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.entity_reference eq
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

theorem measure_rejected_rejected (c : Candidate) (h : c.measure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measure eq
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

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

theorem unit_rejected_rejected (c : Candidate) (h : c.unit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.unit eq
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

end SFT.Chemistry.AmountGrammar
