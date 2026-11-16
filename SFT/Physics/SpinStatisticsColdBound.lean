import SFT.Physics.SpinStatisticsColdMeasure
namespace SFT.Physics.SpinStatisticsColdBound
open SpinStatisticsCondensation SpinStatisticsOccupationWeights SpinStatisticsColdScores SpinStatisticsColdMeasure
open SFT.Foundation.FractionReduction SFT.Mathematics.DiscreteObjects
open VacuumLedgerProofs
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
private theorem binaryPowerMonotone (a b : Nat) (bound : a≤b) : 2^a≤2^b := by
 induction bound with
 | refl => exact Nat.le_refl _
 | @step b bound ih =>
   rw [Nat.pow_succ,Nat.mul_succ,Nat.mul_one]
   exact Nat.le_trans ih (Nat.le_add_right _ _)
theorem originalEachExcitedBound (particles levels depth : Nat) (word : List Nat)
 (generated : word∈words particles levels) (excited : word≠ground particles levels) :
 score (ThermalEquilibriumWeights.originalCounts levels) depth word * 2^depth ≤
 score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels) := by
 have positive := originalExcitedOffsetPositive particles (levels+1) word generated excited
 have exponent : depth≤ThermalEquilibriumResponse.countedThrow word*depth := by
   have h := Nat.mul_le_mul_right depth (Nat.succ_le_of_lt positive)
   rw [Nat.one_mul] at h
   exact h
 have bound := Nat.mul_le_mul_left (score (ThermalEquilibriumWeights.originalCounts levels) depth word)
   (binaryPowerMonotone _ _ exponent)
 rw [originalRelativeColdScore particles levels depth word generated] at bound
 exact bound
private theorem sumAccumulator (values : List Nat) (acc : Nat) :
 values.foldl Nat.add acc=acc+values.foldl Nat.add 0 := by
 induction values generalizing acc with
 | nil => exact (Nat.add_zero acc).symm
 | cons v vs ih =>
   change vs.foldl Nat.add (acc+v)=acc+vs.foldl Nat.add (0+v)
   rw [ih (acc+v),ih (0+v),Nat.zero_add,Nat.add_assoc]
private theorem scoreSumHead (f : List Nat→Nat) (word : List Nat) (rest : List (List Nat)) :
 ((word::rest).map f).foldl Nat.add 0=f word+(rest.map f).foldl Nat.add 0 := by
 change (rest.map f).foldl Nat.add (0+f word)=_
 rw [Nat.zero_add,sumAccumulator]
private theorem sumBound (f : List Nat→Nat) (forms : List (List Nat)) (D G : Nat)
 (bound : ∀ word∈forms,f word*D≤G) :
 (forms.map f).foldl Nat.add 0*D≤forms.length*G := by
 induction forms with
 | nil =>
   change 0*D≤0*G
   rw [Nat.zero_mul,Nat.zero_mul]
   exact Nat.le_refl _
 | cons word rest ih =>
   rw [scoreSumHead,addMul]
   have h := Nat.add_le_add (bound word (.head rest)) (ih (fun v hv => bound v (.tail word hv)))
   rw [Nat.add_comm G] at h
   rw [List.length_cons,Nat.succ_mul]
   exact h
-- The complete source census has exactly one ground contribution.
private theorem completeSumBound (f : List Nat→Nat) (forms : List (List Nat))
 (target : List Nat) (D : Nat) (unique : distinct forms=true) (held : target∈forms)
 (bound : ∀ word∈forms,word≠target → f word*D≤f target) :
 (forms.map f).foldl Nat.add 0*D+f target≤f target*D+forms.length*f target := by
 induction forms with
 | nil => cases held
 | cons word rest ih =>
   have parts := (distinctCons word rest).mp unique
   rw [scoreSumHead,addMul]
   cases same : decEq word target with
   | isTrue eq =>
     cases eq
     have remaining : ∀ v∈rest,f v*D≤f target := by
       intro v hv
       apply bound v (.tail target hv)
       intro eq
       rw [eq] at hv
       exact (absentIff rest target).mp parts.1 hv
     have h := Nat.add_le_add_left (sumBound f rest D (f target) remaining) (f target*D)
     have plus := Nat.add_le_add_right h (f target)
     rw [List.length_cons,Nat.succ_mul,←Nat.add_assoc]
     exact plus
   | isFalse different =>
     have targetRest : target∈rest := by
       cases held with
       | head => exact False.elim (different rfl)
       | tail _ h => exact h
     have tail := ih parts.2 targetRest (fun v hv => bound v (.tail word hv))
     have sum := Nat.add_le_add (bound word (.head rest) different) tail
     rw [←Nat.add_assoc] at sum
     have rhs : f target+(f target*D+rest.length*f target)=
       f target*D+(rest.length+1)*f target := by
       rw [Nat.succ_mul,←Nat.add_assoc,Nat.add_comm (f target) (f target*D)]
       rw [Nat.add_assoc,Nat.add_comm (f target) (rest.length*f target)]
     rw [rhs] at sum
     exact sum

theorem originalCompleteScoreBound (particles levels depth : Nat) :
 denominator particles levels depth*2^depth+
 score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels) ≤
 score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels)*2^depth+
 (words particles levels).length*score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels) := by
 apply completeSumBound _ _ _ _ (SpinStatisticsOccupationEnumeration.originalWalkUnique _ _ _ _)
   (originalGroundMember particles levels)
 exact fun word held different => originalEachExcitedBound particles levels depth word held different
theorem originalCompetingScoreBound (particles levels depth : Nat) :
 denominator particles levels depth*2^depth ≤
 score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels)*2^depth+
 ((words particles levels).length-1)*score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels) := by
 have totalBound := originalCompleteScoreBound particles levels depth
 have lengthPositive : 0<(words particles levels).length := by
   cases eq : words particles levels with
   | nil => exact False.elim (originalWordsNonempty particles levels eq)
   | cons word rest => exact Nat.zero_lt_succ _
 have split := subtractAdd (words particles levels).length 1 lengthPositive
 conv at totalBound => rhs; rw [←split,Nat.succ_mul,←Nat.add_assoc]
 have cancelled := Nat.sub_le_sub_right totalBound
   (score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels))
 rw [SFT.Foundation.ExactCast.addSubtract,SFT.Foundation.ExactCast.addSubtract] at cancelled
 exact cancelled
-- The source's exact finite bound K(m-1)≤2^d implies the lock cross-product.
theorem originalFiniteLockBound (particles levels depth factorPred : Nat)
 (covered : ((words particles levels).length-1)*factorPred≤2^depth) :
 factorPred*denominator particles levels depth ≤
 (factorPred+1)*score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels) := by
 let G := score (ThermalEquilibriumWeights.originalCounts levels) depth (ground particles levels)
 let T := denominator particles levels depth
 let K := (words particles levels).length-1
 let D := 2^depth
 have census : T*D≤G*D+K*G := originalCompetingScoreBound particles levels depth
 have cross : (factorPred*T)*D≤((factorPred+1)*G)*D := calc
   (factorPred*T)*D=factorPred*(T*D) := mulAssoc _ _ _
   _≤factorPred*(G*D+K*G) := Nat.mul_le_mul_left _ census
   _=(factorPred*G)*D+(factorPred*K)*G := by rw [Nat.mul_add,←mulAssoc,←mulAssoc]
   _≤(factorPred*G)*D+D*G := Nat.add_le_add_left
     (by rw [Nat.mul_comm factorPred K];exact Nat.mul_le_mul_right G covered) _
   _=((factorPred+1)*G)*D := by rw [Nat.succ_mul,addMul,Nat.mul_comm D G]
 exact Nat.le_of_mul_le_mul_right cross (Nat.pow_pos (by decide))

theorem originalSearchBoundCovers (particles levels factorPred : Nat) :
 ((words particles levels).length-1)*factorPred≤
 2^(AlphaCovers.coverDepth (max 1 (((words particles levels).length-1)*factorPred))) :=
 Nat.le_trans (by
   rw [Nat.max_def]
   split
   · exact Nat.le_refl _
   · rename_i h
     exact Nat.le_of_lt (Nat.lt_of_not_ge h))
 (AlphaCovers.leastPositiveCover _).2.1
end SFT.Physics.SpinStatisticsColdBound
