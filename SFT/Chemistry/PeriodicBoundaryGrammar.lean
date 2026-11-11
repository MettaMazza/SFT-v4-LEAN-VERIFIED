import SFT.Chemistry.PeriodicRelease
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PeriodicBoundaryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "largest-number-only"
  | .admitted => "complete-source-bounded-census"

inductive Extent where
  | rejected | admitted

def extentName : Extent → String
  | .rejected => "timeless-terminal-claim"
  | .admitted => "greatest-listed-coordinate"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "count-without-element"
  | .admitted => "element-record-retained"

inductive Time where
  | rejected | admitted

def timeName : Time → String
  | .rejected => "undated-table"
  | .admitted => "release-date-retained"

inductive Completeness where
  | rejected | admitted

def completenessName : Completeness → String
  | .rejected => "selected-terminal-row"
  | .admitted => "all-listed-rows-retained"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "observed-means-impossible-beyond"
  | .admitted => "unobserved-successor-open"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "boundary-without-source"
  | .admitted => "source-hash-census-trace"

inductive Rule where
  | rejected | admitted

def ruleName : Rule → String
  | .rejected => "free-terminal-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  extent : Extent
  identity : Identity
  time : Time
  completeness : Completeness
  extension : Extension
  record : Record
  rule : Rule

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, extentName c.extent, identityName c.identity, timeName c.time, completenessName c.completeness, extensionName c.extension, recordName c.record, ruleName c.rule]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "extent=" (extentName c.extent), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "time=" (timeName c.time), SFT.Host.Text.append "completeness=" (completenessName c.completeness), SFT.Host.Text.append "extension=" (extensionName c.extension), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "rule=" (ruleName c.rule)]
def survivorId : String := "complete-source-bounded-census__greatest-listed-coordinate__element-record-retained__release-date-retained__all-listed-rows-retained__unobserved-successor-open__source-hash-census-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-source-bounded-census" &&
  SFT.Host.Text.equal (extentName c.extent) "greatest-listed-coordinate" &&
  SFT.Host.Text.equal (identityName c.identity) "element-record-retained" &&
  SFT.Host.Text.equal (timeName c.time) "release-date-retained" &&
  SFT.Host.Text.equal (completenessName c.completeness) "all-listed-rows-retained" &&
  SFT.Host.Text.equal (extensionName c.extension) "unobserved-successor-open" &&
  SFT.Host.Text.equal (recordName c.record) "source-hash-census-trace" &&
  SFT.Host.Text.equal (ruleName c.rule) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-source-bounded-census") then "A largest number alone omits the observed element census." else
  if !(SFT.Host.Text.equal (extentName c.extent) "greatest-listed-coordinate") then "A current release cannot prove that no successor can exist." else
  if !(SFT.Host.Text.equal (identityName c.identity) "element-record-retained") then "A number without its element record is not an observation boundary." else
  if !(SFT.Host.Text.equal (timeName c.time) "release-date-retained") then "An undated table cannot define a reproducible empirical boundary." else
  if !(SFT.Host.Text.equal (completenessName c.completeness) "all-listed-rows-retained") then "Selecting only the last row cannot establish the registered census." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "unobserved-successor-open") then "Absence from one release is not impossibility." else
  if !(SFT.Host.Text.equal (recordName c.record) "source-hash-census-trace") then "An unsourced endpoint cannot be reproduced." else
  if !(SFT.Host.Text.equal (ruleName c.rule) "no-extra-rule") then "A terminal rule chosen from the table would overfit observation." else
  "complete-source-bounded-census__greatest-listed-coordinate__element-record-retained__unobserved-successor-open"

def generationRule : String := "Generate the literal product of the registered known-boundary carrier, extent, identity, time, completeness, extension, record and rule choices."
def grammarBoundary : String := "Every official finite periodic-table release treated as a source-dated observation census, retaining all listed atomic-number/element records while leaving any unobserved successor scientifically open."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Extent.rejected,Extent.admitted]).flatMap fun extent =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Time.rejected,Time.admitted]).flatMap fun time =>
  ([Completeness.rejected,Completeness.admitted]).flatMap fun completeness =>
  ([Extension.rejected,Extension.admitted]).flatMap fun extension =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Rule.rejected,Rule.admitted]).map fun rule =>
  ⟨carrier,extent,identity,time,completeness,extension,record,rule⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier extent identity time completeness extension record rule =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextent : extent ∈ [Extent.rejected,Extent.admitted] := by
      cases extent <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htime : time ∈ [Time.rejected,Time.admitted] := by
      cases time <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcompleteness : completeness ∈ [Completeness.rejected,Completeness.admitted] := by
      cases completeness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrule : rule ∈ [Rule.rejected,Rule.admitted] := by
      cases rule <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ extent _ hextent
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ time _ htime
    apply CommonRefinement.memFlatMap _ _ completeness _ hcompleteness
    apply CommonRefinement.memFlatMap _ _ extension _ hextension
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ rule _ hrule

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier extent identity time completeness extension record rule =>
    cases carrier <;> cases extent <;> cases identity <;> cases time <;> cases completeness <;> cases extension <;> cases record <;> cases rule
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier extent identity time completeness extension record rule =>
    cases carrier <;> cases extent <;> cases identity <;> cases time <;> cases completeness <;> cases extension <;> cases record <;> cases rule
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.extent = .admitted ∧ c.identity = .admitted ∧ c.time = .admitted ∧ c.completeness = .admitted ∧ c.extension = .admitted ∧ c.record = .admitted ∧ c.rule = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier extent identity time completeness extension record rule =>
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

theorem extent_rejected_rejected (c : Candidate) (h : c.extent = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extent eq
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

theorem time_rejected_rejected (c : Candidate) (h : c.time = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.time eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
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

theorem rule_rejected_rejected (c : Candidate) (h : c.rule = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rule eq
    rw [h] at field
    cases field

end SFT.Chemistry.PeriodicBoundaryGrammar
