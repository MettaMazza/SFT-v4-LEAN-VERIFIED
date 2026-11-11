import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.YieldGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "percentage-without-product"
  | .admitted => "element-or-compound-product"

inductive Process where
  | rejected | admitted

def processName : Process → String
  | .rejected => "unspecified-process"
  | .admitted => "specified-reaction-or-separation"

inductive Numerator where
  | rejected | admitted

def numeratorName : Numerator → String
  | .rejected => "selected-favorable-product"
  | .admitted => "complete-observed-product-amount"

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "unbound-denominator"
  | .admitted => "registered-expected-support"

inductive Quantity where
  | rejected | admitted

def quantityName : Quantity → String
  | .rejected => "floating-percent"
  | .admitted => "exact-positive-amount-fraction"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-yield"
  | .admitted => "empty-product-outcome-form"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "yield-answer-only"
  | .admitted => "product-process-reference-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-yield-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  process : Process
  numerator : Numerator
  reference : Reference
  quantity : Quantity
  absence : Absence
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, processName c.process, numeratorName c.numerator, referenceName c.reference, quantityName c.quantity, absenceName c.absence, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "process=" (processName c.process), SFT.Host.Text.append "numerator=" (numeratorName c.numerator), SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "quantity=" (quantityName c.quantity), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "element-or-compound-product__specified-reaction-or-separation__complete-observed-product-amount__registered-expected-support__exact-positive-amount-fraction__empty-product-outcome-form__product-process-reference-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "element-or-compound-product" &&
  SFT.Host.Text.equal (processName c.process) "specified-reaction-or-separation" &&
  SFT.Host.Text.equal (numeratorName c.numerator) "complete-observed-product-amount" &&
  SFT.Host.Text.equal (referenceName c.reference) "registered-expected-support" &&
  SFT.Host.Text.equal (quantityName c.quantity) "exact-positive-amount-fraction" &&
  SFT.Host.Text.equal (absenceName c.absence) "empty-product-outcome-form" &&
  SFT.Host.Text.equal (recordName c.record) "product-process-reference-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "element-or-compound-product") then "A percentage detached from a product is not chemical yield." else
  if !(SFT.Host.Text.equal (processName c.process) "specified-reaction-or-separation") then "Yield depends on the declared reaction or separation." else
  if !(SFT.Host.Text.equal (numeratorName c.numerator) "complete-observed-product-amount") then "Selecting a favorable amount hides other outcomes." else
  if !(SFT.Host.Text.equal (referenceName c.reference) "registered-expected-support") then "A fraction without its reference is uninterpretable." else
  if !(SFT.Host.Text.equal (quantityName c.quantity) "exact-positive-amount-fraction") then "Floating output is not exact proof." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "empty-product-outcome-form") then "Zero is not an SFT proof value." else
  if !(SFT.Host.Text.equal (recordName c.record) "product-process-reference-trace") then "An answer loses product, process and reference provenance." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A correction can inflate the observed result." else
  "element-or-compound-product__specified-reaction-or-separation__complete-observed-product-amount__exact-positive-amount-fraction"

def generationRule : String := "Generate the literal product of the registered yield carrier, process, numerator, reference, quantity, absence, record and extension choices."
def grammarBoundary : String := "Every specified reaction or separation with a retained expected product support and a positive observed product amount represented as an exact part of that reference support."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Process.rejected,Process.admitted]).flatMap fun process =>
  ([Numerator.rejected,Numerator.admitted]).flatMap fun numerator =>
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Quantity.rejected,Quantity.admitted]).flatMap fun quantity =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,process,numerator,reference,quantity,absence,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier process numerator reference quantity absence record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprocess : process ∈ [Process.rejected,Process.admitted] := by
      cases process <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnumerator : numerator ∈ [Numerator.rejected,Numerator.admitted] := by
      cases numerator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquantity : quantity ∈ [Quantity.rejected,Quantity.admitted] := by
      cases quantity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ process _ hprocess
    apply CommonRefinement.memFlatMap _ _ numerator _ hnumerator
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ quantity _ hquantity
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier process numerator reference quantity absence record extension =>
    cases carrier <;> cases process <;> cases numerator <;> cases reference <;> cases quantity <;> cases absence <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier process numerator reference quantity absence record extension =>
    cases carrier <;> cases process <;> cases numerator <;> cases reference <;> cases quantity <;> cases absence <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.process = .admitted ∧ c.numerator = .admitted ∧ c.reference = .admitted ∧ c.quantity = .admitted ∧ c.absence = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier process numerator reference quantity absence record extension =>
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

theorem process_rejected_rejected (c : Candidate) (h : c.process = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.process eq
    rw [h] at field
    cases field

theorem numerator_rejected_rejected (c : Candidate) (h : c.numerator = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.numerator eq
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

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
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

end SFT.Chemistry.YieldGrammar
