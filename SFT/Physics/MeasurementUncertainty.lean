import SFT.Host.Canonical
namespace SFT.Physics.MeasurementUncertainty
-- measurement_laws.py UNCERTAINTY: all still-admissible source relations
-- remain held. The measurement's verdict is an input record, not a fit.
structure Decision (Relation : Type) where
  relation : Relation
  sourceIdentity : String
  stillAdmissible : Bool

def retained {R : Type} : List (Decision R) → List (Decision R)
  | [] => []
  | row::rest => if row.stillAdmissible then row::retained rest else retained rest

inductive Retention {R : Type} : List (Decision R) → List (Decision R) → Prop
  | empty : Retention [] []
  | keep {row input output} : row.stillAdmissible = true →
      Retention input output → Retention (row::input) (row::output)
  | remove {row input output} : row.stillAdmissible = false →
      Retention input output → Retention (row::input) output

theorem retentionConstructed {R : Type} (rows : List (Decision R)) :
    Retention rows (retained rows) := by
  induction rows with
  | nil => exact .empty
  | cons row rest ih =>
    cases h : row.stillAdmissible with
    | false => rw [retained,h]; exact .remove h ih
    | true => rw [retained,h]; exact .keep h ih

theorem retentionExact {R : Type} {input output : List (Decision R)}
    (h : Retention input output) : output = retained input := by
  induction h with
  | empty => rfl
  | keep accepted prior ih => rw [retained,accepted,ih]; rfl
  | remove rejected prior ih => rw [retained,rejected]; exact ih

theorem noAlternativeSelection {R : Type} {input first second : List (Decision R)}
    (a : Retention input first) (b : Retention input second) : first = second :=
  (retentionExact a).trans (retentionExact b).symm

theorem retainedOrigin {R : Type} (rows : List (Decision R)) (x : Decision R)
    (h : x ∈ retained rows) : x ∈ rows ∧ x.stillAdmissible = true := by
  induction rows with
  | nil => cases h
  | cons row rest ih =>
    cases accepted : row.stillAdmissible with
    | false =>
      rw [retained,accepted] at h
      have hx := ih h
      exact ⟨List.mem_cons_of_mem row hx.1,hx.2⟩
    | true =>
      rw [retained,accepted] at h
      cases h with
      | head => exact ⟨List.mem_cons_self,accepted⟩
      | tail _ member =>
        have hx := ih member
        exact ⟨List.mem_cons_of_mem row hx.1,hx.2⟩

theorem allAdmissibleRetained {R : Type} (rows : List (Decision R)) (x : Decision R)
    (member : x ∈ rows) (admitted : x.stillAdmissible = true) : x ∈ retained rows := by
  induction rows with
  | nil => cases member
  | cons row rest ih =>
    cases member with
    | head => rw [retained,admitted]; exact List.mem_cons_self
    | tail _ member =>
      have hx := ih member
      cases accepted : row.stillAdmissible with
      | false => rw [retained,accepted]; exact hx
      | true => rw [retained,accepted]; exact List.mem_cons_of_mem row hx

theorem exactSupport {R : Type} (rows : List (Decision R)) (x : Decision R) :
    x ∈ retained rows ↔ x ∈ rows ∧ x.stillAdmissible = true :=
  ⟨retainedOrigin rows x,fun h => allAdmissibleRetained rows x h.1 h.2⟩

theorem rejectedExcluded {R : Type} (rows : List (Decision R)) (x : Decision R)
    (rejected : x.stillAdmissible = false) : x ∉ retained rows := by
  intro member
  have h := (retainedOrigin rows x member).2
  rw [rejected] at h
  cases h

theorem completeAppend {R : Type} (a b : List (Decision R)) :
    retained (a++b) = retained a ++ retained b := by
  induction a with
  | nil => rfl
  | cons row rest ih =>
    cases h : row.stillAdmissible with
    | false => change retained (row::(rest++b)) = _; rw [retained,h,retained,h]; exact ih
    | true =>
      change retained (row::(rest++b)) = _
      rw [retained,h,retained,h,ih]
      rfl
end SFT.Physics.MeasurementUncertainty
