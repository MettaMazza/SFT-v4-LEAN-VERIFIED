import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MetallicGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "isolated-atom-pair"
  | .admitted => "connected-atomic-network"

inductive Electron where
  | rejected | admitted

def electronName : Electron → String
  | .rejected => "localized-pair-only"
  | .admitted => "delocalized-electron-support"

inductive Extent where
  | rejected | admitted

def extentName : Extent → String
  | .rejected => "unrecorded-infinite-lattice"
  | .admitted => "finite-whole-network-extent"

inductive Joining where
  | rejected | admitted

def joiningName : Joining → String
  | .rejected => "independent-local-bonds-only"
  | .admitted => "collective-shared-support"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "transient-conduction-only"
  | .admitted => "stable-collective-recurrence"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "anonymous-metal-label"
  | .admitted => "atomic-and-network-identities"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "metallic-label-only"
  | .admitted => "network-electron-recurrence-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-electron-sea-premise"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  electron : Electron
  extent : Extent
  joining : Joining
  recurrence : Recurrence
  identity : Identity
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, electronName c.electron, extentName c.extent, joiningName c.joining, recurrenceName c.recurrence, identityName c.identity, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "electron=" (electronName c.electron), SFT.Host.Text.append "extent=" (extentName c.extent), SFT.Host.Text.append "joining=" (joiningName c.joining), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "connected-atomic-network__delocalized-electron-support__finite-whole-network-extent__collective-shared-support__stable-collective-recurrence__atomic-and-network-identities__network-electron-recurrence-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "connected-atomic-network" &&
  SFT.Host.Text.equal (electronName c.electron) "delocalized-electron-support" &&
  SFT.Host.Text.equal (extentName c.extent) "finite-whole-network-extent" &&
  SFT.Host.Text.equal (joiningName c.joining) "collective-shared-support" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "stable-collective-recurrence" &&
  SFT.Host.Text.equal (identityName c.identity) "atomic-and-network-identities" &&
  SFT.Host.Text.equal (recordName c.record) "network-electron-recurrence-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "connected-atomic-network") then "Metallic support is collective rather than one fixed pair." else
  if !(SFT.Host.Text.equal (electronName c.electron) "delocalized-electron-support") then "A fixed pair cannot mediate the complete network." else
  if !(SFT.Host.Text.equal (extentName c.extent) "finite-whole-network-extent") then "A completed infinite lattice is not generated." else
  if !(SFT.Host.Text.equal (joiningName c.joining) "collective-shared-support") then "Independent local pairs omit collective redistribution." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "stable-collective-recurrence") then "Transport alone does not establish stable bonding." else
  if !(SFT.Host.Text.equal (identityName c.identity) "atomic-and-network-identities") then "A metal label cannot create the law." else
  if !(SFT.Host.Text.equal (recordName c.record) "network-electron-recurrence-trace") then "A label cannot reproduce topology and support." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An imported metaphor cannot select the structure." else
  "connected-atomic-network__delocalized-electron-support__finite-whole-network-extent__collective-shared-support"

def generationRule : String := "Generate the literal product of the registered metallic carrier, electron, extent, joining, recurrence, identity, record and extension choices."
def grammarBoundary : String := "Every finite connected atomic network whose electron-labelled accessible support extends across multiple atomic cells and whose collective recurrence stabilizes the whole carrier."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Electron.rejected,Electron.admitted]).flatMap fun electron =>
  ([Extent.rejected,Extent.admitted]).flatMap fun extent =>
  ([Joining.rejected,Joining.admitted]).flatMap fun joining =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,electron,extent,joining,recurrence,identity,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier electron extent joining recurrence identity record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helectron : electron ∈ [Electron.rejected,Electron.admitted] := by
      cases electron <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextent : extent ∈ [Extent.rejected,Extent.admitted] := by
      cases extent <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjoining : joining ∈ [Joining.rejected,Joining.admitted] := by
      cases joining <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ electron _ helectron
    apply CommonRefinement.memFlatMap _ _ extent _ hextent
    apply CommonRefinement.memFlatMap _ _ joining _ hjoining
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier electron extent joining recurrence identity record extension =>
    cases carrier <;> cases electron <;> cases extent <;> cases joining <;> cases recurrence <;> cases identity <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier electron extent joining recurrence identity record extension =>
    cases carrier <;> cases electron <;> cases extent <;> cases joining <;> cases recurrence <;> cases identity <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.electron = .admitted ∧ c.extent = .admitted ∧ c.joining = .admitted ∧ c.recurrence = .admitted ∧ c.identity = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier electron extent joining recurrence identity record extension =>
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

theorem electron_rejected_rejected (c : Candidate) (h : c.electron = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.electron eq
    rw [h] at field
    cases field

theorem extent_rejected_rejected (c : Candidate) (h : c.extent = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extent eq
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

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
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

end SFT.Chemistry.MetallicGrammar
