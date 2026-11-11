import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CompositionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "bulk-label-only"
  | .admitted => "complete-chemical-carrier"

inductive Components where
  | rejected | admitted

def componentsName : Components → String
  | .rejected => "anonymous-parts"
  | .admitted => "distinct-constituent-identities"

inductive Quantity where
  | rejected | admitted

def quantityName : Quantity → String
  | .rejected => "floating-percentages"
  | .admitted => "exact-positive-rational-parts"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "partial-selected-composition"
  | .admitted => "parts-exhaust-the-One"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "zero-valued-components"
  | .admitted => "absent-component-omitted"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "interchangeable-constituents"
  | .admitted => "constituent-identity-retained"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "composition-answer-only"
  | .admitted => "identity-part-source-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-normalization-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  components : Components
  quantity : Quantity
  closure : Closure
  absence : Absence
  identity : Identity
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, componentsName c.components, quantityName c.quantity, closureName c.closure, absenceName c.absence, identityName c.identity, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "components=" (componentsName c.components), SFT.Host.Text.append "quantity=" (quantityName c.quantity), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-chemical-carrier__distinct-constituent-identities__exact-positive-rational-parts__parts-exhaust-the-One__absent-component-omitted__constituent-identity-retained__identity-part-source-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-chemical-carrier" &&
  SFT.Host.Text.equal (componentsName c.components) "distinct-constituent-identities" &&
  SFT.Host.Text.equal (quantityName c.quantity) "exact-positive-rational-parts" &&
  SFT.Host.Text.equal (closureName c.closure) "parts-exhaust-the-One" &&
  SFT.Host.Text.equal (absenceName c.absence) "absent-component-omitted" &&
  SFT.Host.Text.equal (identityName c.identity) "constituent-identity-retained" &&
  SFT.Host.Text.equal (recordName c.record) "identity-part-source-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-chemical-carrier") then "A bulk label erases constituent support." else
  if !(SFT.Host.Text.equal (componentsName c.components) "distinct-constituent-identities") then "Anonymous parts cannot preserve chemical identity." else
  if !(SFT.Host.Text.equal (quantityName c.quantity) "exact-positive-rational-parts") then "Floating percentages cannot certify exact closure." else
  if !(SFT.Host.Text.equal (closureName c.closure) "parts-exhaust-the-One") then "Selected components need not exhaust the carrier." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "absent-component-omitted") then "Numerical zero is not an SFT composition object." else
  if !(SFT.Host.Text.equal (identityName c.identity) "constituent-identity-retained") then "Equal amounts do not make substances identical." else
  if !(SFT.Host.Text.equal (recordName c.record) "identity-part-source-trace") then "An answer loses part and source provenance." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A correction could force closure after the fact." else
  "complete-chemical-carrier__distinct-constituent-identities__exact-positive-rational-parts__parts-exhaust-the-One"

def generationRule : String := "Generate the literal product of the registered composition carrier, components, quantity, closure, absence, identity, record and extension choices."
def grammarBoundary : String := "Every finite chemical carrier whose distinct constituent identities have exact positive rational parts that exhaust the One and preserve the measurement/source boundary."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Components.rejected,Components.admitted]).flatMap fun components =>
  ([Quantity.rejected,Quantity.admitted]).flatMap fun quantity =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,components,quantity,closure,absence,identity,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier components quantity closure absence identity record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomponents : components ∈ [Components.rejected,Components.admitted] := by
      cases components <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquantity : quantity ∈ [Quantity.rejected,Quantity.admitted] := by
      cases quantity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ components _ hcomponents
    apply CommonRefinement.memFlatMap _ _ quantity _ hquantity
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier components quantity closure absence identity record extension =>
    cases carrier <;> cases components <;> cases quantity <;> cases closure <;> cases absence <;> cases identity <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier components quantity closure absence identity record extension =>
    cases carrier <;> cases components <;> cases quantity <;> cases closure <;> cases absence <;> cases identity <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.components = .admitted ∧ c.quantity = .admitted ∧ c.closure = .admitted ∧ c.absence = .admitted ∧ c.identity = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier components quantity closure absence identity record extension =>
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

theorem components_rejected_rejected (c : Candidate) (h : c.components = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.components eq
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

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
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

end SFT.Chemistry.CompositionGrammar
