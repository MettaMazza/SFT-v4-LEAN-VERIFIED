import SFT.Chemistry.NomenclatureWord
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.NomenclatureGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "partial-name-fragment"
  | .admitted => "complete-name-carrier"

inductive Parts where
  | rejected | admitted

def partsName : Parts → String
  | .rejected => "unregistered-free-text"
  | .admitted => "generated-name-parts"

inductive Prefix where
  | rejected | admitted

def prefixName : Prefix → String
  | .rejected => "implicit-count"
  | .admitted => "count-prefix-support"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "unordered-syllable-bag"
  | .admitted => "held-name-order"

inductive Binding where
  | rejected | admitted

def bindingName : Binding → String
  | .rejected => "name-detached-from-formula"
  | .admitted => "formula-bound-name"

inductive Decode where
  | rejected | admitted

def decodeName : Decode → String
  | .rejected => "unconditional-reversibility"
  | .admitted => "injective-boundary-decoding"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "surface-name-only"
  | .admitted => "complete-name-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-naming-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  parts : Parts
  «prefix» : Prefix
  order : Order
  binding : Binding
  decode : Decode
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, partsName c.parts, prefixName c.«prefix», orderName c.order, bindingName c.binding, decodeName c.decode, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "parts=" (partsName c.parts), SFT.Host.Text.append "prefix=" (prefixName c.«prefix»), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "binding=" (bindingName c.binding), SFT.Host.Text.append "decode=" (decodeName c.decode), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-name-carrier__generated-name-parts__count-prefix-support__held-name-order__formula-bound-name__injective-boundary-decoding__complete-name-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-name-carrier" &&
  SFT.Host.Text.equal (partsName c.parts) "generated-name-parts" &&
  SFT.Host.Text.equal (prefixName c.«prefix») "count-prefix-support" &&
  SFT.Host.Text.equal (orderName c.order) "held-name-order" &&
  SFT.Host.Text.equal (bindingName c.binding) "formula-bound-name" &&
  SFT.Host.Text.equal (decodeName c.decode) "injective-boundary-decoding" &&
  SFT.Host.Text.equal (recordName c.record) "complete-name-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-name-carrier") then "A fragment alone does not carry one complete registered chemical name." else
  if !(SFT.Host.Text.equal (partsName c.parts) "generated-name-parts") then "Free text can import arbitrary answer-bearing distinctions." else
  if !(SFT.Host.Text.equal (prefixName c.«prefix») "count-prefix-support") then "An implicit multiplicity cannot be recovered from the name." else
  if !(SFT.Host.Text.equal (orderName c.order) "held-name-order") then "Unordered parts can merge names with distinct composition." else
  if !(SFT.Host.Text.equal (bindingName c.binding) "formula-bound-name") then "A detached name cannot preserve chemical identity." else
  if !(SFT.Host.Text.equal (decodeName c.decode) "injective-boundary-decoding") then "Not every conventional name is uniquely decodable, so reversibility cannot be assumed." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-name-trace") then "A surface name alone hides its assembly and decoding boundary." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A discretionary naming exception can select any desired identity." else
  "complete-name-carrier__generated-name-parts__count-prefix-support"

def generationRule : String := "Generate the literal product of the registered name carrier, parts, prefix, order, formula binding, decoding, record and extension choices."
def grammarBoundary : String := "Every positive-finite ordered chemical-name word assembled wholly from registered syllable labels and optional generated count prefixes, with an explicit injective-decoding boundary."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Parts.rejected,Parts.admitted]).flatMap fun parts =>
  ([Prefix.rejected,Prefix.admitted]).flatMap fun «prefix» =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Binding.rejected,Binding.admitted]).flatMap fun binding =>
  ([Decode.rejected,Decode.admitted]).flatMap fun decode =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,parts,«prefix»,order,binding,decode,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier parts «prefix» order binding decode record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hparts : parts ∈ [Parts.rejected,Parts.admitted] := by
      cases parts <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprefix : «prefix» ∈ [Prefix.rejected,Prefix.admitted] := by
      cases «prefix» <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbinding : binding ∈ [Binding.rejected,Binding.admitted] := by
      cases binding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdecode : decode ∈ [Decode.rejected,Decode.admitted] := by
      cases decode <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ parts _ hparts
    apply CommonRefinement.memFlatMap _ _ «prefix» _ hprefix
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ binding _ hbinding
    apply CommonRefinement.memFlatMap _ _ decode _ hdecode
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier parts «prefix» order binding decode record extension =>
    cases carrier <;> cases parts <;> cases «prefix» <;> cases order <;> cases binding <;> cases decode <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier parts «prefix» order binding decode record extension =>
    cases carrier <;> cases parts <;> cases «prefix» <;> cases order <;> cases binding <;> cases decode <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.parts = .admitted ∧ c.«prefix» = .admitted ∧ c.order = .admitted ∧ c.binding = .admitted ∧ c.decode = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier parts «prefix» order binding decode record extension =>
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

theorem parts_rejected_rejected (c : Candidate) (h : c.parts = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.parts eq
    rw [h] at field
    cases field

theorem prefix_rejected_rejected (c : Candidate) (h : c.«prefix» = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.«prefix» eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
    rw [h] at field
    cases field

theorem binding_rejected_rejected (c : Candidate) (h : c.binding = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.binding eq
    rw [h] at field
    cases field

theorem decode_rejected_rejected (c : Candidate) (h : c.decode = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.decode eq
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

end SFT.Chemistry.NomenclatureGrammar
