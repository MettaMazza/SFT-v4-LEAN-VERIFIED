import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Mathematics.ExactTraceRemainder
open ExactTraceArithmetic

theorem remainderNonempty (left right : Trace) : (orientedRemainder left right).2.isEmpty = false := by
  unfold orientedRemainder
  cases left.filter (fun a => !contains right a) <;>
    cases right.filter (fun a => !contains left a) <;> rfl

theorem sameFormIffNoUnmatched (left right : Trace) :
    (orientedRemainder left right).1 = "same-form" ↔
    left.filter (fun a => !contains right a) = [] ∧ right.filter (fun a => !contains left a) = [] := by
  unfold orientedRemainder
  cases left.filter (fun a => !contains right a) with
  | nil => cases right.filter (fun a => !contains left a) with
    | nil => exact ⟨fun _ => ⟨rfl,rfl⟩,fun _ => rfl⟩
    | cons b bs =>
      constructor
      · intro h
        exact False.elim ((by decide : "right-held" ≠ "same-form") h)
      · intro h
        cases h.2
  | cons a as => cases right.filter (fun a => !contains left a) with
    | nil =>
      constructor
      · intro h
        exact False.elim ((by decide : "left-held" ≠ "same-form") h)
      · intro h
        cases h.1
    | cons b bs =>
      constructor
      · intro h
        exact False.elim ((by decide : "incomparable-held" ≠ "same-form") h)
      · intro h
        cases h.1

theorem sameFormRetainsEmptyOne (left right : Trace)
    (h : (orientedRemainder left right).1 = "same-form") :
    (orientedRemainder left right).2 = [["empty-One"]] := by
  have none := (sameFormIffNoUnmatched left right).mp h
  unfold orientedRemainder
  rw [none.1,none.2]
  rfl

end SFT.Mathematics.ExactTraceRemainder
