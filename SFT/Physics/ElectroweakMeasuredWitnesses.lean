import SFT.Physics.ElectroweakMeasuredAnalysis
namespace SFT.Physics.ElectroweakMeasuredWitnesses
open ElectroweakMeasuredAnalysis
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalShare : Bool := match exactTerminalWitness with | .error _ => false | .ok b => b
def formalComplement : Bool := match ElectroweakTerminalRatio.completeShare with | .error _ => false | .ok q => q.numerator == q.denominator
def witnesses : List Witness := [⟨"exact-terminal-share","The terminal on-shell carrier is an exact proper Fold fraction.",formalShare⟩,⟨"exact-complement","The terminal sine and cosine squared carriers partition the One exactly.",formalComplement⟩]
theorem formalSharePassed : formalShare=true := rfl
theorem formalComplementPassed : formalComplement=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.ElectroweakMeasuredWitnesses
