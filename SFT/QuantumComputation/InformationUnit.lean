import SFT.QuantumComputation.ReversibleInterpretation
namespace SFT.QuantumComputation.InformationUnit
open SFT.QuantumComputation.ReversibleModel

theorem twoLabelUnit (left right position : String) (cycle : List String) (state : State)
    (accepted : completeSupport [left,right] [position] cycle = .ok state) :
    support state = [[left],[right]] := by
  rw [completeSupportWords _ _ _ _ accepted]
  rfl

theorem unitHasTwoBranches (left right position : String) (cycle : List String) (state : State)
    (accepted : completeSupport [left,right] [position] cycle = .ok state) :
    (support state).length = 2 := by
  rw [twoLabelUnit _ _ _ _ _ accepted]
  rfl

theorem retainedPhaseCarrier (alphabet positions cycle : List String) (state : State)
    (accepted : completeSupport alphabet positions cycle = .ok state) : state.phaseCycle = cycle := by
  unfold completeSupport at accepted
  split at accepted
  · cases accepted
  · cases cycle with
    | nil => cases accepted
    | cons first rest =>
      have exactState := makeStateSource _ _ _ accepted
      rw [exactState]

theorem unitAlternatives (left right position : String) (cycle : List String) (state : State)
    (accepted : completeSupport [left,right] [position] cycle = .ok state) (word : Word) :
    word ∈ support state ↔ word = [left] ∨ word = [right] := by
  rw [twoLabelUnit _ _ _ _ _ accepted]
  constructor
  · intro member
    cases member with
    | head => exact .inl rfl
    | tail _ member => cases member with
      | head => exact .inr rfl
      | tail _ member => cases member
  · intro h
    cases h with
    | inl eq => cases eq; exact .head _
    | inr eq => cases eq; exact .tail _ (.head _)

theorem everyPositionRetainsBoth (left right : String) (before after : Word) (n m : Nat)
    (prefixGenerated : before ∈ SFT.InformationScience.QuantitySupport.words [left,right] n)
    (suffixGenerated : after ∈ SFT.InformationScience.QuantitySupport.words [left,right] m)
    (different : left ≠ right) :
    before ++ left::after ∈ SFT.InformationScience.QuantitySupport.words [left,right] (n+(m+1)) ∧
    before ++ right::after ∈ SFT.InformationScience.QuantitySupport.words [left,right] (n+(m+1)) ∧
    before ++ left::after ≠ before ++ right::after :=
  ⟨SFT.InformationScience.QuantitySupport.independentPosition _ _ _ _ _ _ prefixGenerated suffixGenerated (.head _),
   SFT.InformationScience.QuantitySupport.independentPosition _ _ _ _ _ _ prefixGenerated suffixGenerated (.tail _ (.head _)),
   SFT.InformationScience.QuantitySupport.positionAlternativesDistinct before after left right different⟩
open SFT.QuantumComputation.ReversibleObservation

theorem unitObservationRecord (left right position : String) (cycle : List String) (state selected : State)
    (generated : completeSupport [left,right] [position] cycle = .ok state)
    (mapping : Classification) (label : String) (record : List Record)
    (accepted : observe state mapping label = .ok (selected,record)) :
    record.map Prod.fst = state.branches ∧ record.length = 2 ∧ selected.phaseCycle = cycle := by
  have reconstruction := observationReconstruction state selected mapping label record accepted
  have count : (support state).length = state.branches.length :=
    SFT.Foundation.CommonRefinement.mapLength Prod.fst state.branches
  exact ⟨reconstruction.1,reconstruction.2.trans (count.symm.trans (unitHasTwoBranches _ _ _ _ _ generated)),
    (observationSource state selected mapping label record accepted).2.2.2.1.trans
      (retainedPhaseCarrier _ _ _ _ generated)⟩

theorem observedUnitAlternative (left right position : String) (cycle : List String) (state selected : State)
    (generated : completeSupport [left,right] [position] cycle = .ok state)
    (mapping : Classification) (label : String) (record : List Record)
    (accepted : observe state mapping label = .ok (selected,record))
    (branch : Word × String) (held : branch ∈ selected.branches) :
    (branch.1 = [left] ∨ branch.1 = [right]) ∧
    SFT.InformationScience.EncodingMaps.lookupFirst mapping branch.1 = some label := by
  have member := (observationMembership state selected mapping label record accepted branch).mp held
  exact ⟨(unitAlternatives _ _ _ _ _ generated branch.1).mp
    (SFT.Foundation.Count.TraceDerivation.memMap Prod.fst branch state.branches member.1),member.2⟩

end SFT.QuantumComputation.InformationUnit
