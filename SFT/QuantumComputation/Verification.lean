import SFT.QuantumComputation.Algorithms
import SFT.QuantumComputation.Measurement
namespace SFT.QuantumComputation.Verification
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleExecution
open SFT.QuantumComputation.ReversibleObservation SFT.QuantumComputation.Algorithms
open SFT.InformationScience.EncodingMaps SFT.Mathematics.DiscreteObjects

theorem completeAcceptedBranchCheck (initial terminal selected : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe terminal mapping label = .ok (selected,record))
    (check : (Word × String) → Bool) :
    selected.branches.all check = true ↔
      ∀ source, source ∈ initial.branches → ∀ target,
        BranchTrace initial.phaseCycle gates source target → lookupFirst mapping target.1 = some label →
        check target = true := by
  constructor
  · intro passed source held target trace accepted
    have member := (selectedBranchCorrectness initial terminal selected gates states execution mapping label record observed target).mpr
      ⟨⟨source,held,trace⟩,accepted⟩
    exact (allTrueIffMembers check selected.branches).mp passed target member
  · intro correct
    apply (allTrueIffMembers check selected.branches).mpr
    intro target member
    obtain ⟨⟨source,held,trace⟩,accepted⟩ :=
      (selectedBranchCorrectness initial terminal selected gates states execution mapping label record observed target).mp member
    exact correct source held target trace accepted

theorem rejectedBranchEvidenceRetained (initial terminal selected : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) (mapping : Classification) (label outcome : String)
    (record : List Record) (observed : observe terminal mapping label = .ok (selected,record))
    (source target : Word × String) (held : source ∈ initial.branches)
    (trace : BranchTrace initial.phaseCycle gates source target)
    (classified : lookupFirst mapping target.1 = some outcome) (rejected : outcome ≠ label) :
    target ∉ selected.branches ∧ (target,outcome) ∈ record := by
  have member := (everyBranchHasExactTrace initial terminal gates states execution target).mpr ⟨source,held,trace⟩
  exact SFT.QuantumComputation.Measurement.closedDistinctionRetained terminal selected mapping label outcome
    record observed target member classified rejected
theorem completeChallengeSchedule (initial terminal selected : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe terminal mapping label = .ok (selected,record))
    (challenges : List ((Word × String) → Bool)) :
    challenges.all (fun check => selected.branches.all check) = true ↔
      ∀ check, check ∈ challenges → ∀ source, source ∈ initial.branches → ∀ target,
        BranchTrace initial.phaseCycle gates source target → lookupFirst mapping target.1 = some label →
        check target = true := by
  constructor
  · intro passed check held
    exact (completeAcceptedBranchCheck initial terminal selected gates states execution mapping label record observed check).mp
      ((allTrueIffMembers _ _).mp passed check held)
  · intro correct
    apply (allTrueIffMembers _ _).mpr
    intro check held
    exact (completeAcceptedBranchCheck initial terminal selected gates states execution mapping label record observed check).mpr
      (correct check held)

theorem failedChallengeRejects (initial terminal selected : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe terminal mapping label = .ok (selected,record))
    (challenges : List ((Word × String) → Bool)) (check : (Word × String) → Bool)
    (heldCheck : check ∈ challenges) (source target : Word × String) (held : source ∈ initial.branches)
    (trace : BranchTrace initial.phaseCycle gates source target)
    (classified : lookupFirst mapping target.1 = some label) (failed : check target = false) :
    challenges.all (fun test => selected.branches.all test) ≠ true := by
  intro passed
  have success := (completeChallengeSchedule initial terminal selected gates states execution mapping label record observed challenges).mp
    passed check heldCheck source held target trace classified
  rw [failed] at success
  cases success
end SFT.QuantumComputation.Verification
