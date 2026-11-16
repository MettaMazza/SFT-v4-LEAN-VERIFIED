import SFT.Physics.SpinStatisticsColdGrowth
namespace SFT.Physics.SpinStatisticsCriticalExecution
open SpinStatisticsCondensation SpinStatisticsOccupationWeights SpinStatisticsColdMeasure SpinStatisticsColdThreshold
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
private theorem divideWhole (n p : Nat) :
 LeptonRatios.divide (wholeRatio n) (wholeRatio (p+1))=.ok (natRatio n (p+1) (Nat.zero_lt_succ _)) := by
 rw [←natRatioWhole n,←natRatioWhole (p+1),divideNormalized n 1 (p+1) 1 (by decide) (Nat.zero_lt_succ _) (by decide)]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.one_mul]
private theorem mappedNonempty {α β : Type} (xs : List α) (f : α→β) (nonempty : xs≠[]) : xs.map f≠[] := by
 cases xs with
 | nil => exact False.elim (nonempty rfl)
 | cons x xs => intro impossible;cases impossible
theorem originalNonemptyWeightResult (p l d : Nat) :
 ∃ weights : List (List Nat×Rat),
 canonicalOccupationWeights (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat (d+1)))=.ok weights ∧ weights≠[] := by
 have generated : occupationVectors (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving"=.ok (words (p+1) l) := rfl
 have assembled := originalWeightAssembly p (l+1) d "preserving" (words (p+1) l) generated (originalWordsNonempty (p+1) l)
 refine ⟨_,assembled,?_⟩
 exact mappedNonempty _ _ (originalWordsNonempty (p+1) l)
private theorem meanLoopReturns (p : Nat) (rows : List (List Nat×Rat)) (acc : List Rat) :
 ∃ terms : List Rat,
 List.mapM.loop (fun (row,weight) => do
   let energy ← LeptonRatios.divide (wholeRatio (totalThrow row)) (wholeRatio (p+1))
   pure (multiply weight energy)) rows acc=.ok terms := by
 induction rows generalizing acc with
 | nil => exact ⟨acc.reverse,rfl⟩
 | cons pair rows ih =>
   obtain ⟨row,weight⟩ := pair
   rw [List.mapM.loop.eq_2]
   dsimp only
   rw [divideWhole]
   exact ih _
theorem originalCanonicalMeanReturns (p l d : Nat) :
 ∃ mean : Rat,canonicalMeanThrow (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat (d+1)))=.ok mean := by
 obtain ⟨weights,assembled,nonempty⟩ := originalNonemptyWeightResult p l d
 unfold canonicalMeanThrow
 rw [assembled]
 cases weights with
 | nil => exact False.elim (nonempty rfl)
 | cons pair rest =>
   obtain ⟨terms,success⟩ := meanLoopReturns p (pair::rest) []
   change ∃ mean : Rat, (do
     let terms ← List.mapM.loop _ (pair::rest) []
     pure (terms.foldl add zero) : Except String Rat)=.ok mean
   rw [success]
   exact ⟨terms.foldl add zero,rfl⟩
-- The original recursive search returns once one member of its finite input crosses.
theorem originalFirstCrossingReturns (particles levels factor : Nat) (threshold : Rat)
 (depths : List Nat) (prior : List (Nat×Rat×Rat))
 (ready : ∀ depth∈depths,∃ share mean,
   groundShare (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat depth))=.ok share ∧
   canonicalMeanThrow (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat depth))=.ok mean)
 (crosses : ∃ depth∈depths,∃ share,
   groundShare (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat depth))=.ok share ∧ share.blt threshold=false) :
 ∃ certificate,firstCrossing particles levels factor threshold depths prior=.ok certificate := by
 induction depths generalizing prior with
 | nil => obtain ⟨d,h,_⟩ := crosses;cases h
 | cons depth rest ih =>
   obtain ⟨share,mean,shareEq,meanEq⟩ := ready depth (.head rest)
   cases decision : share.blt threshold with
   | false =>
     refine ⟨⟨particles,levels,factor,threshold,depth,mean,share,
       (match prior.getLast? with | none => true | some (_,previous,_) => previous.blt threshold),
       prior++[(depth,share,mean)],groundWord particles levels⟩,?_⟩
     unfold firstCrossing
     rw [shareEq]
     dsimp only [Except.bind,Bind.bind]
     rw [meanEq]
     dsimp only [Except.bind,Bind.bind]
     rw [decision]
     rfl
   | true =>
     have later : ∃ d∈rest,∃ v,
       groundShare (.integer (.ofNat particles)) (.integer (.ofNat levels)) "preserving" (.integer (.ofNat d))=.ok v ∧ v.blt threshold=false := by
       obtain ⟨d,held,v,valueEq,passes⟩ := crosses
       cases held with
       | head =>
         have same : v=share := Except.ok.inj (valueEq.symm.trans shareEq)
         rw [same,decision] at passes
         cases passes
       | tail _ h => exact ⟨d,h,v,valueEq,passes⟩
     obtain ⟨certificate,run⟩ := ih (prior++[(depth,share,mean)]) (fun d hd => ready d (.tail depth hd)) later
     refine ⟨certificate,?_⟩
     unfold firstCrossing
     rw [shareEq]
     dsimp only [Except.bind,Bind.bind]
     rw [meanEq]
     dsimp only [Except.bind,Bind.bind]
     rw [decision]
     exact run
theorem originalPositiveDepthReady (p l depth : Nat) (positive : 0<depth) :
 ∃ share mean,
 groundShare (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat depth))=.ok share ∧
 canonicalMeanThrow (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat depth))=.ok mean := by
 cases depth with
 | zero => exact False.elim (Nat.not_lt_zero _ positive)
 | succ d =>
   obtain ⟨mean,meanEq⟩ := originalCanonicalMeanReturns p l d
   exact ⟨_,mean,originalGroundShareOperation p l d,meanEq⟩

theorem originalEveryCriticalCertificateReturns (p l m : Nat) :
 ∃ certificate,
 criticalCondensationCertificate (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) (.integer (.ofNat (m+2)))=.ok certificate := by
 let b := sufficientDepth (p+1) l (m+1)
 let depths := (List.range (b+1)).map (fun n => n+1)
 let threshold := natRatio (m+1) (m+2) (Nat.zero_lt_succ _)
 have positive : 0<b := originalSufficientDepthPositive (p+1) l (m+1)
 have ready : ∀ depth∈depths,∃ share mean,
   groundShare (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat depth))=.ok share ∧
   canonicalMeanThrow (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) "preserving" (.integer (.ofNat depth))=.ok mean := by
   intro depth held
   obtain ⟨i,_,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held
   rw [←eq]
   exact originalPositiveDepthReady p l (i+1) (Nat.zero_lt_succ _)
 have split : b-1+1=b := SFT.Foundation.FractionReduction.subtractAdd b 1 positive
 have member : b∈depths := by
   rw [←split]
   exact SFT.Foundation.Count.TraceDerivation.memMap (fun n => n+1) (b-1) (List.range (b+1))
     ((SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mpr (Nat.lt_succ_of_le (Nat.sub_le _ _)))
 obtain ⟨share,mean,shareEq,meanEq⟩ := originalPositiveDepthReady p l b positive
 have passed := originalSufficientDepthPasses p l m
 change (groundShare _ _ _ (.integer (.ofNat b))).map (fun share => !share.blt threshold)=.ok true at passed
 rw [shareEq] at passed
 have accepted : share.blt threshold=false := by
   cases decision : share.blt threshold with
   | false => rfl
   | true =>
     change Except.ok (!share.blt threshold)=.ok true at passed
     rw [decision] at passed
     cases passed
 obtain ⟨certificate,run⟩ := originalFirstCrossingReturns (p+1) (l+2) (m+2) threshold depths [] ready ⟨b,member,share,shareEq,accepted⟩
 refine ⟨certificate,?_⟩
 unfold criticalCondensationCertificate
 change (do
   let threshold ← LeptonRatios.divide (wholeRatio (m+1)) (wholeRatio (m+2))
   firstCrossing (p+1) (l+2) (m+2) threshold depths [] : Except String Condensation)=.ok certificate
 rw [divideWhole]
 exact run
theorem originalCriticalOperation (p l m : Nat) :
 criticalCondensationCertificate (.integer (.ofNat (p+1))) (.integer (.ofNat (l+2))) (.integer (.ofNat (m+2)))=
 firstCrossing (p+1) (l+2) (m+2) (natRatio (m+1) (m+2) (Nat.zero_lt_succ _))
   ((List.range (sufficientDepth (p+1) l (m+1)+1)).map (fun n => n+1)) [] := by
 unfold criticalCondensationCertificate
 change (do
   let threshold ← LeptonRatios.divide (wholeRatio (m+1)) (wholeRatio (m+2))
   firstCrossing (p+1) (l+2) (m+2) threshold _ [] : Except String Condensation)=_
 rw [divideWhole]
 rfl
end SFT.Physics.SpinStatisticsCriticalExecution
