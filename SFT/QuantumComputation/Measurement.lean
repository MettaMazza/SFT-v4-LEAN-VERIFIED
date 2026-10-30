import SFT.QuantumComputation.ReversibleObservation
namespace SFT.QuantumComputation.Measurement
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleObservation
open SFT.InformationScience.EncodingMaps SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

theorem totalObservationRelation (state selected : State) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe state mapping label = .ok (selected,record))
    (branch : Word × String) (held : branch ∈ state.branches) :
    ∃ outcome, lookupFirst mapping branch.1 = some outcome ∧ (branch,outcome) ∈ record := by
  have source := observationSource state selected mapping label record observed
  have coverage := ((SFT.Mathematics.GeometryTopology.andTrue _ _).mp source.1).2
  have domain := (hasIff _ _).mp ((allTrueIffMembers _ _).mp coverage branch.1
    (memMap Prod.fst branch state.branches held))
  obtain ⟨outcome,lookup⟩ := (lookupDefined mapping branch.1).mpr domain
  exact ⟨outcome,lookup,(recordMembership mapping state.branches record source.2.1 branch outcome).mpr ⟨held,lookup⟩⟩

theorem closedDistinctionRetained (state selected : State) (mapping : Classification) (label outcome : String)
    (record : List Record) (observed : observe state mapping label = .ok (selected,record))
    (branch : Word × String) (held : branch ∈ state.branches)
    (classified : lookupFirst mapping branch.1 = some outcome) (closed : outcome ≠ label) :
    branch ∉ selected.branches ∧ (branch,outcome) ∈ record := by
  have source := observationSource state selected mapping label record observed
  refine ⟨?_,(recordMembership mapping state.branches record source.2.1 branch outcome).mpr ⟨held,classified⟩⟩
  intro selectedHeld
  have chosen := (observationMembership state selected mapping label record observed branch).mp selectedHeld
  rw [classified] at chosen
  exact closed (Option.some.inj chosen.2)

theorem reconstructEntireState (state selected : State) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe state mapping label = .ok (selected,record)) :
    (⟨record.map Prod.fst,selected.phaseCycle⟩ : State) = state := by
  have source := observationSource state selected mapping label record observed
  rw [(observationReconstruction state selected mapping label record observed).1,source.2.2.2.1]

theorem selectedClassPreservesOrder (state selected : State) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe state mapping label = .ok (selected,record)) :
    selected.branches = state.branches.filter (matchesLabel mapping label) := by
  have source := observationSource state selected mapping label record observed
  exact source.2.2.1.trans (retainedOrder mapping state.branches record source.2.1 label)

end SFT.QuantumComputation.Measurement
