import SFT.Chemistry.GBlockTraversal
namespace SFT.Chemistry.GBlockFilling
open GBlockOperations SFT.Physics

def occupationTotal : List OccupiedSubshell → Nat
 | [] => 0
 | x::xs => x.occupied + occupationTotal xs

theorem acceptedRowOccupation (p o n c : Nat) (row : OccupiedSubshell)
 (accepted : occupiedSubshell (.integer (.ofNat p)) (.integer (.ofNat o))
   (.integer (.ofNat n)) (.integer (.ofNat c)) = .ok row) : row.occupied=n := by
 cases p <;> cases o <;> cases n <;> cases c <;> try cases accepted
 rename_i p o n c
 change (if (decide (o+1>p+1) || decide (n+1>c+1)) then
   Except.error "ValueError: occupied subshell lies outside its generated support"
   else Except.ok (OccupiedSubshell.mk (p+1) (o+1) (n+1) (c+1))) = .ok row at accepted
 cases h : (decide (o+1>p+1) || decide (n+1>c+1)) with
 | false => rw [h] at accepted; cases accepted; rfl
 | true => rw [h] at accepted; cases accepted

theorem chosenOccupationWithinRemaining (remaining capacity : Nat) :
 (if remaining>capacity then capacity else remaining) ≤ remaining := by
 by_cases greater : remaining>capacity
 · rw [ite_eq_left greater]; exact Nat.le_of_lt greater
 · rw [ite_eq_right greater]; exact Nat.le_refl _

theorem successfulFillConserves (cells : List (Nat × Nat)) (remaining : Nat)
 (rows : List OccupiedSubshell) (filled : fillOn cells remaining = .ok rows) :
 occupationTotal rows = remaining := by
 induction cells generalizing remaining rows with
 | nil => cases filled
 | cons cell cells ih =>
   obtain ⟨p,o⟩ := cell
   cases cap : AtomicOrbitCapacity.orbitCapacity (.integer (.ofNat o)) with
   | error e => rw [fillOn,cap] at filled; cases filled
   | ok capacity =>
     let chosen := if remaining>capacity then capacity else remaining
     cases rowResult : occupiedSubshell (.integer (.ofNat p)) (.integer (.ofNat o))
       (.integer (.ofNat chosen)) (.integer (.ofNat capacity)) with
     | error e =>
       rw [fillOn,cap] at filled
       change (Except.bind (occupiedSubshell (.integer (.ofNat p)) (.integer (.ofNat o)) (.integer (.ofNat chosen)) (.integer (.ofNat capacity)))
         (fun row => if remaining-chosen == 0 then Except.ok [row]
         else Except.bind (fillOn cells (remaining-chosen)) (fun later => Except.ok (row::later)))) = .ok rows at filled
       rw [rowResult] at filled
       cases filled
     | ok row =>
       have same := acceptedRowOccupation p o chosen capacity row rowResult
       rw [fillOn,cap] at filled
       change (Except.bind (occupiedSubshell (.integer (.ofNat p)) (.integer (.ofNat o)) (.integer (.ofNat chosen)) (.integer (.ofNat capacity)))
         (fun row => if remaining-chosen == 0 then Except.ok [row]
         else Except.bind (fillOn cells (remaining-chosen)) (fun later => Except.ok (row::later)))) = .ok rows at filled
       rw [rowResult] at filled
       change (if remaining-chosen == 0 then Except.ok [row]
         else do let later ← fillOn cells (remaining-chosen); Except.ok (row::later)) = .ok rows at filled
       have conservation : chosen+(remaining-chosen)=remaining := by
         rw [Nat.add_comm]
         exact SFT.Foundation.FractionReduction.subtractAdd remaining chosen (chosenOccupationWithinRemaining remaining capacity)
       cases exhausted : (remaining-chosen == 0) with
       | true =>
         rw [exhausted] at filled
         cases filled
         change row.occupied+0=remaining
         rw [same,←(Nat.eq_of_beq_eq_true exhausted)]
         exact conservation
       | false =>
         rw [exhausted] at filled
         cases later : fillOn cells (remaining-chosen) with
         | error e => rw [later] at filled; cases filled
         | ok suffix =>
           rw [later] at filled
           cases filled
           change row.occupied+occupationTotal suffix=remaining
           rw [same,ih (remaining-chosen) suffix later]
           exact conservation

theorem configurationConserves (n : Nat) (rows : List OccupiedSubshell)
 (accepted : fillConfiguration (.integer (.ofNat n)) = .ok rows) : occupationTotal rows=n := by
 cases n with
 | zero => cases accepted
 | succ n =>
   change (do let cells ← endpointSupport; fillOn cells (n+1)) = .ok rows at accepted
   cases support : endpointSupport with
   | error e => rw [support] at accepted; cases accepted
   | ok cells =>
     rw [support] at accepted
     exact successfulFillConserves cells (n+1) rows accepted

theorem acceptedRowExact (p o n c : Nat) (row : OccupiedSubshell)
 (accepted : occupiedSubshell (.integer (.ofNat p)) (.integer (.ofNat o))
   (.integer (.ofNat n)) (.integer (.ofNat c)) = .ok row) :
 row = ⟨p,o,n,c⟩ ∧ 0<p ∧ 0<o ∧ 0<n ∧ 0<c ∧ o≤p ∧ n≤c := by
 cases p <;> cases o <;> cases n <;> cases c <;> try cases accepted
 rename_i p o n c
 change (if (decide (o+1>p+1) || decide (n+1>c+1)) then
   Except.error "ValueError: occupied subshell lies outside its generated support"
   else Except.ok (OccupiedSubshell.mk (p+1) (o+1) (n+1) (c+1))) = .ok row at accepted
 cases ho : decide (o+1>p+1) with
 | true => rw [ho] at accepted; cases accepted
 | false =>
   cases hn : decide (n+1>c+1) with
   | true => rw [ho,hn] at accepted; cases accepted
   | false =>
     rw [ho,hn] at accepted
     cases accepted
     exact ⟨rfl,Nat.zero_lt_succ _,Nat.zero_lt_succ _,Nat.zero_lt_succ _,Nat.zero_lt_succ _,
       Nat.le_of_not_gt (of_decide_eq_false ho),Nat.le_of_not_gt (of_decide_eq_false hn)⟩
end SFT.Chemistry.GBlockFilling

