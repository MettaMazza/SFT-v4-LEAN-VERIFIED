import SFT.Materials.RotationClassification
import SFT.Materials.RotationCertificate
namespace SFT.Materials.RotationClosure
open RotationTotient RotationClassification RotationCertificate

theorem constrainedFormAdmitted (a b : Nat) (aBound : a≤2) (bBound : b≤1)
 (excluded : ¬(a=2 ∧ b=1)) : Allowed (2^a*3^b) := by
 cases a with
 | zero =>
   cases b with
   | zero => exact Or.inl rfl
   | succ b =>
     have eq : b=0 := Nat.eq_zero_of_le_zero (Nat.le_of_succ_le_succ bBound)
     cases eq; exact Or.inr (Or.inr (Or.inl rfl))
 | succ a =>
   cases a with
   | zero =>
     cases b with
     | zero => exact Or.inr (Or.inl rfl)
     | succ b =>
       have eq : b=0 := Nat.eq_zero_of_le_zero (Nat.le_of_succ_le_succ bBound)
       cases eq; exact Or.inr (Or.inr (Or.inr (Or.inr rfl)))
   | succ a =>
     have eq : a=0 := Nat.eq_zero_of_le_zero (Nat.le_of_succ_le_succ (Nat.le_of_succ_le_succ aBound))
     cases eq
     cases b with
     | zero => exact Or.inr (Or.inr (Or.inr (Or.inl rfl)))
     | succ b =>
       have eq : b=0 := Nat.eq_zero_of_le_zero (Nat.le_of_succ_le_succ bBound)
       cases eq
       exact False.elim (excluded ⟨rfl,rfl⟩)

theorem factorCertificateIff (n : PositiveCount) : crystallographicRotationAdmitted n = true ↔
 ∃ a b : Nat, n.val=2^a*3^b ∧ a≤2 ∧ b≤1 ∧ ¬(a=2 ∧ b=1) := by
 constructor
 · exact sourceFactorCertificate n
 · intro h
   obtain ⟨a,b,form,ab,bb,excluded⟩ := h
   apply (exactClassification n).mpr
   rw [form]
   exact constrainedFormAdmitted a b ab bb excluded

theorem allOriginalCandidatesAdmitted : candidates.all crystallographicRotationAdmitted = true := by
 apply (SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mpr
 intro c held
 apply (exactClassification c).mpr
 cases held with
 | head => exact Or.inl rfl
 | tail _ held =>
   cases held with
   | head => exact Or.inr (Or.inl rfl)
   | tail _ held =>
     cases held with
     | head => exact Or.inr (Or.inr (Or.inl rfl))
     | tail _ held =>
       cases held with
       | head => exact Or.inr (Or.inr (Or.inr (Or.inl rfl)))
       | tail _ held =>
         cases held with
         | head => exact Or.inr (Or.inr (Or.inr (Or.inr rfl)))
         | tail _ held => cases held

theorem allowedOrdersVerified : allowedCrystallographicOrders = .ok candidates :=
 guardedSuccess allOriginalCandidatesAdmitted

theorem originalCertificateVerified : rotationFactorCertificate = .ok {
 degreeBoundary := ⟨2,by decide⟩
 oddPrimeRule := "p divides order implies p-1 divides rotation degree; degree<=2 permits only odd prime 3"
 factorForm := "order=2^a*3^b"
 exponentConstraints := ["a<=2", "b<=1", "not(a=2 and b=1)"]
 survivors := [1,2,3,4,6]
 leastExcluded := ⟨5,by decide⟩ } := by
 unfold rotationFactorCertificate
 rw [allowedOrdersVerified]
 rfl

theorem fiveExcluded : crystallographicRotationAdmitted ⟨5,by decide⟩ = false := by
 cases eq : crystallographicRotationAdmitted ⟨5,by decide⟩ with
 | false => rfl
 | true =>
   have impossible := (exactClassification ⟨5,by decide⟩).mp eq
   exact False.elim ((by unfold Allowed; decide : ¬Allowed 5) impossible)

theorem allBeforeFiveAdmitted (n : PositiveCount) (before : n.val < 5) :
 crystallographicRotationAdmitted n = true := by
 apply (exactClassification n).mpr
 obtain ⟨n,positive⟩ := n
 cases n with
 | zero => cases positive
 | succ n =>
   cases n with
   | zero => exact Or.inl rfl
   | succ n =>
     cases n with
     | zero => exact Or.inr (Or.inl rfl)
     | succ n =>
       cases n with
       | zero => exact Or.inr (Or.inr (Or.inl rfl))
       | succ n =>
         cases n with
         | zero => exact Or.inr (Or.inr (Or.inr (Or.inl rfl)))
         | succ n =>
           have bound : 5 ≤ n+5 := Nat.le_add_left 5 n
           exact False.elim (Nat.not_lt_of_ge bound before)
end SFT.Materials.RotationClosure
