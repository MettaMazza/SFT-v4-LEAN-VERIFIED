import «work».AnalyticalCalibrationCarrier639
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.AnalyticalCalibrationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "unknown-reference-input"
  | .admitted => "traceable-reference-input"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "reference-response-erased"
  | .admitted => "reference-response-pair-held"

inductive Ordering where
  | rejected | admitted

def orderingName : Ordering → String
  | .rejected => "unordered-fit"
  | .admitted => "exact-generated-comparison-order"

inductive Sample where
  | rejected | admitted

def sampleName : Sample → String
  | .rejected => "sample-outside-reference-map"
  | .admitted => "sample-compared-with-reference-map"

inductive Range where
  | rejected | admitted

def rangeName : Range → String
  | .rejected => "universal-unbounded-map"
  | .admitted => "declared-calibration-domain"

inductive Uncertainty where
  | rejected | admitted

def uncertaintyName : Uncertainty → String
  | .rejected => "uncertainty-erased"
  | .admitted => "reference-and-sample-uncertainty-held"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "calibrated-answer-only"
  | .admitted => "reference-map-and-result-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-calibration-parameter"
  | .admitted => "no-extra-rule"

structure Candidate where
  reference : Reference
  response : Response
  ordering : Ordering
  sample : Sample
  range : Range
  uncertainty : Uncertainty
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [referenceName c.reference, responseName c.response, orderingName c.ordering, sampleName c.sample, rangeName c.range, uncertaintyName c.uncertainty, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "ordering=" (orderingName c.ordering), SFT.Host.Text.append "sample=" (sampleName c.sample), SFT.Host.Text.append "range=" (rangeName c.range), SFT.Host.Text.append "uncertainty=" (uncertaintyName c.uncertainty), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "traceable-reference-input__reference-response-pair-held__exact-generated-comparison-order__sample-compared-with-reference-map__declared-calibration-domain__reference-and-sample-uncertainty-held__reference-map-and-result-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (referenceName c.reference) "traceable-reference-input" &&
  SFT.Host.Text.equal (responseName c.response) "reference-response-pair-held" &&
  SFT.Host.Text.equal (orderingName c.ordering) "exact-generated-comparison-order" &&
  SFT.Host.Text.equal (sampleName c.sample) "sample-compared-with-reference-map" &&
  SFT.Host.Text.equal (rangeName c.range) "declared-calibration-domain" &&
  SFT.Host.Text.equal (uncertaintyName c.uncertainty) "reference-and-sample-uncertainty-held" &&
  SFT.Host.Text.equal (recordName c.record) "reference-map-and-result-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (referenceName c.reference) "traceable-reference-input") then "Comparison has no fixed support." else
  if !(SFT.Host.Text.equal (responseName c.response) "reference-response-pair-held") then "The comparison cannot be reconstructed." else
  if !(SFT.Host.Text.equal (orderingName c.ordering) "exact-generated-comparison-order") then "A fit can conceal incompatible rows." else
  if !(SFT.Host.Text.equal (sampleName c.sample) "sample-compared-with-reference-map") then "No calibrated comparison is possible." else
  if !(SFT.Host.Text.equal (rangeName c.range) "declared-calibration-domain") then "Calibration support is finite and method-bound." else
  if !(SFT.Host.Text.equal (uncertaintyName c.uncertainty) "reference-and-sample-uncertainty-held") then "Alternatives are falsely collapsed." else
  if !(SFT.Host.Text.equal (recordName c.record) "reference-map-and-result-trace") then "Traceability is lost." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fitted value can select the answer." else
  "traceable-reference-input__reference-response-pair-held__exact-generated-comparison-order__sample-compared-with-reference-map__declared-calibration-domain"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete distinction preservation, exact recurrence/equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite registered reference-response set and sample response sharing one declared observation organization."

def candidates : List Candidate :=
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Ordering.rejected,Ordering.admitted]).flatMap fun ordering =>
  ([Sample.rejected,Sample.admitted]).flatMap fun sample =>
  ([Range.rejected,Range.admitted]).flatMap fun range =>
  ([Uncertainty.rejected,Uncertainty.admitted]).flatMap fun uncertainty =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨reference,response,ordering,sample,range,uncertainty,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk reference response ordering sample range uncertainty record extra =>
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hordering : ordering ∈ [Ordering.rejected,Ordering.admitted] := by
      cases ordering <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsample : sample ∈ [Sample.rejected,Sample.admitted] := by
      cases sample <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrange : range ∈ [Range.rejected,Range.admitted] := by
      cases range <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huncertainty : uncertainty ∈ [Uncertainty.rejected,Uncertainty.admitted] := by
      cases uncertainty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ ordering _ hordering
    apply CommonRefinement.memFlatMap _ _ sample _ hsample
    apply CommonRefinement.memFlatMap _ _ range _ hrange
    apply CommonRefinement.memFlatMap _ _ uncertainty _ huncertainty
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk reference response ordering sample range uncertainty record extra =>
    cases reference <;> cases response <;> cases ordering <;> cases sample <;> cases range <;> cases uncertainty <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk reference response ordering sample range uncertainty record extra =>
    cases reference <;> cases response <;> cases ordering <;> cases sample <;> cases range <;> cases uncertainty <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.reference = .admitted ∧ c.response = .admitted ∧ c.ordering = .admitted ∧ c.sample = .admitted ∧ c.range = .admitted ∧ c.uncertainty = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk reference response ordering sample range uncertainty record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem reference_rejected_rejected (c : Candidate) (h : c.reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reference eq
    rw [h] at field
    cases field

theorem response_rejected_rejected (c : Candidate) (h : c.response = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.response eq
    rw [h] at field
    cases field

theorem ordering_rejected_rejected (c : Candidate) (h : c.ordering = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ordering eq
    rw [h] at field
    cases field

theorem sample_rejected_rejected (c : Candidate) (h : c.sample = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sample eq
    rw [h] at field
    cases field

theorem range_rejected_rejected (c : Candidate) (h : c.range = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.range eq
    rw [h] at field
    cases field

theorem uncertainty_rejected_rejected (c : Candidate) (h : c.uncertainty = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.uncertainty eq
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

end SFT.Physics.AnalyticalCalibrationGrammar
