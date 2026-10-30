import SFT.Mathematics.ExactRatioRelations
namespace SFT.Mathematics.HoldingComplement
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
open ExactRatioRelations

/-- Positive holding complement: the source (m less One)-of-m part,
with m=k+2 expressing exactly the domain where that complement is positive. -/
def complement (k : Nat) : PositiveFraction :=
 ratio (k+1) (k+2) (Nat.zero_lt_succ k) (Nat.zero_lt_succ (k+1))

def Holds (k : Nat) (x : PositiveFraction) : Prop :=
 x.numerator*(k+2)+x.denominator=x.denominator*(k+2)

theorem complementValue (k : Nat) :
 (complement k).numerator*(k+2)=(k+1)*(complement k).denominator :=
 (ratioValue (k+1) (k+2) _ _).symm

theorem complementHolds (k : Nat) : Holds k (complement k) := by
 unfold Holds
 rw [complementValue,Nat.mul_comm (k+1) (complement k).denominator]
 exact (Nat.mul_succ (complement k).denominator (k+1)).symm

theorem holdingForcesValue (k : Nat) (x : PositiveFraction) (h : Holds k x) :
 x.numerator*(k+2)=(k+1)*x.denominator := by
 change x.numerator*(k+2)+x.denominator=x.denominator*(k+2) at h
 rw [Nat.mul_succ x.denominator (k+1)] at h
 have hs := congrArg (fun n => n-x.denominator) h
 have cancel (n d : Nat) : (n+d)-d=n := by
  have hh := addSubtractSame n 0 d
  rw [Nat.zero_add,Nat.sub_zero] at hh
  exact hh
 rw [cancel,cancel,Nat.mul_comm x.denominator (k+1)] at hs
 exact hs

theorem holdingUniqueValue (k : Nat) (x : PositiveFraction) (h : Holds k x) :
 x.numerator*(complement k).denominator=(complement k).numerator*x.denominator := by
 have hx := holdingForcesValue k x h
 have hc := complementValue k
 apply cancelPositive (k+2) _ _ (Nat.zero_lt_succ (k+1))
 calc
  (k+2)*(x.numerator*(complement k).denominator) =
    (x.numerator*(k+2))*(complement k).denominator := by rw [← mulAssoc,Nat.mul_comm (k+2) x.numerator]
  _ = ((k+1)*x.denominator)*(complement k).denominator := by rw [hx]
  _ = ((k+1)*(complement k).denominator)*x.denominator := by
    rw [mulAssoc,Nat.mul_comm x.denominator (complement k).denominator,← mulAssoc]
  _ = ((complement k).numerator*(k+2))*x.denominator := by rw [← hc]
  _ = (k+2)*((complement k).numerator*x.denominator) := by
    rw [Nat.mul_comm (complement k).numerator (k+2),mulAssoc]

theorem binaryComplement : (complement 0).numerator=1 ∧ (complement 0).denominator=2 := ⟨rfl,rfl⟩

#print axioms complement
#print axioms Holds
#print axioms complementValue
#print axioms complementHolds
#print axioms holdingForcesValue
#print axioms holdingUniqueValue
#print axioms binaryComplement
end SFT.Mathematics.HoldingComplement
