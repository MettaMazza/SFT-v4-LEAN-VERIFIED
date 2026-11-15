import SFT.Physics.CompositeConfiningPairCount
namespace SFT.Physics.CompositeConfiningDerivation
open SFT.Foundation.FractionReduction SFT.Foundation.ExactCast
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalOddSupportShape (d : Nat) (odd : d%2=1) : d=2*(d/2)+1 := by
 have split := remainderQuotient d 2 (by decide)
 rw [odd] at split
 exact split.symm.trans (Nat.add_comm 1 _)
theorem originalPairHalfIdentity (d : Nat) (odd : d%2=1) : ((d+1)/2)-1=d/2 := by
 have minus : (d-1)/2=d/2 := by
  conv => lhs; rw [originalOddSupportShape d odd,addSubtract _ 1,divisionMultiple 2 _ (by decide)]
 exact (originalPairCountFormula d odd).trans minus
/-- Every original standing label occurs in one of the generated lower-half pairs. -/
theorem originalPairCoversLabel (d k : Nat) (odd : d%2=1) (kp : 0<k) (kb : k<d) :
 ∃ i, i<((d+1)/2)-1 ∧ (k=i+1 ∨ k=d-(i+1)) := by
 let h := d/2
 have shape : d=h+(h+1) := (originalOddSupportShape d odd).trans (by rw [Nat.two_mul,Nat.add_assoc])
 have count : ((d+1)/2)-1=h := originalPairHalfIdentity d odd
 by_cases lower : k≤h
 · refine ⟨k-1,?_,Or.inl ?_⟩
   · rw [count]
     exact Nat.lt_of_lt_of_le (Nat.sub_lt kp (by decide)) lower
   · exact (subtractAdd k 1 kp).symm
 · have later : h<k := Nat.lt_of_not_ge lower
   let c := d-k
   have complement := originalComplement d k kp kb
   have cBound : c<h+1 := by
    apply Nat.lt_of_add_lt_add_left
    calc
     h+c = c+h := Nat.add_comm h c
     _ < c+k := Nat.add_lt_add_left later c
     _ = d := (Nat.add_comm c k).trans complement.2.2
     _ = h+(h+1) := shape
   have cPositive : 0<c := complement.1
   refine ⟨c-1,?_,Or.inr ?_⟩
   · rw [count]
     exact Nat.lt_of_lt_of_le (Nat.sub_lt cPositive (by decide)) (Nat.le_of_lt_succ cBound)
   · rw [subtractAdd c 1 cPositive]
     exact (originalComplementInvolutive d k kb).symm
end SFT.Physics.CompositeConfiningDerivation
