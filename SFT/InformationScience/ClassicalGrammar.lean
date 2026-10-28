import SFT.InformationScience.ClassicalWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.ClassicalGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "sampled-or-duplicated-support"
  | .admitted => "complete-canonical-support"

inductive Classical where
  | rejected | admitted

def classicalName : Classical → String
  | .rejected => "unheld-symbol-name"
  | .admitted => "one-held-supported-state"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "free-weight-list"
  | .admitted => "total-observation-classes"

inductive Parts where
  | rejected | admitted

def partsName : Parts → String
  | .rejected => "floating-propensities"
  | .admitted => "exact-class-whole-parts"

inductive Meaning where
  | rejected | admitted

def meaningName : Meaning → String
  | .rejected => "ontic-random-cause"
  | .admitted => "unresolved-deterministic-distinction"

inductive Resolution where
  | rejected | admitted

def resolutionName : Resolution → String
  | .rejected => "likely-state-selection"
  | .admitted => "singleton-class-only"

inductive Transformation where
  | rejected | admitted

def transformationName : Transformation → String
  | .rejected => "stochastic-transition-matrix"
  | .admitted => "deterministic-predecessor-grouping"

inductive Normalization where
  | rejected | admitted

def normalizationName : Normalization → String
  | .rejected => "fitted-normalization"
  | .admitted => "partition-exact-whole"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "finite-examples-only"
  | .admitted => "microstate-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-seed-prior-or-kernel"
  | .admitted => "no-extra-stochastic-law"

structure Candidate where
  support : Support
  classical : Classical
  observation : Observation
  parts : Parts
  meaning : Meaning
  resolution : Resolution
  transformation : Transformation
  normalization : Normalization
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [supportName c.support, classicalName c.classical, observationName c.observation, partsName c.parts, meaningName c.meaning, resolutionName c.resolution, transformationName c.transformation, normalizationName c.normalization, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "classical=" (classicalName c.classical), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "parts=" (partsName c.parts), SFT.Host.Text.append "meaning=" (meaningName c.meaning), SFT.Host.Text.append "resolution=" (resolutionName c.resolution), SFT.Host.Text.append "transformation=" (transformationName c.transformation), SFT.Host.Text.append "normalization=" (normalizationName c.normalization), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-support__one-held-supported-state__total-observation-classes__exact-class-whole-parts__unresolved-deterministic-distinction__singleton-class-only__deterministic-predecessor-grouping__partition-exact-whole__microstate-successor__no-extra-stochastic-law"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-canonical-support" &&
  SFT.Host.Text.equal (classicalName c.classical) "one-held-supported-state" &&
  SFT.Host.Text.equal (observationName c.observation) "total-observation-classes" &&
  SFT.Host.Text.equal (partsName c.parts) "exact-class-whole-parts" &&
  SFT.Host.Text.equal (meaningName c.meaning) "unresolved-deterministic-distinction" &&
  SFT.Host.Text.equal (resolutionName c.resolution) "singleton-class-only" &&
  SFT.Host.Text.equal (transformationName c.transformation) "deterministic-predecessor-grouping" &&
  SFT.Host.Text.equal (normalizationName c.normalization) "partition-exact-whole" &&
  SFT.Host.Text.equal (generalityName c.generality) "microstate-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-stochastic-law"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-canonical-support") then "Sampling or duplication changes every exact part." else
  if !(SFT.Host.Text.equal (classicalName c.classical) "one-held-supported-state") then "A name alone does not locate a state in complete support." else
  if !(SFT.Host.Text.equal (observationName c.observation) "total-observation-classes") then "Weights without microstates import a distribution." else
  if !(SFT.Host.Text.equal (partsName c.parts) "exact-class-whole-parts") then "Floating propensities import precision and causal assumptions." else
  if !(SFT.Host.Text.equal (meaningName c.meaning) "unresolved-deterministic-distinction") then "A random cause is neither generated nor needed." else
  if !(SFT.Host.Text.equal (resolutionName c.resolution) "singleton-class-only") then "Selecting the likely state imports a prior." else
  if !(SFT.Host.Text.equal (transformationName c.transformation) "deterministic-predecessor-grouping") then "A free transition matrix adds parameters and random dynamics." else
  if !(SFT.Host.Text.equal (normalizationName c.normalization) "partition-exact-whole") then "A fitted factor can conceal omitted states." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "microstate-successor") then "Examples do not prove the next microstate update." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-stochastic-law") then "The addition is a free parameter and may select results." else
  "The classical/probabilistic kernel is complete deterministic support, one held classical state, total observation classes, exact positive class parts, singleton-only resolution, deterministic pushforward, exact-whole closure, successor closure and no stochastic law."

def generationRule : String := "Generate the complete product of deterministic support, classical state, observation, exact class parts, probabilistic meaning, resolution, transformation, whole closure, generality and extra-random status."
def grammarBoundary : String := "All finite classical/probabilistic information descriptions generated from complete deterministic support, one held classical state, total observation classes, exact positive support parts and total deterministic maps."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Classical.rejected,Classical.admitted]).flatMap fun classical =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Parts.rejected,Parts.admitted]).flatMap fun parts =>
  ([Meaning.rejected,Meaning.admitted]).flatMap fun meaning =>
  ([Resolution.rejected,Resolution.admitted]).flatMap fun resolution =>
  ([Transformation.rejected,Transformation.admitted]).flatMap fun transformation =>
  ([Normalization.rejected,Normalization.admitted]).flatMap fun normalization =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨support,classical,observation,parts,meaning,resolution,transformation,normalization,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support classical observation parts meaning resolution transformation normalization generality addition =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclassical : classical ∈ [Classical.rejected,Classical.admitted] := by
      cases classical <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hparts : parts ∈ [Parts.rejected,Parts.admitted] := by
      cases parts <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeaning : meaning ∈ [Meaning.rejected,Meaning.admitted] := by
      cases meaning <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresolution : resolution ∈ [Resolution.rejected,Resolution.admitted] := by
      cases resolution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransformation : transformation ∈ [Transformation.rejected,Transformation.admitted] := by
      cases transformation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnormalization : normalization ∈ [Normalization.rejected,Normalization.admitted] := by
      cases normalization <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ classical _ hclassical
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ parts _ hparts
    apply CommonRefinement.memFlatMap _ _ meaning _ hmeaning
    apply CommonRefinement.memFlatMap _ _ resolution _ hresolution
    apply CommonRefinement.memFlatMap _ _ transformation _ htransformation
    apply CommonRefinement.memFlatMap _ _ normalization _ hnormalization
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support classical observation parts meaning resolution transformation normalization generality addition =>
    cases support <;> cases classical <;> cases observation <;> cases parts <;> cases meaning <;> cases resolution <;> cases transformation <;> cases normalization <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support classical observation parts meaning resolution transformation normalization generality addition =>
    cases support <;> cases classical <;> cases observation <;> cases parts <;> cases meaning <;> cases resolution <;> cases transformation <;> cases normalization <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.classical = .admitted ∧ c.observation = .admitted ∧ c.parts = .admitted ∧ c.meaning = .admitted ∧ c.resolution = .admitted ∧ c.transformation = .admitted ∧ c.normalization = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support classical observation parts meaning resolution transformation normalization generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem classical_rejected_rejected (c : Candidate) (h : c.classical = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.classical eq
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

theorem parts_rejected_rejected (c : Candidate) (h : c.parts = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.parts eq
    rw [h] at field
    cases field

theorem meaning_rejected_rejected (c : Candidate) (h : c.meaning = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.meaning eq
    rw [h] at field
    cases field

theorem resolution_rejected_rejected (c : Candidate) (h : c.resolution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.resolution eq
    rw [h] at field
    cases field

theorem transformation_rejected_rejected (c : Candidate) (h : c.transformation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transformation eq
    rw [h] at field
    cases field

theorem normalization_rejected_rejected (c : Candidate) (h : c.normalization = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.normalization eq
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

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.InformationScience.ClassicalGrammar
