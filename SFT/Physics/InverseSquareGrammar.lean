import SFT.Physics.InverseSquare
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.InverseSquareGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "unbound-response-number"
  | .admitted => "one-retained-source-carrier"

inductive Conservation where
  | rejected | admitted

def conservationName : Conservation → String
  | .rejected => "distance-created-or-lost-source"
  | .admitted => "same-complete-source-at-every-boundary"

inductive Rank where
  | rejected | admitted

def rankName : Rank → String
  | .rejected => "free-or-measured-exponent"
  | .admitted => "forced-rank-two-boundary"

inductive Coverage where
  | rejected | admitted

def coverageName : Coverage → String
  | .rejected => "selected-boundary-cells"
  | .admitted => "all-equivalent-pair-cells"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "unlabelled-scale-factor"
  | .admitted => "distance-ratio-paired-with-itself"

inductive Allocation where
  | rejected | admitted

def allocationName : Allocation → String
  | .rejected => "fitted-response-profile"
  | .admitted => "source-over-complete-boundary"

inductive Profile where
  | rejected0 | admitted | rejected2 | rejected3

def profileName : Profile → String
  | .rejected0 => "inverse-linear"
  | .admitted => "inverse-square"
  | .rejected2 => "inverse-cubic"
  | .rejected3 => "target-fitted-power"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "finite-distance-table"
  | .admitted => "pair-product-successor-induction"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "measurement-to-exponent"
  | .admitted => "sealed-exponent-to-blind-measurement"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "reported-exponent-only"
  | .admitted => "source-bound-cell-and-measurement-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-shape-or-scale"
  | .admitted => "no-extra-rule"

structure Candidate where
  source : Source
  conservation : Conservation
  rank : Rank
  coverage : Coverage
  scale : Scale
  allocation : Allocation
  profile : Profile
  generality : Generality
  measurement : Measurement
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [sourceName c.source, conservationName c.conservation, rankName c.rank, coverageName c.coverage, scaleName c.scale, allocationName c.allocation, profileName c.profile, generalityName c.generality, measurementName c.measurement, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "conservation=" (conservationName c.conservation), SFT.Host.Text.append "rank=" (rankName c.rank), SFT.Host.Text.append "coverage=" (coverageName c.coverage), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "allocation=" (allocationName c.allocation), SFT.Host.Text.append "profile=" (profileName c.profile), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-source-carrier__same-complete-source-at-every-boundary__forced-rank-two-boundary__all-equivalent-pair-cells__distance-ratio-paired-with-itself__source-over-complete-boundary__inverse-square__pair-product-successor-induction__sealed-exponent-to-blind-measurement__source-bound-cell-and-measurement-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sourceName c.source) "one-retained-source-carrier" &&
  SFT.Host.Text.equal (conservationName c.conservation) "same-complete-source-at-every-boundary" &&
  SFT.Host.Text.equal (rankName c.rank) "forced-rank-two-boundary" &&
  SFT.Host.Text.equal (coverageName c.coverage) "all-equivalent-pair-cells" &&
  SFT.Host.Text.equal (scaleName c.scale) "distance-ratio-paired-with-itself" &&
  SFT.Host.Text.equal (allocationName c.allocation) "source-over-complete-boundary" &&
  SFT.Host.Text.equal (profileName c.profile) "inverse-square" &&
  SFT.Host.Text.equal (generalityName c.generality) "pair-product-successor-induction" &&
  SFT.Host.Text.equal (measurementName c.measurement) "sealed-exponent-to-blind-measurement" &&
  SFT.Host.Text.equal (recordName c.record) "source-bound-cell-and-measurement-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (sourceName c.source) "unbound-response-number" then "A detached number has no conserved source identity." else
  if SFT.Host.Text.equal (conservationName c.conservation) "distance-created-or-lost-source" then "Changing total support violates the admitted conserved-source law." else
  if SFT.Host.Text.equal (rankName c.rank) "free-or-measured-exponent" then "A free or measured exponent reverses forcing." else
  if SFT.Host.Text.equal (coverageName c.coverage) "selected-boundary-cells" then "Selection breaks equivalence and conservation accounting." else
  if SFT.Host.Text.equal (scaleName c.scale) "unlabelled-scale-factor" then "An unlabelled factor loses one boundary coordinate." else
  if SFT.Host.Text.equal (allocationName c.allocation) "fitted-response-profile" then "A fit can select the target falloff." else
  if SFT.Host.Text.equal (profileName c.profile) "inverse-linear" then "Linear falloff omits one retained boundary coordinate." else
  if SFT.Host.Text.equal (profileName c.profile) "inverse-cubic" then "Cubic falloff adds a third boundary coordinate already held normal." else
  if SFT.Host.Text.equal (profileName c.profile) "target-fitted-power" then "A fitted power is target-selected." else
  if SFT.Host.Text.equal (generalityName c.generality) "finite-distance-table" then "A table has no successor proof." else
  if SFT.Host.Text.equal (measurementName c.measurement) "measurement-to-exponent" then "A measured exponent cannot become the law premise." else
  if SFT.Host.Text.equal (recordName c.record) "reported-exponent-only" then "A label alone cannot reproduce conservation, cells or comparison." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-shape-or-scale" then "An added coefficient or shape is not supplied by complete equivalent support." else
  "One conserved source over complete equivalent rank-two boundary support forces response(source,r) = source/(r*r) for every generated exact positive distance ratio r."

def generationRule : String := "Generate the complete product of source identity, conservation, boundary rank, boundary coverage, scale transport, response allocation, falloff profile, generality, measurement direction, evidence record and extra-rule forms."
def grammarBoundary : String := "All exact finite geometric-dilution relations for one conserved localized source over complete equivalent boundaries generated from the forced rank-two spatial boundary."

def candidates : List Candidate :=
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Conservation.rejected,Conservation.admitted]).flatMap fun conservation =>
  ([Rank.rejected,Rank.admitted]).flatMap fun rank =>
  ([Coverage.rejected,Coverage.admitted]).flatMap fun coverage =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Allocation.rejected,Allocation.admitted]).flatMap fun allocation =>
  ([Profile.rejected0,Profile.admitted,Profile.rejected2,Profile.rejected3]).flatMap fun profile =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨source,conservation,rank,coverage,scale,allocation,profile,generality,measurement,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk source conservation rank coverage scale allocation profile generality measurement record extension =>
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconservation : conservation ∈ [Conservation.rejected,Conservation.admitted] := by
      cases conservation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrank : rank ∈ [Rank.rejected,Rank.admitted] := by
      cases rank <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoverage : coverage ∈ [Coverage.rejected,Coverage.admitted] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hallocation : allocation ∈ [Allocation.rejected,Allocation.admitted] := by
      cases allocation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprofile : profile ∈ [Profile.rejected0,Profile.admitted,Profile.rejected2,Profile.rejected3] := by
      cases profile <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ conservation _ hconservation
    apply CommonRefinement.memFlatMap _ _ rank _ hrank
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ allocation _ hallocation
    apply CommonRefinement.memFlatMap _ _ profile _ hprofile
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk source conservation rank coverage scale allocation profile generality measurement record extension =>
    cases source <;> cases conservation <;> cases rank <;> cases coverage <;> cases scale <;> cases allocation <;> cases profile <;> cases generality <;> cases measurement <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk source conservation rank coverage scale allocation profile generality measurement record extension =>
    cases source <;> cases conservation <;> cases rank <;> cases coverage <;> cases scale <;> cases allocation <;> cases profile <;> cases generality <;> cases measurement <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.source = .admitted ∧ c.conservation = .admitted ∧ c.rank = .admitted ∧ c.coverage = .admitted ∧ c.scale = .admitted ∧ c.allocation = .admitted ∧ c.profile = .admitted ∧ c.generality = .admitted ∧ c.measurement = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk source conservation rank coverage scale allocation profile generality measurement record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10
      rfl

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
    rw [h] at field
    cases field

theorem conservation_rejected_rejected (c : Candidate) (h : c.conservation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conservation eq
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

theorem coverage_rejected_rejected (c : Candidate) (h : c.coverage = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
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

theorem allocation_rejected_rejected (c : Candidate) (h : c.allocation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.allocation eq
    rw [h] at field
    cases field

theorem profile_rejected0_rejected (c : Candidate) (h : c.profile = .rejected0) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.profile eq
    rw [h] at field
    cases field

theorem profile_rejected2_rejected (c : Candidate) (h : c.profile = .rejected2) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.profile eq
    rw [h] at field
    cases field

theorem profile_rejected3_rejected (c : Candidate) (h : c.profile = .rejected3) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.profile eq
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

end SFT.Physics.InverseSquareGrammar
