import SFT.InformationScience.NoiseTrace
import SFT.Mathematics.DiscreteComposition
namespace SFT.InformationScience.NoiseExtension
open NoiseRelation NoiseCorrection NoiseTrace
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
open SFT.Mathematics.ExactTraceArithmetic

def extend (relation : ErrorRelation) (added : List Cell) : ErrorRelation :=
  ⟨relation.sources,firstWords (relation.received ++ added.map (fun row => row.2.1)),relation.relation ++ added⟩

theorem receivedMembership (relation : ErrorRelation) (added : List Cell) (image : Word) :
    image ∈ (extend relation added).received ↔
      image ∈ relation.received ∨ ∃ source action, (source,image,action) ∈ added := by
  constructor
  · intro h
    have hm := (firstWordsMembership _ _).mp h
    cases memAppendCases _ _ _ hm with
    | inl old => exact Or.inl old
    | inr fresh =>
      obtain ⟨row,hr,eq⟩ := memMapPreimage (fun row : Cell => row.2.1) image added fresh
      cases row with
      | mk source pair => cases pair with
        | mk target action => cases eq; exact Or.inr ⟨source,action,hr⟩
  · intro h
    apply (firstWordsMembership _ _).mpr
    cases h with
    | inl old => exact memAppendLeft _ _ _ old
    | inr fresh =>
      obtain ⟨source,action,hr⟩ := fresh
      exact memAppendRight _ _ _ (memMap (fun row : Cell => row.2.1) (source,image,action) _ hr)

theorem extensionAdmitted (relation : ErrorRelation) (added : List Cell)
    (valid : makeRelation relation.sources relation.received relation.relation = .ok relation)
    (unique : distinct added = true)
    (fresh : ∀ row, row ∈ relation.relation → ¬ row ∈ added)
    (registered : ∀ row, row ∈ added → row.1 ∈ relation.sources ∧ row.2.2.isEmpty = false) :
    makeRelation (extend relation added).sources (extend relation added).received (extend relation added).relation =
      .ok (extend relation added) := by
  have p := (constructorMeaning _ _ _ _).mp valid
  have carriers := (carriersMeaning _ _).mp p.1
  apply (constructorMeaning _ _ _ _).mpr
  refine ⟨?_,appendDistinct _ _ p.2.1 unique fresh,?_,?_,rfl⟩
  · apply (carriersMeaning _ _).mpr
    refine ⟨carriers.1,?_,carriers.2.2.1,firstWordsDistinct _⟩
    have existsOld : ∃ image, image ∈ relation.received := by
      cases hr : relation.received with
      | nil => rw [hr] at carriers; cases carriers.2.1
      | cons first rest => exact ⟨first,List.Mem.head _⟩
    obtain ⟨image,hi⟩ := existsOld
    have hm := (receivedMembership relation added image).mpr (Or.inl hi)
    cases h : (extend relation added).received with
    | nil => rw [h] at hm; cases hm
    | cons first rest => rfl
  · apply (insideMeaning _ _ _).mpr
    intro row hm
    cases memAppendCases _ _ _ hm with
    | inl old =>
      have q := (insideMeaning _ _ _).mp p.2.2.1 row old
      exact ⟨q.1,(receivedMembership _ _ _).mpr (Or.inl q.2.1),q.2.2⟩
    | inr new =>
      have q := registered row new
      exact ⟨q.1,(receivedMembership _ _ _).mpr (Or.inr ⟨row.1,row.2.2,new⟩),q.2⟩
  · apply (totalMeaning _ _).mpr
    intro source hs
    obtain ⟨image,action,hr⟩ := (totalMeaning _ _).mp p.2.2.2.1 source hs
    exact ⟨image,action,memAppendLeft _ _ _ hr⟩

theorem imagesSuccessor (relation : ErrorRelation) (added : List Cell) (source image : Word) :
    image ∈ rawImages (extend relation added).relation source ↔
      image ∈ rawImages relation.relation source ∨ ∃ action, (source,image,action) ∈ added := by
  constructor
  · intro h
    obtain ⟨action,hm⟩ := (imagesMembership _ _ _).mp h
    cases memAppendCases _ _ _ hm with
    | inl old => exact Or.inl ((imagesMembership _ _ _).mpr ⟨action,old⟩)
    | inr new => exact Or.inr ⟨action,new⟩
  · intro h
    apply (imagesMembership _ _ _).mpr
    cases h with
    | inl old =>
      obtain ⟨action,hm⟩ := (imagesMembership _ _ _).mp old
      exact ⟨action,memAppendLeft _ _ _ hm⟩
    | inr new =>
      obtain ⟨action,hm⟩ := new
      exact ⟨action,memAppendRight _ _ _ hm⟩

theorem predecessorsSuccessor (relation : ErrorRelation) (added : List Cell) (source image : Word) :
    source ∈ rawPredecessors (extend relation added).relation image ↔
      source ∈ rawPredecessors relation.relation image ∨ ∃ action, (source,image,action) ∈ added := by
  constructor
  · intro h
    obtain ⟨action,hm⟩ := (predecessorsMembership _ _ _).mp h
    cases memAppendCases _ _ _ hm with
    | inl old => exact Or.inl ((predecessorsMembership _ _ _).mpr ⟨action,old⟩)
    | inr new => exact Or.inr ⟨action,new⟩
  · intro h
    apply (predecessorsMembership _ _ _).mpr
    cases h with
    | inl old =>
      obtain ⟨action,hm⟩ := (predecessorsMembership _ _ _).mp old
      exact ⟨action,memAppendLeft _ _ _ hm⟩
    | inr new =>
      obtain ⟨action,hm⟩ := new
      exact ⟨action,memAppendRight _ _ _ hm⟩

theorem predecessorOrder (relation : ErrorRelation) (added : List Cell) (image : Word) :
    rawPredecessors (extend relation added).relation image =
      firstWords (((relation.relation.filter (fun row => decide (row.2.1 = image))).map Prod.fst) ++
        ((added.filter (fun row => decide (row.2.1 = image))).map Prod.fst)) := by
  unfold rawPredecessors extend
  rw [filterAppendExact,mapAppend]

theorem imageOrder (relation : ErrorRelation) (added : List Cell) (source : Word) :
    rawImages (extend relation added).relation source =
      firstWords (((relation.relation.filter (fun row => decide (row.1 = source))).map (fun row => row.2.1)) ++
        ((added.filter (fun row => decide (row.1 = source))).map (fun row => row.2.1))) := by
  unfold rawImages extend
  rw [filterAppendExact,mapAppend]

def identityRelation (source : Word) : ErrorRelation := ⟨[source],[source],[(source,source,"identity")]⟩

theorem identityAdmitted (source : Word) :
    makeRelation [source] [source] [(source,source,"identity")] = .ok (identityRelation source) := by
  apply (constructorMeaning _ _ _ _).mpr
  refine ⟨?_,rfl,?_,?_,rfl⟩
  · exact (carriersMeaning _ _).mpr ⟨rfl,rfl,rfl,rfl⟩
  · apply (insideMeaning _ _ _).mpr
    intro row hm
    cases hm with
    | head => exact ⟨List.Mem.head [],List.Mem.head [],rfl⟩
    | tail _ h => cases h
  · apply (totalMeaning _ _).mpr
    intro held hm
    cases hm with
    | head => exact ⟨source,"identity",List.Mem.head []⟩
    | tail _ h => cases h

theorem identityPredecessors (source : Word) : rawPredecessors (identityRelation source).relation source = [source] := by
  change firstWords ((([(source,source,"identity")] : List Cell).filter (fun row => decide (row.2.1 = source))).map Prod.fst) = [source]
  rw [List.filter_cons_of_pos (p := fun row : Cell => decide (row.2.1 = source)) (a := (source,source,"identity")) (decide_eq_true rfl)]
  rfl

theorem identityCorrection (source : Word) : correctionRecord (identityRelation source) source = .ok (.uniqueSource source) :=
  (correctionMeaning _ _ _).mpr ⟨List.Mem.head [],identityPredecessors source⟩

theorem identityBase (source : Word) :
    errorTrace source source = .ok .emptyOne ∧ correctionRecord (identityRelation source) source = .ok (.uniqueSource source) :=
  ⟨identityTrace source,identityCorrection source⟩

end SFT.InformationScience.NoiseExtension
