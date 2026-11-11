import SFT.Chemistry.SpeciesClass
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.SpeciesGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "singular-only"
  | .admitted => "ensemble-carrier"

inductive Member_identity where
  | rejected | admitted

def member_identityName : Member_identity → String
  | .rejected => "mixed-chemical-identities"
  | .admitted => "chemical-identity-equivalence"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "energy-support-erased"
  | .admitted => "shared-energy-support"

inductive Timescale where
  | rejected | admitted

def timescaleName : Timescale → String
  | .rejected => "timeless-equivalence"
  | .admitted => "experiment-timescale-boundary"

inductive Solid_support where
  | rejected | admitted

def solid_supportName : Solid_support → String
  | .rejected => "isolated-molecule-only"
  | .admitted => "molecular-or-solid-unit-support"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "class-without-member-trace"
  | .admitted => "held-member-and-class-record"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "unbound-provenance"
  | .admitted => "source-bound-proof-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-equivalence"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  member_identity : Member_identity
  support : Support
  timescale : Timescale
  solid_support : Solid_support
  record : Record
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, member_identityName c.member_identity, supportName c.support, timescaleName c.timescale, solid_supportName c.solid_support, recordName c.record, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "member_identity=" (member_identityName c.member_identity), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "timescale=" (timescaleName c.timescale), SFT.Host.Text.append "solid_support=" (solid_supportName c.solid_support), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "ensemble-carrier__chemical-identity-equivalence__shared-energy-support__experiment-timescale-boundary__molecular-or-solid-unit-support__held-member-and-class-record__source-bound-proof-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "ensemble-carrier" &&
  SFT.Host.Text.equal (member_identityName c.member_identity) "chemical-identity-equivalence" &&
  SFT.Host.Text.equal (supportName c.support) "shared-energy-support" &&
  SFT.Host.Text.equal (timescaleName c.timescale) "experiment-timescale-boundary" &&
  SFT.Host.Text.equal (solid_supportName c.solid_support) "molecular-or-solid-unit-support" &&
  SFT.Host.Text.equal (recordName c.record) "held-member-and-class-record" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "source-bound-proof-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "ensemble-carrier") then "One member alone is not a chemical species class." else
  if !(SFT.Host.Text.equal (member_identityName c.member_identity) "chemical-identity-equivalence") then "Mixed chemical identities do not form one species." else
  if !(SFT.Host.Text.equal (supportName c.support) "shared-energy-support") then "Erasing accessible-state support merges experimentally distinct species." else
  if !(SFT.Host.Text.equal (timescaleName c.timescale) "experiment-timescale-boundary") then "Interconversion can change whether two forms are experimentally distinct." else
  if !(SFT.Host.Text.equal (solid_supportName c.solid_support) "molecular-or-solid-unit-support") then "A species law limited to isolable molecules loses solid structural units." else
  if !(SFT.Host.Text.equal (recordName c.record) "held-member-and-class-record") then "A quotient without member trace cannot be reconstructed." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "source-bound-proof-trace") then "An unbound class can silently change its equivalence rule." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A discretionary equivalence can force any desired species partition." else
  "ensemble-carrier__chemical-identity-equivalence__shared-energy-support__experiment-timescale-boundary"

def generationRule : String := "Generate the literal product of the registered species carrier, member identity, state support, timescale, solid support, record, provenance and extension choices."
def grammarBoundary : String := "Every finite observation-equivalence class formed from admitted singular chemical entities under an exact declared experiment-timescale relation and any positive-finite successor extension."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Member_identity.rejected,Member_identity.admitted]).flatMap fun member_identity =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Timescale.rejected,Timescale.admitted]).flatMap fun timescale =>
  ([Solid_support.rejected,Solid_support.admitted]).flatMap fun solid_support =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,member_identity,support,timescale,solid_support,record,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier member_identity support timescale solid_support record provenance extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmember_identity : member_identity ∈ [Member_identity.rejected,Member_identity.admitted] := by
      cases member_identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htimescale : timescale ∈ [Timescale.rejected,Timescale.admitted] := by
      cases timescale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsolid_support : solid_support ∈ [Solid_support.rejected,Solid_support.admitted] := by
      cases solid_support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ member_identity _ hmember_identity
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ timescale _ htimescale
    apply CommonRefinement.memFlatMap _ _ solid_support _ hsolid_support
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier member_identity support timescale solid_support record provenance extension =>
    cases carrier <;> cases member_identity <;> cases support <;> cases timescale <;> cases solid_support <;> cases record <;> cases provenance <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier member_identity support timescale solid_support record provenance extension =>
    cases carrier <;> cases member_identity <;> cases support <;> cases timescale <;> cases solid_support <;> cases record <;> cases provenance <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.member_identity = .admitted ∧ c.support = .admitted ∧ c.timescale = .admitted ∧ c.solid_support = .admitted ∧ c.record = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier member_identity support timescale solid_support record provenance extension =>
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

theorem member_identity_rejected_rejected (c : Candidate) (h : c.member_identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.member_identity eq
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

theorem timescale_rejected_rejected (c : Candidate) (h : c.timescale = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.timescale eq
    rw [h] at field
    cases field

theorem solid_support_rejected_rejected (c : Candidate) (h : c.solid_support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.solid_support eq
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

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
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

end SFT.Chemistry.SpeciesGrammar
