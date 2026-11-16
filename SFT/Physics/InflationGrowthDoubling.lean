import SFT.Physics.InflationGrowth
namespace SFT.Physics.InflationGrowthDoubling
open InflationGrowth
set_option maxHeartbeats 100000000

theorem originalDoublingDecision (n : Nat) :
 exactDoublingDepth (.integer (.ofNat (n+2))) =
 if 2^(AlphaCovers.coverDepth (n+2)) != n+2 then
 .error "scale ratio is not an exact complete Fold doubling support"
 else .ok (AlphaCovers.coverDepth (n+2)) := by
 unfold exactDoublingDepth
 dsimp only
 rw [everyPositiveCover (n+1)]
 rfl

theorem originalAcceptedExactSupport (n depth : Nat)
 (accepted : exactDoublingDepth (.integer (.ofNat (n+2)))=.ok depth) :
 depth=AlphaCovers.coverDepth (n+2) ∧ 2^depth=n+2 := by
 rw [originalDoublingDecision] at accepted
 by_cases same : 2^(AlphaCovers.coverDepth (n+2))=n+2
 · have guard : (2^(AlphaCovers.coverDepth (n+2)) != n+2)=false := by
    change Bool.not (decide (2^(AlphaCovers.coverDepth (n+2))=n+2))=false
    rw [decide_eq_true same]
    rfl
   rw [guard] at accepted
   have equal : AlphaCovers.coverDepth (n+2)=depth := Except.ok.inj accepted
   exact ⟨equal.symm,equal ▸ same⟩
 · have guard : (2^(AlphaCovers.coverDepth (n+2)) != n+2)=true := by
    change Bool.not (decide (2^(AlphaCovers.coverDepth (n+2))=n+2))=true
    rw [decide_eq_false same]
    rfl
   rw [guard] at accepted
   cases accepted

theorem originalCompleteSupportAccepted (n : Nat)
 (complete : 2^(AlphaCovers.coverDepth (n+2))=n+2) :
 exactDoublingDepth (.integer (.ofNat (n+2)))=.ok (AlphaCovers.coverDepth (n+2)) := by
 rw [originalDoublingDecision]
 have guard : (2^(AlphaCovers.coverDepth (n+2)) != n+2)=false := by
  change Bool.not (decide (2^(AlphaCovers.coverDepth (n+2))=n+2))=false
  rw [decide_eq_true complete]
  rfl
 rw [guard]
 rfl
end SFT.Physics.InflationGrowthDoubling
