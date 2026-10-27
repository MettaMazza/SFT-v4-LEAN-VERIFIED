import SFT.Mathematics.CombinatorialSelections
namespace SFT.Mathematics.CombinatorialArrangements
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

def remainder (items : List String) (held : String) : List String :=
  match items with
  | [] => []
  | item::rest => if item = held then remainder rest held else item :: remainder rest held

theorem remainderLengthLe (items : List String) (held : String) :
    (remainder items held).length ≤ items.length := by
  induction items with
  | nil => exact Nat.le_refl _
  | cons item rest ih =>
    unfold remainder
    split
    · exact Nat.le_trans ih (Nat.le_succ _)
    · exact Nat.succ_le_succ ih

theorem remainderShorter (items : List String) (held : String) (member : held ∈ items) :
    (remainder items held).length < items.length := by
  induction items with
  | nil => cases member
  | cons item rest ih =>
    unfold remainder
    by_cases eq : item = held
    · rw [ite_eq_left eq]
      exact Nat.lt_succ_of_le (remainderLengthLe rest held)
    · rw [ite_eq_right eq]
      apply Nat.succ_lt_succ
      apply ih
      cases member with
      | head => exact False.elim (eq rfl)
      | tail _ h => exact h

def arrangementsBody (items : List String)
    (recur : (smaller : List String) → smaller.length < items.length → List Form) : List Form :=
  match items, recur with
  | [], _ => []
  | [item], _ => [[item]]
  | first::second::rest, recur =>
    (first::second::rest).attach.flatMap fun held =>
      (recur (remainder (first::second::rest) held.val)
        (remainderShorter _ _ held.property)).map (List.cons held.val)

def arrangementsCore : List String → List Form :=
  (measure (fun xs : List String => xs.length)).wf.fix arrangementsBody

theorem arrangementsStep (first second : String) (rest : List String) :
    arrangementsCore (first::second::rest) =
      (first::second::rest).attach.flatMap (fun held =>
        (arrangementsCore (remainder (first::second::rest) held.val)).map (List.cons held.val)) := by
  unfold arrangementsCore
  rw [WellFounded.fix_eq]
  rfl

theorem arrangementsSingle (label : String) : arrangementsCore [label] = [[label]] := by
  unfold arrangementsCore
  rw [WellFounded.fix_eq]
  rfl

def arrangements (items : List String) : Except String (List Form) :=
  if items.isEmpty || !distinct items then
    .error "ValueError: arrangements require a nonempty unique generated carrier"
  else .ok (arrangementsCore items)

theorem remainderMemberIff (items : List String) (held label : String) :
    label ∈ remainder items held ↔ label ∈ items ∧ label ≠ held := by
  induction items with
  | nil => constructor <;> intro h; cases h; cases h.1
  | cons item rest ih =>
    unfold remainder
    by_cases eq : item = held
    · rw [ite_eq_left eq]
      constructor
      · intro h; have p := ih.mp h; exact ⟨List.Mem.tail _ p.1,p.2⟩
      · intro h
        apply ih.mpr
        constructor
        · cases h.1 with
          | head => exact False.elim (h.2 eq)
          | tail _ hm => exact hm
        · exact h.2
    · rw [ite_eq_right eq]
      constructor
      · intro h
        cases h with
        | head => exact ⟨List.Mem.head _,eq⟩
        | tail _ hm => have p := ih.mp hm; exact ⟨List.Mem.tail _ p.1,p.2⟩
      · intro h
        cases h.1 with
        | head => exact List.Mem.head _
        | tail _ hm => exact List.Mem.tail _ (ih.mpr ⟨hm,h.2⟩)

theorem remainderExcludesHeld (items : List String) (held : String) :
    ¬ held ∈ remainder items held := fun h => ((remainderMemberIff items held held).mp h).2 rfl

theorem remainderPreservesDistinct (items : List String) (held : String)
    (unique : distinct items = true) : distinct (remainder items held) = true := by
  induction items with
  | nil => rfl
  | cons item rest ih =>
    have parts := (distinctCons item rest).mp unique
    change distinct (if item = held then remainder rest held else item :: remainder rest held) = true
    by_cases eq : item = held
    · rw [ite_eq_left eq]; exact ih parts.2
    · rw [ite_eq_right eq]
      apply (distinctCons item (remainder rest held)).mpr
      exact ⟨(absentIff _ _).mpr (fun h => (absentIff rest item).mp parts.1
        ((remainderMemberIff rest held item).mp h).1),ih parts.2⟩

theorem remainderAbsentPreserved (items : List String) (held : String)
    (absent : ¬ held ∈ items) : remainder items held = items := by
  induction items with
  | nil => rfl
  | cons item rest ih =>
    have neq : item ≠ held := by intro eq; cases eq; exact absent (List.Mem.head _)
    unfold remainder
    rw [ite_eq_right neq,ih (fun h => absent (List.Mem.tail _ h))]

theorem remainderRemovesExactlyOne (items : List String) (held : String)
    (unique : distinct items = true) (member : held ∈ items) :
    (remainder items held).length + 1 = items.length := by
  induction items with
  | nil => cases member
  | cons item rest ih =>
    have parts := (distinctCons item rest).mp unique
    unfold remainder
    by_cases eq : item = held
    · rw [ite_eq_left eq]
      cases eq
      rw [remainderAbsentPreserved rest held ((absentIff rest held).mp parts.1)]
      rfl
    · rw [ite_eq_right eq]
      have tail : held ∈ rest := by
        cases member with
        | head => exact False.elim (eq rfl)
        | tail _ h => exact h
      have smaller := ih parts.2 tail
      change ((remainder rest held).length + 1) + 1 = (rest.length + 1)
      exact congrArg (fun n => n+1) smaller

theorem recursiveRemainderAdmitted (first second : String) (rest : List String) (held : String)
    (unique : distinct (first::second::rest) = true) (member : held ∈ first::second::rest) :
    remainder (first::second::rest) held ≠ [] ∧ distinct (remainder (first::second::rest) held) = true := by
  constructor
  · intro empty
    have count := remainderRemovesExactlyOne _ held unique member
    rw [empty] at count
    have impossible : 0 = rest.length + 1 := Nat.succ.inj count
    exact Nat.noConfusion impossible
  · exact remainderPreservesDistinct _ held unique

theorem emptyArrangementsRejected : arrangements [] =
    .error "ValueError: arrangements require a nonempty unique generated carrier" := rfl

theorem singletonArrangement (label : String) : arrangements [label] = .ok [[label]] := by
  unfold arrangements
  change Except.ok (arrangementsCore [label]) = _
  rw [arrangementsSingle]

theorem remainderPermutation (items : List String) (held : String)
    (unique : distinct items = true) (member : held ∈ items) :
    List.Perm items (held :: remainder items held) := by
  induction items with
  | nil => cases member
  | cons item rest ih =>
    have parts := (distinctCons item rest).mp unique
    by_cases eq : item = held
    · cases eq
      change List.Perm (held::rest) (held :: (if held = held then remainder rest held else held :: remainder rest held))
      rw [ite_eq_left rfl,remainderAbsentPreserved rest held ((absentIff rest held).mp parts.1)]
    · have tail : held ∈ rest := by
        cases member with
        | head => exact False.elim (eq rfl)
        | tail _ hm => exact hm
      have prior := List.Perm.cons item (ih parts.2 tail)
      change List.Perm (item::rest) (held :: (if item = held then remainder rest held else item :: remainder rest held))
      rw [ite_eq_right eq]
      exact prior.trans (List.Perm.swap held item _)

theorem arrangementsEmpty : arrangementsCore [] = [] := by
  unfold arrangementsCore
  rw [WellFounded.fix_eq]
  rfl

theorem everyArrangementPermutesCarrier (items : List String) :
    distinct items = true → ∀ form, form ∈ arrangementsCore items → List.Perm form items := by
  apply (measure (fun xs : List String => xs.length)).wf.induction items
  intro carrier ih unique form member
  cases carrier with
  | nil => rw [arrangementsEmpty] at member; cases member
  | cons first tail =>
    cases tail with
    | nil =>
      rw [arrangementsSingle] at member
      cases member with
      | head => exact List.Perm.refl _
      | tail _ impossible => cases impossible
    | cons second rest =>
      rw [arrangementsStep] at member
      obtain ⟨held,_,branch⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ member
      obtain ⟨suffix,hs,eq⟩ := memMapPreimage _ _ _ branch
      rw [← eq]
      have smaller := ih (remainder (first::second::rest) held.val)
        (remainderShorter _ _ held.property) (remainderPreservesDistinct _ _ unique) suffix hs
      exact (List.Perm.cons held.val smaller).trans
        (remainderPermutation _ _ unique held.property).symm

end SFT.Mathematics.CombinatorialArrangements
