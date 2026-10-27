import SFT.Mathematics.AlgebraOperations
import SFT.Mathematics.ArrangementCompleteness
namespace SFT.Mathematics.AlgebraOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
open CombinatorialArrangements

theorem permutationDistinctGeneric {α : Type} [DecidableEq α] {xs ys : List α} (p : List.Perm xs ys) :
    distinct xs = true → distinct ys = true := by
  induction p with
  | nil => intro _; rfl
  | cons x p ih =>
    intro h
    have parts := (distinctCons _ _).mp h
    apply (distinctCons _ _).mpr
    exact ⟨(absentIff _ _).mpr (fun m => (absentIff _ _).mp parts.1
      (permutationMember p.symm x m)), ih parts.2⟩
  | swap x y xs =>
    intro h
    have first := (distinctCons y (x::xs)).mp h
    have second := (distinctCons x xs).mp first.2
    have noY := (absentIff (x::xs) y).mp first.1
    have noX := (absentIff xs x).mp second.1
    apply (distinctCons x (y::xs)).mpr
    constructor
    · apply (absentIff _ _).mpr
      intro m
      cases m with
      | head => exact noY (List.Mem.head _)
      | tail _ m => exact noX m
    · exact (distinctCons y xs).mpr
        ⟨(absentIff _ _).mpr (fun m => noY (List.Mem.tail _ m)),second.2⟩
  | trans p q ip iq => exact fun h => iq (ip h)

theorem splitMemberGeneric {α : Type} (items : List α) (held : α) (member : held ∈ items) :
    ∃ before after, items = before ++ held :: after := by
  induction member with
  | head tail => exact ⟨[],tail,rfl⟩
  | tail x h ih =>
    obtain ⟨before,after,eq⟩ := ih
    exact ⟨x::before,after,congrArg (List.cons x) eq⟩

theorem insertionPermutationGeneric {α : Type} (before after : List α) (fresh : α) :
    List.Perm (before ++ fresh :: after) (fresh :: (before ++ after)) := by
  induction before with
  | nil => exact List.Perm.refl _
  | cons x xs ih =>
    exact (List.Perm.cons x ih).trans (List.Perm.swap fresh x _)

theorem completeEqualLengthPermutation {α : Type} [DecidableEq α]
    (support actual : List α) (unique : distinct support = true)
    (coverage : ∀ x, x ∈ support → x ∈ actual) (size : support.length = actual.length) :
    List.Perm support actual := by
  induction support generalizing actual with
  | nil =>
    cases actual with
    | nil => exact List.Perm.nil
    | cons x xs => cases size
  | cons x xs ih =>
    obtain ⟨before,after,eq⟩ := splitMemberGeneric actual x (coverage x (List.Mem.head _))
    have parts := (distinctCons x xs).mp unique
    have tailCoverage : ∀ y, y ∈ xs → y ∈ before ++ after := by
      intro y member
      have original := coverage y (List.Mem.tail _ member)
      rw [eq] at original
      cases memAppendCases y before (x::after) original with
      | inl h => exact memAppendLeft _ _ _ h
      | inr h =>
        cases h with
        | head => exact False.elim ((absentIff xs x).mp parts.1 member)
        | tail _ h => exact memAppendRight _ _ _ h
    have tailSize : xs.length = (before ++ after).length := by
      rw [eq,appendLength] at size
      change xs.length + 1 = before.length + (after.length + 1) at size
      rw [← Nat.add_assoc] at size
      rw [appendLength]
      exact Nat.succ.inj size
    rw [eq]
    exact (List.Perm.cons x (ih (before ++ after) parts.2 tailCoverage tailSize)).trans
      (insertionPermutationGeneric before after x).symm

theorem pairProductDistinct (left right : List String)
    (hl : distinct left = true) (hr : distinct right = true) :
    distinct (left.flatMap (fun a => right.map (fun b => (a,b)))) = true := by
  induction left with
  | nil => rfl
  | cons x xs ih =>
    have parts := (distinctCons x xs).mp hl
    apply appendDistinct
    · exact mapDistinct (fun y => (x,y)) (fun a b eq => congrArg Prod.snd eq) right hr
    · exact ih parts.2
    · intro pair first remaining
      obtain ⟨y,_,eq⟩ := memMapPreimage (fun y => (x,y)) pair right first
      obtain ⟨a,member,branch⟩ := memFlatMapOrigin _ _ _ remaining
      obtain ⟨b,_,otherEq⟩ := memMapPreimage (fun b => (a,b)) pair right branch
      have same : x = a := congrArg Prod.fst (eq.trans otherEq.symm)
      cases same
      exact (absentIff xs x).mp parts.1 member

theorem acceptedInputsPermuteSupport (carrier : List String) (rows : List (String × String × String))
    (table : OperationTable) (accepted : makeTable carrier rows = .ok table) :
    List.Perm (pairSupport carrier) (rowInputs rows) := by
  have data := tableAcceptedData carrier rows table accepted
  apply completeEqualLengthPermutation
  · exact pairProductDistinct carrier carrier data.2.2.1 data.2.2.1
  · intro pair member
    exact (acceptedInputCoverage carrier rows table accepted pair).mpr member
  · change (pairSupport carrier).length = (rows.map (fun row => (row.1,row.2.1))).length
    rw [mapLength]
    exact data.2.2.2.1.symm

theorem acceptedInputsDistinct (carrier : List String) (rows : List (String × String × String))
    (table : OperationTable) (accepted : makeTable carrier rows = .ok table) :
    distinct (rowInputs rows) = true := by
  have unique := (tableAcceptedData carrier rows table accepted).2.2.1
  exact permutationDistinctGeneric (acceptedInputsPermuteSupport carrier rows table accepted)
    (pairProductDistinct carrier carrier unique unique)


theorem filterEmptyWhenFalse {α : Type} (p : α → Bool) (xs : List α)
    (none : ∀ x, x ∈ xs → p x = false) : xs.filter p = [] := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    rw [List.filter_cons_of_neg (by rw [none x (List.Mem.head _)]; intro h; cases h)]
    exact ih (fun y h => none y (List.Mem.tail _ h))

theorem uniqueProjectedFilter {α β : Type} [DecidableEq β] (key : α → β)
    (p : α → Bool) (target : β) (xs : List α)
    (test : ∀ x, p x = true ↔ key x = target)
    (unique : distinct (xs.map key) = true) (present : target ∈ xs.map key) :
    ∃ row, xs.filter p = [row] := by
  induction xs with
  | nil => cases present
  | cons x xs ih =>
    have parts := (distinctCons (key x) (xs.map key)).mp unique
    cases px : p x with
    | true =>
      rw [List.filter_cons_of_pos px]
      have same := (test x).mp px
      have tailEmpty : xs.filter p = [] := by
        apply filterEmptyWhenFalse
        intro y member
        cases py : p y with
        | false => rfl
        | true =>
          have equal : key y = key x := ((test y).mp py).trans same.symm
          have retained := memMap key y xs member
          rw [equal] at retained
          exact False.elim ((absentIff _ _).mp parts.1 retained)
      rw [tailEmpty]
      exact ⟨x,rfl⟩
    | false =>
      rw [List.filter_cons_of_neg (by rw [px]; intro h; cases h)]
      apply ih parts.2
      cases present with
      | head => have yes := (test x).mpr rfl; rw [px] at yes; cases yes
      | tail _ h => exact h

theorem inputTestIff (row : String × String × String) (left right : String) :
    (decide (row.1 = left) && decide (row.2.1 = right)) = true ↔
      (row.1,row.2.1) = (left,right) := by
  by_cases a : row.1 = left <;> by_cases b : row.2.1 = right
  · rw [decide_eq_true a,decide_eq_true b]
    exact ⟨fun _ => Prod.ext a b,fun _ => rfl⟩
  · rw [decide_eq_true a,decide_eq_false b]
    constructor
    · intro h; cases h
    · intro h; exact False.elim (b (congrArg Prod.snd h))
  · rw [decide_eq_false a,decide_eq_true b]
    constructor
    · intro h; cases h
    · intro h; exact False.elim (a (congrArg Prod.fst h))
  · rw [decide_eq_false a,decide_eq_false b]
    constructor
    · intro h; cases h
    · intro h; exact False.elim (a (congrArg Prod.fst h))

theorem acceptedLookupTotal (carrier : List String) (rows : List (String × String × String))
    (table : OperationTable) (accepted : makeTable carrier rows = .ok table)
    (left right : String) (hl : left ∈ carrier) (hr : right ∈ carrier) :
    ∃ result, applyOperation table left right = .ok result ∧ result ∈ carrier := by
  have data := tableAcceptedData carrier rows table accepted
  have pairMember : (left,right) ∈ pairSupport carrier :=
    memFlatMap _ _ left _ hl (memMap (fun b => (left,b)) right carrier hr)
  have input := (acceptedInputCoverage carrier rows table accepted (left,right)).mpr pairMember
  obtain ⟨row,filtered⟩ := uniqueProjectedFilter (fun row : String × String × String => (row.1,row.2.1))
    (fun row => decide (row.1 = left) && decide (row.2.1 = right)) (left,right) rows
    (fun row => inputTestIff row left right) (acceptedInputsDistinct carrier rows table accepted) input
  have member : row ∈ rows := ((filterMemberIff _ rows row).mp
    (filtered.symm ▸ List.Mem.head [])).1
  refine ⟨row.2.2,?_,acceptedTableClosed carrier rows table accepted row member⟩
  apply singleMatchApplied
  rw [data.1]
  change (rows.filter (fun row => decide (row.1 = left) && decide (row.2.1 = right))).map
    (fun row => row.2.2) = [row.2.2]
  rw [filtered]
  rfl

end SFT.Mathematics.AlgebraOperations
