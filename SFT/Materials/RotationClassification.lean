import SFT.Materials.RotationSmallDegrees
namespace SFT.Materials.RotationClassification
open RotationTotient RotationCoprime RotationFactorPrimality RotationFactors RotationFactorDivisibility
open RotationFactorDegree RotationDegreeProduct RotationSmallDegrees SFT.Foundation.FractionReduction

def Allowed (n : Nat) : Prop := n=1 ∨ n=2 ∨ n=3 ∨ n=4 ∨ n=6

theorem admittedClassification (n : Nat) (hn : 0 < n)
 (admitted : crystallographicRotationAdmitted ⟨n,hn⟩ = true) : Allowed n := by
 induction n using Nat.strongRecOn with
 | ind n ih =>
   by_cases one : n=1
   · rw [one]; exact Or.inl rfl
   · have above : 1 < n := Nat.lt_of_le_of_ne hn (fun eq => one eq.symm)
     obtain ⟨p,prime,divides⟩ := primeDivisorExists n above
     have hp := Nat.lt_trans (by decide : 0 < 1) prime.1
     have positive := quotientPositive n p hn hp divides
     have factor := quotientFactor n p hp divides
     have before := quotientSmaller n p hn prime.1 (zeroRemainderOfDivides p n hp divides)
     let m : PositiveCount := ⟨n/p,positive⟩
     have same : productOrder p prime m = (⟨n,hn⟩ : PositiveCount) := Subtype.ext factor.symm
     have bound := divisorDegreeBound p prime m
     rw [same] at bound
     have small := (admittedDegree ⟨n,hn⟩).mp admitted
     change (totientCount ⟨n,hn⟩).val ≤ 2 at small
     have madmitted : crystallographicRotationAdmitted m = true :=
       (admittedDegree m).mpr (Nat.le_trans bound small)
     have prior := ih (n/p) before positive madmitted
     have choices := admittedFactorTwoOrThree ⟨n,hn⟩ admitted p prime divides
     cases choices with
     | inl two =>
       cases two
       rcases prior with a | b | c | d | e
       · rw [a] at factor; rw [factor]; exact Or.inr (Or.inl rfl)
       · rw [b] at factor; rw [factor]; exact Or.inr (Or.inr (Or.inr (Or.inl rfl)))
       · rw [c] at factor; rw [factor]; exact Or.inr (Or.inr (Or.inr (Or.inr rfl)))
       · rw [d] at factor
         have eq : (totientCount ⟨n,hn⟩).val = 4 := by cases factor; exact degreeEight
         rw [eq] at small
         exact False.elim ((by decide : ¬ 4 ≤ 2) small)
       · rw [e] at factor
         have eq : (totientCount ⟨n,hn⟩).val = 4 := by cases factor; exact degreeTwelve
         rw [eq] at small
         exact False.elim ((by decide : ¬ 4 ≤ 2) small)
     | inr three =>
       cases three
       rcases prior with a | b | c | d | e
       · rw [a] at factor; rw [factor]; exact Or.inr (Or.inr (Or.inl rfl))
       · rw [b] at factor; rw [factor]; exact Or.inr (Or.inr (Or.inr (Or.inr rfl)))
       · rw [c] at factor
         have eq : (totientCount ⟨n,hn⟩).val = 6 := by cases factor; exact degreeNine
         rw [eq] at small
         exact False.elim ((by decide : ¬ 6 ≤ 2) small)
       · rw [d] at factor
         have eq : (totientCount ⟨n,hn⟩).val = 4 := by cases factor; exact degreeTwelve
         rw [eq] at small
         exact False.elim ((by decide : ¬ 4 ≤ 2) small)
       · rw [e] at factor
         have eq : (totientCount ⟨n,hn⟩).val = 6 := by cases factor; exact degreeEighteen
         rw [eq] at small
         exact False.elim ((by decide : ¬ 6 ≤ 2) small)

theorem exactClassification (n : PositiveCount) :
 crystallographicRotationAdmitted n = true ↔ Allowed n.val := by
 constructor
 · exact admittedClassification n.val n.property
 · intro h
   apply (admittedDegree n).mpr
   change (totientCount n).val ≤ 2
   obtain ⟨n,hn⟩ := n
   rcases h with one | two | three | four | six
   · cases one; rw [degreeOne]; decide
   · cases two; rw [degreeTwo]; decide
   · cases three; rw [degreeThree]; decide
   · cases four; rw [degreeFour]; decide
   · cases six; rw [degreeSix]; decide

theorem sourceFactorCertificate (n : PositiveCount) (admitted : crystallographicRotationAdmitted n = true) :
 ∃ a b : Nat, n.val=2^a*3^b ∧ a≤2 ∧ b≤1 ∧ ¬(a=2 ∧ b=1) := by
 have h := (exactClassification n).mp admitted
 rcases h with one | two | three | four | six
 · exact ⟨0,0,one,by decide,by decide,by decide⟩
 · exact ⟨1,0,two,by decide,by decide,by decide⟩
 · exact ⟨0,1,three,by decide,by decide,by decide⟩
 · exact ⟨2,0,four,by decide,by decide,by decide⟩
 · exact ⟨1,1,six,by decide,by decide,by decide⟩
end SFT.Materials.RotationClassification
