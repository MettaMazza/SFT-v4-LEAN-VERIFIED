import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.DirectionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Paths where
  | rejected | admitted

def pathsName : Paths → String
  | .rejected => "forward-path-only"
  | .admitted => "forward-and-reverse-paths"

inductive Energy where
  | rejected | admitted

def energyName : Energy → String
  | .rejected => "energy-change-erased"
  | .admitted => "complete-energy-transfer-ledgers"

inductive Distinctions where
  | rejected | admitted

def distinctionsName : Distinctions → String
  | .rejected => "entropy-label-only"
  | .admitted => "complete-accessible-distinction-census"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "imported-spontaneity-sign"
  | .admitted => "strict-support-order"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "negative-Gibbs-primitive"
  | .admitted => "held-favored-direction"

inductive Equilibrium where
  | rejected | admitted

def equilibriumName : Equilibrium → String
  | .rejected => "forced-direction-at-tie"
  | .admitted => "empty-direction-at-equality"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "direction-answer-only"
  | .admitted => "path-energy-distinction-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-temperature-threshold"
  | .admitted => "no-extra-rule"

structure Candidate where
  paths : Paths
  energy : Energy
  distinctions : Distinctions
  comparison : Comparison
  orientation : Orientation
  equilibrium : Equilibrium
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [pathsName c.paths, energyName c.energy, distinctionsName c.distinctions, comparisonName c.comparison, orientationName c.orientation, equilibriumName c.equilibrium, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "paths=" (pathsName c.paths), SFT.Host.Text.append "energy=" (energyName c.energy), SFT.Host.Text.append "distinctions=" (distinctionsName c.distinctions), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "equilibrium=" (equilibriumName c.equilibrium), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "forward-and-reverse-paths__complete-energy-transfer-ledgers__complete-accessible-distinction-census__strict-support-order__held-favored-direction__empty-direction-at-equality__path-energy-distinction-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (pathsName c.paths) "forward-and-reverse-paths" &&
  SFT.Host.Text.equal (energyName c.energy) "complete-energy-transfer-ledgers" &&
  SFT.Host.Text.equal (distinctionsName c.distinctions) "complete-accessible-distinction-census" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "strict-support-order" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-favored-direction" &&
  SFT.Host.Text.equal (equilibriumName c.equilibrium) "empty-direction-at-equality" &&
  SFT.Host.Text.equal (recordName c.record) "path-energy-distinction-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (pathsName c.paths) "forward-and-reverse-paths") then "No directional comparison exists." else
  if !(SFT.Host.Text.equal (energyName c.energy) "complete-energy-transfer-ledgers") then "Available support is unknown." else
  if !(SFT.Host.Text.equal (distinctionsName c.distinctions) "complete-accessible-distinction-census") then "A label cannot count support." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "strict-support-order") then "A sign assumes the answer." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-favored-direction") then "A negative scalar is prohibited." else
  if !(SFT.Host.Text.equal (equilibriumName c.equilibrium) "empty-direction-at-equality") then "Equal support cannot select." else
  if !(SFT.Host.Text.equal (recordName c.record) "path-energy-distinction-trace") then "It cannot reproduce comparison." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A parameter can force a target." else
  "forward-and-reverse-paths__complete-energy-transfer-ledgers__complete-accessible-distinction-census__strict-support-order__held-favored-direction"

def generationRule : String := "Generate the literal product of path, energy, distinction, comparison, orientation, equilibrium, record and extension choices."
def grammarBoundary : String := "Every finite pair of forward and reverse reaction paths on one retained condition boundary, compared by complete source, energy-transfer and distinction-production support, selecting an orientation only when one path strictly closes the available transition support."

def candidates : List Candidate :=
  ([Paths.rejected,Paths.admitted]).flatMap fun paths =>
  ([Energy.rejected,Energy.admitted]).flatMap fun energy =>
  ([Distinctions.rejected,Distinctions.admitted]).flatMap fun distinctions =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Equilibrium.rejected,Equilibrium.admitted]).flatMap fun equilibrium =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨paths,energy,distinctions,comparison,orientation,equilibrium,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk paths energy distinctions comparison orientation equilibrium record extra =>
    have hpaths : paths ∈ [Paths.rejected,Paths.admitted] := by
      cases paths <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henergy : energy ∈ [Energy.rejected,Energy.admitted] := by
      cases energy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistinctions : distinctions ∈ [Distinctions.rejected,Distinctions.admitted] := by
      cases distinctions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequilibrium : equilibrium ∈ [Equilibrium.rejected,Equilibrium.admitted] := by
      cases equilibrium <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ paths _ hpaths
    apply CommonRefinement.memFlatMap _ _ energy _ henergy
    apply CommonRefinement.memFlatMap _ _ distinctions _ hdistinctions
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ equilibrium _ hequilibrium
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk paths energy distinctions comparison orientation equilibrium record extra =>
    cases paths <;> cases energy <;> cases distinctions <;> cases comparison <;> cases orientation <;> cases equilibrium <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk paths energy distinctions comparison orientation equilibrium record extra =>
    cases paths <;> cases energy <;> cases distinctions <;> cases comparison <;> cases orientation <;> cases equilibrium <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.paths = .admitted ∧ c.energy = .admitted ∧ c.distinctions = .admitted ∧ c.comparison = .admitted ∧ c.orientation = .admitted ∧ c.equilibrium = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk paths energy distinctions comparison orientation equilibrium record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem paths_rejected_rejected (c : Candidate) (h : c.paths = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.paths eq
    rw [h] at field
    cases field

theorem energy_rejected_rejected (c : Candidate) (h : c.energy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.energy eq
    rw [h] at field
    cases field

theorem distinctions_rejected_rejected (c : Candidate) (h : c.distinctions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.distinctions eq
    rw [h] at field
    cases field

theorem comparison_rejected_rejected (c : Candidate) (h : c.comparison = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.comparison eq
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

theorem equilibrium_rejected_rejected (c : Candidate) (h : c.equilibrium = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equilibrium eq
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

end SFT.Chemistry.DirectionGrammar
