import SFT.InformationScience.QuantitySupport
namespace SFT.InformationScience.QuantityPairs
open QuantitySupport SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation
abbrev Pair := Word × Word

def pairs : List Word → List Pair
  | [] => []
  | left :: rest => rest.map (fun right => (left,right)) ++ pairs rest

theorem pairStep (left : Word) (rest : List Word) :
    pairs (left :: rest) = rest.map (fun right => (left,right)) ++ pairs rest := rfl

theorem pairSources (alphabet : List Word) (left right : Word) (h : (left,right) ∈ pairs alphabet) :
    left ∈ alphabet ∧ right ∈ alphabet := by
  induction alphabet with
  | nil => cases h
  | cons first rest ih =>
    cases memAppendCases _ _ _ h with
    | inl new =>
      obtain ⟨r,hr,eq⟩ := memMapPreimage (fun r => (first,r)) (left,right) rest new
      have hl := congrArg Prod.fst eq
      have he := congrArg Prod.snd eq
      cases hl; cases he
      exact ⟨List.Mem.head _,List.Mem.tail left hr⟩
    | inr old =>
      have p := ih old
      exact ⟨List.Mem.tail first p.1,List.Mem.tail first p.2⟩

def distinctionPairs (support : List Word) : Except String (List Pair) :=
  if support.isEmpty || !distinct support then
    .error "ValueError: information support must be complete and duplicate-free"
  else .ok ((pairs support).filter (fun pair => decide (pair.1 ≠ pair.2)))

theorem pairDifferent (support : List Word) (unique : distinct support = true) (a b : Word)
    (hm : (a,b) ∈ pairs support) : a ≠ b := by
  induction support with
  | nil => cases hm
  | cons first rest ih =>
    have p := (distinctCons _ _).mp unique
    cases memAppendCases _ _ _ hm with
    | inl head =>
      obtain ⟨right,hr,eq⟩ := memMapPreimage (fun right => (first,right)) (a,b) rest head
      have ea := congrArg Prod.fst eq
      have eb := congrArg Prod.snd eq
      cases ea; cases eb
      intro same; cases same
      exact (absentIff _ _).mp p.1 hr
    | inr tail => exact ih p.2 tail

theorem pairsDistinct (support : List Word) (unique : distinct support = true) :
    distinct (pairs support) = true := by
  induction support with
  | nil => rfl
  | cons first rest ih =>
    have p := (distinctCons _ _).mp unique
    apply appendDistinct
    · exact mapDistinct (fun right => (first,right)) (fun _ _ eq => congrArg Prod.snd eq) rest p.2
    · exact ih p.2
    · intro pair head tail
      obtain ⟨right,_,eq⟩ := memMapPreimage (fun right => (first,right)) pair rest head
      cases eq
      exact (absentIff _ _).mp p.1 (pairSources _ _ _ tail).1

theorem pairsCover (support : List Word) (a b : Word) (ha : a ∈ support) (hb : b ∈ support)
    (ne : a ≠ b) : (a,b) ∈ pairs support ∨ (b,a) ∈ pairs support := by
  induction support with
  | nil => cases ha
  | cons first rest ih =>
    cases ha with
    | head =>
      cases hb with
      | head => exact False.elim (ne rfl)
      | tail _ hr => exact Or.inl (memAppendLeft _ _ _ (memMap (fun r => (a,r)) b rest hr))
    | tail _ hr =>
      cases hb with
      | head => exact Or.inr (memAppendLeft _ _ _ (memMap (fun r => (b,r)) a rest hr))
      | tail _ ht =>
        cases ih hr ht with
        | inl h => exact Or.inl (memAppendRight _ _ _ h)
        | inr h => exact Or.inr (memAppendRight _ _ _ h)

theorem reverseExcluded (support : List Word) (unique : distinct support = true) (a b : Word)
    (ha : (a,b) ∈ pairs support) (hb : (b,a) ∈ pairs support) : False := by
  induction support with
  | nil => cases ha
  | cons first rest ih =>
    have p := (distinctCons _ _).mp unique
    cases memAppendCases _ _ _ ha with
    | inl head =>
      obtain ⟨right,hr,eq⟩ := memMapPreimage (fun right => (first,right)) (a,b) rest head
      have ea := congrArg Prod.fst eq
      have eb := congrArg Prod.snd eq
      cases ea; cases eb
      cases memAppendCases _ _ _ hb with
      | inl head =>
        obtain ⟨last,_,eq⟩ := memMapPreimage (fun last => (a,last)) (b,a) rest head
        have same := congrArg Prod.fst eq
        cases same
        exact (absentIff _ _).mp p.1 hr
      | inr tail => exact (absentIff _ _).mp p.1 (pairSources _ _ _ tail).2
    | inr tail =>
      cases memAppendCases _ _ _ hb with
      | inl head =>
        obtain ⟨last,_,eq⟩ := memMapPreimage (fun last => (first,last)) (b,a) rest head
        have same := congrArg Prod.fst eq
        cases same
        exact (absentIff _ _).mp p.1 (pairSources _ _ _ tail).2
      | inr other => exact ih p.2 tail other

theorem filterAllDifferent (input : List Pair) (ne : ∀ pair, pair ∈ input → pair.1 ≠ pair.2) :
    input.filter (fun pair => decide (pair.1 ≠ pair.2)) = input := by
  induction input with
  | nil => rfl
  | cons pair rest ih =>
    change (match decide (pair.1 ≠ pair.2) with | true => pair :: rest.filter (fun pair => decide (pair.1 ≠ pair.2)) | false => rest.filter (fun pair => decide (pair.1 ≠ pair.2))) = _
    rw [decide_eq_true (ne pair (List.Mem.head _))]
    exact congrArg (List.cons pair) (ih (fun p hp => ne p (List.Mem.tail pair hp)))

theorem acceptedPairs (support : List Word) (result : List Pair)
    (h : distinctionPairs support = .ok result) :
    support.isEmpty = false ∧ distinct support = true ∧ result = pairs support := by
  unfold distinctionPairs at h
  cases empty : support.isEmpty <;> cases unique : distinct support <;> rw [empty,unique] at h
  all_goals try cases h
  exact ⟨rfl,rfl,filterAllDifferent _ (fun pair hp => pairDifferent _ unique _ _ hp)⟩

theorem admittedPairs (support : List Word) (nonempty : support.isEmpty = false)
    (unique : distinct support = true) : distinctionPairs support = .ok (pairs support) := by
  unfold distinctionPairs
  rw [nonempty,unique]
  change Except.ok ((pairs support).filter (fun pair => decide (pair.1 ≠ pair.2))) = _
  rw [filterAllDifferent _ (fun pair hp => pairDifferent _ unique _ _ hp)]

def extendedPairs (fresh : Word) : List Word → List Pair
  | [] => []
  | left :: rest => (rest.map (fun right => (left,right)) ++ [(left,fresh)]) ++ extendedPairs fresh rest

theorem mapAppend {α β : Type} (f : α → β) (xs ys : List α) :
    (xs ++ ys).map f = xs.map f ++ ys.map f := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons (f x)) ih

theorem successorPairOrder (alphabet : List Word) (fresh : Word) :
    pairs (alphabet ++ [fresh]) = extendedPairs fresh alphabet := by
  induction alphabet with
  | nil => rfl
  | cons first rest ih =>
    change (rest ++ [fresh]).map (fun right => (first,right)) ++ pairs (rest ++ [fresh]) = _
    rw [mapAppend,ih]
    rfl

theorem newPairIncluded (alphabet : List Word) (fresh old : Word) (hm : old ∈ alphabet) :
    (old,fresh) ∈ extendedPairs fresh alphabet := by
  induction alphabet with
  | nil => cases hm
  | cons first rest ih =>
    cases hm with
    | head => exact memAppendLeft _ _ _ (memAppendRight _ _ _ (List.Mem.head []))
    | tail _ member => exact memAppendRight _ _ _ (ih member)

theorem priorPairsRetained (alphabet : List Word) (fresh : Word) (pair : Pair) (hm : pair ∈ pairs alphabet) :
    pair ∈ extendedPairs fresh alphabet := by
  induction alphabet with
  | nil => cases hm
  | cons first rest ih =>
    cases memAppendCases _ _ _ hm with
    | inl head => exact memAppendLeft _ _ _ (memAppendLeft _ _ _ head)
    | inr tail => exact memAppendRight _ _ _ (ih tail)


end SFT.InformationScience.QuantityPairs
