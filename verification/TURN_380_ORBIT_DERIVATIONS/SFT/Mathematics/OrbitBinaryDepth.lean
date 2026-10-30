import SFT.Mathematics.OrbitOrderIdentity
namespace SFT.Mathematics.OrbitBinaryDepth
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
open SFT.Foundation.ExactOperations OrbitOrderIdentity

theorem moduloOne (n : Nat) : n%1 = 0 := by
 induction n with
 | zero => rfl
 | succ n ih =>
   rw [moduloRemoves (n+1) 1 (by decide) (Nat.succ_le_succ (Nat.zero_le n))]
   exact ih

theorem gcdOneLeft (n : Nat) : Nat.gcd 1 n = 1 := by
 rw [gcdStep 1 n (by decide),moduloOne,gcdZero]

theorem dividesProduct (d p n : Nat) (divides : d ∣ n) : d ∣ p*n := by
 obtain ⟨k,hk⟩ := divides
 refine ⟨p*k,?_⟩
 rw [hk,← mulAssoc,Nat.mul_comm p d,mulAssoc]

theorem reducedWithDivisor (p q d : Nat) (reduced : Nat.gcd p q = 1)
 (divides : d ∣ q) : Nat.gcd p d = 1 := by
 have facts := gcdDivides p d
 obtain ⟨k,hk⟩ := divides
 have through : Nat.gcd p d ∣ q := by
   rw [hk,Nat.mul_comm d k]
   exact dividesProduct _ _ _ facts.2
 have one := commonDivisorDividesGcd (Nat.gcd p d) p q facts.1 through
 rw [reduced] at one
 obtain ⟨k,hk⟩ := one
 exact factorOfOne _ k hk.symm

theorem gcdMultiplyReduced (p q n : Nat) (hq : 0 < q)
 (reduced : Nat.gcd p q = 1) : Nat.gcd (p*n) q = Nat.gcd n q := by
 let g := Nat.gcd (p*n) q
 let d := Nat.gcd n q
 have gf := gcdDivides (p*n) q
 have df := gcdDivides n q
 have reducedG : Nat.gcd p g = 1 := reducedWithDivisor p q g reduced gf.2
 have gN : g ∣ n := cancelReducedFactor p g n (gcdPositive (p*n) q hq) reducedG gf.1
 have gD : g ∣ d := commonDivisorDividesGcd g n q gN gf.2
 have dG : d ∣ g := commonDivisorDividesGcd d (p*n) q (dividesProduct d p n df.1) df.2
 exact Nat.le_antisymm (divisorBound g d (gcdPositive n q hq) gD)
   (divisorBound d g (gcdPositive (p*n) q hq) dG)

theorem binaryCoprimeOdd (m : Nat) (odd : m%2 = 1) : Nat.gcd 2 m = 1 := by
 rw [gcdStep 2 m (by decide),odd]
 rfl

theorem binaryPowerCoprimeOdd (m k : Nat) (hm : 0 < m) (odd : m%2 = 1) :
 Nat.gcd (2^k) m = 1 := by
 induction k with
 | zero => exact gcdOneLeft m
 | succ k ih =>
   rw [Nat.pow_succ,Nat.mul_comm (2^k) 2,
     gcdMultiplyReduced 2 m (2^k) hm (binaryCoprimeOdd m odd),ih]

theorem powerAdd (a b : Nat) : 2^(a+b) = 2^a*2^b := by
 induction b with
 | zero => exact (Nat.mul_one _).symm
 | succ b ih =>
   change 2^((a+b)+1) = 2^a*2^(b+1)
   rw [Nat.pow_succ,ih,Nat.pow_succ,mulAssoc]

theorem gcdAtBinaryDepth (p m a : Nat) (hm : 0 < m)
 (reduced : Nat.gcd p (2^a*m) = 1) :
 Nat.gcd (p*2^a) (2^a*m) = 2^a := by
 have hp : 0 < 2^a := Nat.pow_pos (by decide)
 rw [gcdMultiplyReduced p (2^a*m) (2^a) (Nat.mul_pos hp hm) reduced]
 calc
   Nat.gcd (2^a) (2^a*m) = Nat.gcd (2^a*1) (2^a*m) := congrArg (fun x => Nat.gcd x (2^a*m)) (Nat.mul_one (2^a)).symm
   _ = 2^a*Nat.gcd 1 m := gcdScale (2^a) 1 m hp
   _ = 2^a := by rw [gcdOneLeft,Nat.mul_one]

theorem gcdAfterBinaryDepth (p m a k : Nat) (hm : 0 < m) (odd : m%2 = 1)
 (reduced : Nat.gcd p (2^a*m) = 1) :
 Nat.gcd (p*2^(a+k)) (2^a*m) = 2^a := by
 have hp : 0 < 2^a := Nat.pow_pos (by decide)
 rw [gcdMultiplyReduced p (2^a*m) (2^(a+k)) (Nat.mul_pos hp hm) reduced,
   powerAdd,gcdScale (2^a) (2^k) m hp,binaryPowerCoprimeOdd m k hm odd,Nat.mul_one]

theorem denominatorAtBinaryDepth (p m a : Nat) (pp : 0 < p) (hm : 0 < m)
 (reduced : Nat.gcd p (2^a*m) = 1) :
 (normalizePositive (p*2^a) (2^a*m) (Nat.mul_pos pp (Nat.pow_pos (by decide)))
   (Nat.mul_pos (Nat.pow_pos (by decide)) hm)).denominator = m := by
 change (2^a*m)/Nat.gcd (p*2^a) (2^a*m) = m
 rw [gcdAtBinaryDepth p m a hm reduced]
 exact divisionMultiple (2^a) m (Nat.pow_pos (by decide))

theorem denominatorAfterBinaryDepth (p m a k : Nat) (pp : 0 < p) (hm : 0 < m)
 (odd : m%2 = 1) (reduced : Nat.gcd p (2^a*m) = 1) :
 (normalizePositive (p*2^(a+k)) (2^a*m) (Nat.mul_pos pp (Nat.pow_pos (by decide)))
   (Nat.mul_pos (Nat.pow_pos (by decide)) hm)).denominator = m := by
 change (2^a*m)/Nat.gcd (p*2^(a+k)) (2^a*m) = m
 rw [gcdAfterBinaryDepth p m a k hm odd reduced]
 exact divisionMultiple (2^a) m (Nat.pow_pos (by decide))

theorem denominatorBeforeBinaryDepth (p m k rest : Nat) (pp : 0 < p) (hm : 0 < m)
 (reduced : Nat.gcd p (2^(k+rest)*m) = 1) :
 (normalizePositive (p*2^k) (2^(k+rest)*m) (Nat.mul_pos pp (Nat.pow_pos (by decide)))
   (Nat.mul_pos (Nat.pow_pos (by decide)) hm)).denominator = 2^rest*m := by
 change (2^(k+rest)*m)/Nat.gcd (p*2^k) (2^(k+rest)*m) = 2^rest*m
 rw [powerAdd,mulAssoc] at reduced ⊢
 rw [gcdAtBinaryDepth p (2^rest*m) k (Nat.mul_pos (Nat.pow_pos (by decide)) hm) reduced]
 exact divisionMultiple (2^k) (2^rest*m) (Nat.pow_pos (by decide))

theorem gcdRemainder (a q : Nat) (hq : 0 < q) : Nat.gcd a q = Nat.gcd (a%q) q := by
 let g := Nat.gcd a q
 let d := Nat.gcd (a%q) q
 have gf := gcdDivides a q
 have df := gcdDivides (a%q) q
 have left := commonDivisorDividesGcd g (a%q) q (dividesRemainder hq gf.1 gf.2) gf.2
 have dA : d ∣ a := by
   obtain ⟨r,hr⟩ := df.1
   obtain ⟨t,ht⟩ := df.2
   refine ⟨r+t*(a/q),?_⟩
   calc
     a = a%q+q*(a/q) := (remainderQuotient a q hq).symm
     _ = d*r+(d*t)*(a/q) := (congrArg (fun x => x+q*(a/q)) hr).trans
       (congrArg (fun x => d*r+x*(a/q)) ht)
     _ = d*(r+t*(a/q)) := by rw [Nat.mul_add,mulAssoc]
 have right := commonDivisorDividesGcd d a q dA df.2
 exact Nat.le_antisymm (divisorBound g d (gcdPositive (a%q) q hq) left)
   (divisorBound d g (gcdPositive a q hq) right)

theorem sameRemainderSameGcd (a b q : Nat) (hq : 0 < q) (same : a%q = b%q) :
 Nat.gcd a q = Nat.gcd b q :=
 (gcdRemainder a q hq).trans ((congrArg (fun x => Nat.gcd x q) same).trans (gcdRemainder b q hq).symm)

def executedDenominator (p q k : Nat) : Nat := q/Nat.gcd (rankIterate p q k) q

theorem executedDenominatorFormula (p q k : Nat) (hq : 0 < q) :
 executedDenominator p q k = q/Nat.gcd (p*2^k) q := by
 unfold executedDenominator
 rw [sameRemainderSameGcd _ _ q hq (iterationRemainder p q k hq)]

theorem executedDenominatorAtDepth (p m a : Nat) (hm : 0 < m)
 (reduced : Nat.gcd p (2^a*m) = 1) : executedDenominator p (2^a*m) a = m := by
 rw [executedDenominatorFormula _ _ _ (Nat.mul_pos (Nat.pow_pos (by decide)) hm),
   gcdAtBinaryDepth p m a hm reduced]
 exact divisionMultiple (2^a) m (Nat.pow_pos (by decide))

theorem executedDenominatorAfterDepth (p m a k : Nat) (hm : 0 < m) (odd : m%2 = 1)
 (reduced : Nat.gcd p (2^a*m) = 1) : executedDenominator p (2^a*m) (a+k) = m := by
 rw [executedDenominatorFormula _ _ _ (Nat.mul_pos (Nat.pow_pos (by decide)) hm),
   gcdAfterBinaryDepth p m a k hm odd reduced]
 exact divisionMultiple (2^a) m (Nat.pow_pos (by decide))

theorem executedDenominatorBeforeDepth (p m k rest : Nat) (hm : 0 < m)
 (reduced : Nat.gcd p (2^(k+rest)*m) = 1) :
 executedDenominator p (2^(k+rest)*m) k = 2^rest*m := by
 rw [executedDenominatorFormula _ _ _ (Nat.mul_pos (Nat.pow_pos (by decide)) hm)]
 rw [powerAdd,mulAssoc] at reduced ⊢
 rw [gcdAtBinaryDepth p (2^rest*m) k (Nat.mul_pos (Nat.pow_pos (by decide)) hm) reduced]
 exact divisionMultiple (2^k) (2^rest*m) (Nat.pow_pos (by decide))

theorem positiveRemainingDepthEven (m rest : Nat) : (2^(rest+1)*m)%2 = 0 := by
 rw [Nat.pow_succ,Nat.mul_comm (2^rest) 2,mulAssoc]
 have h := moduloAddMultiple 0 2 (2^rest*m) (by decide)
 rw [Nat.zero_add] at h
 exact h

theorem exactBinaryTransient (p m k rest : Nat) (hm : 0 < m) (odd : m%2 = 1)
 (reduced : Nat.gcd p (2^(k+(rest+1))*m) = 1) :
 (executedDenominator p (2^(k+(rest+1))*m) k)%2 = 0 ∧
 (executedDenominator p (2^(k+(rest+1))*m) (k+(rest+1)))%2 = 1 := by
 constructor
 · rw [executedDenominatorBeforeDepth p m k (rest+1) hm reduced]
   exact positiveRemainingDepthEven m rest
 · rw [executedDenominatorAtDepth p m (k+(rest+1)) hm reduced]
   exact odd

theorem actualNormalizedDenominator (p q k : Nat) (positive : 0 < p) (bound : p ≤ q) :
 (normalizePart (rankIterate p q k) q (iterateBounds p q k positive bound).1
   (iterateBounds p q k positive bound).2).denominator = executedDenominator p q k := rfl

theorem firstOddDenominatorAtDepth (p m a : Nat) (hm : 0 < m) (odd : m%2 = 1)
 (reduced : Nat.gcd p (2^a*m) = 1) :
 (executedDenominator p (2^a*m) a)%2 = 1 ∧
 (∀ k, k < a → (executedDenominator p (2^a*m) k)%2 = 0) ∧
 (∀ k, executedDenominator p (2^a*m) (a+k) = m) := by
 refine ⟨?_,?_,?_⟩
 · rw [executedDenominatorAtDepth p m a hm reduced]
   exact odd
 · intro k before
   let rest := a-(k+1)
   have form : a = k+(rest+1) := by
     calc
       a = rest+(k+1) := (subtractAdd a (k+1) before).symm
       _ = k+(rest+1) := by rw [← Nat.add_assoc,Nat.add_comm rest k,Nat.add_assoc]
   have h := exactBinaryTransient p m k rest hm odd (by rw [← form]; exact reduced)
   rw [← form] at h
   exact h.1
 · intro k
   exact executedDenominatorAfterDepth p m a k hm odd reduced

end SFT.Mathematics.OrbitBinaryDepth
