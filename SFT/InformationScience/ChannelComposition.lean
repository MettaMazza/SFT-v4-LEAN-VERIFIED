import SFT.InformationScience.ChannelCapacity
namespace SFT.InformationScience.ChannelComposition
open ChannelRelation SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

def retainFirst (seen : List Cell) : List Cell → List Cell
  | [] => []
  | label :: rest => if has seen label then retainFirst seen rest
    else label :: retainFirst (seen ++ [label]) rest

def firstCells (items : List Cell) : List Cell := retainFirst [] items

theorem retainFirstMembership (seen items : List Cell) (label : Cell) :
    label ∈ retainFirst seen items ↔ label ∈ items ∧ ¬ label ∈ seen := by
  induction items generalizing seen with
  | nil => constructor <;> intro h; cases h; cases h.1
  | cons first rest ih =>
    unfold retainFirst
    cases known : has seen first with
    | true =>
      constructor
      · intro h; have p := (ih seen).mp h; exact ⟨List.Mem.tail first p.1,p.2⟩
      · intro h
        cases h.1 with
        | head => exact False.elim (h.2 ((hasIff _ _).mp known))
        | tail _ hr => exact (ih seen).mpr ⟨hr,h.2⟩
    | false =>
      constructor
      · intro h
        cases h with
        | head =>
          refine ⟨List.Mem.head rest,?_⟩
          intro hv; have yes := (hasIff _ _).mpr hv; rw [known] at yes; cases yes
        | tail _ hr =>
          have p := (ih (seen ++ [first])).mp hr
          exact ⟨List.Mem.tail first p.1,fun hv => p.2 (memAppendLeft _ _ _ hv)⟩
      · intro h
        cases h.1 with
        | head => exact List.Mem.head _
        | tail _ hr =>
          by_cases same : label = first
          · cases same; exact List.Mem.head _
          · apply List.Mem.tail
            apply (ih (seen ++ [first])).mpr
            refine ⟨hr,?_⟩
            intro hv
            cases memAppendCases label seen [first] hv with
            | inl old => exact h.2 old
            | inr new => cases new with
              | head => exact same rfl
              | tail _ h => cases h

theorem firstCellsMembership (items : List Cell) (label : Cell) :
    label ∈ firstCells items ↔ label ∈ items :=
  ⟨fun h => ((retainFirstMembership [] items label).mp h).1,
   fun h => (retainFirstMembership [] items label).mpr ⟨h,fun h => by cases h⟩⟩

theorem retainFirstDistinct (seen items : List Cell) : distinct (retainFirst seen items) = true := by
  induction items generalizing seen with
  | nil => rfl
  | cons first rest ih =>
    change distinct (if has seen first then retainFirst seen rest else first :: retainFirst (seen ++ [first]) rest) = true
    cases known : has seen first with
    | true => exact ih seen
    | false =>
      apply (distinctCons _ _).mpr
      refine ⟨(absentIff _ _).mpr ?_,ih (seen ++ [first])⟩
      intro member
      have p := (retainFirstMembership (seen ++ [first]) rest first).mp member
      exact p.2 (memAppendRight _ _ _ (List.Mem.head []))

theorem firstCellsDistinct (items : List Cell) : distinct (firstCells items) = true := retainFirstDistinct [] items


def pathPairs (first second : List Cell) : List Cell :=
  first.flatMap (fun row => (second.filter (fun next => decide (row.2 = next.1))).map (fun next => (row.1,next.2)))

def composedRelation (first second : FiniteChannel) : List Cell := firstCells (pathPairs first.relation second.relation)

def composeChannels (first second : FiniteChannel) : Except String FiniteChannel :=
  if first.outputs = second.inputs then makeChannel first.inputs second.outputs (composedRelation first second)
  else .error "ValueError: channel composition requires equal canonical interface carriers"

theorem pathsMembership (first second : List Cell) (source target : String) :
    (source,target) ∈ pathPairs first second ↔ ∃ middle, (source,middle) ∈ first ∧ (middle,target) ∈ second := by
  constructor
  · intro h
    obtain ⟨row,hr,hm⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨next,hn,eq⟩ := memMapPreimage (fun next : Cell => (row.1,next.2)) (source,target) _ hm
    have p := (filterMemberIff _ _ _).mp hn
    have linked := of_decide_eq_true p.2
    cases row with
    | mk held middle => cases next with
      | mk nextSource value => cases linked; cases eq; exact ⟨middle,hr,p.1⟩
  · intro ⟨middle,hf,hs⟩
    apply memFlatMap _ _ (source,middle) _ hf
    apply memMap (fun next : Cell => (source,next.2)) (middle,target) _
    exact (filterMemberIff _ _ _).mpr ⟨hs,decide_eq_true rfl⟩

theorem composedMembership (first second : FiniteChannel) (source target : String) :
    (source,target) ∈ composedRelation first second ↔
      ∃ middle, (source,middle) ∈ first.relation ∧ (middle,target) ∈ second.relation := by
  constructor
  · intro h; exact (pathsMembership _ _ _ _).mp ((firstCellsMembership _ _).mp h)
  · intro h; exact (firstCellsMembership _ _).mpr ((pathsMembership _ _ _ _).mpr h)

theorem composedAdmitted (first second : FiniteChannel)
    (hf : makeChannel first.inputs first.outputs first.relation = .ok first)
    (hs : makeChannel second.inputs second.outputs second.relation = .ok second)
    (interface : first.outputs = second.inputs) :
    makeChannel first.inputs second.outputs (composedRelation first second) =
      .ok ⟨first.inputs,second.outputs,composedRelation first second⟩ := by
  have f := (constructorMeaning _ _ _ _).mp hf
  have s := (constructorMeaning _ _ _ _).mp hs
  apply (constructorMeaning _ _ _ _).mpr
  refine ⟨?_,firstCellsDistinct _,?_,?_,rfl⟩
  · have a := (carriersMeaning _ _).mp f.1
    have b := (carriersMeaning _ _).mp s.1
    exact (carriersMeaning _ _).mpr ⟨a.1,b.2.1,a.2.2.1,b.2.2.2⟩
  · apply (insideMeaning _ _ _).mpr
    intro row hm
    obtain ⟨middle,hleft,hright⟩ := (composedMembership _ _ _ _).mp hm
    exact ⟨((insideMeaning _ _ _).mp f.2.2.1 _ hleft).1,((insideMeaning _ _ _).mp s.2.2.1 _ hright).2⟩
  · apply (totalMeaning _ _).mpr
    intro source member
    obtain ⟨middle,hm⟩ := (totalMeaning _ _).mp f.2.2.2.1 source member
    have atInterface := ((insideMeaning _ _ _).mp f.2.2.1 _ hm).2
    rw [interface] at atInterface
    obtain ⟨target,ht⟩ := (totalMeaning _ _).mp s.2.2.2.1 middle atInterface
    exact ⟨target,(composedMembership _ _ _ _).mpr ⟨middle,hm,ht⟩⟩

theorem compositionExists (first second : FiniteChannel)
    (hf : makeChannel first.inputs first.outputs first.relation = .ok first)
    (hs : makeChannel second.inputs second.outputs second.relation = .ok second)
    (interface : first.outputs = second.inputs) :
    composeChannels first second = .ok ⟨first.inputs,second.outputs,composedRelation first second⟩ := by
  unfold composeChannels
  rw [ite_eq_left interface]
  exact composedAdmitted _ _ hf hs interface

theorem compositionResult (first second result : FiniteChannel) (h : composeChannels first second = .ok result) :
    first.outputs = second.inputs ∧ result = ⟨first.inputs,second.outputs,composedRelation first second⟩ := by
  unfold composeChannels at h
  by_cases same : first.outputs = second.inputs
  · rw [ite_eq_left same] at h
    exact ⟨same,((constructorMeaning _ _ _ _).mp h).2.2.2.2⟩
  · rw [ite_eq_right same] at h
    cases h

theorem compositionPaths (first second result : FiniteChannel) (h : composeChannels first second = .ok result)
    (source target : String) : (source,target) ∈ result.relation ↔
      ∃ middle, (source,middle) ∈ first.relation ∧ (middle,target) ∈ second.relation := by
  rw [(compositionResult _ _ _ h).2]
  exact composedMembership _ _ _ _

theorem noRestoredDistinction (first second result : FiniteChannel)
    (hf : makeChannel first.inputs first.outputs first.relation = .ok first)
    (hs : makeChannel second.inputs second.outputs second.relation = .ok second)
    (hc : composeChannels first second = .ok result) (left right : String)
    (merged : overlap first.relation left right = true) : overlap result.relation left right = true := by
  obtain ⟨middle,hl,hr⟩ := (overlapMeaning _ _ _).mp merged
  have f := (constructorMeaning _ _ _ _).mp hf
  have s := (constructorMeaning _ _ _ _).mp hs
  have atInterface := ((insideMeaning _ _ _).mp f.2.2.1 _ hl).2
  rw [(compositionResult _ _ _ hc).1] at atInterface
  obtain ⟨target,ht⟩ := (totalMeaning _ _).mp s.2.2.2.1 middle atInterface
  exact (overlapMeaning _ _ _).mpr ⟨target,(compositionPaths _ _ _ hc _ _).mpr ⟨middle,hl,ht⟩,
    (compositionPaths _ _ _ hc _ _).mpr ⟨middle,hr,ht⟩⟩

end SFT.InformationScience.ChannelComposition
