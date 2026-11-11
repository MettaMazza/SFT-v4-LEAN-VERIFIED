import SFT.Chemistry.TraceabilityChain
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.TraceabilityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Property where
  | rejected | admitted

def propertyName : Property → String
  | .rejected => "value-without-property"
  | .admitted => "reference-material-property"

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "anonymous-reference"
  | .admitted => "identified-reference-realization"

inductive Uncertainty where
  | rejected | admitted

def uncertaintyName : Uncertainty → String
  | .rejected => "uncertainty-erased"
  | .admitted => "uncertainty-retained"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "broken-predecessor-chain"
  | .admitted => "traceability-retained"

inductive Certificate where
  | rejected | admitted

def certificateName : Certificate → String
  | .rejected => "uncertified-result-label"
  | .admitted => "certificate-bound-record"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "substitutable-sample"
  | .admitted => "material-identity-held"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "terminal-value-only"
  | .admitted => "complete-chain-record"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-trace-link"
  | .admitted => "no-extra-rule"

structure Candidate where
  property : Property
  reference : Reference
  uncertainty : Uncertainty
  trace : Trace
  certificate : Certificate
  identity : Identity
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [propertyName c.property, referenceName c.reference, uncertaintyName c.uncertainty, traceName c.trace, certificateName c.certificate, identityName c.identity, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "property=" (propertyName c.property), SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "uncertainty=" (uncertaintyName c.uncertainty), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "certificate=" (certificateName c.certificate), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "reference-material-property__identified-reference-realization__uncertainty-retained__traceability-retained__certificate-bound-record__material-identity-held__complete-chain-record__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (propertyName c.property) "reference-material-property" &&
  SFT.Host.Text.equal (referenceName c.reference) "identified-reference-realization" &&
  SFT.Host.Text.equal (uncertaintyName c.uncertainty) "uncertainty-retained" &&
  SFT.Host.Text.equal (traceName c.trace) "traceability-retained" &&
  SFT.Host.Text.equal (certificateName c.certificate) "certificate-bound-record" &&
  SFT.Host.Text.equal (identityName c.identity) "material-identity-held" &&
  SFT.Host.Text.equal (recordName c.record) "complete-chain-record" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (propertyName c.property) "reference-material-property") then "A value without a property identity cannot be traced." else
  if !(SFT.Host.Text.equal (referenceName c.reference) "identified-reference-realization") then "An anonymous comparison object cannot anchor a trace chain." else
  if !(SFT.Host.Text.equal (uncertaintyName c.uncertainty) "uncertainty-retained") then "Erasing uncertainty overstates what each comparison preserves." else
  if !(SFT.Host.Text.equal (traceName c.trace) "traceability-retained") then "A missing predecessor prevents reconstruction to the reference." else
  if !(SFT.Host.Text.equal (certificateName c.certificate) "certificate-bound-record") then "A result label alone does not bind property, reference and trace." else
  if !(SFT.Host.Text.equal (identityName c.identity) "material-identity-held") then "Silent sample substitution breaks traceability while preserving a surface value." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-chain-record") then "A terminal value cannot reproduce the chain." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An unregistered link can hide a discontinuity." else
  "reference-material-property__uncertainty-retained__traceability-retained__certificate-bound-record"

def generationRule : String := "Generate the literal product of the registered property, reference, uncertainty, trace, certificate, identity, record and extension choices."
def grammarBoundary : String := "Every positive-finite certified chemical-property chain whose reference material, property identity, uncertainty, predecessor links and certificate record are retained to an admitted reference realization."

def candidates : List Candidate :=
  ([Property.rejected,Property.admitted]).flatMap fun property =>
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Uncertainty.rejected,Uncertainty.admitted]).flatMap fun uncertainty =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Certificate.rejected,Certificate.admitted]).flatMap fun certificate =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨property,reference,uncertainty,trace,certificate,identity,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk property reference uncertainty trace certificate identity record extension =>
    have hproperty : property ∈ [Property.rejected,Property.admitted] := by
      cases property <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huncertainty : uncertainty ∈ [Uncertainty.rejected,Uncertainty.admitted] := by
      cases uncertainty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcertificate : certificate ∈ [Certificate.rejected,Certificate.admitted] := by
      cases certificate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ property _ hproperty
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ uncertainty _ huncertainty
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    apply CommonRefinement.memFlatMap _ _ certificate _ hcertificate
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk property reference uncertainty trace certificate identity record extension =>
    cases property <;> cases reference <;> cases uncertainty <;> cases trace <;> cases certificate <;> cases identity <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk property reference uncertainty trace certificate identity record extension =>
    cases property <;> cases reference <;> cases uncertainty <;> cases trace <;> cases certificate <;> cases identity <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.property = .admitted ∧ c.reference = .admitted ∧ c.uncertainty = .admitted ∧ c.trace = .admitted ∧ c.certificate = .admitted ∧ c.identity = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk property reference uncertainty trace certificate identity record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem property_rejected_rejected (c : Candidate) (h : c.property = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.property eq
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

theorem uncertainty_rejected_rejected (c : Candidate) (h : c.uncertainty = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.uncertainty eq
    rw [h] at field
    cases field

theorem trace_rejected_rejected (c : Candidate) (h : c.trace = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trace eq
    rw [h] at field
    cases field

theorem certificate_rejected_rejected (c : Candidate) (h : c.certificate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.certificate eq
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

end SFT.Chemistry.TraceabilityGrammar
