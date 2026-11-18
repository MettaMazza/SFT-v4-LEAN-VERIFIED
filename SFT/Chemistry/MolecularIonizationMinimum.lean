import SFT.Chemistry.MolecularIonization
namespace SFT.Chemistry.MolecularIonizationMinimum
open SFT.Chemistry.DihedralTorsion SFT.Chemistry.MolecularIonization
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
-- Cross multiplication is the source Fraction comparison on positive denominators.
private theorem ratioOrderTrans (a b c : Ratio)
 (ab : a.numerator.value*b.denominator.value ≤ b.numerator.value*a.denominator.value)
 (bc : b.numerator.value*c.denominator.value ≤ c.numerator.value*b.denominator.value) :
 a.numerator.value*c.denominator.value ≤ c.numerator.value*a.denominator.value := by
 have h1 := Nat.mul_le_mul_right c.denominator.value ab
 have h2 := Nat.mul_le_mul_right a.denominator.value bc
 have middle : b.numerator.value*a.denominator.value*c.denominator.value =
  b.numerator.value*c.denominator.value*a.denominator.value := by
  exact (SFT.Foundation.FractionReduction.mulAssoc b.numerator.value a.denominator.value c.denominator.value).trans
   ((congrArg (fun t => b.numerator.value*t) (Nat.mul_comm a.denominator.value c.denominator.value)).trans
    (SFT.Foundation.FractionReduction.mulAssoc b.numerator.value c.denominator.value a.denominator.value).symm)
 rw [middle] at h1
 have h := Nat.le_trans h1 h2
 have left : a.numerator.value*b.denominator.value*c.denominator.value =
  (a.numerator.value*c.denominator.value)*b.denominator.value := by
  exact (SFT.Foundation.FractionReduction.mulAssoc a.numerator.value b.denominator.value c.denominator.value).trans
   ((congrArg (fun t => a.numerator.value*t) (Nat.mul_comm b.denominator.value c.denominator.value)).trans
    (SFT.Foundation.FractionReduction.mulAssoc a.numerator.value c.denominator.value b.denominator.value).symm)
 have right : c.numerator.value*b.denominator.value*a.denominator.value =
  (c.numerator.value*a.denominator.value)*b.denominator.value := by
  exact (SFT.Foundation.FractionReduction.mulAssoc c.numerator.value b.denominator.value a.denominator.value).trans
   ((congrArg (fun t => c.numerator.value*t) (Nat.mul_comm b.denominator.value a.denominator.value)).trans
    (SFT.Foundation.FractionReduction.mulAssoc c.numerator.value a.denominator.value b.denominator.value).symm)
 rw [left,right] at h
 exact Nat.le_of_mul_le_mul_right h b.denominator.positive

theorem leastTakeBelongsToCompleteSupport (first : Ratio) (rest : List Ratio) :
 leastTakeFrom first rest ∈ first::rest := by
 induction rest generalizing first with
 | nil => exact List.Mem.head _
 | cons next rest ih =>
  unfold leastTakeFrom
  cases h : ratioLess next first with
  | true =>
   change leastTakeFrom next rest ∈ first::next::rest
   exact List.Mem.tail _ (ih next)
  | false =>
   change leastTakeFrom first rest ∈ first::next::rest
   have insert : ∀ x : Ratio, x ∈ first::rest → x ∈ first::next::rest := by
    intro x member
    cases member with
    | head => exact List.Mem.head _
    | tail _ inside => exact List.Mem.tail _ (List.Mem.tail _ inside)
   exact insert _ (ih first)

theorem leastTakeNotAboveAnyMember (first : Ratio) (rest : List Ratio) (member : Ratio)
 (included : member ∈ first::rest) :
 (leastTakeFrom first rest).numerator.value*member.denominator.value ≤
 member.numerator.value*(leastTakeFrom first rest).denominator.value := by
 induction rest generalizing first member with
 | nil => cases included with
   | head => exact Nat.le_refl _
   | tail _ impossible => cases impossible
 | cons next rest ih =>
  cases choice : ratioLess next first with
  | true =>
   have selected : leastTakeFrom first (next::rest)=leastTakeFrom next rest := by
    change leastTakeFrom (if ratioLess next first then next else first) rest = leastTakeFrom next rest
    rw [if_pos choice]
   rw [selected]
   cases included with
   | head =>
    apply ratioOrderTrans _ next first (ih next next (List.Mem.head _))
    exact Nat.le_of_lt (of_decide_eq_true choice)
   | tail _ memberIn => exact ih next member memberIn
  | false =>
   have selected : leastTakeFrom first (next::rest)=leastTakeFrom first rest := by
    change leastTakeFrom (if ratioLess next first then next else first) rest = leastTakeFrom first rest
    rw [if_neg (fun h => Bool.noConfusion (choice.symm.trans h))]
   rw [selected]
   cases included with
   | head => exact ih first first (List.Mem.head _)
   | tail _ memberIn => cases memberIn with
    | head =>
     apply ratioOrderTrans _ first next (ih first first (List.Mem.head _))
     exact Nat.le_of_not_gt (of_decide_eq_false choice)
    | tail _ memberRest => exact ih first member (List.Mem.tail _ memberRest)
end SFT.Chemistry.MolecularIonizationMinimum
