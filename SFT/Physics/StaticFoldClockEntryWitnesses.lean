import SFT.Physics.StaticFoldClock
namespace SFT.Physics.StaticFoldClockEntryWitnesses
open StaticFoldClock
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def covarianceCheck : Bool := match staticClock (.fraction ⟨1,8,by decide,by decide⟩) with
 | .error _ => false
 | .ok .horizon => false
 | .ok (.accessible _ folded) => same folded ⟨3,4,by decide,by decide⟩
def rateCheck : Bool := match exactClockRate with
 | .error _ => false
 | .ok rate => same rate ⟨3,4,by decide,by decide⟩
def horizonCheck : Bool := match staticClock (.fraction ⟨1,1,by decide,by decide⟩) with
 | .error _ => false
 | .ok .horizon => true
 | .ok (.accessible _ _) => false
def witnesses : List Witness := [⟨"covariance","The one-eighth well commutes with the Fold.",covarianceCheck⟩,⟨"rate","Seven-sixteenths well gives three-quarter rate.",rateCheck⟩,⟨"horizon","Complete well depth closes the local clock record.",horizonCheck⟩]
theorem covarianceCheckPassed : covarianceCheck=true := by unfold covarianceCheck;rw [originalCovariance];rfl
theorem rateCheckPassed : rateCheck=true := by unfold rateCheck;rw [originalRate];rfl
theorem horizonCheckPassed : horizonCheck=true := by unfold horizonCheck;rw [originalHorizon]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (covarianceCheck && rateCheck && horizonCheck && true)=true
 rw [covarianceCheckPassed,rateCheckPassed,horizonCheckPassed]
 rfl
end SFT.Physics.StaticFoldClockEntryWitnesses
