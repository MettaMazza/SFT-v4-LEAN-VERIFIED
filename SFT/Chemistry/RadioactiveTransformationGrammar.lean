import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RadioactiveTransformationGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Parent where
  | rejected | admitted

def parentName : Parent → String
  | .rejected => "parent-number-only"
  | .admitted => "held-parent-nuclide"

inductive Daughter where
  | rejected | admitted

def daughterName : Daughter → String
  | .rejected => "anonymous-product"
  | .admitted => "held-daughter-nuclide"

inductive Chemistry where
  | rejected | admitted

def chemistryName : Chemistry → String
  | .rejected => "nuclear-edge-only"
  | .admitted => "held-parent-daughter-species"

inductive Channel where
  | rejected | admitted

def channelName : Channel → String
  | .rejected => "unlabelled-transition"
  | .admitted => "held-decay-channel"

inductive Events where
  | rejected | admitted

def eventsName : Events → String
  | .rejected => "continuum-decay-flow"
  | .admitted => "positive-counted-transformations"

inductive Network where
  | rejected | admitted

def networkName : Network → String
  | .rejected => "selected-decay-edge"
  | .admitted => "complete-directed-transformation-network"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-daughter"
  | .admitted => "structural-EmptyOne-no-edge"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "daughter-overwrites-parent"
  | .admitted => "successor-retains-prior-network"

structure Candidate where
  parent : Parent
  daughter : Daughter
  chemistry : Chemistry
  channel : Channel
  events : Events
  network : Network
  absence : Absence
  extension : Extension

def sourceFields (c : Candidate) : List String := [parentName c.parent, daughterName c.daughter, chemistryName c.chemistry, channelName c.channel, eventsName c.events, networkName c.network, absenceName c.absence, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "parent=" (parentName c.parent), SFT.Host.Text.append "daughter=" (daughterName c.daughter), SFT.Host.Text.append "chemistry=" (chemistryName c.chemistry), SFT.Host.Text.append "channel=" (channelName c.channel), SFT.Host.Text.append "events=" (eventsName c.events), SFT.Host.Text.append "network=" (networkName c.network), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-parent-nuclide__held-daughter-nuclide__held-parent-daughter-species__held-decay-channel__positive-counted-transformations__complete-directed-transformation-network__structural-EmptyOne-no-edge__successor-retains-prior-network"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (parentName c.parent) "held-parent-nuclide" &&
  SFT.Host.Text.equal (daughterName c.daughter) "held-daughter-nuclide" &&
  SFT.Host.Text.equal (chemistryName c.chemistry) "held-parent-daughter-species" &&
  SFT.Host.Text.equal (channelName c.channel) "held-decay-channel" &&
  SFT.Host.Text.equal (eventsName c.events) "positive-counted-transformations" &&
  SFT.Host.Text.equal (networkName c.network) "complete-directed-transformation-network" &&
  SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-no-edge" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-retains-prior-network"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (parentName c.parent) "held-parent-nuclide") then "Parent number loses identity." else
  if !(SFT.Host.Text.equal (daughterName c.daughter) "held-daughter-nuclide") then "Product loses daughter identity." else
  if !(SFT.Host.Text.equal (chemistryName c.chemistry) "held-parent-daughter-species") then "Chemical states would be lost." else
  if !(SFT.Host.Text.equal (channelName c.channel) "held-decay-channel") then "Channel identity is required." else
  if !(SFT.Host.Text.equal (eventsName c.events) "positive-counted-transformations") then "Flow hides events." else
  if !(SFT.Host.Text.equal (networkName c.network) "complete-directed-transformation-network") then "One edge hides branching." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-no-edge") then "Numerical zero is not native absence." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-retains-prior-network") then "Overwriting destroys reconstruction." else
  "held-parent-nuclide__held-daughter-nuclide__held-parent-daughter-species__held-decay-channel__positive-counted-transformations__complete-directed-transformation-network__structural-EmptyOne-no-edge__successor-retains-prior-network"

def generationRule : String := "Generate the literal product of eight registered transformation decisions."
def grammarBoundary : String := "Eight dimensions exhaust parent, daughter, chemistry, channel, events, network, absence and extension."

def candidates : List Candidate :=
  ([Parent.rejected,Parent.admitted]).flatMap fun parent =>
  ([Daughter.rejected,Daughter.admitted]).flatMap fun daughter =>
  ([Chemistry.rejected,Chemistry.admitted]).flatMap fun chemistry =>
  ([Channel.rejected,Channel.admitted]).flatMap fun channel =>
  ([Events.rejected,Events.admitted]).flatMap fun events =>
  ([Network.rejected,Network.admitted]).flatMap fun network =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨parent,daughter,chemistry,channel,events,network,absence,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk parent daughter chemistry channel events network absence extension =>
    have hparent : parent ∈ [Parent.rejected,Parent.admitted] := by
      cases parent <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdaughter : daughter ∈ [Daughter.rejected,Daughter.admitted] := by
      cases daughter <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchemistry : chemistry ∈ [Chemistry.rejected,Chemistry.admitted] := by
      cases chemistry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchannel : channel ∈ [Channel.rejected,Channel.admitted] := by
      cases channel <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevents : events ∈ [Events.rejected,Events.admitted] := by
      cases events <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnetwork : network ∈ [Network.rejected,Network.admitted] := by
      cases network <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ parent _ hparent
    apply CommonRefinement.memFlatMap _ _ daughter _ hdaughter
    apply CommonRefinement.memFlatMap _ _ chemistry _ hchemistry
    apply CommonRefinement.memFlatMap _ _ channel _ hchannel
    apply CommonRefinement.memFlatMap _ _ events _ hevents
    apply CommonRefinement.memFlatMap _ _ network _ hnetwork
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,events,network,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,events,network,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,events,network,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,events,network,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,events,network,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,events,network,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,events,network,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,events,network,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,events,network,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,events,network,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,events,network,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,events,network,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,events,network,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,events,network,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,events,network,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (events : Events) (network : Network) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,events,network,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,events,network,absence,extension⟩ := by
 cases events <;> cases network <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk parent daughter chemistry channel events network absence extension =>
  cases parent <;> cases daughter <;> cases chemistry <;> cases channel
  · exact sourceDecisionBlock0000 events network absence extension
  · exact sourceDecisionBlock0001 events network absence extension
  · exact sourceDecisionBlock0010 events network absence extension
  · exact sourceDecisionBlock0011 events network absence extension
  · exact sourceDecisionBlock0100 events network absence extension
  · exact sourceDecisionBlock0101 events network absence extension
  · exact sourceDecisionBlock0110 events network absence extension
  · exact sourceDecisionBlock0111 events network absence extension
  · exact sourceDecisionBlock1000 events network absence extension
  · exact sourceDecisionBlock1001 events network absence extension
  · exact sourceDecisionBlock1010 events network absence extension
  · exact sourceDecisionBlock1011 events network absence extension
  · exact sourceDecisionBlock1100 events network absence extension
  · exact sourceDecisionBlock1101 events network absence extension
  · exact sourceDecisionBlock1110 events network absence extension
  · exact sourceDecisionBlock1111 events network absence extension

theorem parentCriterion (value : Parent) : SFT.Host.Text.equal (parentName value) "held-parent-nuclide" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem daughterCriterion (value : Daughter) : SFT.Host.Text.equal (daughterName value) "held-daughter-nuclide" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem chemistryCriterion (value : Chemistry) : SFT.Host.Text.equal (chemistryName value) "held-parent-daughter-species" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem channelCriterion (value : Channel) : SFT.Host.Text.equal (channelName value) "held-decay-channel" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem eventsCriterion (value : Events) : SFT.Host.Text.equal (eventsName value) "positive-counted-transformations" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem networkCriterion (value : Network) : SFT.Host.Text.equal (networkName value) "complete-directed-transformation-network" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "structural-EmptyOne-no-edge" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-retains-prior-network" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [parentCriterion, daughterCriterion, chemistryCriterion, channelCriterion, eventsCriterion, networkCriterion, absenceCriterion, extensionCriterion]
  cases c with
  | mk parent daughter chemistry channel events network absence extension =>
    cases parent <;> cases daughter <;> cases chemistry <;> cases channel <;> cases events <;> cases network <;> cases absence <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.parent = .admitted ∧ c.daughter = .admitted ∧ c.chemistry = .admitted ∧ c.channel = .admitted ∧ c.events = .admitted ∧ c.network = .admitted ∧ c.absence = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk parent daughter chemistry channel events network absence extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem parent_rejected_rejected (c : Candidate) (h : c.parent = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.parent eq
    rw [h] at field
    cases field

theorem daughter_rejected_rejected (c : Candidate) (h : c.daughter = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.daughter eq
    rw [h] at field
    cases field

theorem chemistry_rejected_rejected (c : Candidate) (h : c.chemistry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.chemistry eq
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

theorem events_rejected_rejected (c : Candidate) (h : c.events = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.events eq
    rw [h] at field
    cases field

theorem network_rejected_rejected (c : Candidate) (h : c.network = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.network eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.RadioactiveTransformationGrammar
