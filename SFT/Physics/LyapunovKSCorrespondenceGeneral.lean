import SFT.Physics.LyapunovKSCorrespondenceCertificate
namespace SFT.Physics.LyapunovKSCorrespondenceGeneral
open LyapunovKSCorrespondence
set_option maxHeartbeats 100000000
theorem completeOriginalSupport (m depth : Nat) :
 completeWordSupport (.integer (.ofNat (m+2))) (.integer (.ofNat (depth+1)))=
 .ok (words ((List.range (m+2)).map (fun i => i+1)) (depth+1)) := rfl
theorem exactOriginalCardinality (m depth : Nat) :
 exactSupportCount (.integer (.ofNat (m+2))) (.integer (.ofNat (depth+1)))=.ok ((m+2)^(depth+1)) := by
 unfold exactSupportCount
 rw [completeOriginalSupport]
 change Except.ok (words _ _).length=_
 rw [completeEnumerationCount,SFT.Foundation.CommonRefinement.mapLength,List.range_eq_range',List.length_range']
theorem exactOriginalSeparation (m parts : Nat) :
 separationCarrier (.integer (.ofNat (m+2))) (.integer (.ofNat (parts+1)))=.ok (.ofNat ((m+2)*(parts+1))) := rfl
theorem supportSuccessorCarrier (m depth : Nat) :
 (do let next ← exactSupportCount (.integer (.ofNat (m+2))) (.integer (.ofNat (depth+2)))
     let previous ← exactSupportCount (.integer (.ofNat (m+2))) (.integer (.ofNat (depth+1)))
     pure (next/previous))=Except.ok (m+2) := by
 rw [exactOriginalCardinality m (depth+1),exactOriginalCardinality m depth]
 change Except.ok (((m+2)^(depth+2))/((m+2)^(depth+1)))=_
 rw [Nat.pow_succ,SFT.Foundation.FractionReduction.divisionMultiple _ _ (Nat.pow_pos (Nat.zero_lt_succ _))]
theorem separationCarrierRatio (m parts : Nat) :
 (do let separation ← separationCarrier (.integer (.ofNat (m+2))) (.integer (.ofNat (parts+1)))
     pure (separation/Int.ofNat (parts+1)))=Except.ok (Int.ofNat (m+2)) := by
 rw [exactOriginalSeparation]
 change Except.ok (Int.ofNat (((m+2)*(parts+1))/(parts+1)))=_
 rw [Nat.mul_comm (m+2) (parts+1),SFT.Foundation.FractionReduction.divisionMultiple _ _ (Nat.zero_lt_succ _)]
end SFT.Physics.LyapunovKSCorrespondenceGeneral

