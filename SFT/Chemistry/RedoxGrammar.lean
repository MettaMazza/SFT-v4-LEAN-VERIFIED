import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RedoxGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "anonymous-charge-change"
  | .admitted => "named-electron-carrier"

inductive Donor where
  | rejected | admitted

def donorName : Donor → String
  | .rejected => "donor-erased"
  | .admitted => "registered-oxidation-endpoint"

inductive Acceptor where
  | rejected | admitted

def acceptorName : Acceptor → String
  | .rejected => "acceptor-erased"
  | .admitted => "registered-reduction-endpoint"

inductive Coupling where
  | rejected | admitted

def couplingName : Coupling → String
  | .rejected => "independent-half-changes"
  | .admitted => "one-paired-transfer"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "different-carrier-after"
  | .admitted => "same-carrier-before-after"

inductive Accounting where
  | rejected | admitted

def accountingName : Accounting → String
  | .rejected => "one-sided-state-change"
  | .admitted => "opposed-assignment-updates"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "redox-label-only"
  | .admitted => "carrier-endpoint-coupling-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-electron-source"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  donor : Donor
  acceptor : Acceptor
  coupling : Coupling
  identity : Identity
  accounting : Accounting
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, donorName c.donor, acceptorName c.acceptor, couplingName c.coupling, identityName c.identity, accountingName c.accounting, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "donor=" (donorName c.donor), SFT.Host.Text.append "acceptor=" (acceptorName c.acceptor), SFT.Host.Text.append "coupling=" (couplingName c.coupling), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "accounting=" (accountingName c.accounting), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "named-electron-carrier__registered-oxidation-endpoint__registered-reduction-endpoint__one-paired-transfer__same-carrier-before-after__opposed-assignment-updates__carrier-endpoint-coupling-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "named-electron-carrier" &&
  SFT.Host.Text.equal (donorName c.donor) "registered-oxidation-endpoint" &&
  SFT.Host.Text.equal (acceptorName c.acceptor) "registered-reduction-endpoint" &&
  SFT.Host.Text.equal (couplingName c.coupling) "one-paired-transfer" &&
  SFT.Host.Text.equal (identityName c.identity) "same-carrier-before-after" &&
  SFT.Host.Text.equal (accountingName c.accounting) "opposed-assignment-updates" &&
  SFT.Host.Text.equal (recordName c.record) "carrier-endpoint-coupling-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "named-electron-carrier") then "It cannot establish electron conservation." else
  if !(SFT.Host.Text.equal (donorName c.donor) "registered-oxidation-endpoint") then "The carrier could be freely created." else
  if !(SFT.Host.Text.equal (acceptorName c.acceptor) "registered-reduction-endpoint") then "The carrier could be lost." else
  if !(SFT.Host.Text.equal (couplingName c.coupling) "one-paired-transfer") then "One open half violates conservation." else
  if !(SFT.Host.Text.equal (identityName c.identity) "same-carrier-before-after") then "That is replacement, not transfer." else
  if !(SFT.Host.Text.equal (accountingName c.accounting) "opposed-assignment-updates") then "One side cannot close the assignment." else
  if !(SFT.Host.Text.equal (recordName c.record) "carrier-endpoint-coupling-trace") then "A label cannot reverse the event." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A free source breaks closure." else
  "named-electron-carrier__registered-oxidation-endpoint__registered-reduction-endpoint__one-paired-transfer__same-carrier-before-after"

def generationRule : String := "Generate the literal product of carrier, donor, acceptor, coupling, identity, accounting, record and extra-rule choices."
def grammarBoundary : String := "Every finite closed electron-labelled transfer between distinct chemical endpoints, with identical carrier identity before and after and paired donor loss/acceptor gain or their complete oxidation-assignment equivalents."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Donor.rejected,Donor.admitted]).flatMap fun donor =>
  ([Acceptor.rejected,Acceptor.admitted]).flatMap fun acceptor =>
  ([Coupling.rejected,Coupling.admitted]).flatMap fun coupling =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Accounting.rejected,Accounting.admitted]).flatMap fun accounting =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨carrier,donor,acceptor,coupling,identity,accounting,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier donor acceptor coupling identity accounting record extra =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdonor : donor ∈ [Donor.rejected,Donor.admitted] := by
      cases donor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hacceptor : acceptor ∈ [Acceptor.rejected,Acceptor.admitted] := by
      cases acceptor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoupling : coupling ∈ [Coupling.rejected,Coupling.admitted] := by
      cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haccounting : accounting ∈ [Accounting.rejected,Accounting.admitted] := by
      cases accounting <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ donor _ hdonor
    apply CommonRefinement.memFlatMap _ _ acceptor _ hacceptor
    apply CommonRefinement.memFlatMap _ _ coupling _ hcoupling
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ accounting _ haccounting
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier donor acceptor coupling identity accounting record extra =>
    cases carrier <;> cases donor <;> cases acceptor <;> cases coupling <;> cases identity <;> cases accounting <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier donor acceptor coupling identity accounting record extra =>
    cases carrier <;> cases donor <;> cases acceptor <;> cases coupling <;> cases identity <;> cases accounting <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.donor = .admitted ∧ c.acceptor = .admitted ∧ c.coupling = .admitted ∧ c.identity = .admitted ∧ c.accounting = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier donor acceptor coupling identity accounting record extra =>
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

theorem coupling_rejected_rejected (c : Candidate) (h : c.coupling = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coupling eq
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

theorem accounting_rejected_rejected (c : Candidate) (h : c.accounting = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.accounting eq
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

theorem extra_rejected_rejected (c : Candidate) (h : c.extra = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Chemistry.RedoxGrammar
