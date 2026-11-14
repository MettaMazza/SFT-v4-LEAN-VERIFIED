import SFT.Physics.PrecisionValidationWitnesses
import SFT.Host.Text
namespace SFT.Physics.EWValidationWitnesses
set_option maxRecDepth 20000
structure Witness where
 name : String
 statement : String
 passed : Bool
def onShellCheck : Bool := match PrecisionValidationWitnesses.electroweak with
 | .ok v => v.1
 | .error _ => false
def compatibleCheck : Bool := match PrecisionValidationWitnesses.electroweak with
 | .ok v => v.2.1
 | .error _ => false
def tensionCheck : Bool := match PrecisionValidationWitnesses.electroweak with
 | .ok v => !v.2.2
 | .error _ => false
def classificationCheck : Bool := match PrecisionValidationWitnesses.electroweak with
 | .ok v => SFT.Host.Text.equal (if v.1 && v.2.1 && !v.2.2 then
     "on-shell-pass__compatible-w-mass-pass__all-input-w-mass-tension-retained"
     else "electroweak-comparison-classification-changed")
     "on-shell-pass__compatible-w-mass-pass__all-input-w-mass-tension-retained"
 | .error _ => false
def witnesses : List Witness := [⟨"on-shell-pass","The sealed sin-squared share lies inside the exact PDG on-shell interval.",onShellCheck⟩,⟨"compatible-wz-pass","The sealed complement lies inside the compatible-input W/Z squared interval.",compatibleCheck⟩,⟨"all-input-tension-retained","The all-input W/Z squared interval is disjoint and remains explicit.",tensionCheck⟩,⟨"complete-classification","The exact three-way classification is stable.",classificationCheck⟩]
theorem onShellCheckPassed : onShellCheck=true := rfl
theorem compatibleCheckPassed : compatibleCheck=true := rfl
theorem tensionCheckPassed : tensionCheck=true := rfl
theorem classificationCheckPassed : classificationCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.EWValidationWitnesses
