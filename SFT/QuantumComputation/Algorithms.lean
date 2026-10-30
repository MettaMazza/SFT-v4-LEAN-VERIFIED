import SFT.QuantumComputation.Circuit
import SFT.QuantumComputation.GateLaw
import SFT.QuantumComputation.PhaseInterference
namespace SFT.QuantumComputation.Algorithms
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleApplication
open SFT.QuantumComputation.ReversibleExecution SFT.QuantumComputation.GateLaw
open SFT.InformationScience.EncodingMaps

-- Records precisely the original word lookup and held-phase action at each gate.
inductive BranchTrace (cycle : List String) : List Gate → (Word × String) → (Word × String) → Prop where
  | identity (row : Word × String) : BranchTrace cycle [] row row
  | next (gate : Gate) (rest : List Gate) (source middle target : Word × String)
      (word : lookupFirst gate.wordMap source.1 = some middle.1)
      (phase : shiftPhase cycle (gate.phaseSuccessors.length % cycle.length) source.2 = some middle.2)
      (tail : BranchTrace cycle rest middle target) : BranchTrace cycle (gate::rest) source target

theorem everyBranchHasExactTrace (initial terminal : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) (target : Word × String) :
    target ∈ terminal.branches ↔ ∃ source, source ∈ initial.branches ∧
      BranchTrace initial.phaseCycle gates source target := by
  induction execution with
  | identity state =>
    constructor
    · intro held; exact ⟨target,held,.identity target⟩
    · intro ⟨source,held,trace⟩; cases trace; exact held
  | next state result terminal gate gates states admitted valid applied rest ih =>
    have cycle := (applicationSource state result gate false applied).2.1
    constructor
    · intro held
      obtain ⟨middle,midHeld,tail⟩ := ih.mp held
      obtain ⟨source,sourceHeld,word,phase⟩ := (exactGateBranch state result gate applied middle).mp midHeld
      rw [cycle] at tail
      exact ⟨source,sourceHeld,.next gate gates source middle target word phase tail⟩
    · intro ⟨source,sourceHeld,trace⟩
      cases trace with
      | next _ _ _ middle _ word phase tail =>
        have midHeld := (exactGateBranch state result gate applied middle).mpr ⟨source,sourceHeld,word,phase⟩
        rw [← cycle] at tail
        exact ih.mpr ⟨middle,midHeld,tail⟩

open SFT.QuantumComputation.ReversibleObservation

theorem selectedBranchCorrectness (initial terminal selected : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe terminal mapping label = .ok (selected,record))
    (target : Word × String) : target ∈ selected.branches ↔
      (∃ source, source ∈ initial.branches ∧ BranchTrace initial.phaseCycle gates source target) ∧
      lookupFirst mapping target.1 = some label := by
  constructor
  · intro held
    have parts := (observationMembership terminal selected mapping label record observed target).mp held
    exact ⟨(everyBranchHasExactTrace initial terminal gates states execution target).mp parts.1,parts.2⟩
  · intro parts
    exact (observationMembership terminal selected mapping label record observed target).mpr
      ⟨(everyBranchHasExactTrace initial terminal gates states execution target).mpr parts.1,parts.2⟩

theorem interferenceBranchCorrectness (initial terminal : State) (gates : List Gate) (states : List State)
    (execution : Forward initial gates states terminal) (mapping : Classification)
    (groups : List (String × List (Word × String)))
    (merged : predecessorMerge terminal mapping = .ok groups) (label : String)
    (rows : List (Word × String)) (group : (label,rows) ∈ groups) (target : Word × String) :
    target ∈ rows ↔
      (∃ source, source ∈ initial.branches ∧ BranchTrace initial.phaseCycle gates source target) ∧
      lookupFirst mapping target.1 = some label := by
  constructor
  · intro held
    have parts := (SFT.QuantumComputation.PhaseInterference.predecessorFibreExactly
      terminal mapping groups merged label rows group target).mp held
    exact ⟨(everyBranchHasExactTrace initial terminal gates states execution target).mp parts.1,parts.2⟩
  · intro parts
    exact (SFT.QuantumComputation.PhaseInterference.predecessorFibreExactly
      terminal mapping groups merged label rows group target).mpr
      ⟨(everyBranchHasExactTrace initial terminal gates states execution target).mpr parts.1,parts.2⟩

end SFT.QuantumComputation.Algorithms
