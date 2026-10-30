import SFT.Mathematics.OrbitBinaryDepth
namespace SFT.Mathematics.OrbitCycleSupport
open OrbitOrderIdentity OrbitBinaryDepth
open SFT.Foundation.FractionReduction

/-- Two distinct positions before the first binary order cannot collide. -/
theorem noEarlierCollision (p q period i j : Nat) (hq : 0 < q) (odd : q%2 = 1)
 (reduced : Nat.gcd p q = 1) (first : FirstBinaryOrder q period)
 (earlier : i < j) (before : j < period) : rankIterate p q i ≠ rankIterate p q j := by
 intro same
 let gap := j-i
 have shape : j = i+gap :=
   (subtractAdd j i (Nat.le_of_lt earlier)).symm.trans (Nat.add_comm gap i)
 have positive : 0 < gap := by
   apply Nat.pos_of_ne_zero
   intro zero
   have collapsed : j = i := by rw [zero,Nat.add_zero] at shape; exact shape
   exact (Nat.ne_of_lt earlier) collapsed.symm
 have small : gap < period := Nat.lt_of_le_of_lt (Nat.sub_le j i) before
 have carrierReduced : Nat.gcd (p*2^i) q = 1 :=
   (gcdMultiplyReduced p q (2^i) hq reduced).trans (binaryPowerCoprimeOdd q i hq odd)
 have residues : (p*2^j)%q = (p*2^i)%q :=
   (iterationRemainder p q j hq).symm.trans
    ((congrArg (fun x => x%q) same.symm).trans (iterationRemainder p q i hq))
 rw [shape,powerAdd,← mulAssoc] at residues
 have returned := (binaryReturnIffOrder (p*2^i) q gap hq carrierReduced).mp residues
 exact first.2.2 gap positive small returned

theorem positionsInjective (p q period i j : Nat) (hq : 0 < q) (odd : q%2 = 1)
 (reduced : Nat.gcd p q = 1) (first : FirstBinaryOrder q period)
 (ib : i < period) (jb : j < period) (same : rankIterate p q i = rankIterate p q j) : i = j := by
 by_cases eq : i = j
 · exact eq
 · by_cases earlier : i < j
   · exact False.elim (noEarlierCollision p q period i j hq odd reduced first earlier jb same)
   · have later : j < i := Nat.lt_of_le_of_ne (Nat.le_of_not_gt earlier) (fun h => eq h.symm)
     exact False.elim (noEarlierCollision p q period j i hq odd reduced first later ib same.symm)

def cycleSupport (p q period : Nat) : List Nat := (List.range period).map (rankIterate p q)

theorem iterateAddition (p q a b : Nat) :
 rankIterate p q (a+b) = rankIterate (rankIterate p q a) q b := by
 induction b with
 | zero => rfl
 | succ b ih => exact congrArg (fun x => foldRank x q) ih

theorem periodicFromReturn (p q period k : Nat) (returned : rankIterate p q period = p) :
 rankIterate p q (period+k) = rankIterate p q k := by
 rw [iterateAddition,returned]

theorem everyReducedCyclePeriod (p q period k : Nat) (positive : 0 < p) (bound : p ≤ q)
 (reduced : Nat.gcd p q = 1) (first : FirstBinaryOrder q period) :
 rankIterate p q (period+k) = rankIterate p q k :=
 periodicFromReturn p q period k ((exactExecutedReturnIffOrder p q period positive bound reduced).mpr first.2.1)

theorem mappedLength {α β : Type} (f : α → β) (xs : List α) : (xs.map f).length = xs.length := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg Nat.succ ih

theorem rangeLoopLength (n : Nat) (acc : List Nat) : (List.range.loop n acc).length = n+acc.length := by
 induction n generalizing acc with
 | zero => exact (Nat.zero_add _).symm
 | succ n ih =>
   change (List.range.loop n (n::acc)).length = (n+1)+acc.length
   rw [ih]
   exact Nat.add_right_comm n acc.length 1

theorem completeCycleCardinality (p q period : Nat) : (cycleSupport p q period).length = period := by
 unfold cycleSupport
 rw [mappedLength]
 exact rangeLoopLength period []

end SFT.Mathematics.OrbitCycleSupport
