import SFT.Foundation.FoldFibres
namespace SFT.Mathematics.FiniteRefinement
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.FoldDynamics SFT.Foundation.FoldFibres

def rung : Nat → Part
 | 0 => one
 | n+1 => lowerPreimage (rung n)

def run : Nat → Part → Part
 | 0,p => p
 | n+1,p => run n (foldPart p)

theorem rungPositive (n : Nat) : 0<(rung n).numerator := (rung n).positive

theorem successorReturns (n : Nat) : foldPart (rung (n+1))=rung n := lowerFoldsToImage (rung n)

theorem countedReturn (n : Nat) : run n (rung n)=one := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change run n (foldPart (rung (n+1)))=one
  rw [successorReturns]
  exact ih

theorem successorNotOne (n : Nat) : rung (n+1)≠one := by
 intro h
 have bound := lowerOnFirstHalf (rung n)
 change (rung (n+1)).numerator+(rung (n+1)).numerator ≤ (rung (n+1)).denominator at bound
 rw [h] at bound
 change 2≤1 at bound
 exact Nat.not_succ_le_self 1 bound

theorem remainingRung (steps remaining : Nat) : run steps (rung (remaining+steps))=rung remaining := by
 induction steps with
 | zero => rfl
 | succ steps ih =>
  rw [Nat.add_succ]
  change run steps (foldPart (rung ((remaining+steps)+1)))=rung remaining
  rw [successorReturns]
  exact ih

theorem noEarlierReturn (steps remaining : Nat) :
 run steps (rung ((remaining+1)+steps))≠one := by
 rw [remainingRung]
 exact successorNotOne remaining

theorem everyDepthHasNext (n : Nat) : n<n+1 := Nat.lt_succ_self n

theorem sameDenominator (n a b : Nat) (hn : 0<n) (ha : n≤a) (hb : n≤b)
 (h : a=b) : normalizePart n a hn ha=normalizePart n b hn hb := by
 cases h
 rfl

theorem dyadicRepresentation (n : Nat) :
 rung n=normalizePart 1 (2^n) (by decide) (Nat.pow_pos (by decide)) := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change lowerPreimage (rung n)=_
  rw [ih,lowerNormalized]
  apply sameDenominator
  rw [Nat.pow_succ,Nat.mul_succ,Nat.mul_one]

#print axioms sameDenominator
#print axioms dyadicRepresentation
#print axioms rung
#print axioms run
#print axioms rungPositive
#print axioms successorReturns
#print axioms countedReturn
#print axioms successorNotOne
#print axioms remainingRung
#print axioms noEarlierReturn
#print axioms everyDepthHasNext
end SFT.Mathematics.FiniteRefinement
