import SFT.Physics.FoldFirstReturn
import SFT.Mathematics.BoundedFoldTransient
namespace SFT.Physics.SymmetryAction
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
abbrev Input := FoldFirstReturn.Input
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Source fold_part: preserve its original exact-Fraction domain and message.
def foldPart : Input → Except String Rat
 | .nonFraction => .error "Fold requires one exact positive part of the One"
 | .fraction value => match admitFraction value with
   | none => .error "Fold requires one exact positive part of the One"
   | some p => .ok (asFraction (SFT.Foundation.ExactOperations.foldPart p))
-- Only the source denominator is divided. The structural bound is derived
-- from that denominator; no stopping depth is supplied by a scientific caller.
def oddCoreLoop : Nat → Nat → Nat
 | 0,n => n
 | fuel+1,n => if n%2==0 then oddCoreLoop fuel (n/2) else n
def reducedOddDenominatorCore : Input → Except String Nat
 | .nonFraction => .error "odd-core custody requires one exact positive Fold part"
 | .fraction value => match admitFraction value with
   | none => .error "odd-core custody requires one exact positive Fold part"
   | some p => .ok (oddCoreLoop p.denominator p.denominator)
def oddCoreIsConserved (value : Input) : Except String Bool := do
 let before ← reducedOddDenominatorCore value
 let folded ← foldPart value
 let after ← reducedOddDenominatorCore (.fraction folded)
 pure (before==after)
theorem originalAdmittedFold (p : Part) : foldPart (.fraction (asFraction p)) =
 .ok (asFraction (SFT.Foundation.ExactOperations.foldPart p)) := by
 unfold foldPart
 dsimp only
 rw [admittedPartRoundTrip]
theorem originalAdmittedCore (p : Part) : reducedOddDenominatorCore (.fraction (asFraction p)) =
 .ok (oddCoreLoop p.denominator p.denominator) := by
 unfold reducedOddDenominatorCore
 dsimp only
 rw [admittedPartRoundTrip]
inductive SourceOddCoreRun : Nat → Nat → Prop where
 | stop (n : Nat) (odd : (n%2==0)=false) : SourceOddCoreRun n n
 | step (n result : Nat) (even : (n%2==0)=true) (later : SourceOddCoreRun (n/2) result) : SourceOddCoreRun n result
theorem originalOddCoreRun (fuel n : Nat) (positive : 0<n) (bound : n≤fuel) :
 SourceOddCoreRun n (oddCoreLoop fuel n) := by
 induction fuel generalizing n with
 | zero => exact False.elim (Nat.not_lt_zero _ (Nat.lt_of_lt_of_le positive bound))
 | succ fuel ih =>
  unfold oddCoreLoop
  cases h : n%2==0 with
  | false => exact SourceOddCoreRun.stop n h
  | true =>
   apply SourceOddCoreRun.step n _ h
   have even : n%2=0 := Nat.eq_of_beq_eq_true h
   have form := SFT.Foundation.FractionReduction.remainderQuotient n 2 (by decide)
   rw [even,Nat.zero_add] at form
   have hp : 0<n/2 := by
    apply Nat.pos_of_ne_zero
    intro hz
    rw [hz,Nat.mul_zero] at form
    exact Nat.ne_of_gt positive form.symm
   have less : n/2<n := by
    calc
     n/2 = n/2+0 := (Nat.add_zero _).symm
     _ < n/2+n/2 := Nat.lt_add_of_pos_right hp
     _ = 2*(n/2) := (Nat.two_mul _).symm
     _ = n := form
   exact ih (n/2) hp (Nat.le_of_lt_succ (Nat.lt_of_lt_of_le less bound))
end SFT.Physics.SymmetryAction
