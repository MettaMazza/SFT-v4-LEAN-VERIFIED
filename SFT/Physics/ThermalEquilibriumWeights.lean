import SFT.Physics.ThermalEquilibriumResponse
import SFT.Physics.ThermalHistoryVisibility
import SFT.Mathematics.OrbitCyclotomic
namespace SFT.Physics.ThermalEquilibriumWeights
open ThermalEquilibriumResponse LeptonIntervals VacuumLedgerProofs ThermalHistoryVisibility
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def originalCounts (n : Nat) : List Nat :=
 (List.range (n+2)).map (fun index => 2^(n+2-index-1))

theorem originalCountOperation (n : Nat) :
 dyadicCanonicalCounts (.integer (.ofNat (n+2)))=.ok (originalCounts n) := rfl

theorem originalPopulationPositive (n : Nat) : 0<(originalCounts n).foldl Nat.add 0 := by
 have last : (n+2)-(n+1)=1 := by
   change ((n+1)+1)-(n+1)=1
   rw [Nat.add_comm (n+1) 1]
   exact SFT.Foundation.ExactCast.addSubtract 1 (n+1)
 unfold originalCounts
 rw [rangeSuccessor,SFT.Mathematics.ExactTraceArithmetic.mapAppend,foldAppend]
 change 0 < ((List.range (n+1)).map (fun index => 2^(n+2-index-1))).foldl Nat.add 0 + 2^(n+2-(n+1)-1)
 rw [last]
 exact Nat.zero_lt_succ _

theorem originalWeightOperation (n : Nat) :
 dyadicCanonicalWeights (.integer (.ofNat (n+2))) = .ok
 ((originalCounts n).map (fun count => natRatio count ((originalCounts n).foldl Nat.add 0) (originalPopulationPositive n))) := by
 unfold dyadicCanonicalWeights
 rw [originalCountOperation]
 dsimp only [Except.bind,Bind.bind]
 exact originalNormalizedWeights _ _ (originalPopulationPositive n)

theorem originalCompleteNormalization (n : Nat) :
 (dyadicCanonicalWeights (.integer (.ofNat (n+2)))).toOption.map (fun weights => weights.foldl add zero)=some (wholeRatio 1) := by
 rw [originalWeightOperation]
 change some (((originalCounts n).map (fun count => natRatio count ((originalCounts n).foldl Nat.add 0) (originalPopulationPositive n))).foldl add zero)=_
 rw [originalNormalizedTotal _ (originalPopulationPositive n)]

theorem originalExponentSuccessor (levels index : Nat) (inside : index<levels) :
 levels+1-index-1=(levels-index-1)+1 := by
 induction levels generalizing index with
 | zero => exact False.elim (Nat.not_lt_zero index inside)
 | succ levels ih =>
   cases index with
   | zero => rfl
   | succ index =>
     rw [Nat.succ_sub_succ,Nat.succ_sub_succ]
     exact ih index (Nat.lt_of_succ_lt_succ inside)

theorem originalDoubledPrefix (levels : Nat) (indices : List Nat)
 (inside : ∀ i, i ∈ indices → i<levels) :
 indices.map (fun i => 2^(levels+1-i-1)) =
 (indices.map (fun i => 2^(levels-i-1))).map (fun n => 2*n) := by
 induction indices with
 | nil => rfl
 | cons i indices ih =>
   have e : 2^(levels+1-i-1)=2*(2^(levels-i-1)) := by
     rw [originalExponentSuccessor levels i (inside i (List.Mem.head _)),Nat.pow_succ,Nat.mul_comm]
   change 2^(levels+1-i-1)::indices.map (fun i => 2^(levels+1-i-1))=_
   rw [e,ih (fun i h => inside i (List.Mem.tail _ h))]
   rfl

theorem originalCountSuccessor (n : Nat) :
 originalCounts (n+1)=(originalCounts n).map (fun c => 2*c)++[1] := by
 have last : (n+3)-(n+2)=1 := by
   change ((n+2)+1)-(n+2)=1
   rw [Nat.add_comm (n+2) 1]
   exact SFT.Foundation.ExactCast.addSubtract 1 (n+2)
 unfold originalCounts
 rw [rangeSuccessor,SFT.Mathematics.ExactTraceArithmetic.mapAppend]
 change (List.range (n+2)).map (fun i => 2^(n+3-i-1))++[2^(n+3-(n+2)-1)]=_
 rw [last]
 rw [originalDoubledPrefix (n+2) _ (fun i h => (SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mp h)]

theorem originalDoubledPopulation (counts : List Nat) (acc : Nat) :
 (counts.map (fun c => 2*c)).foldl Nat.add (2*acc)=2*(counts.foldl Nat.add acc) := by
 induction counts generalizing acc with
 | nil => rfl
 | cons c counts ih =>
   change (counts.map (fun c => 2*c)).foldl Nat.add (2*acc+2*c)=_
   rw [←Nat.mul_add]
   exact ih (acc+c)

theorem originalPopulationSuccessor (n : Nat) :
 (originalCounts (n+1)).foldl Nat.add 0=2*((originalCounts n).foldl Nat.add 0)+1 := by
 rw [originalCountSuccessor,foldAppend]
 change ((originalCounts n).map (fun c => 2*c)).foldl Nat.add 0+1 = _
 have h := originalDoubledPopulation (originalCounts n) 0
 exact congrArg (fun k => k+1) h

theorem originalPopulationPlusOne (n : Nat) :
 (originalCounts n).foldl Nat.add 0+1=2^(n+2) := by
 induction n with
 | zero => rfl
 | succ n ih =>
   rw [originalPopulationSuccessor,Nat.add_assoc]
   change 2*((originalCounts n).foldl Nat.add 0)+2=2^(n+3)
   rw [←Nat.mul_add 2 _ 1,ih]
   exact (Nat.mul_comm _ _).trans (Nat.pow_succ 2 (n+2)).symm

theorem originalPopulationFormula (n : Nat) :
 (originalCounts n).foldl Nat.add 0=2^(n+2)-1 := by
 have h := congrArg (fun k => k-1) (originalPopulationPlusOne n)
 rw [SFT.Foundation.ExactCast.addSubtract] at h
 exact h

theorem originalAdjacentWeightsDecrease (n index : Nat) (inside : index+1<n+2) :
 (natRatio (2^(n+2-(index+1)-1)) ((originalCounts n).foldl Nat.add 0) (originalPopulationPositive n)).blt
 (natRatio (2^(n+2-index-1)) ((originalCounts n).foldl Nat.add 0) (originalPopulationPositive n))=true := by
 have prior : index<n+1 := Nat.lt_of_succ_lt_succ inside
 have exponents := originalExponentSuccessor (n+1) index prior
 have next : n+2-(index+1)-1=n+1-index-1 := by rw [Nat.succ_sub_succ]
 rw [next,exponents]
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (Nat.pow_pos (by decide)) (originalPopulationPositive n)
   (Nat.pow_pos (by decide)) (originalPopulationPositive n)
 apply Nat.mul_lt_mul_of_pos_right _ (originalPopulationPositive n)
 rw [Nat.pow_succ,Nat.mul_succ,Nat.mul_one]
 exact Nat.lt_add_of_pos_right (Nat.pow_pos (by decide))
end SFT.Physics.ThermalEquilibriumWeights
