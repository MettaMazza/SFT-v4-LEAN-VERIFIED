import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.BufferGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Components where
  | rejected | admitted

def componentsName : Components → String
  | .rejected => "single-unpaired-species"
  | .admitted => "conjugate-pair-reservoir"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "one-component-absent"
  | .admitted => "positive-support-of-both"

inductive AcidResponse where
  | rejected | admitted

def acidResponseName : AcidResponse → String
  | .rejected => "added-proton-unanswered"
  | .admitted => "base-member-accepts-proton"

inductive BaseResponse where
  | rejected | admitted

def baseResponseName : BaseResponse → String
  | .rejected => "added-base-unanswered"
  | .admitted => "acid-member-supplies-proton"

inductive Retention where
  | rejected | admitted

def retentionName : Retention → String
  | .rejected => "reservoir-identity-erased"
  | .admitted => "conjugate-pair-retained"

inductive Capacity where
  | rejected | admitted

def capacityName : Capacity → String
  | .rejected => "unlimited-buffer-claim"
  | .admitted => "finite-source-bounded-capacity"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "pH-answer-only"
  | .admitted => "pair-count-response-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-equilibrium-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  components : Components
  support : Support
  acidResponse : AcidResponse
  baseResponse : BaseResponse
  retention : Retention
  capacity : Capacity
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [componentsName c.components, supportName c.support, acidResponseName c.acidResponse, baseResponseName c.baseResponse, retentionName c.retention, capacityName c.capacity, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "components=" (componentsName c.components), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "acid-response=" (acidResponseName c.acidResponse), SFT.Host.Text.append "base-response=" (baseResponseName c.baseResponse), SFT.Host.Text.append "retention=" (retentionName c.retention), SFT.Host.Text.append "capacity=" (capacityName c.capacity), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "conjugate-pair-reservoir__positive-support-of-both__base-member-accepts-proton__acid-member-supplies-proton__conjugate-pair-retained__finite-source-bounded-capacity__pair-count-response-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (componentsName c.components) "conjugate-pair-reservoir" &&
  SFT.Host.Text.equal (supportName c.support) "positive-support-of-both" &&
  SFT.Host.Text.equal (acidResponseName c.acidResponse) "base-member-accepts-proton" &&
  SFT.Host.Text.equal (baseResponseName c.baseResponse) "acid-member-supplies-proton" &&
  SFT.Host.Text.equal (retentionName c.retention) "conjugate-pair-retained" &&
  SFT.Host.Text.equal (capacityName c.capacity) "finite-source-bounded-capacity" &&
  SFT.Host.Text.equal (recordName c.record) "pair-count-response-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (componentsName c.components) "conjugate-pair-reservoir") then "One species cannot supply both complementary responses." else
  if !(SFT.Host.Text.equal (supportName c.support) "positive-support-of-both") then "An absent member leaves one response unavailable." else
  if !(SFT.Host.Text.equal (acidResponseName c.acidResponse) "base-member-accepts-proton") then "No response permits the proton distinction to remain open." else
  if !(SFT.Host.Text.equal (baseResponseName c.baseResponse) "acid-member-supplies-proton") then "No response permits proton removal without paired change." else
  if !(SFT.Host.Text.equal (retentionName c.retention) "conjugate-pair-retained") then "A response without conjugate tracking cannot be reversed." else
  if !(SFT.Host.Text.equal (capacityName c.capacity) "finite-source-bounded-capacity") then "A finite reservoir cannot have unlimited capacity." else
  if !(SFT.Host.Text.equal (recordName c.record) "pair-count-response-trace") then "A pH value cannot reconstruct composition and response." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A fitted equation can force a measured response." else
  "conjugate-pair-reservoir__positive-support-of-both__base-member-accepts-proton__acid-member-supplies-proton__conjugate-pair-retained"

def generationRule : String := "Generate the literal product of the registered buffer components, support, acid response, base response, retention, capacity, record and extension choices."
def grammarBoundary : String := "Every finite reservoir containing positive support of both members of a conjugate pair and two complementary response paths that consume added proton support or supply proton support to an added base within capacity."

def candidates : List Candidate :=
  ([Components.rejected,Components.admitted]).flatMap fun components =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([AcidResponse.rejected,AcidResponse.admitted]).flatMap fun acidResponse =>
  ([BaseResponse.rejected,BaseResponse.admitted]).flatMap fun baseResponse =>
  ([Retention.rejected,Retention.admitted]).flatMap fun retention =>
  ([Capacity.rejected,Capacity.admitted]).flatMap fun capacity =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨components,support,acidResponse,baseResponse,retention,capacity,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk components support acidResponse baseResponse retention capacity record extension =>
    have hcomponents : components ∈ [Components.rejected,Components.admitted] := by
      cases components <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hacidResponse : acidResponse ∈ [AcidResponse.rejected,AcidResponse.admitted] := by
      cases acidResponse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbaseResponse : baseResponse ∈ [BaseResponse.rejected,BaseResponse.admitted] := by
      cases baseResponse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hretention : retention ∈ [Retention.rejected,Retention.admitted] := by
      cases retention <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcapacity : capacity ∈ [Capacity.rejected,Capacity.admitted] := by
      cases capacity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ components _ hcomponents
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ acidResponse _ hacidResponse
    apply CommonRefinement.memFlatMap _ _ baseResponse _ hbaseResponse
    apply CommonRefinement.memFlatMap _ _ retention _ hretention
    apply CommonRefinement.memFlatMap _ _ capacity _ hcapacity
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk components support acidResponse baseResponse retention capacity record extension =>
    cases components <;> cases support <;> cases acidResponse <;> cases baseResponse <;> cases retention <;> cases capacity <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk components support acidResponse baseResponse retention capacity record extension =>
    cases components <;> cases support <;> cases acidResponse <;> cases baseResponse <;> cases retention <;> cases capacity <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.components = .admitted ∧ c.support = .admitted ∧ c.acidResponse = .admitted ∧ c.baseResponse = .admitted ∧ c.retention = .admitted ∧ c.capacity = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk components support acidResponse baseResponse retention capacity record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem components_rejected_rejected (c : Candidate) (h : c.components = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.components eq
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

theorem acidResponse_rejected_rejected (c : Candidate) (h : c.acidResponse = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.acidResponse eq
    rw [h] at field
    cases field

theorem baseResponse_rejected_rejected (c : Candidate) (h : c.baseResponse = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.baseResponse eq
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

theorem capacity_rejected_rejected (c : Candidate) (h : c.capacity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.capacity eq
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

end SFT.Chemistry.BufferGrammar
