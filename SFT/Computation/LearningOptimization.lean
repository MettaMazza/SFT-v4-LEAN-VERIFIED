import SFT.Computation.Inference
import SFT.Computation.OptimizationTrace
namespace SFT.Computation.LearningOptimization
open SFT.Computation.Inference SFT.Computation.OptimizationTrace
open SFT.Mathematics.OptimizationSelection
structure Model where
  hypotheses : List Hypothesis
  evidence : List Evidence
  objective : Preference

def feasible (m : Model) : List String := (retained m.evidence m.hypotheses).map Prod.fst
def optima (m : Model) : List String := scan m.objective [] (feasible m)
def updateTrace (m : Model) : List (List String) := history m.objective [] (feasible m)
def comparisons (m : Model) : List (String × Preference) := comparisonLedger (feasible m) m.objective

theorem exactOptima (m : Model) (name : String) : name ∈ optima m ↔
    name ∈ feasible m ∧ ∀ better, ¬ (better,name) ∈ m.objective := survivorCertificate _ _ _
theorem completeTrace (m : Model) : Trace m.objective [] (feasible m) (updateTrace m) := completeHistory _ _ _
theorem replay (m : Model) (states : List (List String))
    (proof : Trace m.objective [] (feasible m) states) : updateTrace m = states := historyReplay _ _ _ _ proof
theorem comparedEveryCandidate (m : Model) (name : String) :
    (name,eliminators m.objective name) ∈ comparisons m ↔ name ∈ feasible m := completeComparison _ _ _
theorem eliminationEvidence (m : Model) (name : String)
    (valid : preferenceValid (feasible m) m.objective = true)
    (held : name ∈ feasible m) (gone : name ∉ optima m) :
    ∃ better, better ∈ feasible m ∧ (better,name) ∈ eliminators m.objective name ∧ better ≠ name :=
  eliminationCertificate _ _ _ valid held gone
theorem retainTies (m : Model) (a b : String) (ha : a ∈ feasible m) (hb : b ∈ feasible m)
    (pa : ∀ better, ¬ (better,a) ∈ m.objective) (pb : ∀ better, ¬ (better,b) ∈ m.objective) :
    a ∈ optima m ∧ b ∈ optima m := noTieBreak _ _ _ _ ha hb pa pb
theorem feasibleEvidence (m : Model) (name : String) : name ∈ feasible m ↔
    ∃ h, h ∈ m.hypotheses ∧ (∀ e, e ∈ m.evidence → e ∈ h.2) ∧ h.1 = name := by
  constructor
  · intro held
    obtain ⟨h,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held
    have p := (retainedMeaning _ _ _).mp member
    exact ⟨h,p.1,p.2,same⟩
  · intro h
    obtain ⟨row,member,fits,same⟩ := h
    have p := SFT.Foundation.Count.TraceDerivation.memMap Prod.fst row _ ((retainedMeaning _ _ _).mpr ⟨member,fits⟩)
    rw [same] at p
    exact p
theorem selectionExtension (first second : Model) (fresh : List String)
    (added : Preference) (support : feasible second = feasible first ++ fresh)
    (relation : second.objective = first.objective ++ added) (name : String) :
    name ∈ optima second ↔ (name ∈ feasible first ∨ name ∈ fresh) ∧
      (∀ better, ¬ (better,name) ∈ first.objective) ∧ (∀ better, ¬ (better,name) ∈ added) := by
  unfold optima
  rw [support,relation]
  exact extendedSelection _ _ _ _ _
theorem traceLength (m : Model) : (updateTrace m).length = (feasible m).length + 1 := historyCount _ _ _
theorem selectionComposition (m : Model) (first second : List String)
    (partition : feasible m = first ++ second) :
    optima m = scan m.objective (scan m.objective [] first) second := by
  unfold optima
  rw [partition]
  exact scanComposition _ _ _ _
end SFT.Computation.LearningOptimization
