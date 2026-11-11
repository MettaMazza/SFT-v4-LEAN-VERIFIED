import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AnalyticalSampleGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Portion where
  | rejected | admitted

def portionName : Portion → String
  | .rejected => "unbounded-material-name"
  | .admitted => "declared-material-portion"

inductive Components where
  | rejected | admitted

def componentsName : Components → String
  | .rejected => "component-support-erased"
  | .admitted => "complete-resolved-component-support"

inductive Analyte where
  | rejected | admitted

def analyteName : Analyte → String
  | .rejected => "analyte-not-designated"
  | .admitted => "analyte-role-held"

inductive Matrix where
  | rejected | admitted

def matrixName : Matrix → String
  | .rejected => "non-analyte-components-discarded"
  | .admitted => "matrix-support-held"

inductive Sampling where
  | rejected | admitted

def samplingName : Sampling → String
  | .rejected => "sample-equals-whole-source"
  | .admitted => "source-to-sample-map-held"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "response-without-component-map"
  | .admitted => "component-response-map-held"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "result-only"
  | .admitted => "sample-analyte-matrix-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-sample-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  portion : Portion
  components : Components
  analyte : Analyte
  matrix : Matrix
  sampling : Sampling
  observation : Observation
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [portionName c.portion, componentsName c.components, analyteName c.analyte, matrixName c.matrix, samplingName c.sampling, observationName c.observation, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "portion=" (portionName c.portion), SFT.Host.Text.append "components=" (componentsName c.components), SFT.Host.Text.append "analyte=" (analyteName c.analyte), SFT.Host.Text.append "matrix=" (matrixName c.matrix), SFT.Host.Text.append "sampling=" (samplingName c.sampling), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "declared-material-portion__complete-resolved-component-support__analyte-role-held__matrix-support-held__source-to-sample-map-held__component-response-map-held__sample-analyte-matrix-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (portionName c.portion) "declared-material-portion" &&
  SFT.Host.Text.equal (componentsName c.components) "complete-resolved-component-support" &&
  SFT.Host.Text.equal (analyteName c.analyte) "analyte-role-held" &&
  SFT.Host.Text.equal (matrixName c.matrix) "matrix-support-held" &&
  SFT.Host.Text.equal (samplingName c.sampling) "source-to-sample-map-held" &&
  SFT.Host.Text.equal (observationName c.observation) "component-response-map-held" &&
  SFT.Host.Text.equal (recordName c.record) "sample-analyte-matrix-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (portionName c.portion) "declared-material-portion") then "No sampled carrier is identified." else
  if !(SFT.Host.Text.equal (componentsName c.components) "complete-resolved-component-support") then "The portion cannot be compositionally audited." else
  if !(SFT.Host.Text.equal (analyteName c.analyte) "analyte-role-held") then "No measurand-bearing component is selected." else
  if !(SFT.Host.Text.equal (matrixName c.matrix) "matrix-support-held") then "Interference support is hidden." else
  if !(SFT.Host.Text.equal (samplingName c.sampling) "source-to-sample-map-held") then "A portion need not reproduce the source whole." else
  if !(SFT.Host.Text.equal (observationName c.observation) "component-response-map-held") then "A response cannot be assigned." else
  if !(SFT.Host.Text.equal (recordName c.record) "sample-analyte-matrix-trace") then "The sample distinction cannot be reproduced." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A discretionary rule can select any portion." else
  "declared-material-portion__complete-resolved-component-support__analyte-role-held__matrix-support-held__source-to-sample-map-held"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete distinction preservation, exact recurrence/equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite declared material portion with complete resolved components, one or more analyte roles and retained non-analyte support."

def candidates : List Candidate :=
  ([Portion.rejected,Portion.admitted]).flatMap fun portion =>
  ([Components.rejected,Components.admitted]).flatMap fun components =>
  ([Analyte.rejected,Analyte.admitted]).flatMap fun analyte =>
  ([Matrix.rejected,Matrix.admitted]).flatMap fun matrix =>
  ([Sampling.rejected,Sampling.admitted]).flatMap fun sampling =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨portion,components,analyte,matrix,sampling,observation,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk portion components analyte matrix sampling observation record extra =>
    have hportion : portion ∈ [Portion.rejected,Portion.admitted] := by
      cases portion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomponents : components ∈ [Components.rejected,Components.admitted] := by
      cases components <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hanalyte : analyte ∈ [Analyte.rejected,Analyte.admitted] := by
      cases analyte <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmatrix : matrix ∈ [Matrix.rejected,Matrix.admitted] := by
      cases matrix <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsampling : sampling ∈ [Sampling.rejected,Sampling.admitted] := by
      cases sampling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ portion _ hportion
    apply CommonRefinement.memFlatMap _ _ components _ hcomponents
    apply CommonRefinement.memFlatMap _ _ analyte _ hanalyte
    apply CommonRefinement.memFlatMap _ _ matrix _ hmatrix
    apply CommonRefinement.memFlatMap _ _ sampling _ hsampling
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk portion components analyte matrix sampling observation record extra =>
    cases portion <;> cases components <;> cases analyte <;> cases matrix <;> cases sampling <;> cases observation <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk portion components analyte matrix sampling observation record extra =>
    cases portion <;> cases components <;> cases analyte <;> cases matrix <;> cases sampling <;> cases observation <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.portion = .admitted ∧ c.components = .admitted ∧ c.analyte = .admitted ∧ c.matrix = .admitted ∧ c.sampling = .admitted ∧ c.observation = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk portion components analyte matrix sampling observation record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem portion_rejected_rejected (c : Candidate) (h : c.portion = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.portion eq
    rw [h] at field
    cases field

theorem components_rejected_rejected (c : Candidate) (h : c.components = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.components eq
    rw [h] at field
    cases field

theorem analyte_rejected_rejected (c : Candidate) (h : c.analyte = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.analyte eq
    rw [h] at field
    cases field

theorem matrix_rejected_rejected (c : Candidate) (h : c.matrix = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.matrix eq
    rw [h] at field
    cases field

theorem sampling_rejected_rejected (c : Candidate) (h : c.sampling = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sampling eq
    rw [h] at field
    cases field

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
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

end SFT.Chemistry.AnalyticalSampleGrammar
