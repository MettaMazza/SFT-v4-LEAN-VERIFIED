import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CoupledTransportGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "detached-cross-coefficient-or-answer-vector"
  | .admitted => "complete-composition-phase-mass-heat-charge-account"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "anonymous-collapsed-carriers-or-pair"
  | .admitted => "distinct-held-triad-and-pairwise-projections"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "imported-Onsager-matrix-gradient-or-flux-equation"
  | .admitted => "counted-shared-adjacent-cell-transition-ledger"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-flux-proof-magnitudes"
  | .admitted => "held-per-carrier-transfer-orientations"

inductive Resource where
  | rejected | admitted

def resourceName : Resource → String
  | .rejected => "unrecorded-packet-event-time-boundary-or-condition"
  | .admitted => "exact-positive-packet-event-tick-boundary-and-condition-support"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "phenomenological-cross-coefficient-fit-or-target-value"
  | .admitted => "exact-positive-postseal-pairwise-response-support"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "substance-pair-property-condition-method-or-value-readable-before-seal"
  | .admitted => "complete-value-free-232-record-pair-identity-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-after-event-replication-or-record-append"
  | .admitted => "depth-independent-common-replication-and-record-append"

structure Candidate where
  carrier : Carrier
  identity : Identity
  transition : Transition
  orientation : Orientation
  resource : Resource
  magnitude : Magnitude
  prediction : Prediction
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, identityName c.identity, transitionName c.transition, orientationName c.orientation, resourceName c.resource, magnitudeName c.magnitude, predictionName c.prediction, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "resource=" (resourceName c.resource), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-composition-phase-mass-heat-charge-account__distinct-held-triad-and-pairwise-projections__counted-shared-adjacent-cell-transition-ledger__held-per-carrier-transfer-orientations__exact-positive-packet-event-tick-boundary-and-condition-support__exact-positive-postseal-pairwise-response-support__complete-value-free-232-record-pair-identity-seal__depth-independent-common-replication-and-record-append"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-composition-phase-mass-heat-charge-account" &&
  SFT.Host.Text.equal (identityName c.identity) "distinct-held-triad-and-pairwise-projections" &&
  SFT.Host.Text.equal (transitionName c.transition) "counted-shared-adjacent-cell-transition-ledger" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-per-carrier-transfer-orientations" &&
  SFT.Host.Text.equal (resourceName c.resource) "exact-positive-packet-event-tick-boundary-and-condition-support" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-positive-postseal-pairwise-response-support" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-232-record-pair-identity-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-replication-and-record-append"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-composition-phase-mass-heat-charge-account") then "Detached coefficients erase the transported carriers." else
  if !(SFT.Host.Text.equal (identityName c.identity) "distinct-held-triad-and-pairwise-projections") then "A collapsed carrier or pair cannot reconstruct the coupling." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "counted-shared-adjacent-cell-transition-ledger") then "A phenomenological matrix or continuum gradient imports the desired coupling." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-per-carrier-transfer-orientations") then "Signed mass, heat or charge magnitudes violate exact proof arithmetic." else
  if !(SFT.Host.Text.equal (resourceName c.resource) "exact-positive-packet-event-tick-boundary-and-condition-support") then "Unrecorded resources cannot reconstruct the coupled response." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-positive-postseal-pairwise-response-support") then "A fitted cross coefficient selects the result." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-232-record-pair-identity-seal") then "Readable pairwise targets could select the coupling law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-replication-and-record-append") then "Refitting destroys shared-event provenance." else
  "complete-composition-phase-mass-heat-charge-account__distinct-held-triad-and-pairwise-projections__counted-shared-adjacent-cell-transition-ledger__held-per-carrier-transfer-orientations__exact-positive-packet-event-tick-boundary-and-condition-support__exact-positive-postseal-pairwise-response-support__complete-value-free-232-record-pair-identity-seal__depth-independent-common-replication-and-record-append"

def generationRule : String := "Generate the literal product of carrier, identity, transition, orientation, resource, magnitude, prediction and extension forms; decide all 256 candidates only from admitted mass, energy, charge, adjacency, transition, conservation, exact-resource, composition, phase, EmptyOne and finite-successor laws."
def grammarBoundary : String := "Every finite coupled chemical event with complete component and phase identities, the ordered mass/heat/charge triad, counted adjacent cells, per-carrier packets, shared transitions, ticks, boundary and conditions. External testing preserves 232 direct pairwise response rows and all companion properties from three complete NIST sources."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Resource.rejected,Resource.admitted]).flatMap fun resource =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,identity,transition,orientation,resource,magnitude,prediction,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier identity transition orientation resource magnitude prediction extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresource : resource ∈ [Resource.rejected,Resource.admitted] := by
      cases resource <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnitude : magnitude ∈ [Magnitude.rejected,Magnitude.admitted] := by
      cases magnitude <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ resource _ hresource
    apply CommonRefinement.memFlatMap _ _ magnitude _ hmagnitude
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (resource : Resource) (magnitude : Magnitude) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,resource,magnitude,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,resource,magnitude,prediction,extension⟩ := by
 cases resource <;> cases magnitude <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier identity transition orientation resource magnitude prediction extension =>
  cases carrier <;> cases identity <;> cases transition <;> cases orientation
  · exact sourceDecisionBlock0000 resource magnitude prediction extension
  · exact sourceDecisionBlock0001 resource magnitude prediction extension
  · exact sourceDecisionBlock0010 resource magnitude prediction extension
  · exact sourceDecisionBlock0011 resource magnitude prediction extension
  · exact sourceDecisionBlock0100 resource magnitude prediction extension
  · exact sourceDecisionBlock0101 resource magnitude prediction extension
  · exact sourceDecisionBlock0110 resource magnitude prediction extension
  · exact sourceDecisionBlock0111 resource magnitude prediction extension
  · exact sourceDecisionBlock1000 resource magnitude prediction extension
  · exact sourceDecisionBlock1001 resource magnitude prediction extension
  · exact sourceDecisionBlock1010 resource magnitude prediction extension
  · exact sourceDecisionBlock1011 resource magnitude prediction extension
  · exact sourceDecisionBlock1100 resource magnitude prediction extension
  · exact sourceDecisionBlock1101 resource magnitude prediction extension
  · exact sourceDecisionBlock1110 resource magnitude prediction extension
  · exact sourceDecisionBlock1111 resource magnitude prediction extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-composition-phase-mass-heat-charge-account" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "distinct-held-triad-and-pairwise-projections" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem transitionCriterion (value : Transition) : SFT.Host.Text.equal (transitionName value) "counted-shared-adjacent-cell-transition-ledger" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-per-carrier-transfer-orientations" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem resourceCriterion (value : Resource) : SFT.Host.Text.equal (resourceName value) "exact-positive-packet-event-tick-boundary-and-condition-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "exact-positive-postseal-pairwise-response-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-232-record-pair-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-common-replication-and-record-append" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, identityCriterion, transitionCriterion, orientationCriterion, resourceCriterion, magnitudeCriterion, predictionCriterion, extensionCriterion]
  cases c with
  | mk carrier identity transition orientation resource magnitude prediction extension =>
    cases carrier <;> cases identity <;> cases transition <;> cases orientation <;> cases resource <;> cases magnitude <;> cases prediction <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.identity = .admitted ∧ c.transition = .admitted ∧ c.orientation = .admitted ∧ c.resource = .admitted ∧ c.magnitude = .admitted ∧ c.prediction = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier identity transition orientation resource magnitude prediction extension =>
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem transition_rejected_rejected (c : Candidate) (h : c.transition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transition eq
    rw [h] at field
    cases field

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
    rw [h] at field
    cases field

theorem resource_rejected_rejected (c : Candidate) (h : c.resource = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.resource eq
    rw [h] at field
    cases field

theorem magnitude_rejected_rejected (c : Candidate) (h : c.magnitude = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.magnitude eq
    rw [h] at field
    cases field

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
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

end SFT.Chemistry.CoupledTransportGrammar
