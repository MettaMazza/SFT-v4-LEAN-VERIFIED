import SFT.Physics.AlphaRatio
namespace SFT.Physics.AlphaDomain
open AlphaPromotion AlphaRatio GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000

theorem remainingBound (promoted remaining p r : Nat) (held : (p,r) ∈ stagesFrom promoted remaining) : r ≤ remaining := by
 induction remaining generalizing promoted with
 | zero => cases held with | head => exact Nat.le_refl _ | tail _ h => cases h
 | succ remaining ih => cases held with
   | head => exact Nat.le_refl _
   | tail _ h => exact Nat.le_trans (ih (promoted+1) h) (Nat.le_succ _)

theorem stagesUnique (promoted remaining : Nat) : (stagesFrom promoted remaining).Nodup := by
 induction remaining generalizing promoted with
 | zero => exact .cons (fun _ h => by cases h) .nil
 | succ remaining ih =>
   apply List.Pairwise.cons
   · intro pair member same
     cases same
     have impossible := remainingBound (promoted+1) remaining promoted (remaining+1) member
     exact Nat.not_succ_le_self remaining impossible
   · exact ih (promoted+1)

theorem aboveFourRejected (n : Nat) : effectiveCover (.integer (.ofNat (n+5))) =
 .error "ValueError: order must name a positive generated promotion rung" := by
 change (if n+5 > 4 then Except.error "ValueError: order must name a positive generated promotion rung" else _) = _
 rw [if_pos (Nat.lt_of_lt_of_le (by decide : 4 < 5) (Nat.le_add_left 5 n))]

theorem zeroRejected : effectiveCover (.integer 0) =
 .error "ValueError: order must name a positive generated promotion rung" := rfl

theorem negativeRejected (n : Nat) : effectiveCover (.integer (.negSucc n)) =
 .error "ValueError: order must name a positive generated promotion rung" := rfl

theorem booleanRejected (value : Bool) : effectiveCover (.boolean value) =
 .error "ValueError: order must name a positive generated promotion rung" := rfl

def succeeded {α : Type} : Except String α → Bool
 | .error _ => false
 | .ok _ => true

def admittedOrder : CountInput → Bool
 | .boolean _ => false
 | .integer (.negSucc _) => false
 | .integer (.ofNat n) => 0 < n && n ≤ 4

theorem exactOrderDomain (order : CountInput) : succeeded (effectiveCover order) = admittedOrder order := by
 cases order with
 | boolean value => rfl
 | integer value => cases value with
   | negSucc n => rfl
   | ofNat n =>
     cases n with
     | zero => rfl
     | succ n => cases n with
       | zero => rfl
       | succ n => cases n with
         | zero => rfl
         | succ n => cases n with
           | zero => rfl
           | succ n => cases n with
             | zero => rfl
             | succ n =>
               change succeeded (effectiveCover (.integer (.ofNat (n+5)))) = _
               rw [aboveFourRejected]
               have h : ¬ n+5 ≤ 4 := Nat.not_le_of_gt (Nat.lt_of_lt_of_le (by decide : 4 < 5) (Nat.le_add_left 5 n))
               change false = (decide (0 < n+5) && decide (n+5 ≤ 4))
               rw [decide_eq_false h]
               exact (Bool.and_false _).symm

end SFT.Physics.AlphaDomain
