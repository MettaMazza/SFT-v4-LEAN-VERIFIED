import SFT.Physics.RunningConvergence
import SFT.Foundation.ExactValueIdentity
import SFT.Mathematics.ExactRatioRelations
namespace SFT.Physics.MagneticSquare
open SFT.Foundation FractionReduction ExactValueIdentity

-- The squared rational speed cannot land on the half-One Fold boundary.
private theorem binaryForms (n : Nat) : ∃ k,n=2*k ∨ n=2*k+1 := by
 induction n with
 | zero => exact ⟨0,Or.inl rfl⟩
 | succ n ih =>
  obtain ⟨k,h⟩ := ih
  cases h with
  | inl even => exact ⟨k,Or.inr (congrArg Nat.succ even)⟩
  | inr odd =>
   refine ⟨k+1,Or.inl ?_⟩
   rw [Nat.mul_succ]
   exact congrArg Nat.succ odd

private theorem twoStepRemainder (n : Nat) : (n+2)%2=n%2 := by
 rw [moduloRemoves (n+2) 2 (by decide) (Nat.le_add_left 2 n)]
 rw [Nat.add_comm n 2,RunningConvergence.addSubtractLeft]

private theorem evenRemainder (k : Nat) : (2*k)%2=0 := by
 induction k with
 | zero => rfl
 | succ k ih => rw [Nat.mul_succ,twoStepRemainder,ih]

private theorem oddRemainder (k : Nat) : (2*k+1)%2=1 := by
 induction k with
 | zero => rfl
 | succ k ih =>
  rw [Nat.mul_succ,Nat.add_right_comm (2*k) 2 1,twoStepRemainder,ih]

private theorem oddSquare (k : Nat) : (2*k+1)*(2*k+1)=2*(2*k*k+k+k)+1 := by
 have product : (2*k)*(2*k)=2*(2*k*k) := by
  rw [mulAssoc,Nat.mul_comm k (2*k)]
 rw [Nat.mul_add,Nat.mul_one,Nat.mul_comm (2*k+1) (2*k),Nat.mul_add,Nat.mul_one,product]
 rw [Nat.mul_add,Nat.mul_add]
 conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
 conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]

private theorem squareEvenForcesEven (d n : Nat) (equation : d*d=2*n) : ∃ k,d=2*k := by
 obtain ⟨k,h⟩ := binaryForms d
 cases h with
 | inl even => exact ⟨k,even⟩
 | inr odd =>
  rw [odd,oddSquare] at equation
  have impossible := congrArg (fun x => x%2) equation
  rw [oddRemainder,evenRemainder] at impossible
  cases impossible

theorem noHalfSquare (d : Nat) : ∀ n,0<n → d*d≠2*(n*n) := by
 induction d using Nat.strongRecOn with
 | ind d ih =>
  intro n positive equation
  obtain ⟨k,hk⟩ := squareEvenForcesEven d (n*n) equation
  have reduced : n*n=2*(k*k) := by
   rw [hk] at equation
   have arranged : (2*k)*(2*k)=2*(2*(k*k)) := by
    rw [mulAssoc,Nat.mul_comm k (2*k),mulAssoc]
   rw [arranged] at equation
   exact (SFT.Mathematics.ExactRatioRelations.cancelPositive 2 _ _ (by decide) equation).symm
  have smaller : n<d := by
   apply Nat.lt_of_not_ge
   intro bound
   have squares := Nat.mul_le_mul bound bound
   have greater : n*n<2*(n*n) := by
    rw [Nat.mul_comm 2 (n*n),Nat.mul_succ,Nat.mul_one]
    exact Nat.lt_add_of_pos_right (Nat.mul_pos positive positive)
   rw [equation] at squares
   exact Nat.not_le_of_gt greater squares
  have kp : 0<k := by
   cases k with
   | zero =>
    rw [hk] at smaller
    exact False.elim (Nat.not_lt_zero _ smaller)
   | succ k => exact Nat.zero_lt_succ _
  exact ih n smaller k kp reduced
end SFT.Physics.MagneticSquare
