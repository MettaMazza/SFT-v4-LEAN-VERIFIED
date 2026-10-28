import SFT.InformationScience.EncodingMaps
namespace SFT.InformationScience.EncodingLoss
open EncodingClasses EncodingMaps SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Mathematics.AlgebraOperations SFT.Foundation.Count.TraceDerivation
abbrev Pair := String × String

def sourcePairs : List String → List Pair
  | [] => []
  | left :: rest => rest.map (fun right => (left,right)) ++ sourcePairs rest

def closedPair (encoding : Encoding) (left right : String) : Except String Bool :=
  match lookupFirst encoding left with
  | none => .error "RuntimeError: generator raised StopIteration"
  | some l => match lookupFirst encoding right with
    | none => .error "RuntimeError: generator raised StopIteration"
    | some r => .ok (decide (l = r))

def selectClosed (encoding : Encoding) : List Pair → Except String (List Pair)
  | [] => .ok []
  | pair :: rest => match closedPair encoding pair.1 pair.2 with
    | .error e => .error e
    | .ok decision => match selectClosed encoding rest with
      | .error e => .error e
      | .ok tail => .ok (if decision = true then pair :: tail else tail)

def closedDistinctions (source : List String) (encoding : Encoding) : Except String (List Pair) :=
  selectClosed encoding (sourcePairs source)

theorem pairSources (source : List String) (left right : String) (h : (left,right) ∈ sourcePairs source) :
    left ∈ source ∧ right ∈ source := by
  induction source with
  | nil => cases h
  | cons first rest ih =>
    cases memAppendCases _ _ _ h with
    | inl new =>
      obtain ⟨r,hr,eq⟩ := memMapPreimage (fun r => (first,r)) (left,right) rest new
      have hl := congrArg Prod.fst eq
      have he := congrArg Prod.snd eq
      cases hl; cases he
      exact ⟨List.Mem.head _,List.Mem.tail left hr⟩
    | inr old => have p := ih old; exact ⟨List.Mem.tail first p.1,List.Mem.tail first p.2⟩

theorem closedPairImages (encoding : Encoding) (left right : String) (l r : Codeword)
    (hl : lookupFirst encoding left = some l) (hr : lookupFirst encoding right = some r) :
    closedPair encoding left right = .ok (decide (l = r)) := by
  unfold closedPair; rw [hl,hr]

theorem classClosesPair (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (word : Codeword) (left right : String)
    (hl : left ∈ membersFor source encoding word) (hr : right ∈ membersFor source encoding word) :
    closedPair encoding left right = .ok true := by
  have l := (memberMeaning _ _ _ _).mp hl
  have r := (memberMeaning _ _ _ _).mp hr
  rw [closedPairImages _ _ _ _ _ (admittedRowLookup _ _ _ valid _ _ l.2) (admittedRowLookup _ _ _ valid _ _ r.2)]
  rw [decide_eq_true rfl]

theorem closedPairClass (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (left right : String)
    (hl : left ∈ source) (hr : right ∈ source) (hc : closedPair encoding left right = .ok true) :
    ∃ word, left ∈ membersFor source encoding word ∧ right ∈ membersFor source encoding word := by
  obtain ⟨l,ol,_⟩ := admittedSourceCode _ _ _ valid left hl
  obtain ⟨r,orr,_⟩ := admittedSourceCode _ _ _ valid right hr
  rw [closedPairImages _ _ _ _ _ ol orr] at hc
  have eq : l = r := of_decide_eq_true (Except.ok.inj hc)
  cases eq
  exact ⟨l,(memberMeaning _ _ _ _).mpr ⟨hl,lookupRow _ _ _ ol⟩,
    (memberMeaning _ _ _ _).mpr ⟨hr,lookupRow _ _ _ orr⟩⟩

theorem selectionExists (encoding : Encoding) (input : List Pair)
    (defined : ∀ pair, pair ∈ input → ∃ decision, closedPair encoding pair.1 pair.2 = .ok decision) :
    ∃ output, selectClosed encoding input = .ok output := by
  induction input with
  | nil => exact ⟨[],rfl⟩
  | cons pair rest ih =>
    obtain ⟨decision,hd⟩ := defined pair (List.Mem.head _)
    obtain ⟨tail,ht⟩ := ih (fun p hm => defined p (List.Mem.tail pair hm))
    refine ⟨if decision = true then pair :: tail else tail,?_⟩
    unfold selectClosed; rw [hd,ht]

theorem selectionMembership (encoding : Encoding) (input output : List Pair)
    (h : selectClosed encoding input = .ok output) (pair : Pair) :
    pair ∈ output ↔ pair ∈ input ∧ closedPair encoding pair.1 pair.2 = .ok true := by
  induction input generalizing output with
  | nil => cases h; constructor; intro h; cases h; intro h; cases h.1
  | cons first rest ih =>
    unfold selectClosed at h
    cases hd : closedPair encoding first.1 first.2 with
    | error e => rw [hd] at h; cases h
    | ok decision =>
      rw [hd] at h
      cases ht : selectClosed encoding rest with
      | error e => rw [ht] at h; cases h
      | ok tail =>
        rw [ht] at h
        change (Except.ok (if decision = true then first :: tail else tail) : Except String (List Pair)) = .ok output at h
        by_cases same : decision = true
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



theorem admittedLossExists (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) :
    ∃ result, closedDistinctions source encoding = .ok result := by
  apply selectionExists
  intro pair hm
  have endpoints := pairSources source pair.1 pair.2 hm
  obtain ⟨l,hl,_⟩ := admittedSourceCode _ _ _ valid pair.1 endpoints.1
  obtain ⟨r,hr,_⟩ := admittedSourceCode _ _ _ valid pair.2 endpoints.2
  exact ⟨decide (l = r),closedPairImages _ _ _ _ _ hl hr⟩

theorem closedLedgerClass (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (result : List Pair)
    (h : closedDistinctions source encoding = .ok result) (left right : String) :
    (left,right) ∈ result ↔ (left,right) ∈ sourcePairs source ∧
      ∃ word, left ∈ membersFor source encoding word ∧ right ∈ membersFor source encoding word := by
  constructor
  · intro hm
    have p := (selectionMembership _ _ _ h (left,right)).mp hm
    have endpoints := pairSources _ _ _ p.1
    exact ⟨p.1,closedPairClass _ _ _ valid _ _ endpoints.1 endpoints.2 p.2⟩
  · intro hm
    obtain ⟨word,hl,hr⟩ := hm.2
    exact (selectionMembership _ _ _ h (left,right)).mpr ⟨hm.1,classClosesPair _ _ _ valid _ _ _ hl hr⟩

theorem emptyLoss (encoding : Encoding) : closedDistinctions [] encoding = .ok [] := rfl

theorem singletonLoss (source : String) (encoding : Encoding) : closedDistinctions [source] encoding = .ok [] := rfl

end SFT.InformationScience.EncodingLoss
