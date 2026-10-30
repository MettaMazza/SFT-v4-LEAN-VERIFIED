import SFT.QuantumComputation.ReversibleModel
import SFT.InformationScience.CompressionSupport
namespace SFT.QuantumComputation.Superposition
open SFT.QuantumComputation.ReversibleModel
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

theorem fullBranchCount (alphabet positions cycle : List String) (state : State)
    (accepted : completeSupport alphabet positions cycle = .ok state) :
    state.branches.length = alphabet.length ^ positions.length := by
  have count := congrArg List.length (completeSupportWords _ _ _ _ accepted)
  change (state.branches.map Prod.fst).length = _ at count
  rw [mapLength,SFT.InformationScience.CompressionSupport.wordsCount] at count
  exact count

theorem initialPhaseRows (alphabet positions cycle : List String) (state : State)
    (accepted : completeSupport alphabet positions cycle = .ok state) :
    ∃ phase rest, cycle = phase::rest ∧ state.phaseCycle = cycle ∧
      state.branches = (SFT.InformationScience.QuantitySupport.words alphabet positions.length).map
        (fun word => (word,phase)) := by
  unfold completeSupport at accepted
  split at accepted
  · cases accepted
  · cases cycle with
    | nil => cases accepted
    | cons phase rest =>
      have exactState := makeStateSource _ _ _ accepted
      cases exactState
      exact ⟨phase,rest,rfl,rfl,rfl⟩

theorem completeRowMembership (alphabet positions : List String) (phase : String) (rest : List String)
    (state : State) (accepted : completeSupport alphabet positions (phase::rest) = .ok state)
    (word : Word) (heldPhase : String) :
    (word,heldPhase) ∈ state.branches ↔
      word.length = positions.length ∧ (∀ label, label ∈ word → label ∈ alphabet) ∧ heldPhase = phase := by
  obtain ⟨first,tail,cycle,_,rows⟩ := initialPhaseRows alphabet positions (phase::rest) state accepted
  cases cycle
  rw [rows]
  constructor
  · intro member
    obtain ⟨original,generated,equal⟩ := memMapPreimage (fun word => (word,phase)) (word,heldPhase) _ member
    cases equal
    have exactWord := (SFT.InformationScience.QuantitySupport.wordCharacterization _ _ _).mp generated
    exact ⟨exactWord.1,exactWord.2,rfl⟩
  · intro ⟨length,labels,equal⟩
    cases equal
    exact memMap _ word _ ((SFT.InformationScience.QuantitySupport.wordCharacterization _ _ _).mpr ⟨length,labels⟩)
theorem generatedStateAdmitted (alphabet positions cycle : List String) (state : State)
    (accepted : completeSupport alphabet positions cycle = .ok state) :
    makeState state.branches state.phaseCycle = .ok state := by
  unfold completeSupport at accepted
  split at accepted
  · cases accepted
  · cases cycle with
    | nil => cases accepted
    | cons phase rest =>
      have exactState := makeStateSource _ _ _ accepted
      cases exactState
      exact accepted

theorem phaseRetainsCompleteSupport (alphabet positions cycle : List String) (state : State)
    (accepted : completeSupport alphabet positions cycle = .ok state)
    (steps : List String) (nonempty : steps.isEmpty = false) :
    ∃ result, phaseAction state steps = .ok result ∧
      support result = SFT.InformationScience.QuantitySupport.words alphabet positions.length ∧
      result.branches.length = alphabet.length ^ positions.length ∧
      SFT.Mathematics.DiscreteObjects.distinct (support result) = true := by
  obtain ⟨result,action,supportSame,_,admitted⟩ := phaseActionPreserves state steps
    (generatedStateAdmitted _ _ _ _ accepted) nonempty
  have count : result.branches.length = state.branches.length :=
    (mapLength Prod.fst result.branches).symm.trans
      ((congrArg List.length supportSame).trans (mapLength Prod.fst state.branches))
  exact ⟨result,action,supportSame.trans (completeSupportWords _ _ _ _ accepted),
    count.trans (fullBranchCount _ _ _ _ accepted),admittedStateSupport result admitted⟩

end SFT.QuantumComputation.Superposition
