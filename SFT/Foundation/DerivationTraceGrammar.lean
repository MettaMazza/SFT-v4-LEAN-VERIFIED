import SFT.Foundation.DerivationTraceControls
import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.DerivationTraceGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "source-unbound"
  | .admitted => "source-bound"

inductive Dependencies where
  | rejected | admitted

def dependenciesName : Dependencies → String
  | .rejected => "dependencies-partial"
  | .admitted => "dependencies-complete"

inductive Ordering where
  | rejected | admitted

def orderingName : Ordering → String
  | .rejected => "order-lost"
  | .admitted => "order-preserved"

inductive Intermediates where
  | rejected | admitted

def intermediatesName : Intermediates → String
  | .rejected => "intermediates-inexact"
  | .admitted => "intermediates-exact"

inductive Operations where
  | rejected | admitted

def operationsName : Operations → String
  | .rejected => "operations-unregistered"
  | .admitted => "operations-registered"

inductive Reproduction where
  | rejected | admitted

def reproductionName : Reproduction → String
  | .rejected => "replay-diverges"
  | .admitted => "replay-identical"

inductive Terminal where
  | rejected | admitted

def terminalName : Terminal → String
  | .rejected => "terminal-unbound"
  | .admitted => "terminal-identity-bound"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "has-extra"
  | .admitted => "no-extra"

structure Candidate where
  source : Source
  dependencies : Dependencies
  ordering : Ordering
  intermediates : Intermediates
  operations : Operations
  reproduction : Reproduction
  terminal : Terminal
  addition : Addition

def sourceFields (c : Candidate) : List String := [sourceName c.source, dependenciesName c.dependencies, orderingName c.ordering, intermediatesName c.intermediates, operationsName c.operations, reproductionName c.reproduction, terminalName c.terminal, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.append "Derivation record has " (SFT.Host.Text.append (SFT.Host.Text.intercalate ", " (sourceFields c)) ".")
def survivorId : String := "source-bound__dependencies-complete__order-preserved__intermediates-exact__operations-registered__replay-identical__terminal-identity-bound__no-extra"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sourceName c.source) "source-bound" &&
  SFT.Host.Text.equal (dependenciesName c.dependencies) "dependencies-complete" &&
  SFT.Host.Text.equal (orderingName c.ordering) "order-preserved" &&
  SFT.Host.Text.equal (intermediatesName c.intermediates) "intermediates-exact" &&
  SFT.Host.Text.equal (operationsName c.operations) "operations-registered" &&
  SFT.Host.Text.equal (reproductionName c.reproduction) "replay-identical" &&
  SFT.Host.Text.equal (terminalName c.terminal) "terminal-identity-bound" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.contains (candidateId c) "source-unbound" then "The executed derivation source has no immutable identity." else
  if SFT.Host.Text.contains (candidateId c) "dependencies-partial" then "At least one admitted premise or input is omitted." else
  if SFT.Host.Text.contains (candidateId c) "order-lost" then "The successor order required for replay is absent." else
  if SFT.Host.Text.contains (candidateId c) "intermediates-inexact" then "A derivational intermediate is not an exact admitted value." else
  if SFT.Host.Text.contains (candidateId c) "operations-unregistered" then "A step invokes an operation outside the admitted primitive set." else
  if SFT.Host.Text.contains (candidateId c) "replay-diverges" then "Independent execution does not reproduce every bound row." else
  if SFT.Host.Text.contains (candidateId c) "terminal-unbound" then "The final result is not tied to the replayed terminal identity." else
  if SFT.Host.Text.contains (candidateId c) "has-extra" then "The record adds an ungenerated step or datum." else
  "It is the complete ordered exact source- and dependency-bound replay record with identical terminal identity."

def generationRule : String := "Generate the complete product of source custody, dependency coverage, step order, intermediate exactness, operation registration, replay equality, terminal identity and added-data class."
def grammarBoundary : String := "All finite derivation records assembled from admitted exact inputs and registered primitive operations, with an ordered hash-bound row for every successor step."

def candidates : List Candidate :=
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Dependencies.rejected,Dependencies.admitted]).flatMap fun dependencies =>
  ([Ordering.rejected,Ordering.admitted]).flatMap fun ordering =>
  ([Intermediates.rejected,Intermediates.admitted]).flatMap fun intermediates =>
  ([Operations.rejected,Operations.admitted]).flatMap fun operations =>
  ([Reproduction.rejected,Reproduction.admitted]).flatMap fun reproduction =>
  ([Terminal.rejected,Terminal.admitted]).flatMap fun terminal =>
  ([Addition.admitted,Addition.rejected]).map fun addition =>
  ⟨source,dependencies,ordering,intermediates,operations,reproduction,terminal,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk source dependencies ordering intermediates operations reproduction terminal addition =>
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdependencies : dependencies ∈ [Dependencies.rejected,Dependencies.admitted] := by
      cases dependencies <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hordering : ordering ∈ [Ordering.rejected,Ordering.admitted] := by
      cases ordering <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hintermediates : intermediates ∈ [Intermediates.rejected,Intermediates.admitted] := by
      cases intermediates <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperations : operations ∈ [Operations.rejected,Operations.admitted] := by
      cases operations <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreproduction : reproduction ∈ [Reproduction.rejected,Reproduction.admitted] := by
      cases reproduction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hterminal : terminal ∈ [Terminal.rejected,Terminal.admitted] := by
      cases terminal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.admitted,Addition.rejected] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ dependencies _ hdependencies
    apply CommonRefinement.memFlatMap _ _ ordering _ hordering
    apply CommonRefinement.memFlatMap _ _ intermediates _ hintermediates
    apply CommonRefinement.memFlatMap _ _ operations _ hoperations
    apply CommonRefinement.memFlatMap _ _ reproduction _ hreproduction
    apply CommonRefinement.memFlatMap _ _ terminal _ hterminal
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk source dependencies ordering intermediates operations reproduction terminal addition =>
    cases source <;> cases dependencies <;> cases ordering <;> cases intermediates <;> cases operations <;> cases reproduction <;> cases terminal <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk source dependencies ordering intermediates operations reproduction terminal addition =>
    cases source <;> cases dependencies <;> cases ordering <;> cases intermediates <;> cases operations <;> cases reproduction <;> cases terminal <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.source = .admitted ∧ c.dependencies = .admitted ∧ c.ordering = .admitted ∧ c.intermediates = .admitted ∧ c.operations = .admitted ∧ c.reproduction = .admitted ∧ c.terminal = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk source dependencies ordering intermediates operations reproduction terminal addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
    rw [h] at field
    cases field

theorem dependencies_rejected_rejected (c : Candidate) (h : c.dependencies = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dependencies eq
    rw [h] at field
    cases field

theorem ordering_rejected_rejected (c : Candidate) (h : c.ordering = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ordering eq
    rw [h] at field
    cases field

theorem intermediates_rejected_rejected (c : Candidate) (h : c.intermediates = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.intermediates eq
    rw [h] at field
    cases field

theorem operations_rejected_rejected (c : Candidate) (h : c.operations = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.operations eq
    rw [h] at field
    cases field

theorem reproduction_rejected_rejected (c : Candidate) (h : c.reproduction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reproduction eq
    rw [h] at field
    cases field

theorem terminal_rejected_rejected (c : Candidate) (h : c.terminal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.terminal eq
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

end SFT.Foundation.DerivationTraceGrammar
