import SFT.Physics.PlanckHierarchy
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.PlanckTerminalWitnesses
open PlanckHierarchy
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def check0 : Bool := match squaredHierarchy with | .error _ => false | .ok d => d == 2^127
def check1 : Bool := match terminalTransport,colourShare,terminalAlpha with | .ok t,.ok c,.ok a => LeptonIntervals.subtract (BoundaryGrowth.asFraction AlphaRatio.one) (BoundaryGrowth.asFraction t) == BoundaryGrowth.asFraction (BoundaryGrowth.multiply c a) | .error _,_,_ => false | .ok _,.error _,_ => false | .ok _,.ok _,.error _ => false
def check2 : Bool := match terminalTransport with | .error _ => false | .ok t => 0 < t.numerator && t.numerator < t.denominator
def check3 : Bool := match terminalSquaredHierarchy with | .error _ => false | .ok t => pair t == (255923934603817488008405160690199418432572494970880,1511539186407)
def witnesses : List Witness := [⟨"lower-support","The lower hierarchy remains exactly 2^127.",check0⟩,⟨"typed-transport","The transported share is exactly two-thirds terminal alpha.",check1⟩,⟨"retained-part","The terminal transport retains a strict positive part of the lower hierarchy.",check2⟩,⟨"terminal-hierarchy","The exact terminal squared ratio reconstructs independently of measurement.",check3⟩]
theorem check0Passed : check0 = true := rfl
theorem check1Passed : check1 = true := rfl
theorem check2Passed : check2 = true := rfl
theorem check3Passed : check3 = true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && check1 && check2 && check3 && true) = true
 rw [check0Passed,check1Passed,check2Passed,check3Passed]
 rfl
end SFT.Physics.PlanckTerminalWitnesses
