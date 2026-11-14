import SFT.Physics.ConfinementLift
namespace SFT.Physics.ConfinementLiftEntryWitnesses
open ConfinementLift
structure Witness where
 name : String
 statement : String
 passed : Bool
def productsCheck : Bool := match sharpenedQuarkProducts with
 | .error _ => false
 | .ok p => match confinementLift with
   | .error _ => false
   | .ok r => p.down == LeptonIntervals.normalize 3 1454 (by decide) && p.up == LeptonIntervals.normalize 3 13118 (by decide) && r.lightestCarrierLift == 2
def witnesses : List Witness := [⟨"products","Both sharpened products and the lift close exactly.",productsCheck⟩]
theorem productsCheckPassed : productsCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.ConfinementLiftEntryWitnesses
