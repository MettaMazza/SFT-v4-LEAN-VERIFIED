import SFT.Computation.LearningOptimization
namespace SFT.Computation.ComputationalInduction
open SFT.Computation.Inference SFT.Computation.LearningOptimization
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation
abbrev Model := LearningOptimization.Model

def alternatives (m : Model) : List Hypothesis := retained m.evidence m.hypotheses
def minimalRules (m : Model) : List String := optima m
def successorTest (h : Hypothesis) (next : Evidence) : Bool := has h.2 next
def extendEvidence (m : Model) (next : Evidence) : Model := {m with evidence := m.evidence ++ [next]}

theorem successorMeaning (h : Hypothesis) (next : Evidence) : successorTest h next = true ↔ next ∈ h.2 := hasIff _ _
theorem alternativeMeaning (m : Model) (h : Hypothesis) : h ∈ alternatives m ↔
    h ∈ m.hypotheses ∧ ∀ e, e ∈ m.evidence → e ∈ h.2 := retainedMeaning _ _ _
theorem nextAlternatives (m : Model) (next : Evidence) (h : Hypothesis) :
    h ∈ alternatives (extendEvidence m next) ↔ h ∈ alternatives m ∧ next ∈ h.2 := by
  constructor
  · intro held
    have p := (alternativeMeaning _ _).mp held
    refine ⟨(alternativeMeaning _ _).mpr ⟨p.1,fun e member => p.2 e (memAppendLeft _ _ _ member)⟩,?_⟩
    exact p.2 next (memAppendRight _ _ _ (.head _))
  · intro held
    have p := (alternativeMeaning _ _).mp held.1
    apply (alternativeMeaning _ _).mpr
    refine ⟨p.1,?_⟩
    intro e member
    cases memAppendCases _ _ _ member with
    | inl old => exact p.2 e old
    | inr fresh =>
      cases fresh with
      | head => exact held.2
      | tail _ absent => cases absent

theorem falsifiedSuccessor (m : Model) (next : Evidence) (h : Hypothesis) (absent : next ∉ h.2) :
    h ∉ alternatives (extendEvidence m next) := fun held => absent ((nextAlternatives _ _ _).mp held).2

theorem minimalityMeaning (m : Model) (name : String) : name ∈ minimalRules m ↔
    name ∈ feasible m ∧ ∀ better, ¬ (better,name) ∈ m.objective := exactOptima _ _

structure SuccessorCertificate (h : Hypothesis) where
  generated : Nat → Evidence
  base : generated 0 ∈ h.2
  step : ∀ n, generated n ∈ h.2 → generated (n+1) ∈ h.2

theorem generatedContinuation (h : Hypothesis) (certificate : SuccessorCertificate h) (n : Nat) :
    certificate.generated n ∈ h.2 := by
  induction n with
  | zero => exact certificate.base
  | succ n ih => exact certificate.step n ih
theorem grammarExtension (first second : Model)
    (sameEvidence : first.evidence = second.evidence)
    (support : ∀ h, h ∈ first.hypotheses → h ∈ second.hypotheses)
    (h : Hypothesis) (held : h ∈ alternatives first) : h ∈ alternatives second := by
  have p := (alternativeMeaning _ _).mp held
  apply (alternativeMeaning _ _).mpr
  refine ⟨support h p.1,?_⟩
  intro e member
  exact p.2 e (sameEvidence ▸ member)
end SFT.Computation.ComputationalInduction
