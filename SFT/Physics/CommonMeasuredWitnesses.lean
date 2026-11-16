import SFT.Physics.CommonMeasuredAnalysis
namespace SFT.Physics.CommonMeasuredWitnesses
open CommonMeasuredAnalysis
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalShare : Bool := match supportEightWitness with | .error _ => false | .ok b => b
def formalTerminal : Bool := match CommonScaleAxis.terminalElectroweakChain with | .error _ => false | .ok q => (LeptonIntervals.normalize 1 5 (by decide)).blt q.terminalShare && q.terminalShare.blt (LeptonIntervals.normalize 1 4 (by decide))
def witnesses : List Witness := [⟨"support-eight-exact","The forced support-eight share is exactly 25/106.",formalShare⟩,⟨"terminal-exact","The terminal share is an exact proper Fold fraction.",formalTerminal⟩]
theorem formalSharePassed : formalShare=true := rfl
theorem formalTerminalPassed : formalTerminal=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.CommonMeasuredWitnesses
