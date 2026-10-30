import SFT.QuantumComputation.Algorithms
import SFT.QuantumComputation.StateComposition
import SFT.QuantumComputation.Circuit
namespace SFT.QuantumComputation.Learning
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleComposition
open SFT.QuantumComputation.StateComposition SFT.QuantumComputation.ReversibleExecution
open SFT.QuantumComputation.ReversibleObservation SFT.QuantumComputation.Algorithms
open SFT.InformationScience.EncodingMaps

theorem selectedJointExample (examples hypotheses joint terminal selected : State)
    (composed : compose examples hypotheses = .ok joint) (gates : List Gate) (states : List State)
    (execution : Forward joint gates states terminal) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe terminal mapping label = .ok (selected,record))
    (target : Word × String) : target ∈ selected.branches ↔
      ∃ sample hypothesis source, Cell examples hypotheses sample hypothesis source ∧
        BranchTrace joint.phaseCycle gates source target ∧ lookupFirst mapping target.1 = some label := by
  constructor
  · intro held
    obtain ⟨⟨source,member,trace⟩,classified⟩ :=
      (selectedBranchCorrectness joint terminal selected gates states execution mapping label record observed target).mp held
    obtain ⟨sample,hypothesis,cell⟩ := (compositionRowsExactly examples hypotheses joint composed source).mp member
    exact ⟨sample,hypothesis,source,cell,trace,classified⟩
  · intro ⟨sample,hypothesis,source,cell,trace,classified⟩
    exact (selectedBranchCorrectness joint terminal selected gates states execution mapping label record observed target).mpr
      ⟨⟨source,(compositionRowsExactly examples hypotheses joint composed source).mpr ⟨sample,hypothesis,cell⟩,trace⟩,classified⟩

theorem jointSearchRecordCost (examples hypotheses joint terminal selected : State)
    (composed : compose examples hypotheses = .ok joint) (gates : List Gate) (states : List State)
    (execution : Forward joint gates states terminal) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe terminal mapping label = .ok (selected,record)) :
    record.length = examples.branches.length * hypotheses.branches.length := by
  exact (SFT.QuantumComputation.Circuit.circuitObservationRecord joint terminal selected gates states execution
    mapping label record observed).1.trans (compositionCount examples hypotheses joint composed)
theorem allAlternativesRecorded (initial terminal selected : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) (mapping : Classification) (label outcome : String)
    (record : List Record) (observed : observe terminal mapping label = .ok (selected,record))
    (target : Word × String) : (target,outcome) ∈ record ↔
      (∃ source, source ∈ initial.branches ∧ BranchTrace initial.phaseCycle gates source target) ∧
        lookupFirst mapping target.1 = some outcome := by
  have rows := (observationSource terminal selected mapping label record observed).2.1
  constructor
  · intro held
    have p := (recordMembership mapping terminal.branches record rows target outcome).mp held
    exact ⟨(everyBranchHasExactTrace initial terminal gates states execution target).mp p.1,p.2⟩
  · intro p
    exact (recordMembership mapping terminal.branches record rows target outcome).mpr
      ⟨(everyBranchHasExactTrace initial terminal gates states execution target).mpr p.1,p.2⟩
theorem interferenceJointExample (examples hypotheses joint terminal : State)
    (composed : compose examples hypotheses = .ok joint) (gates : List Gate) (states : List State)
    (execution : Forward joint gates states terminal) (mapping : Classification) (label : String)
    (groups : List (String × List (Word × String)))
    (merged : predecessorMerge terminal mapping = .ok groups)
    (rows : List (Word × String)) (group : (label,rows) ∈ groups)
    (target : Word × String) : target ∈ rows ↔
      ∃ sample hypothesis source, Cell examples hypotheses sample hypothesis source ∧
        BranchTrace joint.phaseCycle gates source target ∧ lookupFirst mapping target.1 = some label := by
  constructor
  · intro held
    obtain ⟨⟨source,member,trace⟩,classified⟩ :=
      (interferenceBranchCorrectness joint terminal gates states execution mapping groups merged label rows group target).mp held
    obtain ⟨sample,hypothesis,cell⟩ := (compositionRowsExactly examples hypotheses joint composed source).mp member
    exact ⟨sample,hypothesis,source,cell,trace,classified⟩
  · intro ⟨sample,hypothesis,source,cell,trace,classified⟩
    exact (interferenceBranchCorrectness joint terminal gates states execution mapping groups merged label rows group target).mpr
      ⟨⟨source,(compositionRowsExactly examples hypotheses joint composed source).mpr ⟨sample,hypothesis,cell⟩,trace⟩,classified⟩

end SFT.QuantumComputation.Learning
