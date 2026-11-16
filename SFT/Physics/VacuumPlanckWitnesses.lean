import SFT.Physics.VacuumDensity
namespace SFT.Physics.VacuumPlanckWitnesses
open VacuumDensity
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalFloor : Bool := match localVacuumEnergyFloor with | .error _ => false | .ok q => q.den == 2^20
def formalRadiative : Bool := radiativeLedgersClose
def formalLambda : Bool := (match normalizedCosmologicalConstant.num with | .ofNat n => n == 33 | .negSucc _ => false) && scaleCovariance
def witnesses : List Witness := [⟨"formal-floor","The local floor is exact and independently closed.",formalFloor⟩,⟨"formal-radiative","The finite complete radiative ledger closes at every generated depth.",formalRadiative⟩,⟨"formal-lambda","The normalized coefficient is exact and scale transport is covariant.",formalLambda⟩]
theorem formalFloorPassed : formalFloor=true := by decide +kernel
theorem formalRadiativePassed : formalRadiative=true := originalRadiativeLedgersClose
theorem formalLambdaPassed : formalLambda=true := by
 unfold formalLambda
 rw [originalScaleCovariance]
 decide +kernel
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (formalFloor && (formalRadiative && (formalLambda && true)))=true
 rw [formalFloorPassed,formalRadiativePassed,formalLambdaPassed]
 rfl
end SFT.Physics.VacuumPlanckWitnesses
