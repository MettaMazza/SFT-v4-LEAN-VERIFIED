import SFT.Computation.ProfileResources
import SFT.Mathematics.OptimizationBounds
namespace SFT.Computation.ApproximationResources
open SFT.Mathematics OptimizationSelection OptimizationBounds
open SFT.InformationScience.EncodingMaps
open SFT.Foundation.ExactOperations
open BoundResources

abbrev Objectives := List (String × List String)

def CompleteObjective (feasible : List String) (objectives : Objectives) : Prop :=
  ∀ candidate, candidate ∈ feasible → ∃ cells,
    lookupFirst objectives candidate = some cells ∧ 0 < cells.length

def ObjectiveOrder (feasible : List String) (preferred : Preference) (objectives : Objectives) : Prop :=
  ∀ left right, left ∈ feasible → right ∈ feasible → ∀ a b,
    lookupFirst objectives left = some a → lookupFirst objectives right = some b →
    ((left,right) ∈ preferred ↔ a.length < b.length)

theorem optimumBound (feasible : List String) (preferred : Preference) (objectives : Objectives)
    (ordered : ObjectiveOrder feasible preferred objectives) (optimum candidate : String)
    (optimal : optimum ∈ retained feasible preferred) (held : candidate ∈ feasible)
    (best cells : List String) (one : lookupFirst objectives optimum = some best)
    (two : lookupFirst objectives candidate = some cells) : best.length ≤ cells.length := by
  have retained := (retainedMembership _ _ _).mp optimal
  apply Nat.le_of_not_gt
  intro better
  exact retained.2 candidate ((ordered candidate optimum held retained.1 cells best two one).mpr better)

theorem objectiveProvenance (objectives : Objectives) (candidate : String) (cells : List String)
    (selected : lookupFirst objectives candidate = some cells) : (candidate,cells) ∈ objectives :=
  lookupRow _ _ _ selected

theorem tiedOptima (feasible : List String) (preferred : Preference) (objectives : Objectives)
    (ordered : ObjectiveOrder feasible preferred objectives) (first second : String)
    (one : first ∈ retained feasible preferred) (two : second ∈ retained feasible preferred)
    (a b : List String) (left : lookupFirst objectives first = some a)
    (right : lookupFirst objectives second = some b) : a.length = b.length :=
  Nat.le_antisymm
    (optimumBound _ _ _ ordered _ _ one ((retainedMembership _ _ _).mp two).1 _ _ left right)
    (optimumBound _ _ _ ordered _ _ two ((retainedMembership _ _ _).mp one).1 _ _ right left)

theorem exactApproximationCertificate (feasible : List String) (preferred : Preference) (objectives : Objectives)
    (complete : CompleteObjective feasible objectives) (ordered : ObjectiveOrder feasible preferred objectives)
    (optimum candidate : String) (optimal : optimum ∈ retained feasible preferred) (held : candidate ∈ feasible) :
    ∃ best cells, lookupFirst objectives optimum = some best ∧ lookupFirst objectives candidate = some cells ∧
      ∃ positive : 0 < best.length, ∃ bound : best.length ≤ cells.length,
        exactApproximation (.ofNat cells.length) (.ofNat best.length) = .ok (normalizePart best.length cells.length positive bound) ∧
        best.length * (normalizePart best.length cells.length positive bound).denominator =
          (normalizePart best.length cells.length positive bound).numerator * cells.length := by
  obtain ⟨best,one,positive⟩ := complete optimum ((retainedMembership _ _ _).mp optimal).1
  obtain ⟨cells,two,candidatePositive⟩ := complete candidate held
  have bound := optimumBound _ _ _ ordered _ _ optimal held _ _ one two
  exact ⟨best,cells,one,two,positive,bound,approximationAdmitted _ _ _ _,approximationRatio _ _ _ _⟩

theorem missingObjectiveExcluded (feasible : List String) (objectives : Objectives) (candidate : String)
    (held : candidate ∈ feasible) (missing : lookupFirst objectives candidate = none) :
    ¬ CompleteObjective feasible objectives := by
  intro complete
  obtain ⟨cells,lookup,positive⟩ := complete candidate held
  rw [missing] at lookup
  cases lookup

theorem invalidLowerOptimum (candidate optimum : Nat) (positive : 0 < optimum)
    (invalid : ¬ optimum ≤ candidate) :
    exactApproximation (.ofNat candidate) (.ofNat optimum) =
      .error "approximation requires positive generated cell counts and a valid lower optimum" :=
  approximationRejectsInvalidBound _ _ positive invalid

theorem retainedOutputResources (registry : List (String × UniversalInterpretation.Request))
    (record : Record) (verified : Verified registry record) (before : List String) (candidate : String)
    (output : record.observed = before ++ [candidate]) :
    StateTransition.run record.request.machine record.request.initial record.request.actions = .ok (before ++ [candidate]) ∧
      record.resources.timeTrace.map Prod.snd = before ++ [candidate] ∧
      record.resources.spaceSupport = record.occupied := by
  have ledger := ResourceRecord.recordReconstructs _ _ _ verified.2.2
  rw [output] at ledger
  exact ⟨verified.2.1.trans (congrArg Except.ok output),ledger.1,ledger.2.1⟩

theorem retainedOptimumExtension (old fresh : List String) (preferred : Preference) (candidate : String)
    (held : candidate ∈ old) (noBetter : ∀ other, ¬ (other,candidate) ∈ preferred) :
    candidate ∈ retained (old ++ fresh) preferred :=
  (retainedMembership _ _ _).mpr
    ⟨SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held,noBetter⟩

theorem oneCandidateOptimum (candidate : String) : retained [candidate] [] = [candidate] := rfl
end SFT.Computation.ApproximationResources
