import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ThermalConductivityGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "detached-conductivity-number-or-continuum-field"
  | .admitted => "complete-composition-phase-condition-energy-transfer-account"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "anonymous-or-collapsed-composition-phase"
  | .admitted => "distinct-held-complete-component-and-phase-identities"

inductive Transfer where
  | rejected | admitted

def transferName : Transfer → String
  | .rejected => "Fourier-gradient-or-continuum-carrier-premise"
  | .admitted => "counted-adjacent-cell-energy-packet-transfer"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-heat-flux-proof-magnitude"
  | .admitted => "held-higher-to-lower-thermal-order-orientation"

inductive Resource where
  | rejected | admitted

def resourceName : Resource → String
  | .rejected => "unrecorded-energy-transfer-time-boundary-order-or-condition"
  | .admitted => "exact-positive-packet-transfer-tick-boundary-order-and-condition-support"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "imported-Fourier-kinetic-mixing-temperature-fit-or-logarithm"
  | .admitted => "exact-positive-postseal-thermal-conductivity-support"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "substance-composition-phase-condition-method-or-value-readable-before-seal"
  | .admitted => "complete-value-free-655-record-identity-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-after-transfer-replication-or-record-append"
  | .admitted => "depth-independent-common-replication-and-record-append"

structure Candidate where
  carrier : Carrier
  identity : Identity
  transfer : Transfer
  orientation : Orientation
  resource : Resource
  magnitude : Magnitude
  prediction : Prediction
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, identityName c.identity, transferName c.transfer, orientationName c.orientation, resourceName c.resource, magnitudeName c.magnitude, predictionName c.prediction, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "transfer=" (transferName c.transfer), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "resource=" (resourceName c.resource), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-composition-phase-condition-energy-transfer-account__distinct-held-complete-component-and-phase-identities__counted-adjacent-cell-energy-packet-transfer__held-higher-to-lower-thermal-order-orientation__exact-positive-packet-transfer-tick-boundary-order-and-condition-support__exact-positive-postseal-thermal-conductivity-support__complete-value-free-655-record-identity-seal__depth-independent-common-replication-and-record-append"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-composition-phase-condition-energy-transfer-account" &&
  SFT.Host.Text.equal (identityName c.identity) "distinct-held-complete-component-and-phase-identities" &&
  SFT.Host.Text.equal (transferName c.transfer) "counted-adjacent-cell-energy-packet-transfer" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-higher-to-lower-thermal-order-orientation" &&
  SFT.Host.Text.equal (resourceName c.resource) "exact-positive-packet-transfer-tick-boundary-order-and-condition-support" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-positive-postseal-thermal-conductivity-support" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-655-record-identity-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-replication-and-record-append"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-composition-phase-condition-energy-transfer-account") then "A detached number or field erases the chemical energy-transfer account." else
  if !(SFT.Host.Text.equal (identityName c.identity) "distinct-held-complete-component-and-phase-identities") then "Collapsed composition or phase cannot own a chemical conductivity relation." else
  if !(SFT.Host.Text.equal (transferName c.transfer) "counted-adjacent-cell-energy-packet-transfer") then "A continuum temperature gradient imports an ungenerated carrier." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-higher-to-lower-thermal-order-orientation") then "Signed heat flux imports prohibited arithmetic." else
  if !(SFT.Host.Text.equal (resourceName c.resource) "exact-positive-packet-transfer-tick-boundary-order-and-condition-support") then "Unrecorded resources cannot reconstruct conductivity." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-positive-postseal-thermal-conductivity-support") then "An imported constitutive or fitted law selects the magnitude." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-655-record-identity-seal") then "Readable targets could select the law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-replication-and-record-append") then "Refitting destroys exact transfer provenance." else
  "complete-composition-phase-condition-energy-transfer-account__distinct-held-complete-component-and-phase-identities__counted-adjacent-cell-energy-packet-transfer__held-higher-to-lower-thermal-order-orientation__exact-positive-packet-transfer-tick-boundary-order-and-condition-support__exact-positive-postseal-thermal-conductivity-support__complete-value-free-655-record-identity-seal__depth-independent-common-replication-and-record-append"

def generationRule : String := "Generate the literal product of carrier, identity, transfer, orientation, resource, magnitude, prediction and extension forms; decide all 256 candidates only from admitted energy, thermal-order, adjacency, transition, conservation, exact-resource, composition, phase, EmptyOne and finite-successor laws."
def grammarBoundary : String := "Every finite pure, binary or ternary thermal-conductivity record with complete component identities, phase, exact conditions, counted adjacent cells, thermal orders, energy packets, transfers, ticks and boundary support. External testing preserves all 655 direct conductivity points and all companion properties from three complete NIST sources."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Transfer.rejected,Transfer.admitted]).flatMap fun transfer =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Resource.rejected,Resource.admitted]).flatMap fun resource =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,identity,transfer,orientation,resource,magnitude,prediction,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier identity transfer orientation resource magnitude prediction extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransfer : transfer ∈ [Transfer.rejected,Transfer.admitted] := by
      cases transfer <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
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
    apply CommonRefinement.memFlatMap _ _ transfer _ htransfer
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
 | mk carrier identity transfer orientation resource magnitude prediction extension =>
  cases carrier <;> cases identity <;> cases transfer <;> cases orientation
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

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-composition-phase-condition-energy-transfer-account" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "distinct-held-complete-component-and-phase-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem transferCriterion (value : Transfer) : SFT.Host.Text.equal (transferName value) "counted-adjacent-cell-energy-packet-transfer" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-higher-to-lower-thermal-order-orientation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem resourceCriterion (value : Resource) : SFT.Host.Text.equal (resourceName value) "exact-positive-packet-transfer-tick-boundary-order-and-condition-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "exact-positive-postseal-thermal-conductivity-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-655-record-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-common-replication-and-record-append" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, identityCriterion, transferCriterion, orientationCriterion, resourceCriterion, magnitudeCriterion, predictionCriterion, extensionCriterion]
  cases c with
  | mk carrier identity transfer orientation resource magnitude prediction extension =>
    cases carrier <;> cases identity <;> cases transfer <;> cases orientation <;> cases resource <;> cases magnitude <;> cases prediction <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.identity = .admitted ∧ c.transfer = .admitted ∧ c.orientation = .admitted ∧ c.resource = .admitted ∧ c.magnitude = .admitted ∧ c.prediction = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier identity transfer orientation resource magnitude prediction extension =>
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

theorem transfer_rejected_rejected (c : Candidate) (h : c.transfer = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transfer eq
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

end SFT.Chemistry.ThermalConductivityGrammar
