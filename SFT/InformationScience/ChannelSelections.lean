import SFT.InformationScience.ChannelRelation
namespace SFT.InformationScience.ChannelSelections
open ChannelRelation SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

inductive Chosen : List String → List String → Prop
  | empty : Chosen [] []
  | skip (item : String) {selection carrier : List String} : Chosen selection carrier → Chosen selection (item::carrier)
  | take (item : String) {selection carrier : List String} : Chosen selection carrier → Chosen (item::selection) (item::carrier)

def combinations : Nat → List String → List (List String)
  | 0,_ => [[]]
  | _+1,[] => []
  | k+1,item::rest => (combinations k rest).map (List.cons item) ++ combinations (k+1) rest

def throughSize (carrier : List String) : Nat → List (List String)
  | 0 => []
  | k+1 => throughSize carrier k ++ combinations (k+1) carrier

def codeCandidates (channel : FiniteChannel) : List (List String) :=
  (throughSize channel.inputs channel.inputs.length).filter (distinguishableCode channel)

theorem emptyChosen (carrier : List String) : Chosen [] carrier := by
  induction carrier with
  | nil => exact .empty
  | cons item rest ih => exact .skip item ih

theorem chosenLength (selection carrier : List String) (h : Chosen selection carrier) : selection.length ≤ carrier.length := by
  induction h with
  | empty => exact Nat.le_refl _
  | skip item h ih => exact Nat.le_trans ih (Nat.le_succ _)
  | take item h ih => exact Nat.succ_le_succ ih

theorem chosenContained (selection carrier : List String) (h : Chosen selection carrier)
    (item : String) (hm : item ∈ selection) : item ∈ carrier := by
  induction h with
  | empty => cases hm
  | skip first h ih => exact List.Mem.tail first (ih hm)
  | take first h ih =>
    cases hm with
    | head => exact List.Mem.head _
    | tail _ member => exact List.Mem.tail first (ih member)

theorem combinationsMeaning (k : Nat) (carrier selection : List String) :
    selection ∈ combinations k carrier ↔ selection.length = k ∧ Chosen selection carrier := by
  induction carrier generalizing k selection with
  | nil =>
    cases k with
    | zero =>
      constructor
      · intro h; cases h with
        | head => exact ⟨rfl,.empty⟩
        | tail _ impossible => cases impossible
      · intro h
        cases h.2
        exact List.Mem.head _
    | succ k =>
      constructor
      · intro h; cases h
      · intro h; cases h.2; cases h.1
  | cons item rest ih =>
    cases k with
    | zero =>
      constructor
      · intro h; cases h with
        | head => exact ⟨rfl,emptyChosen _⟩
        | tail _ impossible => cases impossible
      · intro h
        cases selection with
        | nil => exact List.Mem.head _
        | cons first tail => cases h.1
    | succ k =>
      constructor
      · intro h
        cases memAppendCases _ _ _ h with
        | inl included =>
          obtain ⟨tail,ht,eq⟩ := memMapPreimage (List.cons item) selection _ included
          cases eq
          have p := (ih k tail).mp ht
          exact ⟨congrArg Nat.succ p.1,.take item p.2⟩
        | inr omitted =>
          have p := (ih (k+1) selection).mp omitted
          exact ⟨p.1,.skip item p.2⟩
      · intro h
        cases h.2 with
        | skip _ chosen => exact memAppendRight _ _ _ ((ih _ _).mpr ⟨h.1,chosen⟩)
        | take _ chosen =>
          exact memAppendLeft _ _ _ (memMap (List.cons item) _ _ ((ih _ _).mpr ⟨Nat.succ.inj h.1,chosen⟩))

theorem throughMeaning (carrier selection : List String) (n : Nat) :
    selection ∈ throughSize carrier n ↔ 0 < selection.length ∧ selection.length ≤ n ∧ Chosen selection carrier := by
  induction n with
  | zero =>
    constructor
    · intro h; cases h
    · intro h; exact False.elim (Nat.not_lt_of_ge h.2.1 h.1)
  | succ n ih =>
    constructor
    · intro h
      cases memAppendCases _ _ _ h with
      | inl earlier => have p := ih.mp earlier; exact ⟨p.1,Nat.le_trans p.2.1 (Nat.le_succ _),p.2.2⟩
      | inr last =>
        have p := (combinationsMeaning _ _ _).mp last
        exact ⟨by rw [p.1]; exact Nat.zero_lt_succ _,by rw [p.1]; exact Nat.le_refl _,p.2⟩
    · intro h
      cases Nat.eq_or_lt_of_le h.2.1 with
      | inl eq => exact memAppendRight _ _ _ ((combinationsMeaning _ _ _).mpr ⟨eq,h.2.2⟩)
      | inr lt => exact memAppendLeft _ _ _ (ih.mpr ⟨h.1,Nat.le_of_lt_succ lt,h.2.2⟩)

theorem candidatesMeaning (channel : FiniteChannel) (selection : List String) :
    selection ∈ codeCandidates channel ↔ Chosen selection channel.inputs ∧ distinguishableCode channel selection = true := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨((throughMeaning _ _ _).mp p.1).2.2,p.2⟩
  · intro h
    apply (filterMemberIff _ _ _).mpr
    refine ⟨(throughMeaning _ _ _).mpr ⟨?_,chosenLength _ _ h.1,h.1⟩,h.2⟩
    have nonempty := ((codeMeaning _ _).mp h.2).1
    cases selection with
    | nil => cases nonempty
    | cons _ _ => exact Nat.zero_lt_succ _

theorem singletonChosen (carrier : List String) (item : String) (member : item ∈ carrier) : Chosen [item] carrier := by
  induction carrier with
  | nil => cases member
  | cons first rest ih =>
    cases member with
    | head => exact .take item (emptyChosen _)
    | tail _ hm => exact .skip first (ih hm)

theorem singletonCandidate (channel : FiniteChannel) (item : String) (member : item ∈ channel.inputs) :
    [item] ∈ codeCandidates channel :=
  (candidatesMeaning _ _).mpr ⟨singletonChosen _ _ member,singletonCode _ _ member⟩

theorem admittedCandidatesNonempty (inputs outputs : List String) (relation : List Cell) (channel : FiniteChannel)
    (h : makeChannel inputs outputs relation = .ok channel) : ∃ selection, selection ∈ codeCandidates channel := by
  have p := (constructorMeaning _ _ _ _).mp h
  have nonempty := ((carriersMeaning _ _).mp p.1).1
  have same := p.2.2.2.2
  cases inputs with
  | nil => cases nonempty
  | cons first rest =>
    refine ⟨[first],singletonCandidate channel first ?_⟩
    rw [same]
    exact List.Mem.head _

theorem combinationsDistinct (carrier : List String) (unique : distinct carrier = true) (k : Nat) :
    distinct (combinations k carrier) = true := by
  induction carrier generalizing k with
  | nil => cases k <;> rfl
  | cons first rest ih =>
    have p := (distinctCons _ _).mp unique
    cases k with
    | zero => rfl
    | succ k =>
      apply appendDistinct
      · exact mapDistinct (List.cons first) (fun a b eq => (List.cons.inj eq).2) _ (ih p.2 k)
      · exact ih p.2 (k+1)
      · intro held hin hout
        obtain ⟨tail,ht,eq⟩ := memMapPreimage (List.cons first) held _ hin
        have chosen := ((combinationsMeaning _ _ _).mp hout).2
        have firstIn : first ∈ held := by rw [← eq]; exact List.Mem.head _
        exact (absentIff _ _).mp p.1 (chosenContained _ _ chosen first firstIn)

theorem throughDistinct (carrier : List String) (unique : distinct carrier = true) (n : Nat) :
    distinct (throughSize carrier n) = true := by
  induction n with
  | zero => rfl
  | succ n ih =>
    apply appendDistinct _ _ ih (combinationsDistinct _ unique _)
    intro held earlier last
    have le := ((throughMeaning _ _ _).mp earlier).2.1
    have eq := ((combinationsMeaning _ _ _).mp last).1
    rw [eq] at le
    exact Nat.not_succ_le_self _ le

theorem candidatesDistinct (channel : FiniteChannel) (unique : distinct channel.inputs = true) :
    distinct (codeCandidates channel) = true :=
  filterDistinct _ _ (throughDistinct _ unique _)

end SFT.InformationScience.ChannelSelections
