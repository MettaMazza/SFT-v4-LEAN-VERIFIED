import SFT.InformationScience.SymbolClasses
namespace SFT.InformationScience.SymbolLedger
open SymbolObservation SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation
abbrev Pair := Symbol × Symbol

def pairs : List Symbol → List Pair
  | [] => []
  | left :: rest => rest.map (fun right => (left,right)) ++ pairs rest

def selectPairs (observation : Observation) (retain : Bool) : List Pair → Except String (List Pair)
  | [] => .ok []
  | pair :: rest => match distinguishable observation pair.1 pair.2 with
    | .error e => .error e
    | .ok decision => match selectPairs observation retain rest with
      | .error e => .error e
      | .ok tail => .ok (if decision = retain then pair :: tail else tail)

def distinctionLedger (alphabet : List Symbol) (observation : Observation) : Except String (List Pair × List Pair) :=
  match selectPairs observation true (pairs alphabet) with
  | .error e => .error e
  | .ok retained => match selectPairs observation false (pairs alphabet) with
    | .error e => .error e
    | .ok closed => .ok (retained,closed)

theorem pairStep (left : Symbol) (rest : List Symbol) :
    pairs (left :: rest) = rest.map (fun right => (left,right)) ++ pairs rest := rfl

theorem pairSources (alphabet : List Symbol) (left right : Symbol) (h : (left,right) ∈ pairs alphabet) :
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

theorem selectionExists (observation : Observation) (retain : Bool) (input : List Pair)
    (defined : ∀ pair, pair ∈ input → ∃ decision, distinguishable observation pair.1 pair.2 = .ok decision) :
    ∃ output, selectPairs observation retain input = .ok output := by
  induction input with
  | nil => exact ⟨[],rfl⟩
  | cons pair rest ih =>
    obtain ⟨decision,hd⟩ := defined pair (List.Mem.head _)
    obtain ⟨tail,ht⟩ := ih (fun p hm => defined p (List.Mem.tail pair hm))
    refine ⟨if decision = retain then pair :: tail else tail,?_⟩
    unfold selectPairs; rw [hd,ht]

theorem selectionMembership (observation : Observation) (retain : Bool) (input output : List Pair)
    (h : selectPairs observation retain input = .ok output) (pair : Pair) :
    pair ∈ output ↔ pair ∈ input ∧ distinguishable observation pair.1 pair.2 = .ok retain := by
  induction input generalizing output with
  | nil => cases h; constructor; intro h; cases h; intro h; cases h.1
  | cons first rest ih =>
    unfold selectPairs at h
    cases hd : distinguishable observation first.1 first.2 with
    | error e => rw [hd] at h; cases h
    | ok decision =>
      rw [hd] at h
      cases ht : selectPairs observation retain rest with
      | error e => rw [ht] at h; cases h
      | ok tail =>
        rw [ht] at h
        change (Except.ok (if decision = retain then first :: tail else tail) : Except String (List Pair)) = .ok output at h
        by_cases same : decision = retain
        · rw [ite_eq_left same] at h; cases h; cases same
          constructor
          · intro hm
            cases hm with
            | head => exact ⟨List.Mem.head _,hd⟩
            | tail _ hm => have p := (ih tail ht).mp hm; exact ⟨List.Mem.tail first p.1,p.2⟩
          · intro hm
            cases hm.1 with
            | head => exact List.Mem.head _
            | tail _ member => exact List.Mem.tail _ ((ih tail ht).mpr ⟨member,hm.2⟩)
        · rw [ite_eq_right same] at h; cases h
          constructor
          · intro hm; have p := (ih output ht).mp hm; exact ⟨List.Mem.tail first p.1,p.2⟩
          · intro hm
            cases hm.1 with
            | head => exact False.elim (same (Except.ok.inj (hd.symm.trans hm.2)))
            | tail _ member => exact (ih output ht).mpr ⟨member,hm.2⟩

theorem ledgerResults (alphabet : List Symbol) (observation : Observation) (retained closed : List Pair)
    (h : distinctionLedger alphabet observation = .ok (retained,closed)) :
    selectPairs observation true (pairs alphabet) = .ok retained ∧
    selectPairs observation false (pairs alphabet) = .ok closed := by
  unfold distinctionLedger at h
  cases hl : selectPairs observation true (pairs alphabet) with
  | error e => rw [hl] at h; cases h
  | ok kept =>
    rw [hl] at h
    cases hr : selectPairs observation false (pairs alphabet) with
    | error e => rw [hr] at h; cases h
    | ok lost => rw [hr] at h; cases h; exact ⟨rfl,rfl⟩

theorem ledgerDisjoint (alphabet : List Symbol) (observation : Observation) (retained closed : List Pair)
    (h : distinctionLedger alphabet observation = .ok (retained,closed)) (pair : Pair)
    (hr : pair ∈ retained) (hc : pair ∈ closed) : False := by
  have outputs := ledgerResults _ _ _ _ h
  have r := ((selectionMembership _ _ _ _ outputs.1 pair).mp hr).2
  have c := ((selectionMembership _ _ _ _ outputs.2 pair).mp hc).2
  have impossible := Except.ok.inj (r.symm.trans c)
  cases impossible

theorem validatedPairDecision (alphabet : List Symbol) (observation : Observation)
    (valid : validateObservation alphabet observation = true) (pair : Pair) (hm : pair ∈ pairs alphabet) :
    ∃ decision, distinguishable observation pair.1 pair.2 = .ok decision := by
  have members := pairSources alphabet pair.1 pair.2 hm
  obtain ⟨left,hl,_⟩ := validatedLookup _ _ valid pair.1 members.1
  obtain ⟨right,hr,_⟩ := validatedLookup _ _ valid pair.2 members.2
  exact ⟨decide (left ≠ right),labelledDistinction _ _ _ _ _ hl hr⟩

theorem validatedLedger (alphabet : List Symbol) (observation : Observation)
    (valid : validateObservation alphabet observation = true) :
    ∃ retained closed, distinctionLedger alphabet observation = .ok (retained,closed) := by
  have total := validatedPairDecision alphabet observation valid
  obtain ⟨retained,hr⟩ := selectionExists observation true (pairs alphabet) total
  obtain ⟨closed,hc⟩ := selectionExists observation false (pairs alphabet) total
  refine ⟨retained,closed,?_⟩
  unfold distinctionLedger; rw [hr,hc]

theorem ledgerExhausts (alphabet : List Symbol) (observation : Observation)
    (valid : validateObservation alphabet observation = true) (retained closed : List Pair)
    (h : distinctionLedger alphabet observation = .ok (retained,closed)) (pair : Pair) :
    pair ∈ pairs alphabet ↔ pair ∈ retained ∨ pair ∈ closed := by
  have results := ledgerResults _ _ _ _ h
  constructor
  · intro hm
    obtain ⟨decision,hd⟩ := validatedPairDecision _ _ valid pair hm
    cases decision with
    | false => exact Or.inr ((selectionMembership _ _ _ _ results.2 pair).mpr ⟨hm,hd⟩)
    | true => exact Or.inl ((selectionMembership _ _ _ _ results.1 pair).mpr ⟨hm,hd⟩)
  · intro hm
    cases hm with
    | inl hr => exact ((selectionMembership _ _ _ _ results.1 pair).mp hr).1
    | inr hc => exact ((selectionMembership _ _ _ _ results.2 pair).mp hc).1

theorem singletonLedger (symbol : Symbol) (observation : Observation) :
    distinctionLedger [symbol] observation = .ok ([],[]) := rfl


def extendedPairs (fresh : Symbol) : List Symbol → List Pair
  | [] => []
  | left :: rest => (rest.map (fun right => (left,right)) ++ [(left,fresh)]) ++ extendedPairs fresh rest

theorem mapAppend {α β : Type} (f : α → β) (xs ys : List α) :
    (xs ++ ys).map f = xs.map f ++ ys.map f := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons (f x)) ih

theorem successorPairOrder (alphabet : List Symbol) (fresh : Symbol) :
    pairs (alphabet ++ [fresh]) = extendedPairs fresh alphabet := by
  induction alphabet with
  | nil => rfl
  | cons first rest ih =>
    change (rest ++ [fresh]).map (fun right => (first,right)) ++ pairs (rest ++ [fresh]) = _
    rw [mapAppend,ih]
    rfl

theorem newPairIncluded (alphabet : List Symbol) (fresh old : Symbol) (hm : old ∈ alphabet) :
    (old,fresh) ∈ extendedPairs fresh alphabet := by
  induction alphabet with
  | nil => cases hm
  | cons first rest ih =>
    cases hm with
    | head => exact memAppendLeft _ _ _ (memAppendRight _ _ _ (List.Mem.head []))
    | tail _ member => exact memAppendRight _ _ _ (ih member)

theorem priorPairsRetained (alphabet : List Symbol) (fresh : Symbol) (pair : Pair) (hm : pair ∈ pairs alphabet) :
    pair ∈ extendedPairs fresh alphabet := by
  induction alphabet with
  | nil => cases hm
  | cons first rest ih =>
    cases memAppendCases _ _ _ hm with
    | inl head => exact memAppendLeft _ _ _ (memAppendLeft _ _ _ head)
    | inr tail => exact memAppendRight _ _ _ (ih tail)

theorem coarseningClosed (fine coarse : Observation) (left right : Symbol) (label : String)
    (merge : String → String)
    (fl : observedLabel fine left = .ok label) (fr : observedLabel fine right = .ok label)
    (cl : observedLabel coarse left = .ok (merge label)) (cr : observedLabel coarse right = .ok (merge label)) :
    distinguishable fine left right = .ok false ∧ distinguishable coarse left right = .ok false := by
  rw [labelledDistinction _ _ _ _ _ fl fr,labelledDistinction _ _ _ _ _ cl cr]
  rw [decide_eq_false (fun h : label ≠ label => h rfl),
      decide_eq_false (fun h : merge label ≠ merge label => h rfl)]
  exact ⟨rfl,rfl⟩

theorem coarseningClosesExactly (fine coarse : Observation) (left right : Symbol) (l r : String)
    (merge : String → String)
    (fl : observedLabel fine left = .ok l) (fr : observedLabel fine right = .ok r)
    (cl : observedLabel coarse left = .ok (merge l)) (cr : observedLabel coarse right = .ok (merge r)) :
    (distinguishable fine left right = .ok true ∧ distinguishable coarse left right = .ok false) ↔
      l ≠ r ∧ merge l = merge r := by
  rw [labelledDistinction _ _ _ _ _ fl fr,labelledDistinction _ _ _ _ _ cl cr]
  constructor
  · intro h
    have different := of_decide_eq_true (Except.ok.inj h.1)
    have equal : merge l = merge r := by
      by_cases he : merge l = merge r
      · exact he
      · have yes := decide_eq_true he
        have no := Except.ok.inj h.2
        rw [yes] at no; cases no
    exact ⟨different,equal⟩
  · intro h
    rw [decide_eq_true h.1,decide_eq_false (fun ne => ne h.2)]
    exact ⟨rfl,rfl⟩

end SFT.InformationScience.SymbolLedger
