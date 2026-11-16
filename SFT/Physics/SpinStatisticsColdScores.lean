import SFT.Physics.SpinStatisticsGroundMinimum
import SFT.Physics.ThermalEquilibriumMultinomial
namespace SFT.Physics.SpinStatisticsColdScores
open SpinStatisticsCondensation SpinStatisticsOccupationWeights ThermalEquilibriumMultinomial
open SFT.Foundation.FractionReduction
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
private theorem powerAdd (a b c : Nat) : a^(b+c)=a^b*a^c := by
 induction c with
 | zero => rw [Nat.add_zero,Nat.pow_zero,Nat.mul_one]
 | succ c ih => rw [Nat.add_succ,Nat.pow_succ,ih,Nat.pow_succ,mulAssoc]
private theorem powerPower (a b c : Nat) : (a^b)^c=a^(b*c) := by
 induction c with
 | zero => rw [Nat.pow_zero,Nat.mul_zero,Nat.pow_zero]
 | succ c ih => rw [Nat.pow_succ,ih,Nat.mul_succ,powerAdd]
private theorem productPower (a b d : Nat) : (a*b)^d=a^d*b^d := by
 induction d with
 | zero => rfl
 | succ d ih =>
   rw [Nat.pow_succ,ih,Nat.pow_succ,Nat.pow_succ,SFT.Foundation.PrimitiveMaps.mulInterchange]
private theorem onePower (d : Nat) : 1^d=1 := by
 induction d with
 | zero => rfl
 | succ d ih => rw [Nat.pow_succ,ih]
private theorem scoreAccumulator (raw word : List Nat) (depth acc : Nat) :
 (raw.zip word).foldl (fun value (weight,occupied) => value*weight^(depth*occupied)) acc =
 acc*(powerProduct raw word)^depth := by
 induction raw generalizing word acc with
 | nil =>
   change acc=acc*1^depth
   rw [onePower,Nat.mul_one]
 | cons weight raw ih =>
   cases word with
   | nil =>
     change acc=acc*1^depth
     rw [onePower,Nat.mul_one]
   | cons occupied word =>
     change (raw.zip word).foldl _ (acc*weight^(depth*occupied))=acc*(weight^occupied*powerProduct raw word)^depth
     rw [ih,productPower,powerPower,Nat.mul_comm depth occupied,mulAssoc]
theorem originalScorePower (raw word : List Nat) (depth : Nat) :
 score raw depth word=(powerProduct raw word)^depth := by
 unfold score
 rw [scoreAccumulator,Nat.one_mul]
-- Reuse the established complementary dyadic-product identity, now at cold depth d.
theorem originalColdComplement (n depth : Nat) (word : List Nat) (length : word.length=n+2) :
 score (ThermalEquilibriumWeights.originalCounts n) depth word *
 2^(ThermalEquilibriumResponse.countedThrow word*depth)=
 2^(((n+1)*word.foldl Nat.add 0)*depth) := by
 have base := originalFixedCountThrowProduct n word length
 have raised := congrArg (fun value => value^depth) base
 rw [productPower,powerPower,powerPower] at raised
 rw [originalScorePower]
 exact raised
private theorem zeroOffset (word : List Nat) :
 SpinStatisticsGroundMinimum.moment 0 word=ThermalEquilibriumResponse.countedThrow word := by
 unfold SpinStatisticsGroundMinimum.moment ThermalEquilibriumResponse.countedThrow
 have identity : ∀ xs : List Nat, xs.map (fun i => 0+i)=xs := by
   intro xs
   induction xs with
   | nil => rfl
   | cons x xs ih =>
     change (0+x)::xs.map _=x::xs
     rw [Nat.zero_add,ih]
 rw [identity]
theorem originalThrowDecomposition (word : List Nat) :
 totalThrow word=word.foldl Nat.add 0+ThermalEquilibriumResponse.countedThrow word := by
 have shifted := SpinStatisticsGroundMinimum.originalOffsetDifference 0 word
 have same : totalThrow word=SpinStatisticsGroundMinimum.moment 1 word := by
   unfold totalThrow SpinStatisticsGroundMinimum.moment
   have indices : ∀ xs : List Nat, xs.map (fun i => i+1)=xs.map (fun i => 1+i) := by
     intro xs
     induction xs with
     | nil => rfl
     | cons x xs ih =>
       change (x+1)::xs.map _=(1+x)::xs.map _
       rw [Nat.add_comm x 1,ih]
   rw [indices]
 rw [same,shifted,zeroOffset]
theorem originalExcitedOffsetPositive (particles levels : Nat) (word : List Nat)
 (generated : word∈walk particles levels [] particles)
 (excited : word≠groundWord particles (levels+1)) :
 0<ThermalEquilibriumResponse.countedThrow word := by
 have strict := SpinStatisticsGroundMinimum.originalExcitedThrowStrict particles levels word generated excited
 have carrier := (SpinStatisticsOccupationBounds.originalPreservingComplete particles levels word).mp generated
 rw [originalThrowDecomposition,carrier.2] at strict
 cases eq : ThermalEquilibriumResponse.countedThrow word with
 | zero => rw [eq,Nat.add_zero] at strict;exact False.elim (Nat.lt_irrefl _ strict)
 | succ k => exact Nat.zero_lt_succ _
theorem originalGroundOffset (particles levels : Nat) :
 ThermalEquilibriumResponse.countedThrow (groundWord particles (levels+1))=0 := by
 have carrier := (SpinStatisticsOccupationBounds.originalPreservingComplete particles levels _).mp
   (SpinStatisticsGroundMinimum.originalGroundGenerated particles levels)
 have identity := originalThrowDecomposition (groundWord particles (levels+1))
 rw [SpinStatisticsGroundMinimum.originalGroundAttains,carrier.2] at identity
 have cancelled := congrArg (fun value => value-particles) identity
 rw [Nat.sub_self,Nat.add_comm particles,SFT.Foundation.ExactCast.addSubtract] at cancelled
 exact cancelled.symm

theorem originalGroundScore (particles n depth : Nat) :
 score (ThermalEquilibriumWeights.originalCounts n) depth (groundWord particles (n+2))=
 2^(((n+1)*particles)*depth) := by
 have carrier := (SpinStatisticsOccupationBounds.originalPreservingComplete particles (n+1) _).mp
   (SpinStatisticsGroundMinimum.originalGroundGenerated particles (n+1))
 have identity := originalColdComplement n depth (groundWord particles (n+2)) carrier.1
 rw [originalGroundOffset particles (n+1),carrier.2,Nat.zero_mul,Nat.pow_zero,Nat.mul_one] at identity
 exact identity

theorem originalRelativeColdScore (particles n depth : Nat) (word : List Nat)
 (generated : word∈walk particles (n+1) [] particles) :
 score (ThermalEquilibriumWeights.originalCounts n) depth word *
 2^(ThermalEquilibriumResponse.countedThrow word*depth)=
 score (ThermalEquilibriumWeights.originalCounts n) depth (groundWord particles (n+2)) := by
 have carrier := (SpinStatisticsOccupationBounds.originalPreservingComplete particles (n+1) word).mp generated
 have identity := originalColdComplement n depth word carrier.1
 rw [carrier.2] at identity
 rw [originalGroundScore]
 exact identity
theorem originalColdPenaltySuccessor (word : List Nat) (depth : Nat) :
 2^(ThermalEquilibriumResponse.countedThrow word*(depth+1))=
 2^(ThermalEquilibriumResponse.countedThrow word)*
 2^(ThermalEquilibriumResponse.countedThrow word*depth) := by
 rw [Nat.mul_succ,powerAdd,Nat.mul_comm]
theorem originalExcitedCoolingFactor (particles levels : Nat) (word : List Nat)
 (generated : word∈walk particles levels [] particles)
 (excited : word≠groundWord particles (levels+1)) :
 2≤2^(ThermalEquilibriumResponse.countedThrow word) := by
 have positive := originalExcitedOffsetPositive particles levels word generated excited
 cases eq : ThermalEquilibriumResponse.countedThrow word with
 | zero => rw [eq] at positive;exact False.elim (Nat.not_lt_zero _ positive)
 | succ k =>
   rw [Nat.pow_succ]
   have bound := Nat.mul_le_mul_right 2 (Nat.succ_le_of_lt (Nat.pow_pos (a:=2) (n:=k) (by decide)))
   exact bound
end SFT.Physics.SpinStatisticsColdScores
