import SFT.QuantumComputation.Algorithms
import SFT.QuantumComputation.Complexity
namespace SFT.QuantumComputation.ClassicalCorrespondence
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.Algorithms
open SFT.QuantumComputation.ReversibleExecution SFT.InformationScience.EncodingMaps

-- The word component of the original gate lookup, with the same gate schedule.
inductive WordTrace : List Gate → Word → Word → Prop where
  | identity (word : Word) : WordTrace [] word word
  | next (gate : Gate) (rest : List Gate) (source middle target : Word)
      (lookup : lookupFirst gate.wordMap source = some middle)
      (tail : WordTrace rest middle target) : WordTrace (gate::rest) source target

theorem projectBranch (cycle : List String) (gates : List Gate) (source target : Word × String)
    (trace : BranchTrace cycle gates source target) : WordTrace gates source.1 target.1 := by
  induction trace with
  | identity row => exact .identity row.1
  | next gate rest source middle target word phase tail ih => exact .next gate rest source.1 middle.1 target.1 word ih

theorem liftWord (cycle : List String) (positive : 0 < cycle.length)
    (gates : List Gate) (source target : Word) (trace : WordTrace gates source target)
    (phase : String) (held : phase ∈ cycle) :
    ∃ finalPhase, finalPhase ∈ cycle ∧ BranchTrace cycle gates (source,phase) (target,finalPhase) := by
  induction trace generalizing phase with
  | identity word => exact ⟨phase,held,.identity (word,phase)⟩
  | next gate rest source middle target lookup tail ih =>
    obtain ⟨nextPhase,shifted,member⟩ := shiftedPhaseExists cycle positive phase held (gate.phaseSuccessors.length % cycle.length)
    obtain ⟨finalPhase,finalHeld,trace⟩ := ih nextPhase member
    exact ⟨finalPhase,finalHeld,.next gate rest (source,phase) (middle,nextPhase) (target,finalPhase) lookup shifted trace⟩

theorem wordResultEquivalence (cycle : List String) (positive : 0 < cycle.length)
    (gates : List Gate) (source target : Word) (phase : String) (held : phase ∈ cycle) :
    WordTrace gates source target ↔ ∃ finalPhase, BranchTrace cycle gates (source,phase) (target,finalPhase) := by
  constructor
  · intro trace
    obtain ⟨finalPhase,_,lifted⟩ := liftWord cycle positive gates source target trace phase held
    exact ⟨finalPhase,lifted⟩
  · intro ⟨finalPhase,trace⟩
    exact projectBranch cycle gates (source,phase) (target,finalPhase) trace

theorem operationalWordCorrespondence (initial terminal : State) (gates : List Gate) (states : List State)
    (admitted : makeState initial.branches initial.phaseCycle = .ok initial)
    (execution : Forward initial gates states terminal) (word : Word) :
    (∃ phase, (word,phase) ∈ terminal.branches) ↔
      ∃ source, source ∈ initial.branches ∧ WordTrace gates source.1 word := by
  constructor
  · intro ⟨phase,member⟩
    obtain ⟨source,held,trace⟩ := (everyBranchHasExactTrace initial terminal gates states execution (word,phase)).mp member
    exact ⟨source,held,projectBranch initial.phaseCycle gates source (word,phase) trace⟩
  · intro ⟨source,held,trace⟩
    have positive := Nat.lt_of_lt_of_le (by decide : 0 < 2) (admittedPhaseCycle initial admitted).2.2
    obtain ⟨phase,_,lifted⟩ := liftWord initial.phaseCycle positive gates source.1 word trace source.2
      (admittedPhaseMember initial admitted source held)
    exact ⟨phase,(everyBranchHasExactTrace initial terminal gates states execution (word,phase)).mpr ⟨source,held,lifted⟩⟩
open SFT.QuantumComputation.ReversibleObservation

theorem decodedWordCorrespondence (initial terminal selected : State) (gates : List Gate) (states : List State)
    (admitted : makeState initial.branches initial.phaseCycle = .ok initial)
    (execution : Forward initial gates states terminal) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe terminal mapping label = .ok (selected,record)) (word : Word) :
    (∃ phase, (word,phase) ∈ selected.branches) ↔
      (∃ source, source ∈ initial.branches ∧ WordTrace gates source.1 word) ∧
        lookupFirst mapping word = some label := by
  constructor
  · intro ⟨phase,member⟩
    have p := (observationMembership terminal selected mapping label record observed (word,phase)).mp member
    exact ⟨(operationalWordCorrespondence initial terminal gates states admitted execution word).mp ⟨phase,p.1⟩,p.2⟩
  · intro p
    obtain ⟨phase,member⟩ := (operationalWordCorrespondence initial terminal gates states admitted execution word).mpr p.1
    exact ⟨phase,(observationMembership terminal selected mapping label record observed (word,phase)).mpr ⟨member,p.2⟩⟩
theorem phasePreservingSubmodel (cycle : List String) (gates : List Gate)
    (neutral : ∀ gate, gate ∈ gates → gate.phaseSuccessors.length % cycle.length = 0)
    (source target : Word) (trace : WordTrace gates source target) (phase : String) (held : phase ∈ cycle) :
    BranchTrace cycle gates (source,phase) (target,phase) := by
  induction trace with
  | identity word => exact .identity (word,phase)
  | next gate rest source middle target lookup tail ih =>
    have shifted : shiftPhase cycle (gate.phaseSuccessors.length % cycle.length) phase = some phase := by
      rw [neutral gate (.head rest)]
      exact SFT.QuantumComputation.PhaseInterference.zeroShift cycle phase held
    exact .next gate rest (source,phase) (middle,phase) (target,phase) lookup shifted
      (ih (fun g member => neutral g (.tail gate member)))
open SFT.Mathematics.DiscreteObjects

theorem singletonEmbeddingAdmitted (word : Word) (phase : String) (cycle : List String)
    (unique : distinct cycle = true) (size : 2 ≤ cycle.length) (held : phase ∈ cycle) :
    makeState [(word,phase)] cycle = .ok ⟨[(word,phase)],cycle⟩ := by
  have small : decide (cycle.length < 2) = false := decide_eq_false (Nat.not_lt_of_ge size)
  unfold makeState
  rw [unique,small]
  change (if !distinct [word] then _ else if !has cycle phase || false then _ else _) = _
  rw [(hasIff cycle phase).mpr held]
  rfl

theorem singletonResourceLedger (word : Word) (phase : String) (cycle : List String)
    (terminal : State) (gates : List Gate) (states : List State)
    (execution : Forward ⟨[(word,phase)],cycle⟩ gates states terminal) :
    states.length = gates.length ∧ terminal.branches.length = 1 ∧
      states.map (fun state => state.branches.length) = List.replicate gates.length 1 := by
  exact ⟨retainedPredecessorCount _ _ _ _ execution,fullSupportRetained _ _ _ _ execution,
    SFT.QuantumComputation.Complexity.completeLiveSupportLedger _ _ _ _ execution⟩
end SFT.QuantumComputation.ClassicalCorrespondence
