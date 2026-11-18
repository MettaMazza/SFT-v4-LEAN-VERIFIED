import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularMeasurementGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Preparation where
  | rejected | admitted

def preparationName : Preparation → String
  | .rejected => "outcome-without-prepared-state"
  | .admitted => "retained-pre-observation-state"

inductive Probe where
  | rejected | admitted

def probeName : Probe → String
  | .rejected => "stochastic-collapse-premise"
  | .admitted => "exact-generated-observation-class"

inductive Retention where
  | rejected | admitted

def retentionName : Retention → String
  | .rejected => "all-or-nothing-observation"
  | .admitted => "explicit-retained-coordinate-set"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "silent-predecessor-erasure"
  | .admitted => "explicit-closed-coordinate-set"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "unrecorded-measurement-result"
  | .admitted => "retained-finite-readout-record"

inductive Poststate where
  | rejected | admitted

def poststateName : Poststate → String
  | .rejected => "undefined-or-destroyed-poststate"
  | .admitted => "retained-post-observation-state"

inductive Reconstruction where
  | rejected | admitted

def reconstructionName : Reconstruction → String
  | .rejected => "recover-unrecorded-predecessor"
  | .admitted => "record-bounded-reconstruction"

inductive Replication where
  | rejected | admitted

def replicationName : Replication → String
  | .rejected => "selected-successful-readouts"
  | .admitted => "complete-repeat-and-adverse-record"

structure Candidate where
  preparation : Preparation
  probe : Probe
  retention : Retention
  closure : Closure
  record : Record
  poststate : Poststate
  reconstruction : Reconstruction
  replication : Replication

def sourceFields (c : Candidate) : List String := [preparationName c.preparation, probeName c.probe, retentionName c.retention, closureName c.closure, recordName c.record, poststateName c.poststate, reconstructionName c.reconstruction, replicationName c.replication]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "preparation=" (preparationName c.preparation), SFT.Host.Text.append "probe=" (probeName c.probe), SFT.Host.Text.append "retention=" (retentionName c.retention), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "poststate=" (poststateName c.poststate), SFT.Host.Text.append "reconstruction=" (reconstructionName c.reconstruction), SFT.Host.Text.append "replication=" (replicationName c.replication)]
def survivorId : String := "retained-pre-observation-state__exact-generated-observation-class__explicit-retained-coordinate-set__explicit-closed-coordinate-set__retained-finite-readout-record__retained-post-observation-state__record-bounded-reconstruction__complete-repeat-and-adverse-record"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (preparationName c.preparation) "retained-pre-observation-state" &&
  SFT.Host.Text.equal (probeName c.probe) "exact-generated-observation-class" &&
  SFT.Host.Text.equal (retentionName c.retention) "explicit-retained-coordinate-set" &&
  SFT.Host.Text.equal (closureName c.closure) "explicit-closed-coordinate-set" &&
  SFT.Host.Text.equal (recordName c.record) "retained-finite-readout-record" &&
  SFT.Host.Text.equal (poststateName c.poststate) "retained-post-observation-state" &&
  SFT.Host.Text.equal (reconstructionName c.reconstruction) "record-bounded-reconstruction" &&
  SFT.Host.Text.equal (replicationName c.replication) "complete-repeat-and-adverse-record"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (preparationName c.preparation) "retained-pre-observation-state") then "An outcome alone cannot identify the state presented to the probe." else
  if !(SFT.Host.Text.equal (probeName c.probe) "exact-generated-observation-class") then "A stochastic collapse postulate imports an ungenerated law and numerical probability." else
  if !(SFT.Host.Text.equal (retentionName c.retention) "explicit-retained-coordinate-set") then "All-or-nothing readout hides which distinctions survive." else
  if !(SFT.Host.Text.equal (closureName c.closure) "explicit-closed-coordinate-set") then "Silent erasure makes later reconstruction claims untestable." else
  if !(SFT.Host.Text.equal (recordName c.record) "retained-finite-readout-record") then "A result without a retained record cannot be repeated or audited." else
  if !(SFT.Host.Text.equal (poststateName c.poststate) "retained-post-observation-state") then "An undefined post-state breaks process composition." else
  if !(SFT.Host.Text.equal (reconstructionName c.reconstruction) "record-bounded-reconstruction") then "A merged predecessor cannot be recovered without a retained distinction." else
  if !(SFT.Host.Text.equal (replicationName c.replication) "complete-repeat-and-adverse-record") then "Successful readouts alone erase failures and state changes." else
  "retained-pre-observation-state__exact-generated-observation-class__explicit-retained-coordinate-set__explicit-closed-coordinate-set__retained-finite-readout-record__retained-post-observation-state__record-bounded-reconstruction__complete-repeat-and-adverse-record"

def generationRule : String := "Generate the literal product of preparation, probe, retention, closure, record, poststate, reconstruction and replication forms; decide all 256 only from admitted observation, information-loss, state-transition and resolved molecular-state laws."
def grammarBoundary : String := "Every positive finite molecular preparation/readout sequence and its retained instrument/condition boundary, tested against the complete nine-file NIST MDS2-3389 CaH+ package containing 330 data rows and 796 cells."

def candidates : List Candidate :=
  ([Preparation.rejected,Preparation.admitted]).flatMap fun preparation =>
  ([Probe.rejected,Probe.admitted]).flatMap fun probe =>
  ([Retention.rejected,Retention.admitted]).flatMap fun retention =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Poststate.rejected,Poststate.admitted]).flatMap fun poststate =>
  ([Reconstruction.rejected,Reconstruction.admitted]).flatMap fun reconstruction =>
  ([Replication.rejected,Replication.admitted]).map fun replication =>
  ⟨preparation,probe,retention,closure,record,poststate,reconstruction,replication⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk preparation probe retention closure record poststate reconstruction replication =>
    have hpreparation : preparation ∈ [Preparation.rejected,Preparation.admitted] := by
      cases preparation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprobe : probe ∈ [Probe.rejected,Probe.admitted] := by
      cases probe <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hretention : retention ∈ [Retention.rejected,Retention.admitted] := by
      cases retention <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpoststate : poststate ∈ [Poststate.rejected,Poststate.admitted] := by
      cases poststate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreconstruction : reconstruction ∈ [Reconstruction.rejected,Reconstruction.admitted] := by
      cases reconstruction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreplication : replication ∈ [Replication.rejected,Replication.admitted] := by
      cases replication <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ preparation _ hpreparation
    apply CommonRefinement.memFlatMap _ _ probe _ hprobe
    apply CommonRefinement.memFlatMap _ _ retention _ hretention
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ poststate _ hpoststate
    apply CommonRefinement.memFlatMap _ _ reconstruction _ hreconstruction
    exact Count.TraceDerivation.memMap _ replication _ hreplication

theorem sourceDecisionBlock0000 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock0001 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock0010 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock0011 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock0100 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock0101 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock0110 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock0111 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock1000 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock1001 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock1010 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock1011 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock1100 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock1101 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock1110 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionBlock1111 (record : Record) (poststate : Poststate) (reconstruction : Reconstruction) (replication : Replication) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,record,poststate,reconstruction,replication⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,record,poststate,reconstruction,replication⟩ := by
 cases record <;> cases poststate <;> cases reconstruction <;> cases replication <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk preparation probe retention closure record poststate reconstruction replication =>
  cases preparation <;> cases probe <;> cases retention <;> cases closure
  · exact sourceDecisionBlock0000 record poststate reconstruction replication
  · exact sourceDecisionBlock0001 record poststate reconstruction replication
  · exact sourceDecisionBlock0010 record poststate reconstruction replication
  · exact sourceDecisionBlock0011 record poststate reconstruction replication
  · exact sourceDecisionBlock0100 record poststate reconstruction replication
  · exact sourceDecisionBlock0101 record poststate reconstruction replication
  · exact sourceDecisionBlock0110 record poststate reconstruction replication
  · exact sourceDecisionBlock0111 record poststate reconstruction replication
  · exact sourceDecisionBlock1000 record poststate reconstruction replication
  · exact sourceDecisionBlock1001 record poststate reconstruction replication
  · exact sourceDecisionBlock1010 record poststate reconstruction replication
  · exact sourceDecisionBlock1011 record poststate reconstruction replication
  · exact sourceDecisionBlock1100 record poststate reconstruction replication
  · exact sourceDecisionBlock1101 record poststate reconstruction replication
  · exact sourceDecisionBlock1110 record poststate reconstruction replication
  · exact sourceDecisionBlock1111 record poststate reconstruction replication

theorem preparationCriterion (value : Preparation) : SFT.Host.Text.equal (preparationName value) "retained-pre-observation-state" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem probeCriterion (value : Probe) : SFT.Host.Text.equal (probeName value) "exact-generated-observation-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem retentionCriterion (value : Retention) : SFT.Host.Text.equal (retentionName value) "explicit-retained-coordinate-set" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem closureCriterion (value : Closure) : SFT.Host.Text.equal (closureName value) "explicit-closed-coordinate-set" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "retained-finite-readout-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem poststateCriterion (value : Poststate) : SFT.Host.Text.equal (poststateName value) "retained-post-observation-state" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem reconstructionCriterion (value : Reconstruction) : SFT.Host.Text.equal (reconstructionName value) "record-bounded-reconstruction" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem replicationCriterion (value : Replication) : SFT.Host.Text.equal (replicationName value) "complete-repeat-and-adverse-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [preparationCriterion, probeCriterion, retentionCriterion, closureCriterion, recordCriterion, poststateCriterion, reconstructionCriterion, replicationCriterion]
  cases c with
  | mk preparation probe retention closure record poststate reconstruction replication =>
    cases preparation <;> cases probe <;> cases retention <;> cases closure <;> cases record <;> cases poststate <;> cases reconstruction <;> cases replication
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.preparation = .admitted ∧ c.probe = .admitted ∧ c.retention = .admitted ∧ c.closure = .admitted ∧ c.record = .admitted ∧ c.poststate = .admitted ∧ c.reconstruction = .admitted ∧ c.replication = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk preparation probe retention closure record poststate reconstruction replication =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem preparation_rejected_rejected (c : Candidate) (h : c.preparation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.preparation eq
    rw [h] at field
    cases field

theorem probe_rejected_rejected (c : Candidate) (h : c.probe = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.probe eq
    rw [h] at field
    cases field

theorem retention_rejected_rejected (c : Candidate) (h : c.retention = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.retention eq
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

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

theorem poststate_rejected_rejected (c : Candidate) (h : c.poststate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.poststate eq
    rw [h] at field
    cases field

theorem reconstruction_rejected_rejected (c : Candidate) (h : c.reconstruction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reconstruction eq
    rw [h] at field
    cases field

theorem replication_rejected_rejected (c : Candidate) (h : c.replication = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.replication eq
    rw [h] at field
    cases field

end SFT.Chemistry.MolecularMeasurementGrammar
