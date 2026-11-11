import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PhaseGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Region where
  | rejected | admitted

def regionName : Region → String
  | .rejected => "arbitrary-sample-label"
  | .admitted => "maximal-connected-region"

inductive Homogeneity where
  | rejected | admitted

def homogeneityName : Homogeneity → String
  | .rejected => "single-point-observation"
  | .admitted => "complete-intensive-trace-equivalence"

inductive Extent where
  | rejected | admitted

def extentName : Extent → String
  | .rejected => "size-dependent-phase"
  | .admitted => "extent-independent-class"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "interface-erased"
  | .admitted => "retained-phase-interface"

inductive Coexistence where
  | rejected | admitted

def coexistenceName : Coexistence → String
  | .rejected => "one-phase-only"
  | .admitted => "paired-interface-recurrence"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "condition-free-phase"
  | .admitted => "temperature-pressure-composition-held"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "phase-name-only"
  | .admitted => "region-trace-interface-record"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-phase-diagram"
  | .admitted => "no-extra-rule"

structure Candidate where
  region : Region
  homogeneity : Homogeneity
  extent : Extent
  boundary : Boundary
  coexistence : Coexistence
  conditions : Conditions
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [regionName c.region, homogeneityName c.homogeneity, extentName c.extent, boundaryName c.boundary, coexistenceName c.coexistence, conditionsName c.conditions, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "region=" (regionName c.region), SFT.Host.Text.append "homogeneity=" (homogeneityName c.homogeneity), SFT.Host.Text.append "extent=" (extentName c.extent), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "coexistence=" (coexistenceName c.coexistence), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "maximal-connected-region__complete-intensive-trace-equivalence__extent-independent-class__retained-phase-interface__paired-interface-recurrence__temperature-pressure-composition-held__region-trace-interface-record__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (regionName c.region) "maximal-connected-region" &&
  SFT.Host.Text.equal (homogeneityName c.homogeneity) "complete-intensive-trace-equivalence" &&
  SFT.Host.Text.equal (extentName c.extent) "extent-independent-class" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "retained-phase-interface" &&
  SFT.Host.Text.equal (coexistenceName c.coexistence) "paired-interface-recurrence" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "temperature-pressure-composition-held" &&
  SFT.Host.Text.equal (recordName c.record) "region-trace-interface-record" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (regionName c.region) "maximal-connected-region") then "It does not define phase identity." else
  if !(SFT.Host.Text.equal (homogeneityName c.homogeneity) "complete-intensive-trace-equivalence") then "It cannot establish uniformity." else
  if !(SFT.Host.Text.equal (extentName c.extent) "extent-independent-class") then "Phase identity is intensive." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "retained-phase-interface") then "Distinct phases cannot be separated." else
  if !(SFT.Host.Text.equal (coexistenceName c.coexistence) "paired-interface-recurrence") then "No coexistence relation exists." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "temperature-pressure-composition-held") then "Phase depends on source conditions." else
  if !(SFT.Host.Text.equal (recordName c.record) "region-trace-interface-record") then "It cannot reproduce homogeneity." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "An imported diagram selects the class." else
  "maximal-connected-region__complete-intensive-trace-equivalence__extent-independent-class__retained-phase-interface__paired-interface-recurrence"

def generationRule : String := "Generate the literal product of region, homogeneity, extent, boundary, coexistence, condition, record and extension choices."
def grammarBoundary : String := "Every finite maximal connected chemical region whose complete intensive observation trace is homogeneous under the declared resolution, separated from a distinct region by a retained interface; coexistence is paired recurrence at that interface."

def candidates : List Candidate :=
  ([Region.rejected,Region.admitted]).flatMap fun region =>
  ([Homogeneity.rejected,Homogeneity.admitted]).flatMap fun homogeneity =>
  ([Extent.rejected,Extent.admitted]).flatMap fun extent =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Coexistence.rejected,Coexistence.admitted]).flatMap fun coexistence =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨region,homogeneity,extent,boundary,coexistence,conditions,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk region homogeneity extent boundary coexistence conditions record extra =>
    have hregion : region ∈ [Region.rejected,Region.admitted] := by
      cases region <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hhomogeneity : homogeneity ∈ [Homogeneity.rejected,Homogeneity.admitted] := by
      cases homogeneity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextent : extent ∈ [Extent.rejected,Extent.admitted] := by
      cases extent <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoexistence : coexistence ∈ [Coexistence.rejected,Coexistence.admitted] := by
      cases coexistence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ region _ hregion
    apply CommonRefinement.memFlatMap _ _ homogeneity _ hhomogeneity
    apply CommonRefinement.memFlatMap _ _ extent _ hextent
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ coexistence _ hcoexistence
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk region homogeneity extent boundary coexistence conditions record extra =>
    cases region <;> cases homogeneity <;> cases extent <;> cases boundary <;> cases coexistence <;> cases conditions <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk region homogeneity extent boundary coexistence conditions record extra =>
    cases region <;> cases homogeneity <;> cases extent <;> cases boundary <;> cases coexistence <;> cases conditions <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.region = .admitted ∧ c.homogeneity = .admitted ∧ c.extent = .admitted ∧ c.boundary = .admitted ∧ c.coexistence = .admitted ∧ c.conditions = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk region homogeneity extent boundary coexistence conditions record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem region_rejected_rejected (c : Candidate) (h : c.region = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.region eq
    rw [h] at field
    cases field

theorem homogeneity_rejected_rejected (c : Candidate) (h : c.homogeneity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.homogeneity eq
    rw [h] at field
    cases field

theorem extent_rejected_rejected (c : Candidate) (h : c.extent = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extent eq
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

theorem coexistence_rejected_rejected (c : Candidate) (h : c.coexistence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coexistence eq
    rw [h] at field
    cases field

theorem conditions_rejected_rejected (c : Candidate) (h : c.conditions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conditions eq
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

end SFT.Chemistry.PhaseGrammar
