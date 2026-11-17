import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RadiolysisNetworkGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Handoff where
  | rejected | admitted

def handoffName : Handoff → String
  | .rejected => "chemistry-defines-deposited-energy"
  | .admitted => "explicit-positive-deposited-resource-handoff"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "anonymous-radical-yield"
  | .admitted => "held-medium-reactant-product-identities"

inductive Network where
  | rejected | admitted

def networkName : Network → String
  | .rejected => "single-net-equation"
  | .admitted => "complete-directed-reaction-network"

inductive Events where
  | rejected | admitted

def eventsName : Events → String
  | .rejected => "continuum-concentration-premise"
  | .admitted => "positive-product-event-counts"

inductive Yield where
  | rejected | admitted

def yieldName : Yield → String
  | .rejected => "fitted-G-value"
  | .admitted => "exact-product-per-deposited-resource-ratio"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "selected-major-products"
  | .admitted => "exact-complete-channel-partition-of-One"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "negative-consumption-ledger"
  | .admitted => "explicit-reaction-or-EmptyOne-termination"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "differential-kinetic-model-premise"
  | .admitted => "successor-retains-and-recomputes-complete-network"

structure Candidate where
  handoff : Handoff
  identity : Identity
  network : Network
  events : Events
  yield : Yield
  partition : Partition
  closure : Closure
  extension : Extension

def sourceFields (c : Candidate) : List String := [handoffName c.handoff, identityName c.identity, networkName c.network, eventsName c.events, yieldName c.yield, partitionName c.partition, closureName c.closure, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "handoff=" (handoffName c.handoff), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "network=" (networkName c.network), SFT.Host.Text.append "events=" (eventsName c.events), SFT.Host.Text.append "yield=" (yieldName c.yield), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "explicit-positive-deposited-resource-handoff__held-medium-reactant-product-identities__complete-directed-reaction-network__positive-product-event-counts__exact-product-per-deposited-resource-ratio__exact-complete-channel-partition-of-One__explicit-reaction-or-EmptyOne-termination__successor-retains-and-recomputes-complete-network"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (handoffName c.handoff) "explicit-positive-deposited-resource-handoff" &&
  SFT.Host.Text.equal (identityName c.identity) "held-medium-reactant-product-identities" &&
  SFT.Host.Text.equal (networkName c.network) "complete-directed-reaction-network" &&
  SFT.Host.Text.equal (eventsName c.events) "positive-product-event-counts" &&
  SFT.Host.Text.equal (yieldName c.yield) "exact-product-per-deposited-resource-ratio" &&
  SFT.Host.Text.equal (partitionName c.partition) "exact-complete-channel-partition-of-One" &&
  SFT.Host.Text.equal (closureName c.closure) "explicit-reaction-or-EmptyOne-termination" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-recomputes-complete-network"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (handoffName c.handoff) "explicit-positive-deposited-resource-handoff") then "Deposited resource belongs to Physics." else
  if !(SFT.Host.Text.equal (identityName c.identity) "held-medium-reactant-product-identities") then "A yield needs medium and species identity." else
  if !(SFT.Host.Text.equal (networkName c.network) "complete-directed-reaction-network") then "A net equation hides channels and intermediates." else
  if !(SFT.Host.Text.equal (eventsName c.events) "positive-product-event-counts") then "Continuum concentration hides occurrences." else
  if !(SFT.Host.Text.equal (yieldName c.yield) "exact-product-per-deposited-resource-ratio") then "A fitted value cannot define native yield." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "exact-complete-channel-partition-of-One") then "Major-product selection erases support." else
  if !(SFT.Host.Text.equal (closureName c.closure) "explicit-reaction-or-EmptyOne-termination") then "Consumption cannot be a negative proof value." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-recomputes-complete-network") then "A continuum kinetic model is not required." else
  "explicit-positive-deposited-resource-handoff__held-medium-reactant-product-identities__complete-directed-reaction-network__positive-product-event-counts__exact-product-per-deposited-resource-ratio__exact-complete-channel-partition-of-One__explicit-reaction-or-EmptyOne-termination__successor-retains-and-recomputes-complete-network"

def generationRule : String := "Generate the literal product of eight registered radiolysis decisions."
def grammarBoundary : String := "Eight dimensions exhaust handoff, identity, network, events, yield, partition, closure and extension."

def candidates : List Candidate :=
  ([Handoff.rejected,Handoff.admitted]).flatMap fun handoff =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Network.rejected,Network.admitted]).flatMap fun network =>
  ([Events.rejected,Events.admitted]).flatMap fun events =>
  ([Yield.rejected,Yield.admitted]).flatMap fun yield =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨handoff,identity,network,events,yield,partition,closure,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk handoff identity network events yield partition closure extension =>
    have hhandoff : handoff ∈ [Handoff.rejected,Handoff.admitted] := by
      cases handoff <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnetwork : network ∈ [Network.rejected,Network.admitted] := by
      cases network <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevents : events ∈ [Events.rejected,Events.admitted] := by
      cases events <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hyield : yield ∈ [Yield.rejected,Yield.admitted] := by
      cases yield <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ handoff _ hhandoff
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ network _ hnetwork
    apply CommonRefinement.memFlatMap _ _ events _ hevents
    apply CommonRefinement.memFlatMap _ _ yield _ hyield
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,yield,partition,closure,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,yield,partition,closure,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,yield,partition,closure,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,yield,partition,closure,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,yield,partition,closure,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,yield,partition,closure,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,yield,partition,closure,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,yield,partition,closure,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,yield,partition,closure,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,yield,partition,closure,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,yield,partition,closure,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,yield,partition,closure,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,yield,partition,closure,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,yield,partition,closure,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,yield,partition,closure,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (yield : Yield) (partition : Partition) (closure : Closure) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,yield,partition,closure,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,yield,partition,closure,extension⟩ := by
 cases yield <;> cases partition <;> cases closure <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk handoff identity network events yield partition closure extension =>
  cases handoff <;> cases identity <;> cases network <;> cases events
  · exact sourceDecisionBlock0000 yield partition closure extension
  · exact sourceDecisionBlock0001 yield partition closure extension
  · exact sourceDecisionBlock0010 yield partition closure extension
  · exact sourceDecisionBlock0011 yield partition closure extension
  · exact sourceDecisionBlock0100 yield partition closure extension
  · exact sourceDecisionBlock0101 yield partition closure extension
  · exact sourceDecisionBlock0110 yield partition closure extension
  · exact sourceDecisionBlock0111 yield partition closure extension
  · exact sourceDecisionBlock1000 yield partition closure extension
  · exact sourceDecisionBlock1001 yield partition closure extension
  · exact sourceDecisionBlock1010 yield partition closure extension
  · exact sourceDecisionBlock1011 yield partition closure extension
  · exact sourceDecisionBlock1100 yield partition closure extension
  · exact sourceDecisionBlock1101 yield partition closure extension
  · exact sourceDecisionBlock1110 yield partition closure extension
  · exact sourceDecisionBlock1111 yield partition closure extension

theorem handoffCriterion (value : Handoff) : SFT.Host.Text.equal (handoffName value) "explicit-positive-deposited-resource-handoff" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-medium-reactant-product-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem networkCriterion (value : Network) : SFT.Host.Text.equal (networkName value) "complete-directed-reaction-network" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem eventsCriterion (value : Events) : SFT.Host.Text.equal (eventsName value) "positive-product-event-counts" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem yieldCriterion (value : Yield) : SFT.Host.Text.equal (yieldName value) "exact-product-per-deposited-resource-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partitionCriterion (value : Partition) : SFT.Host.Text.equal (partitionName value) "exact-complete-channel-partition-of-One" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem closureCriterion (value : Closure) : SFT.Host.Text.equal (closureName value) "explicit-reaction-or-EmptyOne-termination" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-retains-and-recomputes-complete-network" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [handoffCriterion, identityCriterion, networkCriterion, eventsCriterion, yieldCriterion, partitionCriterion, closureCriterion, extensionCriterion]
  cases c with
  | mk handoff identity network events yield partition closure extension =>
    cases handoff <;> cases identity <;> cases network <;> cases events <;> cases yield <;> cases partition <;> cases closure <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.handoff = .admitted ∧ c.identity = .admitted ∧ c.network = .admitted ∧ c.events = .admitted ∧ c.yield = .admitted ∧ c.partition = .admitted ∧ c.closure = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk handoff identity network events yield partition closure extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem handoff_rejected_rejected (c : Candidate) (h : c.handoff = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.handoff eq
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

theorem network_rejected_rejected (c : Candidate) (h : c.network = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.network eq
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

theorem yield_rejected_rejected (c : Candidate) (h : c.yield = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.yield eq
    rw [h] at field
    cases field

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.RadiolysisNetworkGrammar
