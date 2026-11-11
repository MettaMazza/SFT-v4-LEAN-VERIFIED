import SFT.Chemistry.UncertaintyRecord
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.UncertaintyGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "single-answer-without-resolution"
  | .admitted => "uncertainty-carrier"

inductive Alternatives where
  | rejected | admitted

def alternativesName : Alternatives → String
  | .rejected => "discarded-alternatives"
  | .admitted => "retained-alternative-class"

inductive Bound where
  | rejected | admitted

def boundName : Bound → String
  | .rejected => "unbounded-vagueness"
  | .admitted => "upper-bound-support"

inductive Use where
  | rejected | admitted

def useName : Use → String
  | .rejected => "context-free-resolution"
  | .admitted => "use-bounded-resolution"

inductive Result where
  | rejected | admitted

def resultName : Result → String
  | .rejected => "bound-detached-from-result"
  | .admitted => "result-record-boundary"

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "source-free-bound"
  | .admitted => "source-bound-uncertainty"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "favourable-row-only"
  | .admitted => "complete-uncertainty-record"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-uncertainty-margin"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  alternatives : Alternatives
  bound : Bound
  use : Use
  result : Result
  source : Source
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, alternativesName c.alternatives, boundName c.bound, useName c.use, resultName c.result, sourceName c.source, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "alternatives=" (alternativesName c.alternatives), SFT.Host.Text.append "bound=" (boundName c.bound), SFT.Host.Text.append "use=" (useName c.use), SFT.Host.Text.append "result=" (resultName c.result), SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "uncertainty-carrier__retained-alternative-class__upper-bound-support__use-bounded-resolution__result-record-boundary__source-bound-uncertainty__complete-uncertainty-record__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "uncertainty-carrier" &&
  SFT.Host.Text.equal (alternativesName c.alternatives) "retained-alternative-class" &&
  SFT.Host.Text.equal (boundName c.bound) "upper-bound-support" &&
  SFT.Host.Text.equal (useName c.use) "use-bounded-resolution" &&
  SFT.Host.Text.equal (resultName c.result) "result-record-boundary" &&
  SFT.Host.Text.equal (sourceName c.source) "source-bound-uncertainty" &&
  SFT.Host.Text.equal (recordName c.record) "complete-uncertainty-record" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "uncertainty-carrier") then "A lone answer erases the unresolved observation class." else
  if !(SFT.Host.Text.equal (alternativesName c.alternatives) "retained-alternative-class") then "Discarding compatible alternatives falsely turns resolution into exact identity." else
  if !(SFT.Host.Text.equal (boundName c.bound) "upper-bound-support") then "Unbounded uncertainty cannot falsify a measured correspondence." else
  if !(SFT.Host.Text.equal (useName c.use) "use-bounded-resolution") then "Required resolution depends on the declared purpose of the result." else
  if !(SFT.Host.Text.equal (resultName c.result) "result-record-boundary") then "A bound detached from its result cannot be applied or audited." else
  if !(SFT.Host.Text.equal (sourceName c.source) "source-bound-uncertainty") then "A source-free bound can be changed after comparison." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-uncertainty-record") then "Selected rows cannot test uncertainty transport." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An adjustable margin can force agreement with any target." else
  "uncertainty-carrier__upper-bound-support__use-bounded-resolution__result-record-boundary"

def generationRule : String := "Generate the literal product of the registered uncertainty carrier, alternatives, bound, use, result, source, record and extension choices."
def grammarBoundary : String := "Every source-bounded finite chemical measurement record whose unresolved alternatives, exact upper bound, intended use and result identity are retained without entering the derivation as proof values."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Alternatives.rejected,Alternatives.admitted]).flatMap fun alternatives =>
  ([Bound.rejected,Bound.admitted]).flatMap fun bound =>
  ([Use.rejected,Use.admitted]).flatMap fun use =>
  ([Result.rejected,Result.admitted]).flatMap fun result =>
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,alternatives,bound,use,result,source,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier alternatives bound use result source record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have halternatives : alternatives ∈ [Alternatives.rejected,Alternatives.admitted] := by
      cases alternatives <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbound : bound ∈ [Bound.rejected,Bound.admitted] := by
      cases bound <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huse : use ∈ [Use.rejected,Use.admitted] := by
      cases use <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresult : result ∈ [Result.rejected,Result.admitted] := by
      cases result <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ alternatives _ halternatives
    apply CommonRefinement.memFlatMap _ _ bound _ hbound
    apply CommonRefinement.memFlatMap _ _ use _ huse
    apply CommonRefinement.memFlatMap _ _ result _ hresult
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier alternatives bound use result source record extension =>
    cases carrier <;> cases alternatives <;> cases bound <;> cases use <;> cases result <;> cases source <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier alternatives bound use result source record extension =>
    cases carrier <;> cases alternatives <;> cases bound <;> cases use <;> cases result <;> cases source <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.alternatives = .admitted ∧ c.bound = .admitted ∧ c.use = .admitted ∧ c.result = .admitted ∧ c.source = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier alternatives bound use result source record extension =>
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

theorem alternatives_rejected_rejected (c : Candidate) (h : c.alternatives = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.alternatives eq
    rw [h] at field
    cases field

theorem bound_rejected_rejected (c : Candidate) (h : c.bound = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bound eq
    rw [h] at field
    cases field

theorem use_rejected_rejected (c : Candidate) (h : c.use = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.use eq
    rw [h] at field
    cases field

theorem result_rejected_rejected (c : Candidate) (h : c.result = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.result eq
    rw [h] at field
    cases field

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
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

end SFT.Chemistry.UncertaintyGrammar
