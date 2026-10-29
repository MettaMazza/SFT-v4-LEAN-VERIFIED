import SFT.Physics.BoundaryGrowth
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.BoundaryRankGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "unbound-coordinate-space"
  | .admitted => "forced-three-direction-carrier"

inductive Normal where
  | rejected | admitted

def normalName : Normal → String
  | .rejected => "no-held-source-normal"
  | .admitted => "one-held-source-normal"

inductive Incidence where
  | rejected | admitted

def incidenceName : Incidence → String
  | .rejected => "selected-tangent-subset"
  | .admitted => "all-nonnormal-directions-retained"

inductive Rank where
  | rejected | admitted

def rankName : Rank → String
  | .rejected => "signed-dimension-minus-one"
  | .admitted => "unique-positive-predecessor"

inductive Value where
  | rejected0 | admitted | rejected2 | rejected3

def valueName : Value → String
  | .rejected0 => "rank-one"
  | .admitted => "rank-two"
  | .rejected2 => "rank-three"
  | .rejected3 => "target-selected-rank"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "linear-or-unlabelled-repetition"
  | .admitted => "complete-pair-cell-product"

inductive Coverage where
  | rejected | admitted

def coverageName : Coverage → String
  | .rejected => "partial-boundary-sample"
  | .admitted => "complete-equivalent-boundary-support"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "fixed-scale-table"
  | .admitted => "pair-product-successor-closure"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "measured-rank-input"
  | .admitted => "rank-sealed-before-measurement"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-boundary-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  normal : Normal
  incidence : Incidence
  rank : Rank
  value : Value
  scale : Scale
  coverage : Coverage
  generality : Generality
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, normalName c.normal, incidenceName c.incidence, rankName c.rank, valueName c.value, scaleName c.scale, coverageName c.coverage, generalityName c.generality, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "normal=" (normalName c.normal), SFT.Host.Text.append "incidence=" (incidenceName c.incidence), SFT.Host.Text.append "rank=" (rankName c.rank), SFT.Host.Text.append "value=" (valueName c.value), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "coverage=" (coverageName c.coverage), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "forced-three-direction-carrier__one-held-source-normal__all-nonnormal-directions-retained__unique-positive-predecessor__rank-two__complete-pair-cell-product__complete-equivalent-boundary-support__pair-product-successor-closure__rank-sealed-before-measurement__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "forced-three-direction-carrier" &&
  SFT.Host.Text.equal (normalName c.normal) "one-held-source-normal" &&
  SFT.Host.Text.equal (incidenceName c.incidence) "all-nonnormal-directions-retained" &&
  SFT.Host.Text.equal (rankName c.rank) "unique-positive-predecessor" &&
  SFT.Host.Text.equal (valueName c.value) "rank-two" &&
  SFT.Host.Text.equal (scaleName c.scale) "complete-pair-cell-product" &&
  SFT.Host.Text.equal (coverageName c.coverage) "complete-equivalent-boundary-support" &&
  SFT.Host.Text.equal (generalityName c.generality) "pair-product-successor-closure" &&
  SFT.Host.Text.equal (measurementName c.measurement) "rank-sealed-before-measurement" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "unbound-coordinate-space" then "An unbound coordinate collection has no forced dimension identity." else
  if SFT.Host.Text.equal (normalName c.normal) "no-held-source-normal" then "Without a held normal relation the boundary is not source-relative." else
  if SFT.Host.Text.equal (incidenceName c.incidence) "selected-tangent-subset" then "A selected subset can omit a free boundary direction." else
  if SFT.Host.Text.equal (rankName c.rank) "signed-dimension-minus-one" then "A signed scalar expression is not the positive proof witness." else
  if SFT.Host.Text.equal (valueName c.value) "rank-one" then "One plus the held normal does not exhaust three directions." else
  if SFT.Host.Text.equal (valueName c.value) "rank-three" then "Three plus the held normal exceeds the carrier." else
  if SFT.Host.Text.equal (valueName c.value) "target-selected-rank" then "A measured exponent cannot select boundary rank." else
  if SFT.Host.Text.equal (scaleName c.scale) "linear-or-unlabelled-repetition" then "Unlabelled repetition loses one retained boundary coordinate." else
  if SFT.Host.Text.equal (coverageName c.coverage) "partial-boundary-sample" then "A sample cannot establish complete geometric dilution." else
  if SFT.Host.Text.equal (generalityName c.generality) "fixed-scale-table" then "A finite table does not prove the next scale." else
  if SFT.Host.Text.equal (measurementName c.measurement) "measured-rank-input" then "That reverses the derivation-to-measurement boundary." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-boundary-rule" then "An added shape or exponent is not supplied by the dependencies." else
  "The complete boundary of the forced three-direction spatial carrier has exact positive rank two and r-by-r pair-cell support at every generated positive scale r."

def generationRule : String := "Generate the complete product of spatial carrier, source normal, boundary incidence, rank relation, rank value, scale composition, coverage, generality, measurement direction and extra-rule forms."
def grammarBoundary : String := "All complete finite boundaries of a localized cell in the forced three-direction carrier, classified by one held normal direction and the positive predecessor relation on retained independent boundary directions."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Normal.rejected,Normal.admitted]).flatMap fun normal =>
  ([Incidence.rejected,Incidence.admitted]).flatMap fun incidence =>
  ([Rank.rejected,Rank.admitted]).flatMap fun rank =>
  ([Value.rejected0,Value.admitted,Value.rejected2,Value.rejected3]).flatMap fun value =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Coverage.rejected,Coverage.admitted]).flatMap fun coverage =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,normal,incidence,rank,value,scale,coverage,generality,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier normal incidence rank value scale coverage generality measurement extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnormal : normal ∈ [Normal.rejected,Normal.admitted] := by
      cases normal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hincidence : incidence ∈ [Incidence.rejected,Incidence.admitted] := by
      cases incidence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrank : rank ∈ [Rank.rejected,Rank.admitted] := by
      cases rank <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvalue : value ∈ [Value.rejected0,Value.admitted,Value.rejected2,Value.rejected3] := by
      cases value <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoverage : coverage ∈ [Coverage.rejected,Coverage.admitted] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ normal _ hnormal
    apply CommonRefinement.memFlatMap _ _ incidence _ hincidence
    apply CommonRefinement.memFlatMap _ _ rank _ hrank
    apply CommonRefinement.memFlatMap _ _ value _ hvalue
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier normal incidence rank value scale coverage generality measurement extension =>
    cases carrier <;> cases normal <;> cases incidence <;> cases rank <;> cases value <;> cases scale <;> cases coverage <;> cases generality <;> cases measurement <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier normal incidence rank value scale coverage generality measurement extension =>
    cases carrier <;> cases normal <;> cases incidence <;> cases rank <;> cases value <;> cases scale <;> cases coverage <;> cases generality <;> cases measurement <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.normal = .admitted ∧ c.incidence = .admitted ∧ c.rank = .admitted ∧ c.value = .admitted ∧ c.scale = .admitted ∧ c.coverage = .admitted ∧ c.generality = .admitted ∧ c.measurement = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier normal incidence rank value scale coverage generality measurement extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem normal_rejected_rejected (c : Candidate) (h : c.normal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.normal eq
    rw [h] at field
    cases field

theorem incidence_rejected_rejected (c : Candidate) (h : c.incidence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.incidence eq
    rw [h] at field
    cases field

theorem rank_rejected_rejected (c : Candidate) (h : c.rank = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rank eq
    rw [h] at field
    cases field

theorem value_rejected0_rejected (c : Candidate) (h : c.value = .rejected0) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.value eq
    rw [h] at field
    cases field

theorem value_rejected2_rejected (c : Candidate) (h : c.value = .rejected2) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.value eq
    rw [h] at field
    cases field

theorem value_rejected3_rejected (c : Candidate) (h : c.value = .rejected3) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.value eq
    rw [h] at field
    cases field

theorem scale_rejected_rejected (c : Candidate) (h : c.scale = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scale eq
    rw [h] at field
    cases field

theorem coverage_rejected_rejected (c : Candidate) (h : c.coverage = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.BoundaryRankGrammar
