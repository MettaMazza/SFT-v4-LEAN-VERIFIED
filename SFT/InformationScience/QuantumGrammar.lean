import SFT.InformationScience.QuantumWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.QuantumGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Unit where
  | rejected | admitted

def unitName : Unit → String
  | .rejected => "imported-qubit"
  | .admitted => "one-Fold-distinction"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "sampled-branches"
  | .admitted => "complete-Fold-word-support"

inductive Basis where
  | rejected | admitted

def basisName : Basis → String
  | .rejected => "unnamed-state-count"
  | .admitted => "bijective-word-basis-trace"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "amplitude-only-row"
  | .admitted => "position-label-trace"

inductive Superposition where
  | rejected | admitted

def superpositionName : Superposition → String
  | .rejected => "complex-amplitude-premise"
  | .admitted => "complete-alternative-support"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "tensor-symbol-premise"
  | .admitted => "complete-pair-cell-support"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "stochastic-collapse"
  | .admitted => "exact-observation-class"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "discarded-predecessors"
  | .admitted => "complete-branch-image-record"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "small-depth-table"
  | .admitted => "position-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-amplitude-phase-or-gate-law"
  | .admitted => "no-extra-quantum-operation"

structure Candidate where
  unit : Unit
  support : Support
  basis : Basis
  provenance : Provenance
  superposition : Superposition
  composition : Composition
  observation : Observation
  record : Record
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [unitName c.unit, supportName c.support, basisName c.basis, provenanceName c.provenance, superpositionName c.superposition, compositionName c.composition, observationName c.observation, recordName c.record, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "unit=" (unitName c.unit), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "basis=" (basisName c.basis), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "superposition=" (superpositionName c.superposition), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "one-Fold-distinction__complete-Fold-word-support__bijective-word-basis-trace__position-label-trace__complete-alternative-support__complete-pair-cell-support__exact-observation-class__complete-branch-image-record__position-successor__no-extra-quantum-operation"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (unitName c.unit) "one-Fold-distinction" &&
  SFT.Host.Text.equal (supportName c.support) "complete-Fold-word-support" &&
  SFT.Host.Text.equal (basisName c.basis) "bijective-word-basis-trace" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "position-label-trace" &&
  SFT.Host.Text.equal (superpositionName c.superposition) "complete-alternative-support" &&
  SFT.Host.Text.equal (compositionName c.composition) "complete-pair-cell-support" &&
  SFT.Host.Text.equal (observationName c.observation) "exact-observation-class" &&
  SFT.Host.Text.equal (recordName c.record) "complete-branch-image-record" &&
  SFT.Host.Text.equal (generalityName c.generality) "position-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-quantum-operation"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (unitName c.unit) "one-Fold-distinction") then "A conventional qubit premise would select the carrier." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-Fold-word-support") then "Sampling cannot establish complete finite support." else
  if !(SFT.Host.Text.equal (basisName c.basis) "bijective-word-basis-trace") then "A count erases which Fold word corresponds to which basis state." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "position-label-trace") then "A coefficient without a generated word erases branch origin." else
  if !(SFT.Host.Text.equal (superpositionName c.superposition) "complete-alternative-support") then "Complex amplitudes, phases and normalization are not derived here." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "complete-pair-cell-support") then "A borrowed symbol does not enumerate joint alternatives." else
  if !(SFT.Host.Text.equal (observationName c.observation) "exact-observation-class") then "A random collapse rule is not generated at this boundary." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-branch-image-record") then "Discarding the record prevents exact support reconstruction." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "position-successor") then "A table does not establish the next support layer." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-quantum-operation") then "Those structures belong to later forced derivations and would select results here." else
  "The quantum-information correspondence kernel is one Fold distinction per position, complete Fold-word branch support, bijective basis and provenance traces, support-only superposition equivalence, complete pair-cell joint support, exact observation classes, reconstructing records, position induction and no imported quantum operation."

def generationRule : String := "Generate the complete product of native unit, word support, basis correspondence, branch provenance, superposition boundary, joint support, observation record, reconstruction, generality and extra-quantum status."
def grammarBoundary : String := "All finite quantum-information support correspondences generated from the two held Fold labels, canonical word positions, complete branch support, bijective basis names, pair-cell composition and total observation classes."

def candidates : List Candidate :=
  ([Unit.rejected,Unit.admitted]).flatMap fun unit =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Basis.rejected,Basis.admitted]).flatMap fun basis =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Superposition.rejected,Superposition.admitted]).flatMap fun superposition =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨unit,support,basis,provenance,superposition,composition,observation,record,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk unit support basis provenance superposition composition observation record generality addition =>
    have hunit : unit ∈ [Unit.rejected,Unit.admitted] := by
      cases unit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbasis : basis ∈ [Basis.rejected,Basis.admitted] := by
      cases basis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuperposition : superposition ∈ [Superposition.rejected,Superposition.admitted] := by
      cases superposition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ unit _ hunit
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ basis _ hbasis
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ superposition _ hsuperposition
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk unit support basis provenance superposition composition observation record generality addition =>
    cases unit <;> cases support <;> cases basis <;> cases provenance <;> cases superposition <;> cases composition <;> cases observation <;> cases record <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk unit support basis provenance superposition composition observation record generality addition =>
    cases unit <;> cases support <;> cases basis <;> cases provenance <;> cases superposition <;> cases composition <;> cases observation <;> cases record <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.unit = .admitted ∧ c.support = .admitted ∧ c.basis = .admitted ∧ c.provenance = .admitted ∧ c.superposition = .admitted ∧ c.composition = .admitted ∧ c.observation = .admitted ∧ c.record = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk unit support basis provenance superposition composition observation record generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem unit_rejected_rejected (c : Candidate) (h : c.unit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.unit eq
    rw [h] at field
    cases field

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem basis_rejected_rejected (c : Candidate) (h : c.basis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.basis eq
    rw [h] at field
    cases field

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
    rw [h] at field
    cases field

theorem superposition_rejected_rejected (c : Candidate) (h : c.superposition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.superposition eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
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

end SFT.InformationScience.QuantumGrammar
