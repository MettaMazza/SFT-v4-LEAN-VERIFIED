import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.OrderGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "index-without-bond"
  | .admitted => "identified-bond-carrier"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-channel-count"
  | .admitted => "complete-joining-channel-support"

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "arbitrary-scale"
  | .admitted => "single-localized-pair-reference"

inductive Quantity where
  | rejected | admitted

def quantityName : Quantity → String
  | .rejected => "floating-index"
  | .admitted => "exact-positive-rational-degree"

inductive Delocalization where
  | rejected | admitted

def delocalizationName : Delocalization → String
  | .rejected => "integer-only-order"
  | .admitted => "rational-support-sharing-retained"

inductive Method where
  | rejected | admitted

def methodName : Method → String
  | .rejected => "one-partition-as-absolute"
  | .admitted => "partition-bound-index"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "order-answer-only"
  | .admitted => "bond-channel-reference-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-order-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  support : Support
  reference : Reference
  quantity : Quantity
  delocalization : Delocalization
  method : Method
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, supportName c.support, referenceName c.reference, quantityName c.quantity, delocalizationName c.delocalization, methodName c.method, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "quantity=" (quantityName c.quantity), SFT.Host.Text.append "delocalization=" (delocalizationName c.delocalization), SFT.Host.Text.append "method=" (methodName c.method), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "identified-bond-carrier__complete-joining-channel-support__single-localized-pair-reference__exact-positive-rational-degree__rational-support-sharing-retained__partition-bound-index__bond-channel-reference-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "identified-bond-carrier" &&
  SFT.Host.Text.equal (supportName c.support) "complete-joining-channel-support" &&
  SFT.Host.Text.equal (referenceName c.reference) "single-localized-pair-reference" &&
  SFT.Host.Text.equal (quantityName c.quantity) "exact-positive-rational-degree" &&
  SFT.Host.Text.equal (delocalizationName c.delocalization) "rational-support-sharing-retained" &&
  SFT.Host.Text.equal (methodName c.method) "partition-bound-index" &&
  SFT.Host.Text.equal (recordName c.record) "bond-channel-reference-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "identified-bond-carrier") then "A number detached from a bond has no meaning." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-joining-channel-support") then "Omitting channels can force the degree." else
  if !(SFT.Host.Text.equal (referenceName c.reference) "single-localized-pair-reference") then "A free scale can select any order." else
  if !(SFT.Host.Text.equal (quantityName c.quantity) "exact-positive-rational-degree") then "Floating arithmetic cannot certify the exact support ratio." else
  if !(SFT.Host.Text.equal (delocalizationName c.delocalization) "rational-support-sharing-retained") then "Delocalized support can distribute a joining unit across links." else
  if !(SFT.Host.Text.equal (methodName c.method) "partition-bound-index") then "Different observational partitions can report different indices." else
  if !(SFT.Host.Text.equal (recordName c.record) "bond-channel-reference-trace") then "An index alone cannot reproduce support." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A correction can force a conventional integer." else
  "identified-bond-carrier__complete-joining-channel-support__single-localized-pair-reference__exact-positive-rational-degree"

def generationRule : String := "Generate the literal product of the registered bond-order carrier, support, reference, quantity, delocalization, method, record and extension choices."
def grammarBoundary : String := "Every finite identified bond with complete joining-channel support, measured relative to one localized electron-pair joining unit using exact positive counts or rational support parts."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Quantity.rejected,Quantity.admitted]).flatMap fun quantity =>
  ([Delocalization.rejected,Delocalization.admitted]).flatMap fun delocalization =>
  ([Method.rejected,Method.admitted]).flatMap fun method =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,support,reference,quantity,delocalization,method,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier support reference quantity delocalization method record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquantity : quantity ∈ [Quantity.rejected,Quantity.admitted] := by
      cases quantity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdelocalization : delocalization ∈ [Delocalization.rejected,Delocalization.admitted] := by
      cases delocalization <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmethod : method ∈ [Method.rejected,Method.admitted] := by
      cases method <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ quantity _ hquantity
    apply CommonRefinement.memFlatMap _ _ delocalization _ hdelocalization
    apply CommonRefinement.memFlatMap _ _ method _ hmethod
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier support reference quantity delocalization method record extension =>
    cases carrier <;> cases support <;> cases reference <;> cases quantity <;> cases delocalization <;> cases method <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier support reference quantity delocalization method record extension =>
    cases carrier <;> cases support <;> cases reference <;> cases quantity <;> cases delocalization <;> cases method <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.support = .admitted ∧ c.reference = .admitted ∧ c.quantity = .admitted ∧ c.delocalization = .admitted ∧ c.method = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier support reference quantity delocalization method record extension =>
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

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem reference_rejected_rejected (c : Candidate) (h : c.reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reference eq
    rw [h] at field
    cases field

theorem quantity_rejected_rejected (c : Candidate) (h : c.quantity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.quantity eq
    rw [h] at field
    cases field

theorem delocalization_rejected_rejected (c : Candidate) (h : c.delocalization = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.delocalization eq
    rw [h] at field
    cases field

theorem method_rejected_rejected (c : Candidate) (h : c.method = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.method eq
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

end SFT.Chemistry.OrderGrammar
