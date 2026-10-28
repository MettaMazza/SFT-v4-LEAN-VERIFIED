import SFT.InformationScience.ChannelComposition
namespace SFT.InformationScience.NoiseRelation
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
abbrev Word := List String
abbrev Cell := Word × Word × String
structure ErrorRelation where
  sources : List Word
  received : List Word
  relation : List Cell

def retainFirst (seen : List Word) : List Word → List Word
  | [] => []
  | label :: rest => if has seen label then retainFirst seen rest
    else label :: retainFirst (seen ++ [label]) rest

def firstWords (items : List Word) : List Word := retainFirst [] items

theorem retainFirstMembership (seen items : List Word) (label : Word) :
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

theorem firstWordsMembership (items : List Word) (label : Word) :
    label ∈ firstWords items ↔ label ∈ items :=
  ⟨fun h => ((retainFirstMembership [] items label).mp h).1,
   fun h => (retainFirstMembership [] items label).mpr ⟨h,fun h => by cases h⟩⟩

theorem retainFirstDistinct (seen items : List Word) : distinct (retainFirst seen items) = true := by
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

theorem firstWordsDistinct (items : List Word) : distinct (firstWords items) = true := retainFirstDistinct [] items


def carriersValid (sources received : List Word) : Bool :=
  !sources.isEmpty && !received.isEmpty && distinct sources && distinct received

def inside (sources received : List Word) (relation : List Cell) : Bool :=
  relation.all (fun row => has sources row.1 && has received row.2.1 && !row.2.2.isEmpty)

def total (sources : List Word) (relation : List Cell) : Bool :=
  sources.all (fun source => relation.any (fun row => decide (row.1 = source)))

def makeRelation (sources received : List Word) (relation : List Cell) : Except String ErrorRelation :=
  if carriersValid sources received then
    if distinct relation then
      if inside sources received relation then
        if total sources relation then .ok ⟨sources,received,relation⟩
        else .error "ValueError: every source requires at least one registered received image"
      else .error "ValueError: every error cell retains source, received form and action identity"
    else .error "ValueError: error transformation cells cannot repeat"
  else .error "ValueError: error relation requires complete canonical carriers"

def rawImages (relation : List Cell) (source : Word) : List Word :=
  firstWords ((relation.filter (fun row => decide (row.1 = source))).map (fun row => row.2.1))

def rawPredecessors (relation : List Cell) (received : Word) : List Word :=
  firstWords ((relation.filter (fun row => decide (row.2.1 = received))).map Prod.fst)

def errorImages (relation : ErrorRelation) (source : Word) : Except String (List Word) :=
  if has relation.sources source then .ok (rawImages relation.relation source)
  else .error "ValueError: source is outside the registered error relation"

def predecessors (relation : ErrorRelation) (received : Word) : Except String (List Word) :=
  if has relation.received received then .ok (rawPredecessors relation.relation received)
  else .error "ValueError: received form is outside registered support"

theorem carriersMeaning (inputs outputs : List Word) : carriersValid inputs outputs = true ↔
    inputs.isEmpty = false ∧ outputs.isEmpty = false ∧ distinct inputs = true ∧ distinct outputs = true := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    have t := (andTrue _ _).mp q.1
    exact ⟨(notTrue _).mp t.1,(notTrue _).mp t.2,q.2,p.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,(notTrue _).mpr h.2.1⟩,h.2.2.1⟩,h.2.2.2⟩

theorem insideMeaning (sources received : List Word) (relation : List Cell) :
    inside sources received relation = true ↔ ∀ row, row ∈ relation →
      row.1 ∈ sources ∧ row.2.1 ∈ received ∧ row.2.2.isEmpty = false := by
  constructor
  · intro h row hm
    have p := (andTrue _ _).mp (allTrueAtMember _ _ h row hm)
    have q := (andTrue _ _).mp p.1
    exact ⟨(hasIff _ _).mp q.1,(hasIff _ _).mp q.2,(notTrue _).mp p.2⟩
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro row hm
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr (h row hm).1,(hasIff _ _).mpr (h row hm).2.1⟩,(notTrue _).mpr (h row hm).2.2⟩

theorem totalMeaning (sources : List Word) (relation : List Cell) : total sources relation = true ↔
    ∀ source, source ∈ sources → ∃ image action, (source,image,action) ∈ relation := by
  constructor
  · intro h source hm
    obtain ⟨row,hr,eq⟩ := (anyTrueIff _ _).mp (allTrueAtMember _ _ h source hm)
    have same := of_decide_eq_true eq
    cases row with
    | mk held pair => cases pair with
      | mk image action => cases same; exact ⟨image,action,hr⟩
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro source hm
    obtain ⟨image,action,hr⟩ := h source hm
    exact (anyTrueIff _ _).mpr ⟨(source,image,action),hr,decide_eq_true rfl⟩

theorem constructorMeaning (inputs outputs : List Word) (relation : List Cell) (channel : ErrorRelation) :
    makeRelation inputs outputs relation = .ok channel ↔
      carriersValid inputs outputs = true ∧ distinct relation = true ∧ inside inputs outputs relation = true ∧
      total inputs relation = true ∧ channel = ⟨inputs,outputs,relation⟩ := by
  unfold makeRelation
  cases a : carriersValid inputs outputs <;> cases b : distinct relation <;>
    cases c : inside inputs outputs relation <;> cases d : total inputs relation
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { cases h.2.1 }
  all_goals try { cases h.2.2.1 }
  all_goals try { cases h.2.2.2.1 }
  · exact ⟨rfl,rfl,rfl,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2.2.2]; rfl

theorem imagesMembership (relation : List Cell) (source image : Word) :
    image ∈ rawImages relation source ↔ ∃ action, (source,image,action) ∈ relation := by
  constructor
  · intro h
    have hm := (firstWordsMembership _ _).mp h
    obtain ⟨row,hr,eq⟩ := memMapPreimage (fun row : Cell => row.2.1) image _ hm
    have p := (filterMemberIff _ _ _).mp hr
    have same := of_decide_eq_true p.2
    cases row with
    | mk held pair => cases pair with
      | mk value action => cases same; cases eq; exact ⟨action,p.1⟩
  · intro ⟨action,h⟩
    apply (firstWordsMembership _ _).mpr
    apply memMap (fun row : Cell => row.2.1) (source,image,action) _
    exact (filterMemberIff _ _ _).mpr ⟨h,decide_eq_true rfl⟩

theorem predecessorsMembership (relation : List Cell) (source image : Word) :
    source ∈ rawPredecessors relation image ↔ ∃ action, (source,image,action) ∈ relation := by
  constructor
  · intro h
    have hm := (firstWordsMembership _ _).mp h
    obtain ⟨row,hr,eq⟩ := memMapPreimage Prod.fst source _ hm
    have p := (filterMemberIff _ _ _).mp hr
    have same := of_decide_eq_true p.2
    cases row with
    | mk held pair => cases pair with
      | mk value action => cases same; cases eq; exact ⟨action,p.1⟩
  · intro ⟨action,h⟩
    apply (firstWordsMembership _ _).mpr
    apply memMap Prod.fst (source,image,action) _
    exact (filterMemberIff _ _ _).mpr ⟨h,decide_eq_true rfl⟩

theorem imagesDistinct (relation : List Cell) (source : Word) :
    distinct (rawImages relation source) = true := firstWordsDistinct _

theorem predecessorsDistinct (relation : List Cell) (image : Word) :
    distinct (rawPredecessors relation image) = true := firstWordsDistinct _

theorem imagesMeaning (channel : ErrorRelation) (source : Word) (result : List Word) :
    errorImages channel source = .ok result ↔ source ∈ channel.sources ∧ result = rawImages channel.relation source := by
  unfold errorImages
  cases h : has channel.sources source with
  | false =>
    constructor
    · intro eq; cases eq
    · intro p; have yes := (hasIff _ _).mpr p.1; rw [h] at yes; cases yes
  | true =>
    constructor
    · intro eq; exact ⟨(hasIff _ _).mp h,(Except.ok.inj eq).symm⟩
    · intro p; rw [p.2]; rfl

theorem predecessorsMeaning (channel : ErrorRelation) (source : Word) (result : List Word) :
    predecessors channel source = .ok result ↔ source ∈ channel.received ∧ result = rawPredecessors channel.relation source := by
  unfold predecessors
  cases h : has channel.received source with
  | false =>
    constructor
    · intro eq; cases eq
    · intro p; have yes := (hasIff _ _).mpr p.1; rw [h] at yes; cases yes
  | true =>
    constructor
    · intro eq; exact ⟨(hasIff _ _).mp h,(Except.ok.inj eq).symm⟩
    · intro p; rw [p.2]; rfl

theorem admittedImagesNonempty (sources received : List Word) (cells : List Cell) (relation : ErrorRelation)
    (h : makeRelation sources received cells = .ok relation) (source : Word) (hs : source ∈ relation.sources) :
    ∃ image, image ∈ rawImages relation.relation source := by
  have p := (constructorMeaning _ _ _ _).mp h
  rw [p.2.2.2.2] at hs ⊢
  obtain ⟨image,action,ht⟩ := (totalMeaning _ _).mp p.2.2.2.1 source hs
  exact ⟨image,(imagesMembership _ _ _).mpr ⟨action,ht⟩⟩

theorem admittedImagesInside (sources received : List Word) (cells : List Cell) (relation : ErrorRelation)
    (h : makeRelation sources received cells = .ok relation) (source image : Word)
    (hi : image ∈ rawImages relation.relation source) : image ∈ relation.received := by
  have p := (constructorMeaning _ _ _ _).mp h
  rw [p.2.2.2.2] at hi ⊢
  obtain ⟨action,hr⟩ := (imagesMembership _ _ _).mp hi
  exact ((insideMeaning _ _ _).mp p.2.2.1 (source,image,action) hr).2.1

theorem admittedPredecessorsInside (sources received : List Word) (cells : List Cell) (relation : ErrorRelation)
    (h : makeRelation sources received cells = .ok relation) (source image : Word)
    (hi : source ∈ rawPredecessors relation.relation image) : source ∈ relation.sources := by
  have p := (constructorMeaning _ _ _ _).mp h
  rw [p.2.2.2.2] at hi ⊢
  obtain ⟨action,hr⟩ := (predecessorsMembership _ _ _).mp hi
  exact ((insideMeaning _ _ _).mp p.2.2.1 (source,image,action) hr).1

end SFT.InformationScience.NoiseRelation
