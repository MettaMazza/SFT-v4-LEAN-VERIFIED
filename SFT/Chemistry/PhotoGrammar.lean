import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PhotoGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Radiation where
  | rejected | admitted

def radiationName : Radiation → String
  | .rejected => "anonymous-energy-input"
  | .admitted => "one-retained-photon-carrier"

inductive Absorption where
  | rejected | admitted

def absorptionName : Absorption → String
  | .rejected => "photon-copied"
  | .admitted => "carrier-absorbed-once"

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "ground-state-unchanged"
  | .admitted => "distinct-excited-state-support"

inductive Channel where
  | rejected | admitted

def channelName : Channel → String
  | .rejected => "unregistered-outcome"
  | .admitted => "source-bound-reaction-or-relaxation-channel"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "energy-erased"
  | .admitted => "complete-photon-molecule-energy-ledger"

inductive Selection where
  | rejected | admitted

def selectionName : Selection → String
  | .rejected => "free-quantum-yield-fit"
  | .admitted => "generated-channel-census"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "photochemical-label-only"
  | .admitted => "photon-state-channel-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-spectral-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  radiation : Radiation
  absorption : Absorption
  state : State
  channel : Channel
  conservation : Conservation
  selection : Selection
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [radiationName c.radiation, absorptionName c.absorption, stateName c.state, channelName c.channel, conservationName c.conservation, selectionName c.selection, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "radiation=" (radiationName c.radiation), SFT.Host.Text.append "absorption=" (absorptionName c.absorption), SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "channel=" (channelName c.channel), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "selection=" (selectionName c.selection), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "one-retained-photon-carrier__carrier-absorbed-once__distinct-excited-state-support__source-bound-reaction-or-relaxation-channel__complete-photon-molecule-energy-ledger__generated-channel-census__photon-state-channel-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (radiationName c.radiation) "one-retained-photon-carrier" &&
  SFT.Host.Text.equal (absorptionName c.absorption) "carrier-absorbed-once" &&
  SFT.Host.Text.equal (stateName c.state) "distinct-excited-state-support" &&
  SFT.Host.Text.equal (channelName c.channel) "source-bound-reaction-or-relaxation-channel" &&
  SFT.Host.Text.equal (conservationName c.conservation) "complete-photon-molecule-energy-ledger" &&
  SFT.Host.Text.equal (selectionName c.selection) "generated-channel-census" &&
  SFT.Host.Text.equal (recordName c.record) "photon-state-channel-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (radiationName c.radiation) "one-retained-photon-carrier") then "It cannot establish carrier identity." else
  if !(SFT.Host.Text.equal (absorptionName c.absorption) "carrier-absorbed-once") then "Copying violates conservation." else
  if !(SFT.Host.Text.equal (stateName c.state) "distinct-excited-state-support") then "No excitation occurs." else
  if !(SFT.Host.Text.equal (channelName c.channel) "source-bound-reaction-or-relaxation-channel") then "No chemical path is retained." else
  if !(SFT.Host.Text.equal (conservationName c.conservation) "complete-photon-molecule-energy-ledger") then "The path cannot close." else
  if !(SFT.Host.Text.equal (selectionName c.selection) "generated-channel-census") then "A fit can force outcomes." else
  if !(SFT.Host.Text.equal (recordName c.record) "photon-state-channel-trace") then "It cannot reproduce excitation." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "An imported rule selects a target." else
  "one-retained-photon-carrier__carrier-absorbed-once__distinct-excited-state-support__source-bound-reaction-or-relaxation-channel__complete-photon-molecule-energy-ledger"

def generationRule : String := "Generate the literal product of radiation, absorption, state, channel, conservation, selection, record and extension choices."
def grammarBoundary : String := "Every finite chemical path initiated when one retained radiation carrier is absorbed by a named molecular carrier, producing a distinct excited-state support and a source-bound reaction or relaxation channel with complete energy accounting."

def candidates : List Candidate :=
  ([Radiation.rejected,Radiation.admitted]).flatMap fun radiation =>
  ([Absorption.rejected,Absorption.admitted]).flatMap fun absorption =>
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Channel.rejected,Channel.admitted]).flatMap fun channel =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Selection.rejected,Selection.admitted]).flatMap fun selection =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨radiation,absorption,state,channel,conservation,selection,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk radiation absorption state channel conservation selection record extra =>
    have hradiation : radiation ∈ [Radiation.rejected,Radiation.admitted] := by
      cases radiation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsorption : absorption ∈ [Absorption.rejected,Absorption.admitted] := by
      cases absorption <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchannel : channel ∈ [Channel.rejected,Channel.admitted] := by
      cases channel <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hselection : selection ∈ [Selection.rejected,Selection.admitted] := by
      cases selection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ radiation _ hradiation
    apply CommonRefinement.memFlatMap _ _ absorption _ habsorption
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ channel _ hchannel
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ selection _ hselection
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk radiation absorption state channel conservation selection record extra =>
    cases radiation <;> cases absorption <;> cases state <;> cases channel <;> cases conservation <;> cases selection <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk radiation absorption state channel conservation selection record extra =>
    cases radiation <;> cases absorption <;> cases state <;> cases channel <;> cases conservation <;> cases selection <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.radiation = .admitted ∧ c.absorption = .admitted ∧ c.state = .admitted ∧ c.channel = .admitted ∧ c.conservation = .admitted ∧ c.selection = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk radiation absorption state channel conservation selection record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem radiation_rejected_rejected (c : Candidate) (h : c.radiation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.radiation eq
    rw [h] at field
    cases field

theorem absorption_rejected_rejected (c : Candidate) (h : c.absorption = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absorption eq
    rw [h] at field
    cases field

theorem state_rejected_rejected (c : Candidate) (h : c.state = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.state eq
    rw [h] at field
    cases field

theorem channel_rejected_rejected (c : Candidate) (h : c.channel = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.channel eq
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

theorem selection_rejected_rejected (c : Candidate) (h : c.selection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.selection eq
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

end SFT.Chemistry.PhotoGrammar
