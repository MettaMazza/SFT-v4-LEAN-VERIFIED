import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.LewisGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Endpoints where
  | rejected | admitted

def endpointsName : Endpoints → String
  | .rejected => "one-unoriented-species"
  | .admitted => "distinct-donor-acceptor"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "single-electron-only"
  | .admitted => "two-electron-occurrences"

inductive Donor where
  | rejected | admitted

def donorName : Donor → String
  | .rejected => "electron-pair-name-only"
  | .admitted => "pair-donor-support"

inductive Acceptor where
  | rejected | admitted

def acceptorName : Acceptor → String
  | .rejected => "unregistered-vacancy"
  | .admitted => "pair-acceptor-support"

inductive Joining where
  | rejected | admitted

def joiningName : Joining → String
  | .rejected => "copied-electron-pair"
  | .admitted => "shared-or-transferred-pair"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "electron-identity-erased"
  | .admitted => "both-electron-identities-retained"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "Lewis-label-only"
  | .admitted => "endpoint-pair-joining-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-orbital-premise"
  | .admitted => "no-extra-rule"

structure Candidate where
  endpoints : Endpoints
  support : Support
  donor : Donor
  acceptor : Acceptor
  joining : Joining
  conservation : Conservation
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [endpointsName c.endpoints, supportName c.support, donorName c.donor, acceptorName c.acceptor, joiningName c.joining, conservationName c.conservation, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "endpoints=" (endpointsName c.endpoints), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "donor=" (donorName c.donor), SFT.Host.Text.append "acceptor=" (acceptorName c.acceptor), SFT.Host.Text.append "joining=" (joiningName c.joining), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "distinct-donor-acceptor__two-electron-occurrences__pair-donor-support__pair-acceptor-support__shared-or-transferred-pair__both-electron-identities-retained__endpoint-pair-joining-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (endpointsName c.endpoints) "distinct-donor-acceptor" &&
  SFT.Host.Text.equal (supportName c.support) "two-electron-occurrences" &&
  SFT.Host.Text.equal (donorName c.donor) "pair-donor-support" &&
  SFT.Host.Text.equal (acceptorName c.acceptor) "pair-acceptor-support" &&
  SFT.Host.Text.equal (joiningName c.joining) "shared-or-transferred-pair" &&
  SFT.Host.Text.equal (conservationName c.conservation) "both-electron-identities-retained" &&
  SFT.Host.Text.equal (recordName c.record) "endpoint-pair-joining-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (endpointsName c.endpoints) "distinct-donor-acceptor") then "The relation requires donor and acceptor roles." else
  if !(SFT.Host.Text.equal (supportName c.support) "two-electron-occurrences") then "The registered relation concerns paired support." else
  if !(SFT.Host.Text.equal (donorName c.donor) "pair-donor-support") then "A name cannot demonstrate available support." else
  if !(SFT.Host.Text.equal (acceptorName c.acceptor) "pair-acceptor-support") then "An unregistered destination cannot close the interaction." else
  if !(SFT.Host.Text.equal (joiningName c.joining) "shared-or-transferred-pair") then "Copying violates exclusion and conservation." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "both-electron-identities-retained") then "Erasure cannot reverse the relation." else
  if !(SFT.Host.Text.equal (recordName c.record) "endpoint-pair-joining-trace") then "A label cannot reconstruct pair support." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An imported orbital rule can select a desired classification." else
  "distinct-donor-acceptor__two-electron-occurrences__pair-donor-support__pair-acceptor-support__shared-or-transferred-pair"

def generationRule : String := "Generate the literal product of the registered Lewis endpoints, support, donor, acceptor, joining, conservation, record and extension choices."
def grammarBoundary : String := "Every finite donor/acceptor pair joined by one exclusion-preserving pair of named electron occurrences, with both electron identities conserved and the donor/acceptor orientation retained."

def candidates : List Candidate :=
  ([Endpoints.rejected,Endpoints.admitted]).flatMap fun endpoints =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Donor.rejected,Donor.admitted]).flatMap fun donor =>
  ([Acceptor.rejected,Acceptor.admitted]).flatMap fun acceptor =>
  ([Joining.rejected,Joining.admitted]).flatMap fun joining =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨endpoints,support,donor,acceptor,joining,conservation,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk endpoints support donor acceptor joining conservation record extension =>
    have hendpoints : endpoints ∈ [Endpoints.rejected,Endpoints.admitted] := by
      cases endpoints <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdonor : donor ∈ [Donor.rejected,Donor.admitted] := by
      cases donor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hacceptor : acceptor ∈ [Acceptor.rejected,Acceptor.admitted] := by
      cases acceptor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjoining : joining ∈ [Joining.rejected,Joining.admitted] := by
      cases joining <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ endpoints _ hendpoints
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ donor _ hdonor
    apply CommonRefinement.memFlatMap _ _ acceptor _ hacceptor
    apply CommonRefinement.memFlatMap _ _ joining _ hjoining
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk endpoints support donor acceptor joining conservation record extension =>
    cases endpoints <;> cases support <;> cases donor <;> cases acceptor <;> cases joining <;> cases conservation <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk endpoints support donor acceptor joining conservation record extension =>
    cases endpoints <;> cases support <;> cases donor <;> cases acceptor <;> cases joining <;> cases conservation <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.endpoints = .admitted ∧ c.support = .admitted ∧ c.donor = .admitted ∧ c.acceptor = .admitted ∧ c.joining = .admitted ∧ c.conservation = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk endpoints support donor acceptor joining conservation record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem endpoints_rejected_rejected (c : Candidate) (h : c.endpoints = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.endpoints eq
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

theorem donor_rejected_rejected (c : Candidate) (h : c.donor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.donor eq
    rw [h] at field
    cases field

theorem acceptor_rejected_rejected (c : Candidate) (h : c.acceptor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.acceptor eq
    rw [h] at field
    cases field

theorem joining_rejected_rejected (c : Candidate) (h : c.joining = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.joining eq
    rw [h] at field
    cases field

theorem conservation_rejected_rejected (c : Candidate) (h : c.conservation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conservation eq
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

end SFT.Chemistry.LewisGrammar
