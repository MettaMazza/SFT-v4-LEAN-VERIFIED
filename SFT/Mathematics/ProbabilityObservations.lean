import SFT.Mathematics.ProbabilityModes
namespace SFT.Mathematics.ProbabilityObservations
open DiscreteObjects AlgebraOperations GeometryTopology ProbabilityIndependence SFT.Foundation.Count.TraceDerivation

abbrev Observation := List (String × String)

def keysMatch (support : List String) (mapping : Observation) : Bool :=
  (mapping.map Prod.fst).all (has support) && support.all (has (mapping.map Prod.fst))

def observedValues (mapping : Observation) : List String → List String
  | [] => []
  | state :: rest => match image mapping state with
    | none => observedValues mapping rest
    | some label => label :: observedValues mapping rest

def belongs (mapping : Observation) (label state : String) : Bool :=
  match image mapping state with
  | none => false
  | some value => decide (value = label)

def fibre (support : List String) (mapping : Observation) (label : String) : List String :=
  support.filter (belongs mapping label)

def classRows (support : List String) (mapping : Observation) : List (String × List String) :=
  (firstLabels (observedValues mapping support)).map (fun label => (label,fibre support mapping label))

def observationClasses (support : List String) (mapping : Observation) : Except String (List (String × List String)) :=
  if keysMatch support mapping then .ok (classRows support mapping)
  else .error "observation must classify every microstate once"

theorem keysMatchMeaning (support : List String) (mapping : Observation) :
    keysMatch support mapping = true ↔
      (∀ key, key ∈ mapping.map Prod.fst → key ∈ support) ∧
      (∀ state, state ∈ support → state ∈ mapping.map Prod.fst) := by
  constructor
  · intro h
    have parts := (andTrue _ _).mp h
    exact ⟨fun k hk => (hasIff _ _).mp (allTrueAtMember _ _ parts.1 k hk),
      fun k hk => (hasIff _ _).mp (allTrueAtMember _ _ parts.2 k hk)⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(allTrueIffMembers _ _).mpr (fun k hk => (hasIff _ _).mpr (h.1 k hk)),
      (allTrueIffMembers _ _).mpr (fun k hk => (hasIff _ _).mpr (h.2 k hk))⟩

theorem imageDefined (mapping : Observation) (state : String) :
    (∃ label, image mapping state = some label) ↔ state ∈ mapping.map Prod.fst := by
  induction mapping with
  | nil => constructor
           · intro ⟨label,h⟩; cases h
           · intro h; cases h
  | cons pair rest ih =>
    cases pair with
    | mk key value =>
      constructor
      · intro ⟨label,h⟩
        cases tail : image rest state with
        | some result => exact List.Mem.tail key (ih.mp ⟨result,tail⟩)
        | none =>
          change (match image rest state with | some x => some x | none => if key = state then some value else none) = _ at h
          rw [tail] at h
          by_cases same : key = state
          · cases same; exact List.Mem.head _
          · rw [ite_eq_right same] at h; cases h
      · intro h
        cases tail : image rest state with
        | some result =>
          refine ⟨result,?_⟩
          change (match image rest state with | some x => some x | none => if key = state then some value else none) = _
          rw [tail]
        | none =>
          cases h with
          | head =>
            refine ⟨value,?_⟩
            change (match image rest key with | some x => some x | none => if key = key then some value else none) = _
            rw [tail,ite_eq_left rfl]
          | tail _ member =>
            obtain ⟨label,equal⟩ := ih.mpr member
            rw [tail] at equal
            cases equal

theorem admittedImage (support : List String) (mapping : Observation)
    (admitted : keysMatch support mapping = true) (state : String) (member : state ∈ support) :
    ∃ label, image mapping state = some label :=
  (imageDefined mapping state).mpr (((keysMatchMeaning _ _).mp admitted).2 state member)

theorem observedMembership (mapping : Observation) (support : List String) (label : String) :
    label ∈ observedValues mapping support ↔ ∃ state, state ∈ support ∧ image mapping state = some label := by
  induction support with
  | nil => constructor
           · intro h; cases h
           · intro ⟨state,h,_⟩; cases h
  | cons state rest ih =>
    change label ∈ (match image mapping state with | none => observedValues mapping rest | some value => value :: observedValues mapping rest) ↔ _
    cases observed : image mapping state with
    | none =>
      constructor
      · intro h; obtain ⟨s,hs,eq⟩ := ih.mp h; exact ⟨s,List.Mem.tail state hs,eq⟩
      · intro ⟨s,hs,eq⟩
        cases hs with
        | head => rw [observed] at eq; cases eq
        | tail _ hr => exact ih.mpr ⟨s,hr,eq⟩
    | some value =>
      constructor
      · intro h
        cases h with
        | head => exact ⟨state,List.Mem.head _,observed⟩
        | tail _ hr => obtain ⟨s,hs,eq⟩ := ih.mp hr; exact ⟨s,List.Mem.tail state hs,eq⟩
      · intro ⟨s,hs,eq⟩
        cases hs with
        | head => rw [observed] at eq; cases eq; exact List.Mem.head _
        | tail _ hr => exact List.Mem.tail value (ih.mpr ⟨s,hr,eq⟩)

theorem observedLength (mapping : Observation) (support : List String)
    (total : ∀ state, state ∈ support → ∃ label, image mapping state = some label) :
    (observedValues mapping support).length = support.length := by
  induction support with
  | nil => rfl
  | cons state rest ih =>
    obtain ⟨label,equal⟩ := total state (List.Mem.head rest)
    change (match image mapping state with | none => observedValues mapping rest | some value => value :: observedValues mapping rest).length = _
    rw [equal]
    exact congrArg Nat.succ (ih (fun s hs => total s (List.Mem.tail state hs)))

theorem belongsMeaning (mapping : Observation) (label state : String) :
    belongs mapping label state = true ↔ image mapping state = some label := by
  unfold belongs
  cases h : image mapping state with
  | none => constructor <;> intro h <;> cases h
  | some value =>
    constructor
    · intro h; have same := of_decide_eq_true h; cases same; rfl
    · intro h; cases h; exact decide_eq_true rfl

theorem fibreMembership (support : List String) (mapping : Observation) (label state : String) :
    state ∈ fibre support mapping label ↔ state ∈ support ∧ image mapping state = some label := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(belongsMeaning _ _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(belongsMeaning _ _ _).mpr h.2⟩

theorem rowMembership (support : List String) (mapping : Observation) (label : String) (states : List String) :
    (label,states) ∈ classRows support mapping ↔
      (∃ state, state ∈ support ∧ image mapping state = some label) ∧ states = fibre support mapping label := by
  constructor
  · intro h
    obtain ⟨value,member,equal⟩ := memMapPreimage _ _ _ h
    cases equal
    exact ⟨(observedMembership _ _ _).mp ((firstLabelsMembership _ _).mp member),rfl⟩
  · intro h
    cases h.2
    exact memMap _ label _ ((firstLabelsMembership _ _).mpr ((observedMembership _ _ _).mpr h.1))

theorem fibreDisjoint (support : List String) (mapping : Observation) (left right state : String)
    (a : state ∈ fibre support mapping left) (b : state ∈ fibre support mapping right) : left = right := by
  have h1 := ((fibreMembership _ _ _ _).mp a).2
  have h2 := ((fibreMembership _ _ _ _).mp b).2
  rw [h1] at h2
  cases h2
  rfl

theorem classesCover (support : List String) (mapping : Observation)
    (admitted : keysMatch support mapping = true) (state : String) (member : state ∈ support) :
    ∃ label, (label,fibre support mapping label) ∈ classRows support mapping ∧ state ∈ fibre support mapping label := by
  obtain ⟨label,equal⟩ := admittedImage support mapping admitted state member
  exact ⟨label,(rowMembership _ _ _ _).mpr ⟨⟨state,member,equal⟩,rfl⟩,
    (fibreMembership _ _ _ _).mpr ⟨member,equal⟩⟩

theorem classNonempty (support : List String) (mapping : Observation) (label : String) (states : List String)
    (row : (label,states) ∈ classRows support mapping) : ∃ state, state ∈ states := by
  have parts := (rowMembership _ _ _ _).mp row
  obtain ⟨state,member,equal⟩ := parts.1
  rw [parts.2]
  exact ⟨state,(fibreMembership _ _ _ _).mpr ⟨member,equal⟩⟩

theorem observationAdmitted (support : List String) (mapping : Observation)
    (admitted : keysMatch support mapping = true) : observationClasses support mapping = .ok (classRows support mapping) := by
  unfold observationClasses
  rw [admitted]
  rfl

theorem observationRejected (support : List String) (mapping : Observation)
    (rejected : keysMatch support mapping = false) :
    observationClasses support mapping = .error "observation must classify every microstate once" := by
  unfold observationClasses
  rw [rejected]
  rfl

theorem emptyObservation : observationClasses [] [] = .ok [] := rfl

end SFT.Mathematics.ProbabilityObservations
