import SFT.Mathematics.CategoryTypes
namespace SFT.InformationScience.SymbolObservation
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

abbrev Symbol := String × String
abbrev Observation := List (Symbol × String)

def symbolHeld (symbol : Symbol) : Bool := !symbol.1.isEmpty && !symbol.2.isEmpty

def canonicalAlphabet (symbols : List Symbol) : Except String (List Symbol) :=
  if symbols.isEmpty || !distinct symbols then .error "an alphabet requires distinct canonical symbol forms"
  else if !symbols.all symbolHeld then .error "each symbol retains a canonical form and held label"
  else .ok symbols

def keysMatch (alphabet : List Symbol) (observation : Observation) : Bool :=
  (observation.map Prod.fst).all (has alphabet) && alphabet.all (has (observation.map Prod.fst))

def validateObservation (alphabet : List Symbol) (observation : Observation) : Bool :=
  !alphabet.isEmpty && decide (observation.length = alphabet.length) &&
    distinct (observation.map Prod.fst) && keysMatch alphabet observation &&
    observation.all (fun row => !row.2.isEmpty)

def labelsFor (observation : Observation) (symbol : Symbol) : List String :=
  match observation with
  | [] => []
  | (source,label) :: rest => if source = symbol then label :: labelsFor rest symbol else labelsFor rest symbol

def observedLabel (observation : Observation) (symbol : Symbol) : Except String String :=
  match labelsFor observation symbol with
  | [] => .error "observation must classify the symbol exactly once"
  | label :: rest => match rest with
    | [] => .ok label
    | _ :: _ => .error "observation must classify the symbol exactly once"

def distinguishable (observation : Observation) (left right : Symbol) : Except String Bool :=
  if left = right then .ok false
  else match observedLabel observation left with
    | .error e => .error e
    | .ok l => match observedLabel observation right with
      | .error e => .error e
      | .ok r => .ok (decide (l ≠ r))

theorem alphabetAdmitted (symbols : List Symbol)
    (h : (symbols.isEmpty || !distinct symbols) = false) (held : symbols.all symbolHeld = true) :
    canonicalAlphabet symbols = .ok symbols := by
  unfold canonicalAlphabet; rw [h,held]; rfl

theorem alphabetResult (symbols result : List Symbol) (h : canonicalAlphabet symbols = .ok result) :
    result = symbols ∧ symbols.all symbolHeld = true := by
  unfold canonicalAlphabet at h
  cases hc : symbols.isEmpty || !distinct symbols with
  | true => rw [hc] at h; cases h
  | false =>
    rw [hc] at h
    cases hh : symbols.all symbolHeld with
    | false => rw [hh] at h; cases h
    | true => rw [hh] at h; cases h; exact ⟨rfl,rfl⟩

theorem alphabetMembersHeld (symbols result : List Symbol) (h : canonicalAlphabet symbols = .ok result)
    (symbol : Symbol) (member : symbol ∈ result) : symbolHeld symbol = true := by
  have p := alphabetResult _ _ h
  rw [p.1] at member
  exact allTrueAtMember _ _ p.2 symbol member

theorem keysMeaning (alphabet : List Symbol) (observation : Observation) : keysMatch alphabet observation = true ↔
    (∀ symbol, symbol ∈ observation.map Prod.fst → symbol ∈ alphabet) ∧
    (∀ symbol, symbol ∈ alphabet → symbol ∈ observation.map Prod.fst) := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    exact ⟨fun symbol hm => (hasIff _ _).mp (allTrueAtMember _ _ p.1 symbol hm),
      fun symbol hm => (hasIff _ _).mp (allTrueAtMember _ _ p.2 symbol hm)⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(allTrueIffMembers _ _).mpr (fun symbol hm => (hasIff _ _).mpr (h.1 symbol hm)),
      (allTrueIffMembers _ _).mpr (fun symbol hm => (hasIff _ _).mpr (h.2 symbol hm))⟩

theorem validationMeaning (alphabet : List Symbol) (observation : Observation) : validateObservation alphabet observation = true ↔
    alphabet.isEmpty = false ∧ observation.length = alphabet.length ∧
    distinct (observation.map Prod.fst) = true ∧ keysMatch alphabet observation = true ∧
    observation.all (fun row => !row.2.isEmpty) = true := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    have t := (andTrue _ _).mp q.1
    have u := (andTrue _ _).mp t.1
    exact ⟨(notTrue _).mp u.1,of_decide_eq_true u.2,t.2,q.2,p.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr
      ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,decide_eq_true h.2.1⟩,h.2.2.1⟩,h.2.2.2.1⟩,h.2.2.2.2⟩

theorem labelMembership (observation : Observation) (symbol : Symbol) (label : String) :
    label ∈ labelsFor observation symbol ↔ (symbol,label) ∈ observation := by
  induction observation with
  | nil => constructor <;> intro h <;> cases h
  | cons row rest ih =>
    cases row with
    | mk source value =>
      by_cases same : source = symbol
      · cases same
        rw [labelsFor,ite_eq_left rfl]
        constructor
        · intro h
          cases h with
          | head => exact List.Mem.head _
          | tail _ hm => exact List.Mem.tail _ (ih.mp hm)
        · intro h
          cases h with
          | head => exact List.Mem.head _
          | tail _ hm => exact List.Mem.tail _ (ih.mpr hm)
      · rw [labelsFor,ite_eq_right same]
        constructor
        · intro h; exact List.Mem.tail _ (ih.mp h)
        · intro h
          cases h with
          | head => exact False.elim (same rfl)
          | tail _ hm => exact ih.mpr hm

theorem observedExactlyOnce (observation : Observation) (symbol : Symbol) (label : String) :
    observedLabel observation symbol = .ok label ↔ labelsFor observation symbol = [label] := by
  unfold observedLabel
  cases hm : labelsFor observation symbol with
  | nil => constructor <;> intro h <;> cases h
  | cons first rest =>
    cases rest with
    | nil => constructor <;> intro h <;> cases h <;> rfl
    | cons next tail => constructor <;> intro h <;> cases h

theorem observedSource (observation : Observation) (symbol : Symbol) (label : String)
    (h : observedLabel observation symbol = .ok label) : (symbol,label) ∈ observation := by
  apply (labelMembership _ _ _).mp
  rw [(observedExactlyOnce _ _ _).mp h]
  exact List.Mem.head _

theorem observedUnique (observation : Observation) (symbol : Symbol) (label other : String)
    (h : observedLabel observation symbol = .ok label) (member : (symbol,other) ∈ observation) : other = label := by
  have hm := (labelMembership _ _ _).mpr member
  rw [(observedExactlyOnce _ _ _).mp h] at hm
  cases hm with
  | head => rfl
  | tail _ h => cases h

theorem irreflexive (observation : Observation) (symbol : Symbol) : distinguishable observation symbol symbol = .ok false := by
  unfold distinguishable; rw [ite_eq_left rfl]

theorem labelledDistinction (observation : Observation) (left right : Symbol) (l r : String)
    (hl : observedLabel observation left = .ok l) (hr : observedLabel observation right = .ok r) :
    distinguishable observation left right = .ok (decide (l ≠ r)) := by
  by_cases same : left = right
  · cases same
    have eq : l = r := Except.ok.inj (hl.symm.trans hr)
    cases eq
    rw [irreflexive,decide_eq_false (fun h : l ≠ l => h rfl)]
  · unfold distinguishable; rw [ite_eq_right same,hl,hr]

theorem retainedIffDifferent (observation : Observation) (left right : Symbol) (l r : String)
    (hl : observedLabel observation left = .ok l) (hr : observedLabel observation right = .ok r) :
    distinguishable observation left right = .ok true ↔ l ≠ r := by
  rw [labelledDistinction _ _ _ _ _ hl hr]
  constructor
  · intro h; exact of_decide_eq_true (Except.ok.inj h)
  · intro h; rw [decide_eq_true h]

theorem symmetry (observation : Observation) (left right : Symbol) (l r : String)
    (hl : observedLabel observation left = .ok l) (hr : observedLabel observation right = .ok r) :
    distinguishable observation left right = distinguishable observation right left := by
  rw [labelledDistinction _ _ _ _ _ hl hr,labelledDistinction _ _ _ _ _ hr hl]
  by_cases same : l = r
  · cases same; rfl
  · have reverse : r ≠ l := fun h => same h.symm
    rw [decide_eq_true same,decide_eq_true reverse]


theorem labelsAbsent (observation : Observation) (symbol : Symbol)
    (h : ¬ symbol ∈ observation.map Prod.fst) : labelsFor observation symbol = [] := by
  induction observation with
  | nil => rfl
  | cons row rest ih =>
    cases row with
    | mk source label =>
      have different : source ≠ symbol := by
        intro same; cases same; exact h (List.Mem.head _)
      have absent : ¬ symbol ∈ rest.map Prod.fst := fun hm => h (List.Mem.tail source hm)
      rw [labelsFor,ite_eq_right different]
      exact ih absent

theorem uniqueSourceLabel (observation : Observation) (symbol : Symbol)
    (hd : distinct (observation.map Prod.fst) = true) (hm : symbol ∈ observation.map Prod.fst) :
    ∃ label, labelsFor observation symbol = [label] := by
  induction observation with
  | nil => cases hm
  | cons row rest ih =>
    cases row with
    | mk source label =>
      have parts := (andTrue _ _).mp hd
      have absent := (absentIff _ _).mp ((notTrue _).mp parts.1)
      by_cases same : source = symbol
      · cases same
        refine ⟨label,?_⟩
        rw [labelsFor,ite_eq_left rfl,labelsAbsent _ _ absent]
      · have tail : symbol ∈ rest.map Prod.fst := by
          cases hm with
          | head => exact False.elim (same rfl)
          | tail _ h => exact h
        obtain ⟨value,hv⟩ := ih parts.2 tail
        refine ⟨value,?_⟩
        rw [labelsFor,ite_eq_right same,hv]

theorem validatedLookup (alphabet : List Symbol) (observation : Observation)
    (valid : validateObservation alphabet observation = true) (symbol : Symbol) (hm : symbol ∈ alphabet) :
    ∃ label, observedLabel observation symbol = .ok label ∧ label.isEmpty = false := by
  have v := (validationMeaning _ _).mp valid
  have keys := (keysMeaning _ _).mp v.2.2.2.1
  obtain ⟨label,hl⟩ := uniqueSourceLabel observation symbol v.2.2.1 (keys.2 symbol hm)
  have found := (observedExactlyOnce _ _ _).mpr hl
  have row := observedSource _ _ _ found
  have nonempty := allTrueAtMember _ _ v.2.2.2.2 (symbol,label) row
  exact ⟨label,found,(notTrue _).mp nonempty⟩

theorem validatedSymmetry (alphabet : List Symbol) (observation : Observation)
    (valid : validateObservation alphabet observation = true) (left right : Symbol)
    (hl : left ∈ alphabet) (hr : right ∈ alphabet) :
    distinguishable observation left right = distinguishable observation right left := by
  obtain ⟨l,ol,_⟩ := validatedLookup _ _ valid left hl
  obtain ⟨r,orr,_⟩ := validatedLookup _ _ valid right hr
  exact symmetry _ _ _ _ _ ol orr

end SFT.InformationScience.SymbolObservation
