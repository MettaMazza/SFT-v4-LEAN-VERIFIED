import SFT.InformationScience.EntropyWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.EntropyGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "partial-microstate-support"
  | .admitted => "complete-deterministic-support"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "overlapping-or-partial-classes"
  | .admitted => "total-disjoint-observation-classes"

inductive Weights where
  | rejected | admitted

def weightsName : Weights → String
  | .rejected => "floating-probability"
  | .admitted => "exact-class-whole-part"

inductive Unresolved where
  | rejected | admitted

def unresolvedName : Unresolved → String
  | .rejected => "scalar-uncertainty-score"
  | .admitted => "complete-within-class-pairs"

inductive Entropy where
  | rejected | admitted

def entropyName : Entropy → String
  | .rejected => "logarithmic-expectation"
  | .admitted => "weighted-class-distinction-ledger"

inductive Refinement where
  | rejected | admitted

def refinementName : Refinement → String
  | .rejected => "assumed-more-information"
  | .admitted => "class-containment-witness"

inductive Cause where
  | rejected | admitted

def causeName : Cause → String
  | .rejected => "ontic-random-source"
  | .admitted => "deterministic-support-observation"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "sampled-distributions"
  | .admitted => "microstate-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-log-base-or-prior"
  | .admitted => "no-extra-entropy-convention"

structure Candidate where
  support : Support
  partition : Partition
  weights : Weights
  unresolved : Unresolved
  entropy : Entropy
  refinement : Refinement
  cause : Cause
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [supportName c.support, partitionName c.partition, weightsName c.weights, unresolvedName c.unresolved, entropyName c.entropy, refinementName c.refinement, causeName c.cause, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "weights=" (weightsName c.weights), SFT.Host.Text.append "unresolved=" (unresolvedName c.unresolved), SFT.Host.Text.append "entropy=" (entropyName c.entropy), SFT.Host.Text.append "refinement=" (refinementName c.refinement), SFT.Host.Text.append "cause=" (causeName c.cause), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-deterministic-support__total-disjoint-observation-classes__exact-class-whole-part__complete-within-class-pairs__weighted-class-distinction-ledger__class-containment-witness__deterministic-support-observation__microstate-successor__no-extra-entropy-convention"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-deterministic-support" &&
  SFT.Host.Text.equal (partitionName c.partition) "total-disjoint-observation-classes" &&
  SFT.Host.Text.equal (weightsName c.weights) "exact-class-whole-part" &&
  SFT.Host.Text.equal (unresolvedName c.unresolved) "complete-within-class-pairs" &&
  SFT.Host.Text.equal (entropyName c.entropy) "weighted-class-distinction-ledger" &&
  SFT.Host.Text.equal (refinementName c.refinement) "class-containment-witness" &&
  SFT.Host.Text.equal (causeName c.cause) "deterministic-support-observation" &&
  SFT.Host.Text.equal (generalityName c.generality) "microstate-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-entropy-convention"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-deterministic-support") then "Omission changes observation classes and uncertainty." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "total-disjoint-observation-classes") then "Overlap or omission does not partition exact support." else
  if !(SFT.Host.Text.equal (weightsName c.weights) "exact-class-whole-part") then "A floating propensity imports precision and stochastic cause." else
  if !(SFT.Host.Text.equal (unresolvedName c.unresolved) "complete-within-class-pairs") then "A scalar score erases which distinctions are unavailable." else
  if !(SFT.Host.Text.equal (entropyName c.entropy) "weighted-class-distinction-ledger") then "Logarithms and real expectations import forbidden proof values." else
  if !(SFT.Host.Text.equal (refinementName c.refinement) "class-containment-witness") then "A name does not prove one observation separates every fine class." else
  if !(SFT.Host.Text.equal (causeName c.cause) "deterministic-support-observation") then "A stochastic source is neither generated nor required." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "microstate-successor") then "Examples cannot establish a fresh microstate class update." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-entropy-convention") then "A chosen log base or prior is a free parameter." else
  "The entropy/uncertainty kernel is complete deterministic support, total observation classes, exact class parts, complete unresolved-pair ledgers, refinement containment, successor closure and no stochastic or log rule."

def generationRule : String := "Generate the complete product of microstate support, observation partition, class weights, unresolved pairs, entropy representation, refinement order, deterministic status, generality and extra-entropy status."
def grammarBoundary : String := "All finite uncertainty structures generated from complete deterministic microstate support, total observation partitions, exact class parts, complete within-class pair ledgers and refinement relations."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Weights.rejected,Weights.admitted]).flatMap fun weights =>
  ([Unresolved.rejected,Unresolved.admitted]).flatMap fun unresolved =>
  ([Entropy.rejected,Entropy.admitted]).flatMap fun entropy =>
  ([Refinement.rejected,Refinement.admitted]).flatMap fun refinement =>
  ([Cause.rejected,Cause.admitted]).flatMap fun cause =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨support,partition,weights,unresolved,entropy,refinement,cause,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support partition weights unresolved entropy refinement cause generality addition =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hweights : weights ∈ [Weights.rejected,Weights.admitted] := by
      cases weights <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunresolved : unresolved ∈ [Unresolved.rejected,Unresolved.admitted] := by
      cases unresolved <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hentropy : entropy ∈ [Entropy.rejected,Entropy.admitted] := by
      cases entropy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrefinement : refinement ∈ [Refinement.rejected,Refinement.admitted] := by
      cases refinement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcause : cause ∈ [Cause.rejected,Cause.admitted] := by
      cases cause <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ weights _ hweights
    apply CommonRefinement.memFlatMap _ _ unresolved _ hunresolved
    apply CommonRefinement.memFlatMap _ _ entropy _ hentropy
    apply CommonRefinement.memFlatMap _ _ refinement _ hrefinement
    apply CommonRefinement.memFlatMap _ _ cause _ hcause
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support partition weights unresolved entropy refinement cause generality addition =>
    cases support <;> cases partition <;> cases weights <;> cases unresolved <;> cases entropy <;> cases refinement <;> cases cause <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support partition weights unresolved entropy refinement cause generality addition =>
    cases support <;> cases partition <;> cases weights <;> cases unresolved <;> cases entropy <;> cases refinement <;> cases cause <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.partition = .admitted ∧ c.weights = .admitted ∧ c.unresolved = .admitted ∧ c.entropy = .admitted ∧ c.refinement = .admitted ∧ c.cause = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support partition weights unresolved entropy refinement cause generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
    rw [h] at field
    cases field

theorem weights_rejected_rejected (c : Candidate) (h : c.weights = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.weights eq
    rw [h] at field
    cases field

theorem unresolved_rejected_rejected (c : Candidate) (h : c.unresolved = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.unresolved eq
    rw [h] at field
    cases field

theorem entropy_rejected_rejected (c : Candidate) (h : c.entropy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.entropy eq
    rw [h] at field
    cases field

theorem refinement_rejected_rejected (c : Candidate) (h : c.refinement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.refinement eq
    rw [h] at field
    cases field

theorem cause_rejected_rejected (c : Candidate) (h : c.cause = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cause eq
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

end SFT.InformationScience.EntropyGrammar
