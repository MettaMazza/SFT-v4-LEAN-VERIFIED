import SFT.Physics.TargetCustody
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.TargetCustodyGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Timing where
  | rejected | admitted

def timingName : Timing → String
  | .rejected => "post-prediction-choice"
  | .admitted => "pre-prediction-commitment"

inductive Holder where
  | rejected | admitted

def holderName : Holder → String
  | .rejected => "prediction-holder"
  | .admitted => "distinct-custodian"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "partial-or-open-support"
  | .admitted => "complete-named-support"

inductive Content where
  | rejected | admitted

def contentName : Content → String
  | .rejected => "unbound-content"
  | .admitted => "nonce-bound-content-identity"

inductive Experiment where
  | rejected | admitted

def experimentName : Experiment → String
  | .rejected => "cross-experiment-release"
  | .admitted => "matching-experiment-only"

inductive Envelope where
  | rejected | admitted

def envelopeName : Envelope → String
  | .rejected => "unbound-envelope"
  | .admitted => "matching-envelope-only"

inductive Release where
  | rejected | admitted

def releaseName : Release → String
  | .rejected => "preseal-or-repeat-release"
  | .admitted => "one-postseal-release"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  timing : Timing
  holder : Holder
  support : Support
  content : Content
  experiment : Experiment
  envelope : Envelope
  release : Release
  extension : Extension

def sourceFields (c : Candidate) : List String := [timingName c.timing, holderName c.holder, supportName c.support, contentName c.content, experimentName c.experiment, envelopeName c.envelope, releaseName c.release, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "timing=" (timingName c.timing), SFT.Host.Text.append "holder=" (holderName c.holder), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "content=" (contentName c.content), SFT.Host.Text.append "experiment=" (experimentName c.experiment), SFT.Host.Text.append "envelope=" (envelopeName c.envelope), SFT.Host.Text.append "release=" (releaseName c.release), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "pre-prediction-commitment__distinct-custodian__complete-named-support__nonce-bound-content-identity__matching-experiment-only__matching-envelope-only__one-postseal-release__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (timingName c.timing) "pre-prediction-commitment" &&
  SFT.Host.Text.equal (holderName c.holder) "distinct-custodian" &&
  SFT.Host.Text.equal (supportName c.support) "complete-named-support" &&
  SFT.Host.Text.equal (contentName c.content) "nonce-bound-content-identity" &&
  SFT.Host.Text.equal (experimentName c.experiment) "matching-experiment-only" &&
  SFT.Host.Text.equal (envelopeName c.envelope) "matching-envelope-only" &&
  SFT.Host.Text.equal (releaseName c.release) "one-postseal-release" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (timingName c.timing) "pre-prediction-commitment") then "A post-prediction choice can select favorable target content." else
  if !(SFT.Host.Text.equal (holderName c.holder) "distinct-custodian") then "The predictor holding targets violates structural inaccessibility." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-named-support") then "Partial or open support permits selective favorable rows." else
  if !(SFT.Host.Text.equal (contentName c.content) "nonce-bound-content-identity") then "Unbound content can be replaced after prediction." else
  if !(SFT.Host.Text.equal (experimentName c.experiment) "matching-experiment-only") then "Cross-experiment reuse breaks registration custody." else
  if !(SFT.Host.Text.equal (envelopeName c.envelope) "matching-envelope-only") then "An unbound seal can certify a different input or relation." else
  if !(SFT.Host.Text.equal (releaseName c.release) "one-postseal-release") then "Pre-seal or repeat release leaks target information." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "Discretionary release is a free selection parameter." else
  "Pre-prediction complete commitment, distinct custodian, nonce-bound unchanged content, matching experiment and envelope, one post-seal release and no extra rule."

def generationRule : String := "Generate the complete product of timing, holder, target support, content identity, experiment, envelope, release and extension forms."
def grammarBoundary : String := "All finite portable target exchanges using admitted exact identities, pre-seal commitment, distinct custody and one post-seal release."

def candidates : List Candidate :=
  ([Timing.rejected,Timing.admitted]).flatMap fun timing =>
  ([Holder.rejected,Holder.admitted]).flatMap fun holder =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Content.rejected,Content.admitted]).flatMap fun content =>
  ([Experiment.rejected,Experiment.admitted]).flatMap fun experiment =>
  ([Envelope.rejected,Envelope.admitted]).flatMap fun envelope =>
  ([Release.rejected,Release.admitted]).flatMap fun release =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨timing,holder,support,content,experiment,envelope,release,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk timing holder support content experiment envelope release extension =>
    have htiming : timing ∈ [Timing.rejected,Timing.admitted] := by
      cases timing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hholder : holder ∈ [Holder.rejected,Holder.admitted] := by
      cases holder <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontent : content ∈ [Content.rejected,Content.admitted] := by
      cases content <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexperiment : experiment ∈ [Experiment.rejected,Experiment.admitted] := by
      cases experiment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henvelope : envelope ∈ [Envelope.rejected,Envelope.admitted] := by
      cases envelope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelease : release ∈ [Release.rejected,Release.admitted] := by
      cases release <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ timing _ htiming
    apply CommonRefinement.memFlatMap _ _ holder _ hholder
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ content _ hcontent
    apply CommonRefinement.memFlatMap _ _ experiment _ hexperiment
    apply CommonRefinement.memFlatMap _ _ envelope _ henvelope
    apply CommonRefinement.memFlatMap _ _ release _ hrelease
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk timing holder support content experiment envelope release extension =>
    cases timing <;> cases holder <;> cases support <;> cases content <;> cases experiment <;> cases envelope <;> cases release <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk timing holder support content experiment envelope release extension =>
    cases timing <;> cases holder <;> cases support <;> cases content <;> cases experiment <;> cases envelope <;> cases release <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.timing = .admitted ∧ c.holder = .admitted ∧ c.support = .admitted ∧ c.content = .admitted ∧ c.experiment = .admitted ∧ c.envelope = .admitted ∧ c.release = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk timing holder support content experiment envelope release extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem timing_rejected_rejected (c : Candidate) (h : c.timing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.timing eq
    rw [h] at field
    cases field

theorem holder_rejected_rejected (c : Candidate) (h : c.holder = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.holder eq
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

theorem content_rejected_rejected (c : Candidate) (h : c.content = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.content eq
    rw [h] at field
    cases field

theorem experiment_rejected_rejected (c : Candidate) (h : c.experiment = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.experiment eq
    rw [h] at field
    cases field

theorem envelope_rejected_rejected (c : Candidate) (h : c.envelope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.envelope eq
    rw [h] at field
    cases field

theorem release_rejected_rejected (c : Candidate) (h : c.release = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.release eq
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

end SFT.Physics.TargetCustodyGrammar
