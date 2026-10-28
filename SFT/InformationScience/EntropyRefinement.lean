import SFT.InformationScience.EntropyPartition
namespace SFT.InformationScience.EntropyRefinement
open EntropyPartition
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Mathematics.ProbabilityObservations

def refines (support : List String) (fine coarse : Observation) : Bool :=
  keysMatch support fine && keysMatch support coarse &&
    support.all (fun left => support.all (fun right =>
      if image fine left = image fine right then decide (image coarse left = image coarse right) else true))

theorem refinementMeaning (support : List String) (fine coarse : Observation) :
    refines support fine coarse = true ↔ keysMatch support fine = true ∧ keysMatch support coarse = true ∧
      ∀ a b, a ∈ support → b ∈ support → image fine a = image fine b → image coarse a = image coarse b := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    refine ⟨q.1,q.2,?_⟩
    intro a b ha hb same
    have row := allTrueAtMember _ _ p.2 a ha
    have cell := allTrueAtMember _ _ row b hb
    rw [ite_eq_left same] at cell
    exact of_decide_eq_true cell
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨h.1,h.2.1⟩,?_⟩
    apply (allTrueIffMembers _ _).mpr
    intro a ha
    apply (allTrueIffMembers _ _).mpr
    intro b hb
    by_cases same : image fine a = image fine b
    · rw [ite_eq_left same]; exact decide_eq_true (h.2.2 a b ha hb same)
    · rw [ite_eq_right same]

theorem refinementReflexive (support : List String) (observation : Observation)
    (keys : keysMatch support observation = true) : refines support observation observation = true :=
  (refinementMeaning _ _ _).mpr ⟨keys,keys,fun _ _ _ _ same => same⟩

theorem refinementTransitive (support : List String) (fine middle coarse : Observation)
    (first : refines support fine middle = true) (second : refines support middle coarse = true) :
    refines support fine coarse = true := by
  have p := (refinementMeaning _ _ _).mp first
  have q := (refinementMeaning _ _ _).mp second
  exact (refinementMeaning _ _ _).mpr ⟨p.1,q.2.1,fun a b ha hb same => q.2.2 a b ha hb (p.2.2 a b ha hb same)⟩

theorem emptyRefinement : refines [] [] [] = true := rfl

theorem classContainment (support : List String) (fine coarse : Observation) (fp cp : Partition)
    (hf : exactPartition support fine = .ok fp) (hc : exactPartition support coarse = .ok cp)
    (refined : refines support fine coarse = true) (label : String) (members : List String)
    (member : (label,members) ∈ fp) :
    ∃ coarseLabel coarseMembers, (coarseLabel,coarseMembers) ∈ cp ∧
      ∀ state, state ∈ members → state ∈ coarseMembers := by
  obtain ⟨base,hbase⟩ := partitionNonemptyClass _ _ _ hf _ _ member
  have fineRow := (partitionMembership _ _ _ hf _ _).mp member
  rw [fineRow.2] at hbase
  have baseInfo := (fibreMembership _ _ _ _).mp hbase
  have rules := (refinementMeaning _ _ _).mp refined
  obtain ⟨coarseLabel,baseCoarse⟩ := admittedImage _ _ rules.2.1 base baseInfo.1
  refine ⟨coarseLabel,fibre support coarse coarseLabel,?_,?_⟩
  · apply (partitionMembership _ _ _ hc _ _).mpr
    exact ⟨⟨base,baseInfo.1,baseCoarse⟩,rfl⟩
  · intro state hs
    rw [fineRow.2] at hs
    have stateInfo := (fibreMembership _ _ _ _).mp hs
    have sameFine := stateInfo.2.trans baseInfo.2.symm
    have sameCoarse := rules.2.2 state base stateInfo.1 baseInfo.1 sameFine
    exact (fibreMembership _ _ _ _).mpr ⟨stateInfo.1,sameCoarse.trans baseCoarse⟩

theorem containmentImpliesRefinement (support : List String) (fine coarse : Observation) (fp cp : Partition)
    (hf : exactPartition support fine = .ok fp) (hc : exactPartition support coarse = .ok cp)
    (contained : ∀ label members, (label,members) ∈ fp →
      ∃ coarseLabel coarseMembers, (coarseLabel,coarseMembers) ∈ cp ∧
        ∀ state, state ∈ members → state ∈ coarseMembers) : refines support fine coarse = true := by
  apply (refinementMeaning _ _ _).mpr
  refine ⟨((validityMeaning _ _).mp (partitionResult _ _ _ hf).1).2.2.2,
    ((validityMeaning _ _).mp (partitionResult _ _ _ hc).1).2.2.2,?_⟩
  intro a b ha hb same
  obtain ⟨label,members,hr,hm⟩ := partitionCovers _ _ _ hf a ha
  have row := (partitionMembership _ _ _ hf _ _).mp hr
  have aImage : image fine a = some label := by
    rw [row.2] at hm
    exact ((fibreMembership _ _ _ _).mp hm).2
  have bm : b ∈ members := by
    rw [row.2]
    exact (fibreMembership _ _ _ _).mpr ⟨hb,same.symm.trans aImage⟩
  obtain ⟨coarseLabel,coarseMembers,hcr,includes⟩ := contained label members hr
  have coarseRow := (partitionMembership _ _ _ hc _ _).mp hcr
  have ac := includes a hm
  have bc := includes b bm
  rw [coarseRow.2] at ac bc
  exact ((fibreMembership _ _ _ _).mp ac).2.trans (((fibreMembership _ _ _ _).mp bc).2.symm)

theorem refinementIffContainment (support : List String) (fine coarse : Observation) (fp cp : Partition)
    (hf : exactPartition support fine = .ok fp) (hc : exactPartition support coarse = .ok cp) :
    refines support fine coarse = true ↔
      ∀ label members, (label,members) ∈ fp →
        ∃ coarseLabel coarseMembers, (coarseLabel,coarseMembers) ∈ cp ∧
          ∀ state, state ∈ members → state ∈ coarseMembers :=
  ⟨fun h => classContainment _ _ _ _ _ hf hc h,
   fun h => containmentImpliesRefinement _ _ _ _ _ hf hc h⟩

end SFT.InformationScience.EntropyRefinement
