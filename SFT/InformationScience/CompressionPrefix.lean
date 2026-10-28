import SFT.InformationScience.CompressionDescription
import SFT.InformationScience.QuantitySupport
namespace SFT.InformationScience.CompressionPrefix
open SFT.Mathematics.AlgebraOperations
open CompressionDescription SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

def properPrefix (left right : Word) : Bool :=
  decide (left.length < right.length) && decide (right.take left.length = left)

def prefixFree (words : List Word) : Bool :=
  !words.isEmpty && words.all (fun word => !word.isEmpty) && distinct words &&
    words.all (fun left => words.all (fun right => if left = right then true else !properPrefix left right))

def concatenate : List Word → Word
  | [] => []
  | word :: rest => word ++ concatenate rest

theorem prefixMeaning (left right : Word) : properPrefix left right = true ↔
    left.length < right.length ∧ right.take left.length = left := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; exact ⟨of_decide_eq_true p.1,of_decide_eq_true p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨decide_eq_true h.1,decide_eq_true h.2⟩

theorem prefixFreeMeaning (words : List Word) : prefixFree words = true ↔
    words.isEmpty = false ∧ (∀ word, word ∈ words → word.isEmpty = false) ∧ distinct words = true ∧
    ∀ left, left ∈ words → ∀ right, right ∈ words → left ≠ right → properPrefix left right = false := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    have t := (andTrue _ _).mp q.1
    refine ⟨(notTrue _).mp t.1,fun word hm => (notTrue _).mp (allTrueAtMember _ _ t.2 word hm),q.2,?_⟩
    intro left hl right hr different
    have pair := allTrueAtMember _ _ (allTrueAtMember _ _ p.2 left hl) right hr
    rw [ite_eq_right different] at pair
    exact (notTrue _).mp pair
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,?_⟩,h.2.2.1⟩,?_⟩
    · exact (allTrueIffMembers _ _).mpr (fun word hm => (notTrue _).mpr (h.2.1 word hm))
    · apply (allTrueIffMembers _ _).mpr
      intro left hl
      apply (allTrueIffMembers _ _).mpr
      intro right hr
      by_cases eq : left = right
      · rw [ite_eq_left eq]
      · rw [ite_eq_right eq]
        exact (notTrue _).mpr (h.2.2.2 left hl right hr eq)

theorem takeOwnAppend (word tail : Word) : (word ++ tail).take word.length = word := by
  induction word with
  | nil => rfl
  | cons first rest ih => exact congrArg (List.cons first) ih

theorem commonInitial (left right tailLeft tailRight : Word)
    (eq : left ++ tailLeft = right ++ tailRight) :
    (∃ suffix, right = left ++ suffix) ∨ (∃ suffix, left = right ++ suffix) := by
  induction left generalizing right with
  | nil => exact Or.inl ⟨right,rfl⟩
  | cons first rest ih =>
    cases right with
    | nil => exact Or.inr ⟨first::rest,rfl⟩
    | cons other remaining =>
      have heads := List.cons.inj eq
      cases heads.1
      cases ih remaining heads.2 with
      | inl h => obtain ⟨suffix,hs⟩ := h; exact Or.inl ⟨suffix,congrArg (List.cons first) hs⟩
      | inr h => obtain ⟨suffix,hs⟩ := h; exact Or.inr ⟨suffix,congrArg (List.cons first) hs⟩

theorem prefixForbiddenExtension (words : List Word) (valid : prefixFree words = true)
    (left right : Word) (hl : left ∈ words) (hr : right ∈ words) (suffix : Word)
    (eq : right = left ++ suffix) : left = right := by
  cases suffix with
  | nil => rw [SymbolExtension.appendNil] at eq; exact eq.symm
  | cons first rest =>
    have longer : left.length < right.length := by
      rw [eq,appendLength]
      exact Nat.lt_add_of_pos_right (Nat.zero_lt_succ _)
    have different : left ≠ right := by
      intro same
      have len := congrArg List.length same
      rw [len] at longer
      exact Nat.lt_irrefl _ longer
    have blocked := (prefixFreeMeaning _).mp valid |>.2.2.2 left hl right hr different
    have allowed := (prefixMeaning _ _).mpr ⟨longer,by rw [eq,takeOwnAppend]⟩
    rw [blocked] at allowed
    cases allowed

theorem firstWordUnique (words : List Word) (valid : prefixFree words = true)
    (left right tailLeft tailRight : Word) (hl : left ∈ words) (hr : right ∈ words)
    (eq : left ++ tailLeft = right ++ tailRight) : left = right := by
  cases commonInitial _ _ _ _ eq with
  | inl h => obtain ⟨suffix,hs⟩ := h; exact prefixForbiddenExtension _ valid _ _ hl hr _ hs
  | inr h => obtain ⟨suffix,hs⟩ := h; exact (prefixForbiddenExtension _ valid _ _ hr hl _ hs).symm

theorem concatenateNonempty (word : Word) (tail : List Word) (h : word.isEmpty = false) :
    concatenate (word :: tail) ≠ [] := by
  cases word with
  | nil => cases h
  | cons first rest => intro eq; cases eq

theorem uniqueParse (words : List Word) (valid : prefixFree words = true)
    (left right : List Word) (hl : ∀ word, word ∈ left → word ∈ words)
    (hr : ∀ word, word ∈ right → word ∈ words)
    (eq : concatenate left = concatenate right) : left = right := by
  induction left generalizing right with
  | nil =>
    cases right with
    | nil => rfl
    | cons word rest => exact False.elim (concatenateNonempty word rest (((prefixFreeMeaning _).mp valid).2.1 word (hr word (List.Mem.head _))) eq.symm)
  | cons word rest ih =>
    cases right with
    | nil => exact False.elim (concatenateNonempty word rest (((prefixFreeMeaning _).mp valid).2.1 word (hl word (List.Mem.head _))) eq)
    | cons other remaining =>
      have same := firstWordUnique _ valid word other (concatenate rest) (concatenate remaining)
        (hl word (List.Mem.head _)) (hr other (List.Mem.head _)) eq
      cases same
      have tails := QuantitySupport.cancelPrefix word _ _ eq
      exact congrArg (List.cons word) (ih remaining (fun held hm => hl held (List.Mem.tail word hm))
        (fun held hm => hr held (List.Mem.tail word hm)) tails)

end SFT.InformationScience.CompressionPrefix
