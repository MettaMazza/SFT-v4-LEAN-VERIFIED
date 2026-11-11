import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.GeometryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "geometry-without-molecule"
  | .admitted => "identified-molecular-carrier"

inductive Adjacency where
  | rejected | admitted

def adjacencyName : Adjacency → String
  | .rejected => "atom-list-only"
  | .admitted => "complete-atom-adjacency"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "distance-only-record"
  | .admitted => "held-relative-orientation"

inductive Completeness where
  | rejected | admitted

def completenessName : Completeness → String
  | .rejected => "selected-coordinate-subset"
  | .admitted => "complete-pair-support"

inductive Equivalence where
  | rejected | admitted

def equivalenceName : Equivalence → String
  | .rejected => "absolute-host-frame"
  | .admitted => "rigid-relabel-equivalence"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "coordinate-as-proof-premise"
  | .admitted => "source-bounded-geometry-record"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "shape-name-only"
  | .admitted => "adjacency-orientation-source-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-angle-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  adjacency : Adjacency
  orientation : Orientation
  completeness : Completeness
  equivalence : Equivalence
  measurement : Measurement
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, adjacencyName c.adjacency, orientationName c.orientation, completenessName c.completeness, equivalenceName c.equivalence, measurementName c.measurement, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "adjacency=" (adjacencyName c.adjacency), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "completeness=" (completenessName c.completeness), SFT.Host.Text.append "equivalence=" (equivalenceName c.equivalence), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "identified-molecular-carrier__complete-atom-adjacency__held-relative-orientation__complete-pair-support__rigid-relabel-equivalence__source-bounded-geometry-record__adjacency-orientation-source-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "identified-molecular-carrier" &&
  SFT.Host.Text.equal (adjacencyName c.adjacency) "complete-atom-adjacency" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-relative-orientation" &&
  SFT.Host.Text.equal (completenessName c.completeness) "complete-pair-support" &&
  SFT.Host.Text.equal (equivalenceName c.equivalence) "rigid-relabel-equivalence" &&
  SFT.Host.Text.equal (measurementName c.measurement) "source-bounded-geometry-record" &&
  SFT.Host.Text.equal (recordName c.record) "adjacency-orientation-source-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "identified-molecular-carrier") then "A shape detached from an identified carrier is not molecular geometry." else
  if !(SFT.Host.Text.equal (adjacencyName c.adjacency) "complete-atom-adjacency") then "An atom list omits which occurrences are joined." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-relative-orientation") then "Distances alone can omit handed or ordered orientation." else
  if !(SFT.Host.Text.equal (completenessName c.completeness) "complete-pair-support") then "A favorable subset cannot establish the whole geometry." else
  if !(SFT.Host.Text.equal (equivalenceName c.equivalence) "rigid-relabel-equivalence") then "A host coordinate frame cannot define chemical identity." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "source-bounded-geometry-record") then "A measured coordinate cannot select the law." else
  if !(SFT.Host.Text.equal (recordName c.record) "adjacency-orientation-source-trace") then "A shape name cannot reproduce the relations." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A fitted angle can force a target geometry." else
  "identified-molecular-carrier__complete-atom-adjacency__held-relative-orientation__complete-pair-support__rigid-relabel-equivalence"

def generationRule : String := "Generate the literal product of the registered geometry carrier, adjacency, orientation, completeness, equivalence, measurement, record and extension choices."
def grammarBoundary : String := "Every finite admitted molecular carrier with a complete pairwise relative-orientation record, interpreted up to one global rigid relabelling and retained with its source and observation conditions."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Adjacency.rejected,Adjacency.admitted]).flatMap fun adjacency =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Completeness.rejected,Completeness.admitted]).flatMap fun completeness =>
  ([Equivalence.rejected,Equivalence.admitted]).flatMap fun equivalence =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,adjacency,orientation,completeness,equivalence,measurement,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier adjacency orientation completeness equivalence measurement record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadjacency : adjacency ∈ [Adjacency.rejected,Adjacency.admitted] := by
      cases adjacency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcompleteness : completeness ∈ [Completeness.rejected,Completeness.admitted] := by
      cases completeness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequivalence : equivalence ∈ [Equivalence.rejected,Equivalence.admitted] := by
      cases equivalence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ adjacency _ hadjacency
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ completeness _ hcompleteness
    apply CommonRefinement.memFlatMap _ _ equivalence _ hequivalence
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier adjacency orientation completeness equivalence measurement record extension =>
    cases carrier <;> cases adjacency <;> cases orientation <;> cases completeness <;> cases equivalence <;> cases measurement <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier adjacency orientation completeness equivalence measurement record extension =>
    cases carrier <;> cases adjacency <;> cases orientation <;> cases completeness <;> cases equivalence <;> cases measurement <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.adjacency = .admitted ∧ c.orientation = .admitted ∧ c.completeness = .admitted ∧ c.equivalence = .admitted ∧ c.measurement = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier adjacency orientation completeness equivalence measurement record extension =>
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

theorem adjacency_rejected_rejected (c : Candidate) (h : c.adjacency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.adjacency eq
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

theorem completeness_rejected_rejected (c : Candidate) (h : c.completeness = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.completeness eq
    rw [h] at field
    cases field

theorem equivalence_rejected_rejected (c : Candidate) (h : c.equivalence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equivalence eq
    rw [h] at field
    cases field

theorem measurement_rejected_rejected (c : Candidate) (h : c.measurement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measurement eq
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

end SFT.Chemistry.GeometryGrammar
