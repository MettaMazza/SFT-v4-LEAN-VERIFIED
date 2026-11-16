import SFT.Mathematics.OrbitOrderIdentity
namespace SFT.Chemistry.ElectronCountSpin
open SFT.Foundation.FractionReduction SFT.Mathematics.OrbitOrderIdentity

-- Exact source construction: d = width−1 and p = (N−d)/2.
theorem generatedPairsExhaust (n d : Nat) (retained : d ≤ n) (even : (n-d)%2 = 0) :
 (n-d)/2*2+d = n := by
 have h := remainderQuotient (n-d) 2 (Nat.zero_lt_succ 1)
 rewrite [even,Nat.zero_add,Nat.mul_comm] at h
 exact Eq.trans (congrArg (fun x => x+d) h) (subtractAdd n d retained)

theorem pairCountUnique (n d p q : Nat) (hp : p*2+d=n) (hq : q*2+d=n) : p=q := by
 have h : p*2+d=q*2+d := Eq.trans hp hq.symm
 have left := addSubtractSame (p*2) 0 d
 have right := addSubtractSame (q*2) 0 d
 rewrite [Nat.zero_add,Nat.sub_zero] at left right
 have reduced := congrArg (fun x => x-d) h
 rewrite [left,right] at reduced
 exact Nat.eq_of_mul_eq_mul_right (Nat.zero_lt_succ 1) reduced

theorem widthRecoversUnmatched (d : Nat) : (d+1)-1=d := addSubtractSame d 0 1

theorem generatedPairCountUnique (n d p : Nat) (retained : d ≤ n) (even : (n-d)%2=0)
 (exhaustive : p*2+d=n) : p=(n-d)/2 :=
 pairCountUnique n d p ((n-d)/2) exhaustive (generatedPairsExhaust n d retained even)

theorem supportParity (p d : Nat) : (p*2+d)%2=d%2 := by
 rewrite [Nat.mul_comm p 2,Nat.add_comm (2*p) d]
 exact moduloAddMultiple d 2 p (Nat.zero_lt_succ 1)

theorem widthParity (p d : Nat) : (p*2+d+1)%2=(d+1)%2 := by
 rewrite [Nat.add_assoc]
 exact supportParity p (d+1)

theorem complementaryPairSuccessor (p d : Nat) : (p+1)*2+d=(p*2+d)+2 := by
 rewrite [Nat.succ_mul,Nat.add_assoc,Nat.add_comm 2 d,← Nat.add_assoc]
 rfl

theorem unmatchedSuccessor (p d : Nat) : p*2+(d+1)=(p*2+d)+1 := (Nat.add_assoc (p*2) d 1).symm

#print axioms generatedPairsExhaust
#print axioms pairCountUnique
#print axioms widthRecoversUnmatched
#print axioms generatedPairCountUnique
#print axioms supportParity
#print axioms widthParity
#print axioms complementaryPairSuccessor
#print axioms unmatchedSuccessor
end SFT.Chemistry.ElectronCountSpin
