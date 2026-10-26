import SFT.Mathematics.ExactTraceArithmetic
import SFT.Foundation.FormConstruction
namespace SFT.Mathematics.DiscreteObjects
open SFT.Foundation.FormConstruction
abbrev Form := List String
abbrev Collection := List Form
abbrev Relation := List (Form × Form)

def has {α : Type} [DecidableEq α] : List α → α → Bool
  | [], _ => false
  | x::xs, a => if x = a then true else has xs a

def distinct {α : Type} [DecidableEq α] : List α → Bool
  | [] => true
  | x::xs => !has xs x && distinct xs

def emptyOne : Form := ["empty-One"]
def formValue (form : Form) : TupleValue := .tuple (form.map TupleValue.text)
def collectionValue (forms : Collection) : TupleValue := .tuple (forms.map formValue)

def generatedCollection (forms : Collection) : Except String Collection :=
  if forms.isEmpty || !distinct forms then
    .error "ValueError: a generated collection requires distinct nonempty forms"
  else .ok forms

def heldSelection (collection held : Collection) : Except String TupleValue :=
  if held.any (fun form => !has collection form) || !distinct held then
    .error "ValueError: a selection must retain distinct members of its source collection"
  else if held.isEmpty then .ok (formValue emptyOne) else .ok (collectionValue held)

def completePairs (left right : Collection) : Relation := left.flatMap (fun a => right.map (fun b => (a,b)))

def generatedRelation (left right : Collection) (heldPairs : Relation) : Except String Relation :=
  if heldPairs.any (fun pair => !has (completePairs left right) pair) || !distinct heldPairs then
    .error "ValueError: a relation is a held selection of the complete pair-cell support"
  else .ok heldPairs

def isTotalSingleValued (source : Collection) (relation : Relation) : Bool :=
  source.all (fun item => decide ((relation.filter (fun pair => decide (pair.1 = item))).length = 1))

def successorTrace (collection : Collection) (fresh : Form) : Except String Collection :=
  if has collection fresh then .error "ValueError: successor must be freshly generated"
  else .ok (collection ++ [fresh])

theorem hasIff {α : Type} [DecidableEq α] (xs : List α) (a : α) : has xs a = true ↔ a ∈ xs := by
  induction xs with
  | nil => constructor <;> intro h <;> cases h
  | cons x xs ih =>
    by_cases eq : x = a
    · rw [has,ite_eq_left eq]
      constructor
      · intro _; cases eq; exact List.Mem.head _
      · intro _; rfl
    · rw [has,ite_eq_right eq]
      constructor
      · intro h; exact List.Mem.tail _ (ih.mp h)
      · intro h
        cases h with
        | head => exact False.elim (eq rfl)
        | tail _ h => exact ih.mpr h

theorem emptyCollectionRejected : generatedCollection [] = .error "ValueError: a generated collection requires distinct nonempty forms" := rfl

theorem emptyMemberAccepted : generatedCollection [[]] = .ok [[]] := rfl

theorem generatedCollectionPreserves (forms result : Collection) (h : generatedCollection forms = .ok result) : result = forms := by
  unfold generatedCollection at h
  split at h
  · cases h
  · exact (Except.ok.inj h).symm

theorem heldEmptySelection (collection : Collection) : heldSelection collection [] = .ok (formValue emptyOne) := rfl

theorem emptyRelationAccepted (left right : Collection) : generatedRelation left right [] = .ok [] := rfl

theorem generatedRelationPreserves (left right : Collection) (held result : Relation)
    (h : generatedRelation left right held = .ok result) : result = held := by
  unfold generatedRelation at h
  split at h
  · cases h
  · exact (Except.ok.inj h).symm

theorem freshSuccessorAppends (collection : Collection) (fresh : Form) (h : has collection fresh = false) :
    successorTrace collection fresh = .ok (collection ++ [fresh]) := by
  unfold successorTrace
  rw [h]
  rfl

theorem existingSuccessorRejected (collection : Collection) (fresh : Form) (h : fresh ∈ collection) :
    successorTrace collection fresh = .error "ValueError: successor must be freshly generated" := by
  unfold successorTrace
  rw [(hasIff collection fresh).mpr h]
  rfl

theorem emptySourceTotal (relation : Relation) : isTotalSingleValued [] relation = true := rfl

theorem anyFalseAtMember {α : Type} (p : α → Bool) (xs : List α)
    (h : xs.any p = false) (a : α) (ha : a ∈ xs) : p a = false := by
  induction xs with
  | nil => cases ha
  | cons x xs ih =>
    cases ha with
    | head =>
      cases hx : p a with
      | false => rfl
      | true => simp only [List.any_cons, hx, Bool.true_or] at h; cases h
    | tail _ ht =>
      apply ih
      · cases hx : p x with
        | false => simpa only [List.any_cons, hx, Bool.false_or] using h
        | true => simp only [List.any_cons, hx, Bool.true_or] at h; cases h
      · exact ht

theorem heldSelectionContained (collection held : Collection) (result : TupleValue)
    (h : heldSelection collection held = .ok result) (form : Form) (hf : form ∈ held) :
    form ∈ collection := by
  unfold heldSelection at h
  cases ha : held.any (fun f => !has collection f) with
  | true => rw [ha] at h; cases h
  | false =>
    have hn := anyFalseAtMember (fun f => !has collection f) held ha form hf
    apply (hasIff collection form).mp
    cases hm : has collection form with
    | false => rw [hm] at hn; cases hn
    | true => rfl

end SFT.Mathematics.DiscreteObjects
