import SFT.Foundation.Part
/-! part.py::closure_record positive_boundary: a held selection contained in a
registered finite whole cannot have more fibres than its whole. Whole positions
come from Count's generated trace. A predicate records which fibres are held;
this is source selection data, not an unforced coordinate or fitted parameter. -/
namespace SFT.Foundation.Part.SelectionDerivation
open Count.TraceDerivation

def select {α : Type} (keep : α → Bool) : List α → List α
  | [] => []
  | x::xs => if keep x then x :: select keep xs else select keep xs

def heldSelection (t : Trace) (held : Position t → Bool) : List (Position t) :=
  select held (complete t)

theorem filterMembership {α : Type} (keep : α → Bool) (xs : List α) (x : α)
    (h : x ∈ select keep xs) : x ∈ xs := by
  induction xs with
  | nil => cases h
  | cons a xs ih =>
    change x ∈ (if keep a then a :: select keep xs else select keep xs) at h
    cases ha : keep a with
    | false => rw [ha] at h; exact List.Mem.tail _ (ih h)
    | true =>
      rw [ha] at h
      cases h with
      | head => exact List.Mem.head _
      | tail _ hx => exact List.Mem.tail _ (ih hx)

theorem keptMemberInFilter {α : Type} (keep : α → Bool) (xs : List α) (x : α)
    (member : x ∈ xs) (kept : keep x = true) : x ∈ select keep xs := by
  induction xs with
  | nil => cases member
  | cons a xs ih =>
    change x ∈ (if keep a then a :: select keep xs else select keep xs)
    cases member with
    | head => rw [kept]; exact List.Mem.head _
    | tail _ hx =>
      cases ha : keep a with
      | false => exact ih hx
      | true => exact List.Mem.tail _ (ih hx)

theorem filterNoDuplicates {α : Type} (keep : α → Bool) (xs : List α) (h : xs.Nodup) :
    (select keep xs).Nodup := by
  induction xs with
  | nil => exact List.Pairwise.nil
  | cons a xs ih =>
    cases h with
    | cons distinct rest =>
      change (if keep a then a :: select keep xs else select keep xs).Nodup
      cases ha : keep a with
      | false => exact ih rest
      | true =>
        exact List.Pairwise.cons
          (fun x hx eq => distinct x (filterMembership keep xs x hx) eq) (ih rest)

theorem filterLengthBound {α : Type} (keep : α → Bool) (xs : List α) :
    (select keep xs).length ≤ xs.length := by
  induction xs with
  | nil => exact Nat.le_refl 0
  | cons a xs ih =>
    change (if keep a then a :: select keep xs else select keep xs).length ≤ Nat.succ xs.length
    cases ha : keep a with
    | false => exact Nat.le_trans ih (Nat.le_succ _)
    | true => exact Nat.succ_le_succ ih

theorem heldSelectionContained (t : Trace) (held : Position t → Bool) :
    ∀ p, p ∈ heldSelection t held → p ∈ complete t :=
  fun p h => filterMembership held (complete t) p h

theorem heldSelectionRetainsOnce (t : Trace) (held : Position t → Bool) :
    (heldSelection t held).Nodup :=
  filterNoDuplicates held (complete t) (everyGeneratedPositionRetainedOnce t)

theorem heldCountCannotExceedWhole (t : Trace) (held : Position t → Bool) :
    (heldSelection t held).length ≤ (complete t).length := filterLengthBound held (complete t)

theorem witnessedSelectionNonempty (t : Trace) (held : Position t → Bool)
    (p : Position t) (kept : held p = true) : heldSelection t held ≠ [] := by
  intro empty
  have member := keptMemberInFilter held (complete t) p (everyGeneratedPositionRetained t p) kept
  change p ∈ heldSelection t held at member
  rw [empty] at member
  cases member

-- Source closure_record.coordinate: the exact coordinate is the pair of held
-- and whole positive generation records. No division or normalization is used.
def coordinate (t : Trace) (held : Position t → Bool) :
    List (Position t) × List (Position t) := (heldSelection t held, complete t)

theorem coordinateIdentifiesHeld (t : Trace) (held : Position t → Bool) :
    (coordinate t held).1 = heldSelection t held := rfl

theorem coordinateIdentifiesWhole (t : Trace) (held : Position t → Bool) :
    (coordinate t held).2 = complete t := rfl

theorem heldWholePairUnique (t : Trace) (held : Position t → Bool)
    (pair : List (Position t) × List (Position t))
    (heldIdentity : pair.1 = heldSelection t held) (wholeIdentity : pair.2 = complete t) :
    pair = coordinate t held := by
  cases pair with
  | mk h w =>
    cases heldIdentity
    cases wholeIdentity
    rfl

theorem witnessedCoordinatePositiveAndContained (t : Trace) (held : Position t → Bool)
    (p : Position t) (kept : held p = true) :
    (coordinate t held).1 ≠ [] ∧ (coordinate t held).2 ≠ [] ∧
      (coordinate t held).1.length ≤ (coordinate t held).2.length :=
  ⟨witnessedSelectionNonempty t held p kept,completeNonempty t,heldCountCannotExceedWhole t held⟩

end SFT.Foundation.Part.SelectionDerivation
