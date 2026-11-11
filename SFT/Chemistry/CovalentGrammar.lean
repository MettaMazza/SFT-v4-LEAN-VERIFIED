import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CovalentGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "bond-without-nuclei"
  | .admitted => "identified-nuclear-pair"

inductive Electron where
  | rejected | admitted

def electronName : Electron → String
  | .rejected => "electron-assigned-to-one-centre"
  | .admitted => "joint-electron-support"

inductive Sharing where
  | rejected | admitted

def sharingName : Sharing → String
  | .rejected => "copied-electron-label"
  | .admitted => "one-support-shared-access"

inductive Density where
  | rejected | admitted

def densityName : Density → String
  | .rejected => "empty-internuclear-path"
  | .admitted => "internuclear-accessible-region"

inductive Attraction where
  | rejected | admitted

def attractionName : Attraction → String
  | .rejected => "unbound-force-label"
  | .admitted => "stable-contractive-response"

inductive Occupation where
  | rejected | admitted

def occupationName : Occupation → String
  | .rejected => "duplicate-identical-cell"
  | .admitted => "exclusion-preserving-channels"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "covalent-label-only"
  | .admitted => "nuclei-channel-sharing-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-orbital-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  electron : Electron
  sharing : Sharing
  density : Density
  attraction : Attraction
  occupation : Occupation
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, electronName c.electron, sharingName c.sharing, densityName c.density, attractionName c.attraction, occupationName c.occupation, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "electron=" (electronName c.electron), SFT.Host.Text.append "sharing=" (sharingName c.sharing), SFT.Host.Text.append "density=" (densityName c.density), SFT.Host.Text.append "attraction=" (attractionName c.attraction), SFT.Host.Text.append "occupation=" (occupationName c.occupation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "identified-nuclear-pair__joint-electron-support__one-support-shared-access__internuclear-accessible-region__stable-contractive-response__exclusion-preserving-channels__nuclei-channel-sharing-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "identified-nuclear-pair" &&
  SFT.Host.Text.equal (electronName c.electron) "joint-electron-support" &&
  SFT.Host.Text.equal (sharingName c.sharing) "one-support-shared-access" &&
  SFT.Host.Text.equal (densityName c.density) "internuclear-accessible-region" &&
  SFT.Host.Text.equal (attractionName c.attraction) "stable-contractive-response" &&
  SFT.Host.Text.equal (occupationName c.occupation) "exclusion-preserving-channels" &&
  SFT.Host.Text.equal (recordName c.record) "nuclei-channel-sharing-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "identified-nuclear-pair") then "Covalent support relates identified atomic centres." else
  if !(SFT.Host.Text.equal (electronName c.electron) "joint-electron-support") then "One-centre support alone is not shared bonding support." else
  if !(SFT.Host.Text.equal (sharingName c.sharing) "one-support-shared-access") then "Copying one conserved carrier violates exclusion and conservation." else
  if !(SFT.Host.Text.equal (densityName c.density) "internuclear-accessible-region") then "No connecting support cannot join the nuclei." else
  if !(SFT.Host.Text.equal (attractionName c.attraction) "stable-contractive-response") then "A force name without recurrence does not establish a bond." else
  if !(SFT.Host.Text.equal (occupationName c.occupation) "exclusion-preserving-channels") then "Duplicated identical occupation violates exclusion." else
  if !(SFT.Host.Text.equal (recordName c.record) "nuclei-channel-sharing-trace") then "A label cannot reconstruct sharing." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An imported orbital choice can select a desired bond." else
  "identified-nuclear-pair__joint-electron-support__one-support-shared-access__internuclear-accessible-region"

def generationRule : String := "Generate the literal product of the registered covalent carrier, electron, sharing, density, attraction, occupation, record and extension choices."
def grammarBoundary : String := "Every finite bonded atomic support with one or more electron-labelled recurrence channels jointly accessible to both nuclear carriers and exclusion-preserving occupation."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Electron.rejected,Electron.admitted]).flatMap fun electron =>
  ([Sharing.rejected,Sharing.admitted]).flatMap fun sharing =>
  ([Density.rejected,Density.admitted]).flatMap fun density =>
  ([Attraction.rejected,Attraction.admitted]).flatMap fun attraction =>
  ([Occupation.rejected,Occupation.admitted]).flatMap fun occupation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,electron,sharing,density,attraction,occupation,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier electron sharing density attraction occupation record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helectron : electron ∈ [Electron.rejected,Electron.admitted] := by
      cases electron <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsharing : sharing ∈ [Sharing.rejected,Sharing.admitted] := by
      cases sharing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdensity : density ∈ [Density.rejected,Density.admitted] := by
      cases density <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hattraction : attraction ∈ [Attraction.rejected,Attraction.admitted] := by
      cases attraction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoccupation : occupation ∈ [Occupation.rejected,Occupation.admitted] := by
      cases occupation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ electron _ helectron
    apply CommonRefinement.memFlatMap _ _ sharing _ hsharing
    apply CommonRefinement.memFlatMap _ _ density _ hdensity
    apply CommonRefinement.memFlatMap _ _ attraction _ hattraction
    apply CommonRefinement.memFlatMap _ _ occupation _ hoccupation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier electron sharing density attraction occupation record extension =>
    cases carrier <;> cases electron <;> cases sharing <;> cases density <;> cases attraction <;> cases occupation <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier electron sharing density attraction occupation record extension =>
    cases carrier <;> cases electron <;> cases sharing <;> cases density <;> cases attraction <;> cases occupation <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.electron = .admitted ∧ c.sharing = .admitted ∧ c.density = .admitted ∧ c.attraction = .admitted ∧ c.occupation = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier electron sharing density attraction occupation record extension =>
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

theorem sharing_rejected_rejected (c : Candidate) (h : c.sharing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sharing eq
    rw [h] at field
    cases field

theorem density_rejected_rejected (c : Candidate) (h : c.density = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.density eq
    rw [h] at field
    cases field

theorem attraction_rejected_rejected (c : Candidate) (h : c.attraction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.attraction eq
    rw [h] at field
    cases field

theorem occupation_rejected_rejected (c : Candidate) (h : c.occupation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.occupation eq
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

end SFT.Chemistry.CovalentGrammar
