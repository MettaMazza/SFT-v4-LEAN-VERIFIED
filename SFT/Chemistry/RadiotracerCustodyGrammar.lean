import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RadiotracerCustodyGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "activity-only-tracer"
  | .admitted => "held-tracer-and-chemical-carrier"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "continuous-concentration-field"
  | .admitted => "positive-ordered-observation-support"

inductive Locations where
  | rejected | admitted

def locationsName : Locations → String
  | .rejected => "selected-detector-location"
  | .admitted => "complete-location-time-vector"

inductive Events where
  | rejected | admitted

def eventsName : Events → String
  | .rejected => "expected-count-premise"
  | .admitted => "positive-administered-and-observed-counts"

inductive Recovery where
  | rejected | admitted

def recoveryName : Recovery → String
  | .rejected => "fitted-recovery-coefficient"
  | .admitted => "exact-observed-per-administered-ratio"

inductive Loss where
  | rejected | admitted

def lossName : Loss → String
  | .rejected => "negative-missing-activity"
  | .admitted => "positive-Take-or-EmptyOne-unobserved"

inductive Inference where
  | rejected | admitted

def inferenceName : Inference → String
  | .rejected => "model-selected-localization"
  | .admitted => "inference-bounded-by-observed-support"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "renormalized-selected-series"
  | .admitted => "successor-preserves-identity-and-complete-record"

structure Candidate where
  identity : Identity
  support : Support
  locations : Locations
  events : Events
  recovery : Recovery
  loss : Loss
  inference : Inference
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, supportName c.support, locationsName c.locations, eventsName c.events, recoveryName c.recovery, lossName c.loss, inferenceName c.inference, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "locations=" (locationsName c.locations), SFT.Host.Text.append "events=" (eventsName c.events), SFT.Host.Text.append "recovery=" (recoveryName c.recovery), SFT.Host.Text.append "loss=" (lossName c.loss), SFT.Host.Text.append "inference=" (inferenceName c.inference), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-tracer-and-chemical-carrier__positive-ordered-observation-support__complete-location-time-vector__positive-administered-and-observed-counts__exact-observed-per-administered-ratio__positive-Take-or-EmptyOne-unobserved__inference-bounded-by-observed-support__successor-preserves-identity-and-complete-record"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-tracer-and-chemical-carrier" &&
  SFT.Host.Text.equal (supportName c.support) "positive-ordered-observation-support" &&
  SFT.Host.Text.equal (locationsName c.locations) "complete-location-time-vector" &&
  SFT.Host.Text.equal (eventsName c.events) "positive-administered-and-observed-counts" &&
  SFT.Host.Text.equal (recoveryName c.recovery) "exact-observed-per-administered-ratio" &&
  SFT.Host.Text.equal (lossName c.loss) "positive-Take-or-EmptyOne-unobserved" &&
  SFT.Host.Text.equal (inferenceName c.inference) "inference-bounded-by-observed-support" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-preserves-identity-and-complete-record"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-tracer-and-chemical-carrier") then "Activity alone loses nuclide and chemistry." else
  if !(SFT.Host.Text.equal (supportName c.support) "positive-ordered-observation-support") then "A continuum field hides observations." else
  if !(SFT.Host.Text.equal (locationsName c.locations) "complete-location-time-vector") then "Selection cannot establish complete transport." else
  if !(SFT.Host.Text.equal (eventsName c.events) "positive-administered-and-observed-counts") then "Expectation is not observed-event custody." else
  if !(SFT.Host.Text.equal (recoveryName c.recovery) "exact-observed-per-administered-ratio") then "A fit cannot define recovery." else
  if !(SFT.Host.Text.equal (lossName c.loss) "positive-Take-or-EmptyOne-unobserved") then "Missing tracer cannot be a negative proof value." else
  if !(SFT.Host.Text.equal (inferenceName c.inference) "inference-bounded-by-observed-support") then "A model cannot create an observation." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-preserves-identity-and-complete-record") then "Renormalization erases custody." else
  "held-tracer-and-chemical-carrier__positive-ordered-observation-support__complete-location-time-vector__positive-administered-and-observed-counts__exact-observed-per-administered-ratio__positive-Take-or-EmptyOne-unobserved__inference-bounded-by-observed-support__successor-preserves-identity-and-complete-record"

def generationRule : String := "Generate the literal product of eight registered radiotracer decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, support, locations, events, recovery, loss, inference and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Locations.rejected,Locations.admitted]).flatMap fun locations =>
  ([Events.rejected,Events.admitted]).flatMap fun events =>
  ([Recovery.rejected,Recovery.admitted]).flatMap fun recovery =>
  ([Loss.rejected,Loss.admitted]).flatMap fun loss =>
  ([Inference.rejected,Inference.admitted]).flatMap fun inference =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,support,locations,events,recovery,loss,inference,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity support locations events recovery loss inference extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlocations : locations ∈ [Locations.rejected,Locations.admitted] := by
      cases locations <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevents : events ∈ [Events.rejected,Events.admitted] := by
      cases events <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecovery : recovery ∈ [Recovery.rejected,Recovery.admitted] := by
      cases recovery <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hloss : loss ∈ [Loss.rejected,Loss.admitted] := by
      cases loss <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinference : inference ∈ [Inference.rejected,Inference.admitted] := by
      cases inference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ locations _ hlocations
    apply CommonRefinement.memFlatMap _ _ events _ hevents
    apply CommonRefinement.memFlatMap _ _ recovery _ hrecovery
    apply CommonRefinement.memFlatMap _ _ loss _ hloss
    apply CommonRefinement.memFlatMap _ _ inference _ hinference
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (recovery : Recovery) (loss : Loss) (inference : Inference) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,recovery,loss,inference,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,recovery,loss,inference,extension⟩ := by
 cases recovery <;> cases loss <;> cases inference <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity support locations events recovery loss inference extension =>
  cases identity <;> cases support <;> cases locations <;> cases events
  · exact sourceDecisionBlock0000 recovery loss inference extension
  · exact sourceDecisionBlock0001 recovery loss inference extension
  · exact sourceDecisionBlock0010 recovery loss inference extension
  · exact sourceDecisionBlock0011 recovery loss inference extension
  · exact sourceDecisionBlock0100 recovery loss inference extension
  · exact sourceDecisionBlock0101 recovery loss inference extension
  · exact sourceDecisionBlock0110 recovery loss inference extension
  · exact sourceDecisionBlock0111 recovery loss inference extension
  · exact sourceDecisionBlock1000 recovery loss inference extension
  · exact sourceDecisionBlock1001 recovery loss inference extension
  · exact sourceDecisionBlock1010 recovery loss inference extension
  · exact sourceDecisionBlock1011 recovery loss inference extension
  · exact sourceDecisionBlock1100 recovery loss inference extension
  · exact sourceDecisionBlock1101 recovery loss inference extension
  · exact sourceDecisionBlock1110 recovery loss inference extension
  · exact sourceDecisionBlock1111 recovery loss inference extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-tracer-and-chemical-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "positive-ordered-observation-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem locationsCriterion (value : Locations) : SFT.Host.Text.equal (locationsName value) "complete-location-time-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem eventsCriterion (value : Events) : SFT.Host.Text.equal (eventsName value) "positive-administered-and-observed-counts" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recoveryCriterion (value : Recovery) : SFT.Host.Text.equal (recoveryName value) "exact-observed-per-administered-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem lossCriterion (value : Loss) : SFT.Host.Text.equal (lossName value) "positive-Take-or-EmptyOne-unobserved" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem inferenceCriterion (value : Inference) : SFT.Host.Text.equal (inferenceName value) "inference-bounded-by-observed-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-preserves-identity-and-complete-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, supportCriterion, locationsCriterion, eventsCriterion, recoveryCriterion, lossCriterion, inferenceCriterion, extensionCriterion]
  cases c with
  | mk identity support locations events recovery loss inference extension =>
    cases identity <;> cases support <;> cases locations <;> cases events <;> cases recovery <;> cases loss <;> cases inference <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.support = .admitted ∧ c.locations = .admitted ∧ c.events = .admitted ∧ c.recovery = .admitted ∧ c.loss = .admitted ∧ c.inference = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity support locations events recovery loss inference extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

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

theorem locations_rejected_rejected (c : Candidate) (h : c.locations = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.locations eq
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

theorem recovery_rejected_rejected (c : Candidate) (h : c.recovery = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recovery eq
    rw [h] at field
    cases field

theorem loss_rejected_rejected (c : Candidate) (h : c.loss = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.loss eq
    rw [h] at field
    cases field

theorem inference_rejected_rejected (c : Candidate) (h : c.inference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.inference eq
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

end SFT.Chemistry.RadiotracerCustodyGrammar
