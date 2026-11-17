import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.FissionProductDistributionGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Handoff where
  | rejected | admitted

def handoffName : Handoff → String
  | .rejected => "chemistry-selects-fission-products"
  | .admitted => "explicit-physics-product-handoff"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "mass-chain-only"
  | .admitted => "held-nuclide-and-chemical-species"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "bulk-release-fraction"
  | .admitted => "complete-phase-location-support"

inductive Events where
  | rejected | admitted

def eventsName : Events → String
  | .rejected => "expected-yield-premise"
  | .admitted => "positive-species-resolved-events"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "renormalized-selected-products"
  | .admitted => "exact-complete-partition-of-One"

inductive Chemistry where
  | rejected | admitted

def chemistryName : Chemistry → String
  | .rejected => "fixed-chemical-form-assumption"
  | .admitted => "explicit-chemical-redistribution-network"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "silent-decay-inside-chemistry"
  | .admitted => "nuclide-change-requires-physics-handoff"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "selected-terminal-sample"
  | .admitted => "successor-retains-complete-time-sample-vector"

structure Candidate where
  handoff : Handoff
  identity : Identity
  support : Support
  events : Events
  partition : Partition
  chemistry : Chemistry
  boundary : Boundary
  extension : Extension

def sourceFields (c : Candidate) : List String := [handoffName c.handoff, identityName c.identity, supportName c.support, eventsName c.events, partitionName c.partition, chemistryName c.chemistry, boundaryName c.boundary, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "handoff=" (handoffName c.handoff), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "events=" (eventsName c.events), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "chemistry=" (chemistryName c.chemistry), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "explicit-physics-product-handoff__held-nuclide-and-chemical-species__complete-phase-location-support__positive-species-resolved-events__exact-complete-partition-of-One__explicit-chemical-redistribution-network__nuclide-change-requires-physics-handoff__successor-retains-complete-time-sample-vector"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (handoffName c.handoff) "explicit-physics-product-handoff" &&
  SFT.Host.Text.equal (identityName c.identity) "held-nuclide-and-chemical-species" &&
  SFT.Host.Text.equal (supportName c.support) "complete-phase-location-support" &&
  SFT.Host.Text.equal (eventsName c.events) "positive-species-resolved-events" &&
  SFT.Host.Text.equal (partitionName c.partition) "exact-complete-partition-of-One" &&
  SFT.Host.Text.equal (chemistryName c.chemistry) "explicit-chemical-redistribution-network" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "nuclide-change-requires-physics-handoff" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-retains-complete-time-sample-vector"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (handoffName c.handoff) "explicit-physics-product-handoff") then "Chemistry cannot select nuclear products." else
  if !(SFT.Host.Text.equal (identityName c.identity) "held-nuclide-and-chemical-species") then "Mass chain loses nuclide identity." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-phase-location-support") then "One bulk fraction loses phase and location." else
  if !(SFT.Host.Text.equal (eventsName c.events) "positive-species-resolved-events") then "Expectation is not counted custody." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "exact-complete-partition-of-One") then "Selection changes the distribution." else
  if !(SFT.Host.Text.equal (chemistryName c.chemistry) "explicit-chemical-redistribution-network") then "A name cannot freeze chemistry." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "nuclide-change-requires-physics-handoff") then "Chemistry cannot silently change nuclides." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-retains-complete-time-sample-vector") then "One sample cannot establish the distribution." else
  "explicit-physics-product-handoff__held-nuclide-and-chemical-species__complete-phase-location-support__positive-species-resolved-events__exact-complete-partition-of-One__explicit-chemical-redistribution-network__nuclide-change-requires-physics-handoff__successor-retains-complete-time-sample-vector"

def generationRule : String := "Generate the literal product of eight registered fission-product decisions."
def grammarBoundary : String := "Eight dimensions exhaust handoff, identity, support, events, partition, chemistry, boundary and extension."

def candidates : List Candidate :=
  ([Handoff.rejected,Handoff.admitted]).flatMap fun handoff =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Events.rejected,Events.admitted]).flatMap fun events =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Chemistry.rejected,Chemistry.admitted]).flatMap fun chemistry =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨handoff,identity,support,events,partition,chemistry,boundary,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk handoff identity support events partition chemistry boundary extension =>
    have hhandoff : handoff ∈ [Handoff.rejected,Handoff.admitted] := by
      cases handoff <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevents : events ∈ [Events.rejected,Events.admitted] := by
      cases events <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchemistry : chemistry ∈ [Chemistry.rejected,Chemistry.admitted] := by
      cases chemistry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ handoff _ hhandoff
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ events _ hevents
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ chemistry _ hchemistry
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (partition : Partition) (chemistry : Chemistry) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,partition,chemistry,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,partition,chemistry,boundary,extension⟩ := by
 cases partition <;> cases chemistry <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk handoff identity support events partition chemistry boundary extension =>
  cases handoff <;> cases identity <;> cases support <;> cases events
  · exact sourceDecisionBlock0000 partition chemistry boundary extension
  · exact sourceDecisionBlock0001 partition chemistry boundary extension
  · exact sourceDecisionBlock0010 partition chemistry boundary extension
  · exact sourceDecisionBlock0011 partition chemistry boundary extension
  · exact sourceDecisionBlock0100 partition chemistry boundary extension
  · exact sourceDecisionBlock0101 partition chemistry boundary extension
  · exact sourceDecisionBlock0110 partition chemistry boundary extension
  · exact sourceDecisionBlock0111 partition chemistry boundary extension
  · exact sourceDecisionBlock1000 partition chemistry boundary extension
  · exact sourceDecisionBlock1001 partition chemistry boundary extension
  · exact sourceDecisionBlock1010 partition chemistry boundary extension
  · exact sourceDecisionBlock1011 partition chemistry boundary extension
  · exact sourceDecisionBlock1100 partition chemistry boundary extension
  · exact sourceDecisionBlock1101 partition chemistry boundary extension
  · exact sourceDecisionBlock1110 partition chemistry boundary extension
  · exact sourceDecisionBlock1111 partition chemistry boundary extension

theorem handoffCriterion (value : Handoff) : SFT.Host.Text.equal (handoffName value) "explicit-physics-product-handoff" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-nuclide-and-chemical-species" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-phase-location-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem eventsCriterion (value : Events) : SFT.Host.Text.equal (eventsName value) "positive-species-resolved-events" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partitionCriterion (value : Partition) : SFT.Host.Text.equal (partitionName value) "exact-complete-partition-of-One" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem chemistryCriterion (value : Chemistry) : SFT.Host.Text.equal (chemistryName value) "explicit-chemical-redistribution-network" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "nuclide-change-requires-physics-handoff" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-retains-complete-time-sample-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [handoffCriterion, identityCriterion, supportCriterion, eventsCriterion, partitionCriterion, chemistryCriterion, boundaryCriterion, extensionCriterion]
  cases c with
  | mk handoff identity support events partition chemistry boundary extension =>
    cases handoff <;> cases identity <;> cases support <;> cases events <;> cases partition <;> cases chemistry <;> cases boundary <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.handoff = .admitted ∧ c.identity = .admitted ∧ c.support = .admitted ∧ c.events = .admitted ∧ c.partition = .admitted ∧ c.chemistry = .admitted ∧ c.boundary = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk handoff identity support events partition chemistry boundary extension =>
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

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
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

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
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

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
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

end SFT.Chemistry.FissionProductDistributionGrammar
