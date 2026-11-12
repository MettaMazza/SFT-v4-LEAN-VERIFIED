import SFT.Materials.RotationDegreeBase
import SFT.Mathematics.DiscreteComposition
import SFT.Mathematics.CategoryIdentity
import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Materials.RotationResidueBlocks
open SFT.Physics.SpatialStability SFT.Mathematics.OrbitOrderIdentity
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
open SFT.Mathematics.OrbitTilingCount

theorem filterHead (pred : Nat → Bool) (a : Nat) (xs : List Nat) :
 (a::xs).filter pred = (match pred a with | true => a::xs.filter pred | false => xs.filter pred) := rfl

def nonmultiples (n p : Nat) : List Nat :=
 (positiveCounts n).filter (fun c => !(c%p == 0))

theorem positiveCountsAdd (a b : Nat) :
 positiveCounts (a+b) = positiveCounts a ++ (positiveCounts b).map (fun c => a+c) := by
 induction b with
 | zero => exact (SFT.Mathematics.CategoryIdentity.appendNil _).symm
 | succ b ih =>
   change positiveCounts (a+b) ++ [a+(b+1)] = _
   rw [ih,positiveCounts,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.appendAssociative]
   rfl

theorem filterMapShift (xs : List Nat) (p k : Nat) (hp : 0 < p) :
 ((xs.map (fun c => p*k+c)).filter (fun c => !(c%p == 0))) =
 (xs.filter (fun c => !(c%p == 0))).map (fun c => p*k+c) := by
 induction xs with
 | nil => rfl
 | cons a xs ih =>
   have eq : (p*k+a)%p = a%p := by
     rw [Nat.add_comm]
     exact moduloAddMultiple a p k hp
   rw [List.map_cons,filterHead,filterHead,eq]
   cases h : !(a%p == 0) <;> rw [ih] <;> rfl

theorem oneBlock (p : Nat) (hp : 0 < p) : nonmultiples p p = positiveCounts (p-1) := by
 have form := (subtractAdd p 1 hp).symm
 unfold nonmultiples
 have expansion : positiveCounts p = positiveCounts (p-1) ++ [p] := by
   calc
     positiveCounts p = positiveCounts ((p-1)+1) := congrArg positiveCounts form
     _ = positiveCounts (p-1) ++ [(p-1)+1] := rfl
     _ = positiveCounts (p-1) ++ [p] := congrArg (fun t => positiveCounts (p-1) ++ [t]) form.symm
 rw [expansion]
 rw [SFT.Mathematics.CategoryPaths.filterAppend]
 have retained : (positiveCounts (p-1)).filter (fun c => !(c%p == 0)) = positiveCounts (p-1) := by
   apply filterAll
   intro c hc
   have bounds := (positiveCountMembership _ _).mp hc
   have below : c < p := by
     rw [form]
     exact Nat.lt_succ_of_le bounds.2
   rw [moduloBelow c p hp below]
   exact (SFT.Materials.RotationTotient.nonzeroCheck c).mpr (Nat.ne_of_gt bounds.1)
 rw [retained,filterHead,moduloSelf p hp]
 exact SFT.Mathematics.CategoryIdentity.appendNil _

theorem blockCount (p k : Nat) (hp : 0 < p) : (nonmultiples (p*k) p).length = k*(p-1) := by
 induction k with
 | zero => rw [Nat.mul_zero,Nat.zero_mul]; rfl
 | succ k ih =>
   rw [Nat.mul_succ]
   unfold nonmultiples
   rw [positiveCountsAdd,SFT.Mathematics.CategoryPaths.filterAppend,filterMapShift _ p k hp,SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.mapLength]
   change (nonmultiples (p*k) p).length+(nonmultiples p p).length = _
   rw [ih,oneBlock p hp,positiveCountLength,Nat.succ_mul]
end SFT.Materials.RotationResidueBlocks
