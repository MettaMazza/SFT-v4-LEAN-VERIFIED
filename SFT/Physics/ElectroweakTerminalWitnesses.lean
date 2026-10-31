import SFT.Physics.ElectroweakTerminalRatio
namespace SFT.Physics.ElectroweakTerminalWitnesses
open ElectroweakTerminalRatio
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match ElectroweakTerminalSupport.promotionCount,ElectroweakTerminalSupport.binarySupport with | .error _,_ => false | .ok _,.error _ => false | .ok c,.ok s => c == 4 && s == 16
def check1 : Bool := match ElectroweakTerminalSupport.runningLevel with | .error _ => false | .ok l => l == 13
def check2 : Bool := match runningShare (.integer 13) with | .error _ => false | .ok p => p.numerator == 225 && p.denominator == 1009
def check3 : Bool := match sinSquared with | .error _ => false | .ok p => p.numerator == 1930922298157999 && p.denominator == 8642477221479757
def check4 : Bool := match completeShare with | .error _ => false | .ok p => p.numerator == 1 && p.denominator == 1
def witnesses : List Witness := [⟨"terminal-count","The promotion object terminates after four rungs and has sixteen complete binary words.",check0⟩,⟨"running-level","Holding all three generator directions leaves exact level thirteen.",check1⟩,⟨"base-share","The exact charged-versus-neutral support share is 225/1009.",check2⟩,⟨"terminal-share","One alpha return over seventeen forces the exact terminal fraction.",check3⟩,⟨"complete-complement","The two terminal shares reassemble the One exactly.",check4⟩]
theorem check0Passed : check0 = true := rfl
theorem check1Passed : check1 = true := rfl
theorem check2Passed : check2 = true := rfl
theorem check3Passed : check3 = true := rfl
theorem check4Passed : check4 = true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && check1 && check2 && check3 && check4 && true) = true
 rw [check0Passed,check1Passed,check2Passed,check3Passed,check4Passed]
 rfl
end SFT.Physics.ElectroweakTerminalWitnesses
